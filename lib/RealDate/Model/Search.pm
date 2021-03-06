# Search.pm - Handles database queries for non-registered and non-premium members. Uses one of the Data accounts.
# Authors: (Backend Programmer and supporting frontend programmer Jayant Arora) and (Database and Frontend Programmer- Amos Olasoji)
# Date: CURRENT_TIMESTAMP
package RealDate::Model::Search;

use strict;
use warnings;
use utf8;
use POSIX qw/strftime/;

use DBI;
use DBD::mysql;

my $dbh;

sub new
{ 
  #my $class=shift;
  # my $username=shift;
  # my $password=shift;
  $dbh=DBI->connect("dbi:mysql:jaror001", "jaror001_data1", "MUZ7qCJF2W",{AutoCommit => 1}); die "database connect error:", $DBI::errstr unless($dbh);
  my $self=\$dbh;
  bless $self;#, $class;
  return $self; 
}

sub searchUsersWithoutLoggingIn($$$$)
{
   my $gender = shift;
   my $ageEnd = shift;
   my $ageStart = shift;  
   my $zipcode = shift;
   my $dateToday = int(strftime('%Y%m%d',localtime));
   my $ageStartNew = int($dateToday - $ageStart);
   my $ageEndNew = int($dateToday - $ageEnd);
   new();
   #gender, ageStart, ageEnd, zipcode
   my $sth = $dbh->prepare_cached('select u.userName, u.dob, s.zipcode, s.city from Users u inner join searchAttributes s on u.userid=s.userid where u.gender=? and (u.dob between ? and ?) and s.zipCode = ?');
	die "Prepare failed", $dbh->errstr unless ($sth);

   my $rv = $sth->execute("$gender", $ageEndNew, $ageStartNew, $zipcode);
   die "Execute failed", $sth->errstr unless($rv);

   my @resultingRows;
   do{
      while(my @ar=$sth->fetchrow_array){
         push(@resultingRows, \@ar);
      } die "Fetch failed", $sth->errstr if($sth->err);
   }while($sth->more_results);
   #$sth->finish;
   return \@resultingRows;
}

1;
