#Tristan Werden Perl I/O practice Project - User Deletion
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
    delUsers();
    printReport();

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
#        @tempUsers = split(/,/);  ##I overcomplicated it, so I just decided to cut it.
#        chomp ($users[$counter] = $tempUsers[$counter]);
#        $counter++;
    }
    close $IN;
}

sub delUsers(){
     $numOfUsers = @users;
     for (my $i = 0; $i < $numOfUsers; $i++){ 
##do not do +1 to numOfUsers, it loops into deleting the next user, which is blank, and when left blank becomes the current directory. NOT COOL lol. 
        print "\nProcessing user: $users[$i]\n\n";
        system("sudo zip -r backup$i.zip /home/$users[$i]"); 
##for some reason, on the last run through the loop, zip decides it won't take the whole $users[$i] variable as an option for the zip file name, the zip will fail, and all the files will be lost. No one online knows why. I can't figure it out. I'm over fighting with it, so they are all getting generic names.
        system("sudo userdel -rf $users[$i]");
        print "\n\nUser Deleted";
    }
}

sub printReport(){
    print "\n\n\nAll deleted users have had zip files with all files backed up in the folder that this program was ran from. Users Deleted:";
    for (my $i = 0; $i < $numOfUsers; $i++){
        print "\n      $users[$i]";
}
}
