#!/usr/bin/perl -w

# $Id: simlife-consts.pl,v 1.1 1999/08/08 15:48:48 root Exp root $

# Copyright (c) Mark Summerfield 1999. All Rights Reserved.
# May be used/distributed under the GPL.

use strict ;

package main ;


if( $^O =~ /win32/oi ) {
    $Const{OPTS_FILE} = 'SIMLIFE.INI' ;
}
else {
    my $home = ( $ENV{HOME} or $ENV{LOGDIR} or (getpwuid( $> ))[7] ) ;
    $Const{OPTS_FILE} = $home . '/.simliferc' ;
    my $xdefaults     = $home . '/.Xdefaults' ;
#    $Win->optionReadfile( $xdefaults ) ; # Does not work: don't know why.
}


$Const{BUTTON_WIDTH}             =  8 ;

$Const{CANVAS_WIDTH_DEF}         = 400 ;
$Const{CANVAS_HEIGHT_DEF}        = 400 ;
$Const{CANVAS_SCALE_DEF}         =   5 ;

$Const{CANVAS_BACKGROUND_COLOUR} = 'white' ;
$Const{DEAD_COLOUR}              = $Const{CANVAS_BACKGROUND_COLOUR} ;
$Const{USER_COLOUR}              = 'black' ; 

$Const{VERBOSE}                  = 0 ;

$Const{FILENAME}                 = 'Untitled-' ;
$Const{FILE_SUFFIX}              = '.smp' ;
$Const{DIR}                      = '.' ;
$Const{LAST_FILE_MAX}            =  9 ;
$Const{RULE_FILE_SUFFIX}         = '.spr' ;

$Const{HELP_FILE}                = "$RealBin/" . "simlife-help.pod" ; 

my $s = "$RealBin/simlife-" ;
$Const{INITIALISE_IMAGE} = $Win->Pixmap( -file => "${s}initialise.xpm" ) ;
$Const{START_IMAGE}      = $Win->Pixmap( -file => "${s}start.xpm" ) ;
$Const{STEP_IMAGE}       = $Win->Pixmap( -file => "${s}step.xpm" ) ;
$Const{STEPBACK_IMAGE}   = $Win->Pixmap( -file => "${s}stepback.xpm" ) ;
$Const{STEPTO_IMAGE}     = $Win->Pixmap( -file => "${s}stepto.xpm" ) ;
$Const{PAUSE_IMAGE}      = $Win->Pixmap( -file => "${s}pause.xpm" ) ;
$Const{STOP_IMAGE}       = $Win->Pixmap( -file => "${s}stop.xpm" ) ;
$Const{CLEAR_IMAGE}      = $Win->Pixmap( -file => "${s}clear.xpm" ) ;


1 ;
