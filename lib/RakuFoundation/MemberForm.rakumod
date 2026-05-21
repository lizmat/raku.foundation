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
                start {
                    my $mail = start {
                        CATCH { default { note "SMTP error: $_" } }
                        send-member-email($form)
                    };
                    await Promise.anyof($mail, Promise.in(30));
                    note "SMTP: timed out after 30s" if $mail.status == Planned;
                }
                self.finish: '<p style="text-align:center"><em><u>Thank you — we will be in touch!</u></em></p>'
            }
            else {
                self.retry: $form
            }
        }
    }
}

our $member is export = Member.empty;

sub send-member-email(Member $form) {
    my $host = %*ENV<SMTP_HOST>;
    my $port = %*ENV<SMTP_PORT> // 587;
    my $user = %*ENV<SMTP_USER>;
    my $pass = %*ENV<SMTP_PASS>;
    my $from = %*ENV<SMTP_FROM> // 'webserver@raku.foundation';
    my $to   = %*ENV<SMTP_TO>   // 'membershiplist@raku.foundation';
    my $bcc  = %*ENV<SMTP_BCC>  // 'librasteve@furnival.net';

    my $message = qq:to/END/;
        From: $from
        To: $to
        Subject: The Raku Foundation — Member Registration Interest

        Name:  { $form.name }
        Nick:  { $form.nick // '(not provided)' }
        Email: { $form.email }
        END

    my $smtp = Net::SMTP.new(:server($host), :$port);
    $smtp.auth($user, $pass);
    $smtp.send("<$from>", ("<$to>", "<$bcc>"), $message);
    $smtp.quit;
}
