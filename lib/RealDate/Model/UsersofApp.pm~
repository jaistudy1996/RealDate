# UsersofApp - Handles most of the database queries for login controller.
# Authors: (Backend Programmer and supporting frontend programmer Jayant Arora) and (Database and Frontend Programmer- Amos Olasoji)
# Date: CURRENT_TIMESTAMP

package RealDate::Model::UsersofApp;

use strict;
use warnings;
use utf8;

use DBI;
use DBD::mysql;

my $dbh;

sub new
{ 
  #my $class=shift;
  # my $username=shift;
  # my $password=shift;
  $dbh=DBI->connect("dbi:mysql:jaror001", "jaror001_dbo", "7j9BtqwgzZ",{AutoCommit => 1});
    die "database connect error:", $DBI::errstr unless($dbh);
  my $self=\$dbh;
  bless $self;#, $class;
  return $self; 
}

sub loginUser($$)
{
  new();
  # my $dbh = shift;
  my $username = shift;
  my $password = shift;

  my $sth = $dbh->prepare_cached(
  	"select userName from Users where userName = (?) and password = (?)"
   ); die "Prepare statement failed ", $dbh->errstr unless($sth);

  my $rv = $sth->execute($username, $password) or return undef;
  die "Execute failed", $sth->errstr unless($rv);
  
  do{
    while(my $aref=$sth->fetchrow_arrayref){
      return 1;
    }die "Fetch failed", $sth->errstr if($sth->err);
  }while($sth->more_results);

  $sth->finish;
  return undef;
}

sub profileSelf($)
{
    new();
    my $myself = shift;  # this is the username in the database
    my $sth = $dbh->prepare_cached(q{
    	 select s.*, u.dob from searchAttributes as s inner join Users as u on u.userid = s.userid where u.userid = (select userid from Users where userName=(?))
    }); die "Prepare failed", $dbh->errstr unless($sth);
    
    my $rv = $sth->execute($myself);
    die "Execute failed on profileSelf", $sth->errstr unless($rv);
    do{
    	while(my $aref=$sth->fetchrow_arrayref){
	   #return 100;
	   return $aref;
	} die "Fetch failed", $sth->errstr if($sth->err);
    }while($sth->more_results);
    $sth->finish;
    return undef;
}

sub changePass($$$){
   new();
   my $oldPass = shift;
   my $newPass = shift;
   my $userName = shift;
   my $passinData = $dbh->prepare_cached("select password from Users where userName = ?"); die "Prepare failed", $dbh->errstr unless($passinData);

   my $rv = $passinData->execute($userName);
   die "Execute failed", $passinData->errstr unless($rv);

   my @retPass = $passinData->fetchrow_array;
   if($oldPass eq $retPass[0]){
	my $change = $dbh->prepare("update Users set password = ? where userName = ? and password = ?"); die "prepare failed", $dbh->errstr unless($change);
	my $rv2 = $change->execute($newPass, $userName, $oldPass); die "update failed", unless($rv2);
	return 1;
   }
   else{return undef;}
}

sub signup($$$$$$$$$$$){
	my $genderSelf = shift;
	my $month = shift;
	my $day = shift;
	my $year = shift;
	my $userN = shift;
	my $pass1 = shift;
	my $pass2 = shift;
	my $email = shift;
	my $city = shift;
	my $state = shift;
	my $zip = shift;

	new();
	my $sth = $dbh->prepare_cached(q{
        insert into Users(userName, dob, password, email) values(?, ?, ?, ?)
    }); die "Prepare failed", $dbh->errstr unless($sth);

    my $rv = $sth->execute($userN, $year.$month.$day, $pass1, $email);
    die "Execute failed on profileSelf", $sth->errstr unless($rv);
	return 1;
	

}

1;
