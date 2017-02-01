# Login.pm -- Handles all the actions realting to login, logout, viewing one's profile, change password and also signup which
#              will be moved to some other account in upcoming versions.
# Authors: (Backend Programmer and supporting frontend programmer Jayant Arora) and (Database and Frontend Programmer- Amos Olasoji)
# Date: CURRENT_TIMESTAMP

package RealDate::Controller::Login;
use Mojo::Base 'Mojolicious::Controller';
use RealDate::Model::UsersofApp;
#use RealDate::Model::Users;

#my state $loginusingModel = RealDate::Model::UsersofApp->loginUser; 

sub login{
  my $self = shift;
  if($self->session('logged_in')){
  	$self->redirect_to('/profile');
  }

  my $username = $self->param('username');
  my $password = $self->param('password');
  
  my $value = RealDate::Model::UsersofApp::loginUser($username, $password);
  if ($value){
     $self->session(logged_in => 1);
     $self->session(username => $username);
     #print($self->session("logged_in"));
     $self->render(username => "$username", password=> "$password", value=>"$value");
     $self->redirect_to('/profile');
  }
  else{
     #$self->render(username=>"Not found", password=> "Sorry, login attempt failed.");
     #$self->session(expires=>1);
     $self->render(text=>"The passowrd does not match our records");
  }
}

sub viewProfile{
  my $self = shift;
  if($self->session('logged_in')){
     #$self->session(expire=>1);
     my $profileUserName = $self->session('username');
     #print($profileUserName);
     my $profileData = RealDate::Model::UsersofApp::profileSelf($profileUserName);
     #print($profileData);
     #$profileData = @$profileData[0];
     $self->render(userName=>"$profileUserName", dob=>"@$profileData[11]", smokes=>"@$profileData[1]", drinks=>"@$profileData[2]", kids=>"@$profileData[3]", height=>"@$profileData[4]", weight=>"@$profileData[5]", maritalStatus=>"@$profileData[6]", pets=>"@$profileData[7]", city=>"@$profileData[8]", state=>"@$profileData[9]", zipcode=>"@$profileData[10]");
  }
  else{
  $self->session(expires=>1);
  $self->stash(loginReminder=>"You are Not Logged in!! Login here -");
  $self->render(template=>'login/logout');
  }
}

sub changePassword{
  my $self = shift;
  my $oldPass = $self->param("oldPass");
  my $newPass = $self->param("newPass");
  my $newPass1 = $self->param("newPass1");
  my $userName = $self->session("username");
  if ($newPass ne $newPass1){
      $self->render(text=>"Your new passowrds do not match");
      return;
  }
  my $success = RealDate::Model::UsersofApp::changePass($oldPass, $newPass, $userName);
  if ($success == 1){
      $self->session(expires=>1);
      $self->render(template=>'login/passwordChangeSuccess');
  }
  else{
 	$self->render(text=>'The process to change your password is a pain.. So get the hell outta here..');
  }
}

sub logout{
   my $self= shift;
   if($self->session('logged_in')){
      $self->session(expires=>1);
      $self->stash(loginReminder=>"You have been logged out! You can login again below!");
   }
   else{
      $self->stash(loginReminder=>"You are Not Logged in!! Login here -");
   }
   $self->render(template=>'login/logout');
}

sub signup{
  my $self = shift;
  if($self->session('logged_in')){
  	$self->redirect_to('/profile');
  }
  else{
	my $iam = $self->param('iam');
	my $genderSelf;
	my $genderSeek;
	if($iam eq "MF"){
	    $genderSelf = 'M';
	    $genderSeek = 'F';
	}
	if($iam eq "FM"){
	    $genderSelf = 'F';
	    $genderSeek = 'M';
	}
	my $month = $self->param('month');
	my $day = $self->param('day');
	my $year = $self->param('year');
	my $userN = $self->param('username'); 
		#if(!$userN){ 
		#return $self->render(text=>'User name field cannot be empty! Try again');}
	my $pass1 = $self->param('password1');
	my $pass2 = $self->param('password2');
	      #if($pass1 ne $pass2){ 
	#return $self->render(text=>'Your passwords do not match');}
	my $email = $self->param('email'); 
		#if(!$email){
	#return $self->render(text=>'Email field cannot be empty!')}
	my $city = $self->param('city');
	my $state = $self->param('state');
	my $zip = $self->param('zipcode');
	my $inserting = RealDate::Model::UsersofApp::signup($genderSelf, $month, $day, $year, $userN, $pass1, $pass2, $email, $city, $state, $zip);
	#my $inserting = 1;
	if ($inserting == 1){
		$self->render(text=>'You have been successfully signed up!');
	}
	else{
		$self->redirect_to('exception');
	}
  }
}

1;


