#!/usr/bin/perl -w

# $Id: simlife-help-cmd.pl,v 1.1 1999/08/08 15:48:48 root Exp $

# Copyright (c) Mark Summerfield 1999. All Rights Reserved.
# May be used/distributed under the GPL.

use strict ;

package help ;


sub about {
    package main ;

    &cursor( 'clock' ) ;
    &canvas::status( 'Showing about box...' ) ;

    my $text = <<__EOT__ ;
SimLife v $VERSION

summer\@chest.ac.uk

Copyright (c) Mark Summerfield 1999. 
All Rights Reserved.

May be used/distributed under the GPL.
__EOT__


    my $msg = $Win->MesgBox(
        -title => 'SimLife - About',
        -text  => $text,
        ) ;
    $msg->Show ;
    
    &cursor() ;
    &canvas::status( '' ) ;
}


1 ;
