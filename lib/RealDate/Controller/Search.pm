# Search.pm: this file connects the search model and the search template to view results using array referencing. 
# Authors: (Backend Programmer and supporting frontend programmer Jayant Arora) and (Database and Frontend Programmer- Amos Olasoji)
# Date: CURRENT_TIMESTAMP

package RealDate::Controller::Search;
use Mojo::Base 'Mojolicious::Controller';
use RealDate::Model::Search;

sub searching
{
   my $self = shift;
   my $ageEnd = $self->param('ageEnd');
   my $ageStart = $self->param('ageStart');
   my $gender = $self->param('seek');
   my $zipcode = $self->param('zipcode');

   my $resultingResult = RealDate::Model::Search::searchUsersWithoutLoggingIn($gender, $ageEnd, $ageStart, $zipcode);
   #my @resultsReturn = @results[0];
   #my $test = scalar @resultingResult;
   $self->stash(resulting=>$resultingResult);
   # $self->render(text=>"$test, $ageStart, $ageEnd");
   $self->render(template=>'search/search'); #, results=>$results);
   #$self->redirect_to('/search');
}

1;
