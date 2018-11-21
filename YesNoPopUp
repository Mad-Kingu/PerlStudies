#!/usr/bin/perl -w
use strict;
use warnings;

use Tk;

my $mw = MainWindow->new();
$mw->withdraw();

my $ftp_warn = $mw->messageBox(
  -title   => 'Silly message',
  -message => "We are displaying a silly message, do you wish to conti
+nue?",
  -type    => 'YesNo',
  -icon    => 'question',
);

if ( $ftp_warn eq 'No' ) {
  exit;

  }else {
    my $msg2 = $mw->messageBox(
    -title   => 'Really?',
    -message => "We displayed silly message and you wish to continue?",
    -type    => 'OK',
    -icon    => 'question',
  );

while (1){
print "hit control-c to exit\n";
sleep 1;
}

}
