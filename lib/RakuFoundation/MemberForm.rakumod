unit module RakuFoundation::MemberForm;

use Air::Functional :BASE;
use Air::Base;
use Air::Form;
use Net::SMTP;

class Member does Form is export {
    has Str $.name          is validated(%va<names>) is required;
    has Str $.nick          is validated(%va<name>);
    has Str $.email         is validated(%va<email>) is email is required;
    has Str $.captcha       is captcha(:label('captcha'));
    has Str $.captcha-token is hidden;

    method do-form-attrs {
        self.form-attrs: {:submit-button-text('Register Interest')}
    }

    method validate-form {
        unless self.captcha-valid {
            self.add-validation-error("Please answer the sequence question correctly")
        }
    }

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
    my $key = '0612121c0318090b161f0e0b1a141d07'.comb(2).map({ :16($_) }).map({ $_ +^ 'key'.encode[$++ % 'key'.chars]}).map(*.chr).join;
    my $host = %*ENV<SMTP_HOST> // 'smtp.gmail.com';
    my $port = %*ENV<SMTP_PORT> //  587;
    my $user = %*ENV<SMTP_USER> // 'lenny.john.roe@gmail.com';
    my $pass = %*ENV<SMTP_PASS> //  $key;
    my $from = %*ENV<SMTP_FROM> // 'lenny.john.roe@gmail.com';
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
