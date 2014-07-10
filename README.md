# DevLog

Custom logger module for development purposes

# VERSION

Version 0.05

# SYNOPSIS

Use this module to log a transaction to a database location specified by logpath

Code snippet.

    use DevLog;
    
    my $log = DevLog->new( 
      logpath => $log_path, #required, defaults to current directory of script \\db
      logdb   => $log_db, #required, defaults to 'Log.db'
      date    => $current_date, #defaults to current date
      time    => $current_time, #defaults to current time
      comment => $comment,
      status  => $status,
      keyword => $keyword, #required
      errmsg  => $errmsg, #required
      script  => $script_name,
      user    => $user_name # defaults to $ENV{'USERNAME'}
    );

    $log->log;
       

## EXPORTS

\* dev\_log()
\* list()

## SUBROUTINES/METHODS

## dev\_log()

Creates a logging database for tracking development of scripts

## list

Return an array of all logs within the Sqlite database

# AUTHOR

Sholto Maud, `<sholto.maud at gmail.com>`

# BUGS

Please report any bugs in the issues wiki.

# SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Logger

# ACKNOWLEDGEMENTS

# LICENSE AND COPYRIGHT

Copyright 2014 Sholto Maud.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

[http://www.perlfoundation.org/artistic\_license\_2\_0](http://www.perlfoundation.org/artistic_license_2_0)

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
