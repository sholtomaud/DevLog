package DevLog;
use Moose;
#use Moose::Util::TypeConstraints;
use DBI;
use JSON;
use DateTime;
use FindBin qw($Bin);
use Env;

=head1 DevLog

Custom logger module for development

=head1 VERSION

Version 0.10

=cut

our $VERSION = '0.03';

=head1 SYNOPSIS

Use this module to log development
     
=cut

 
 my $defaultdb_dir = $Bin.'\\db\\';
 my $defaultdb = $defaultdb_dir.'\\Log.db';
 
 has 'keyword' => ( is => 'rw', isa => 'Str', required => 1); 
 has 'logpath' => ( is => 'rw', isa => 'Str', required => 1, default => $defaultdb_dir);
 has 'logdb' => ( is => 'rw', isa => 'Str', required => 1, default => $defaultdb);  
 has 'status'  => ( is => 'rw', isa => 'Str'); 
 has 'date'  => ( is => 'rw', isa => 'Num',  default => sub { ((localtime)[5] + 1900 ). (localtime)[4] . (localtime)[3] } ); 
 has 'time'  => ( is => 'rw', isa => 'Num', default => sub { (localtime)[2] . (localtime)[1] . (localtime)[0] }); 
 has 'errmsg' => ( is => 'rw', isa => 'Str', required => 1); 
 has 'script' => ( is => 'rw', isa => 'Str'); 
 has 'comment' => ( is => 'rw', isa => 'Str'); 
 has 'user' => ( is => 'rw', isa => 'Str', default => $ENV{'USERNAME'} ); 
 
=head1 EXPORTS

* dev_log()
* list()

=head1 SUBROUTINES/METHODS

=head2 dev_log()
  
Creates a logging database for tracking development of scripts

=cut

sub dev_log{
  my $self = shift;
 if ( $defaultdb_dir ne $self->logpath ) {
    mkdir ($self->logpath) if ( ! -d $self->logpath ) ;
  }
  else{  
    mkdir ($defaultdb_dir) if ( ! -d $defaultdb_dir );
  }  
  my $db = $self->logdb;
  my $dbh = DBI->connect(          
      "dbi:SQLite:dbname=$db", 
      "",                          
      "",                          
      { RaiseError => 1, AutoCommit => 0},         
  ) or die print $DBI::errstr;
  
  my $primary_key = 'PRIMARY KEY (Script, Date, Time)';
  $dbh->do("CREATE TABLE IF NOT EXISTS LOG(
    Script    TEXT,
    Keyword   TEXT, 
    Status    TEXT, 
    Comment   TEXT, 
    Errmsg    TEXT,
    Date      TEXT, 
    Time      TEXT, 
    User      TEXT,
    $primary_key
  )");
    
  my $sth = $dbh->prepare("INSERT INTO LOG VALUES ( ?, ?, ?, ?, ?, ?, ?, ? )");
  my @values = ($self->script, $self->keyword, $self->status, $self->comment, $self->errmsg, $self->date, $self->time, $self->user );
  $sth->execute(@values) or die return $sth->errstr;
  $dbh->commit;  
  $dbh->disconnect();
  return 1;    
}


=head2 list

Return an array of all logs within the Sqlite database
  
=cut

sub list{
  my $self = shift;
  my $db = $self->logdb;
  my $dbh = DBI->connect(          
      "dbi:SQLite:dbname=$db", 
      "",                          
      "",                          
      { RaiseError => 1, AutoCommit => 0},         
  ) or die print $DBI::errstr;
  my $sth = $dbh->prepare("SELECT * FROM LOG");
  $sth->execute;
  my $hash_ref = $sth->fetchall_hashref( [ qw(Script Date Time) ]);
  $dbh->disconnect();
  return $hash_ref;
}

=head1 AUTHOR

Sholto Maud, C<< <sholto.maud at gmail.com> >>

=head1 BUGS

Please report any bugs in the issues wiki.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Logger


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Logger>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Logger>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Logger>

=item * Search CPAN

L<http://search.cpan.org/dist/Logger/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2014 Sholto Maud.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of Logger