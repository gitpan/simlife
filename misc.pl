#!/usr/bin/perl -w

# $Id: misc.pl,v 1.3 1999/08/08 15:16:58 root Exp $

# Copyright (c) Mark Summerfield 1999. All Rights Reserved.
# May be used/distributed under the LGPL. 

use strict ;

use Cwd ;

package main ;


sub abs_path {
    my $path = shift ;

    my $filename = basename( $path ) ;

    $path        = dirname( $path ) ;
    chdir $path ;
    $path = cwd ;

    $path =~ s!/./!/!go ;

    if( $filename ) {
        $path .= '/' unless substr( $path, -1, 1 ) eq '/' ;
        $path .= $filename ;
    }

    $path ;
}


# Based on the example in The Perl Cookbook, but doesn't commify the year in
# dates, i.e. leave 20/7/2004 in tact.
sub commify {
    my $num = reverse $_[0] ;
    $num =~ s/(\d\d\d)(?=\d)(?!\d*\.)/$1,/g ;
    $num = scalar reverse $num ;
    $num =~ s!(/\d),!$1!go ;
    $num ;
}


1 ;
