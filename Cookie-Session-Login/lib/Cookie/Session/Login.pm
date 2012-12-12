package Cookie::Session::Login;

use 5.010000;
use strict;
use warnings;
use CGI;
use vars qw($q);
$q=new CGI;
use CGI::Cookie;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Cookie::Session::Login ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	new session_start create_cookie cookie_extract http_header_hash redirect_page delete_cookie
);

our $VERSION = '0.01';

sub new {
    my $class = shift;
    my $self ={} ;
     bless ($self,$class);
    return $self;
}
sub session_start{
     my $self = shift;
  (%{$self->{params}}) = @_;
  my %hash;
 #my $remorteip = $ENV{REMOTE_ADDR}; 
    
     my $cookie_user = new CGI::Cookie(
                                    -name  => "$self->{params}{name}",
                                    -value => "$self->{params}{value}",
				    
				    -path =>	"$self->{params}{path}",
                                    -expires =>  '+'.$self->{params}{exptime}.'M',
				    
                                   );
	    print "Set-Cookie: ",$cookie_user->as_string,"\n";
	    
#for(keys %{$self->{params}}) {
#     $hash{$_}=$self->{params}{$_};
#}
#cookie_extract( \%hash);
}
sub create_cookie{
     my $self = shift;
  (%{$self->{params}}) = @_;
  my %hash;
     my $cookie_user = new CGI::Cookie(
                                    -name  => "$self->{params}{name}",
                                    -value => "$self->{params}{value}",
				    
				    -path =>	"$self->{params}{path}",
                                    -expires =>  '+'.$self->{params}{exptime}.'M',
				    
                                   );
	    print "Set-Cookie: ",$cookie_user->as_string,"\n";
	    
}
sub cookie_extract{
   shift;
   my @array;
   my @array1;
    #my $ck_name=$ENV{HTTP_COOKIE};
    #$ck_name=~/(.*?)\=(.*)/;
    #my $cooke_name=$1;
    #my $cooke_values=$2;
    foreach my $name ($q->cookie())
    {
        push(@array,$name); 
    }
 
    if($_[0] eq "c-name"){
	return @array;
    }
    if($_[0] eq "c-value"){
	
	foreach my $name ($q->cookie()){
	    
	    push(@array1,$q->cookie($name)); 
	}
	
	return @array1;
    }
    
    
}
sub http_header_hash{
    my %CHash;
    foreach my $keey(keys %ENV){
	$CHash{$keey}=$ENV{$keey};
    } 
return %CHash;
}
sub redirect_page{
    shift;
       print $q->redirect("$_[0]");
       $CGI::HEADERS_ONCE = 1;
}
sub delete_cookie{
shift;
# Delete All Cookie....
    $CGI::HEADERS_ONCE = 1;
    foreach my $cooke_name ($q->cookie()){
	my $cookie_user =
	new CGI::Cookie(
	    -name  => "$cooke_name",
	    -value => "",
	    -expires =>  "-1H",
	    );
	print "Set-Cookie: ",$cookie_user->as_string,"\n";
    }
}


1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Cookie::Session::Login -used to create cookie session in browser

=head1 SYNOPSIS

    use Cookie::Session::Login;
    my $value =Cookie::Session::Login->new;
This function will create session cookie in browser
    my $r=$value->session_start(
                             
                                name=>'Demo_Test',
                                value=>'Hay',
                                exptime=>'1',
                                path    =>''
                             );


=head2 create_cookie()
You can create more Browser cookie  Like this
    my $cookies=$value->create_cookie(
                             
                                name=>'Demo_Next',
                                value=>'E-say',
                                exptime=>'1',
                                path    =>''
                             );

=head2 cookie_extract()
We can pass two parameters to this function  [c-name or c-value] this function returns an array
That array has both cookie name and cookie value, which depends up on changes of "c-name" and "c-value"
The redirect_page function which is using for Redirecting to a page. 

    my @result=$value->cookie_extract("c-value");   

    if(!$result[1]){
        $value->redirect_page("login.pl");
    }else{
        $value->redirect_page("index.pl");
    }

=head2 http_header_hash()        
This http_header_hash  funcions may contain Environment values of http headers
This function will return a hash
    my %Http_value=$value->http_header_hash;  
  
    foreach my $keys(keys %Http_value){
        print $keys."=".$Http_value{$keys}."<br>";
    }
    
=head2 delete_cookie() 
when you call delete_cookie function you can delete you created all cookie  in the browser

    $value->delete_cookie;
  
=head1 DESCRIPTION

This module helps to create cookies in browser and you can retrieve that cookie values from browser.
and also this module helps create sessions in browser it can use Login purpose at the end of session
you can delete you created all cookie value in browser.  
http_header_hash function will return Environment values

=head2 EXPORT

None by default.

=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

Mahesh Raghunath, E<lt>blackwind@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2012 by Mahesh Raghunath. 

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.0 or,
at your option, any later version of Perl 5 you may have available.


=cut