unit module RakuFoundation::MemberForm;

use Air::Functional :BASE;
use Air::Base;
use Air::Form;
use Net::SMTP;

class Member does Form is export {
    has Str $.name  is validated(%va<names>) is required;
    has Str $.nick  is validated(%va<name>);
    has Str $.email is validated(%va<email>) is email is required;

    method do-form-attrs {
        self.form-attrs: {:submit-button-text('Register Interest')}
    }

    method validate-form {}

    method form-routes {
        self.init;

        self.submit: -> Member $form {
            if $form.is-valid {
                note "Member registration: $form.form-data()";
                try {
                    send-member-email($form);
                    CATCH { default { note "SMTP error: $_" } }
                }
                self.finish: '<b style="text-align:center"><em>Thank you — we will be in touch!</em></b>'
            }
            else {
                self.retry: $form
            }
        }
    }
}

our $member is export = Member.empty;

sub send-member-email(Member $form) {
    my $host = %*ENV<SMTP_HOST> // 'smtp.gmail.com';
    my $port = (%*ENV<SMTP_PORT> // '587').Int;
    my $user = %*ENV<SMTP_USER>;
    my $pass = %*ENV<SMTP_PASS>;
    my $from = %*ENV<SMTP_FROM> // 'webserver@raku.foundation';
    my $to   = %*ENV<SMTP_TO>  // 'librasteve@furnival.net';

    my $message = qq:to/END/;
        From: $from
        To: $to
        Subject: Raku Foundation — Member Registration Interest

        Name:  { $form.name }
        Nick:  { $form.nick // '(not provided)' }
        Email: { $form.email }
        END

    my $smtp = Net::SMTP.new(:server($host), :$port);
    $smtp.auth($user, $pass);
    $smtp.send($from, $to, $message);
    $smtp.quit;
}
