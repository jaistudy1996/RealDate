package RealDate;
use Mojo::Base 'Mojolicious';
use RealDate::Model::UsersofApp;
use Mojolicious::Sessions;
# This method will run once at server start
sub startup {
  my $self = shift;

  # Documentation browser under "/perldoc"
  # my $sessions = Mojolicious::Sessions->new;
  $self->plugin('PODRenderer');
  $self->app->sessions->cookie_name('RealDate');
  #$self->app->sessions->default_expiration('600');
  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('welcome#welcome');
  # $r->get('/login')->to('welcome#login');
  $r->get('/profile')->to('login#viewProfile');
  $r->get('/login')->to(template=>'login/login');
  $r->get('/logout')->to('login#logout');
  $r->get('/changePassword')->to(template=>'login/changePassword');
  $r->get('/signup')->to(template=>'login/signup');

  # POST routes
  $r->post('/')->to('search#searching');
  $r->post('/loginuser/')->to('login#login');
  $r->post('/changePassword')->to('login#changePassword');
  $r->post('/signup')->to('login#signup');
}

1;
