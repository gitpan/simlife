#!/usr/bin/perl -w

# $Id: simlife-canvas-ui.pl,v 1.1 1999/08/08 15:48:48 root Exp root $

# Copyright (c) Mark Summerfield 1999. All Rights Reserved.
# May be used/distributed under the GPL.

use strict ;

package main ;


my $Frame = $Win->Frame()->pack( 
                -side   => 'bottom', 
                -expand => 1, 
                -fill   => 'x',
                -padx   => 2,
                -pady   => 2,
                ) ;

$Canvas{GENERATION} = $Frame->Label( 
                    -text   => '0',
                    -relief => 'ridge',
                    -anchor => 'w',
                    )->pack( -side => 'left', ) ;

$Canvas{STATUS} = $Frame->Label( 
                    -text   => '',
                    -relief => 'ridge',
                    -anchor => 'w',
                    )->pack( 
                        -side   => 'left', 
                        -fill   => 'x', 
                        -expand => 1,
                        ) ;


$Frame = $Win->Frame()->pack(
                -side   => 'top',
                -expand => 1,
                -fill   => 'both',
                -padx   => 1,
                -pady   => 1,
                ) ;


$Canvas{CANVAS} = $Frame->Canvas(
                    -width       => $Opt{CANVAS_WIDTH}, 
                    -height      => $Opt{CANVAS_HEIGHT},
                    -bg          => $Opt{CANVAS_BACKGROUND_COLOUR},
                    -borderwidth => 1,
                    ) ;

$Canvas{CANVAS}->pack( -side => 'bottom', -fill => 'both', -expand => 1 ) ; 
$Canvas{CANVAS}->Tk::bind( '<1>', \&canvas::click1 ) ;
$Canvas{CANVAS}->Tk::bind( '<3>', \&canvas::click3 ) ;


1 ;
