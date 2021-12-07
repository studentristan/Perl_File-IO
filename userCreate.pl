#Tristan Werden Perl I/O practice Project - User Creation
#V.3.0 Major Changes:
#   - Added proper looping for multiple users at once

use strict;
use warnings;
use 5.26.3;


my ($DATAFILEIN);
my @users;
my $numOfUsers;
sub main {

    verifyArguments();
    setDataFileIn();
    readUsers();
    $numOfUsers = @users;
    for (my $i = 0; $i < $numOfUsers; $i++){
        print "\nProcessing user: $users[$i]\n\n";
        system ("sudo useradd -m $users[$i]");
    }

}

main();

sub verifyArguments(){
    if (!(@ARGV) || !(-e $ARGV[0])) {
        die "\n\nUse a correct file name for the command argument\n\n";
    }
}

sub setDataFileIn(){
    $DATAFILEIN = $ARGV[0];
}

sub readUsers(){
    my $IN;
    my @tempUsers = ();
    my $counter = 0; #I shouldn't set the var in the declaration, but it's convenient
    @users = ();

    open ($IN, '<', $DATAFILEIN);
    while (<$IN>) {
        print "$_";
        @users = split(/,/);
#        @tempUsers = split(/,/);
#        chomp ($users[$counter] = $tempUsers[$counter]);
#        $counter++;
    }
    close $IN;
}
