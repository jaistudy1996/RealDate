# Welcome.pm -- Handles the homepage for RealDate.com and contains links to other actions in different controllers.  
# Authors: (Backend Programmer and supporting frontend programmer Jayant Arora) and (Database and Frontend Programmer- Amos Olasoji)
# Date: CURRENT_TIMESTAMP

package RealDate::Controller::Welcome;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub welcome {
  my $self = shift;

  # Render template "example/welcome.html.ep" with message
  $self->render(msg => 'Welcome to the Mojolicious real-time web framework!');
}

sub login{
   my $self = shift;
   # taking parameters
   my $seekType = $self->param('seekType');
   my $month = $self->param('month');
   my $day = $self->param('day');
   my $year = $self->param('year');
   my $city = $self->param('city');
   my $zipcode = $self->param('zipcode');
   my $email = $self->param('email');
   my $password = $self->param('password');

   $self->render(againMsg => "you entered:" . $seekType);
}

1;
