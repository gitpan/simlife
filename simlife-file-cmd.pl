#!/usr/bin/perl -w

# $Id: simlife-file-cmd.pl,v 1.2 1999/08/28 22:12:46 root Exp $

# (c) Mark Summerfield 1999. All Rights Reserved.
# May be used/distributed under the GPL.

use strict ;

package file ;


sub new {
    package main ;

    my $first_use = shift ;
    $first_use = ( defined $first_use and $first_use == 1 ) ? 1 : 0 ;

    if( $first_use ) {
        $Opt{CANVAS_WIDTH}  = $Const{CANVAS_WIDTH_DEF} ;
        $Opt{CANVAS_HEIGHT} = $Const{CANVAS_HEIGHT_DEF} ;
		$Opt{WIDTH}         = int( $Opt{CANVAS_WIDTH}  / $Opt{CANVAS_SCALE} ) ;
		$Opt{HEIGHT}        = int( $Opt{CANVAS_HEIGHT} / $Opt{CANVAS_SCALE} ) ;
    }
    else {
        &file::prompt_save unless $Global{WROTE_SIM} ;
    }

    $Global{WROTE_SIM} = 1 ;

    &file::new_sim( $first_use ) ;
	&options::form unless $first_use ;
	&simulation::initialise ;

    $Win->title( 'SimLife - ' . $Global{FILENAME} ) ;
}


sub new_sim {
    package main ;

    my $first_use = shift ;

    $Global{FILENAME}   = $Const{FILENAME} . $Global{FILENAME_INDEX}++ .
                          $Const{FILE_SUFFIX} ;
	$Global{GENERATION} = 0 ;
}


sub open {
    package main ;

    &file::prompt_save unless $Global{WROTE_SIM} ;

    shift if ref $_[0] ;
    my $filename = shift ;

    if( defined $filename and $filename =~ /^([1-9])$/o ) {
        $filename = $Opt{"LAST_FILE_$1"} ;
        $filename = '' if $filename eq '(none)' ;
    }

    if( not $filename ) {
        &cursor( 'clock' ) ;
        $Opt{DIR}  = &abs_path( $Opt{DIR} ) ;
        my $dialog = $Win->FileSelect( 
                        -directory => $Opt{DIR},
                        -filter    => "*$Const{FILE_SUFFIX}",
                        ) ;
        $filename = $dialog->Show ;
        &cursor() ; 
    }

    if( $filename ) {
        my $loaded = 0 ;
       
        my $dir = dirname( $filename ) ;
        if( $Opt{DIR} ne $dir ) {
            $Opt{DIR} = &abs_path( $dir ) ;
            $Global{WROTE_OPTS} = 0 ;
        }

		&cursor( 'watch' ) ;
		&canvas::status( "Loading `$filename'..." ) ;

        if( $filename =~ /$Const{FILENAME_SUFFIX}$/o ) {
            $loaded = &simulation::load( $filename ) ; 
        }
		else {
			message( 'Warning', 'Open', 'Cannot open this file format' ) 
        }

        $Global{WROTE_SIM} = 1 ;

        if( $loaded ) {
            $filename = &abs_path( $filename ) ;
            $Global{FILENAME} = $filename ;
            $Win->title( 'SimLife - ' . $filename ) ;
            &file::remember_name( 
                $filename, 'LAST_FILE', $MenuFile, $Const{LAST_FILE_MAX} ) ;
        }

		&cursor() ;
		&canvas::status( '' ) ;
    }
}


sub save {
    package main ;

    if( $Global{FILENAME} =~ /^$Const{FILENAME}/o ) {
        &file::save_as ;
    }
    else {
        $Global{FILENAME} = &abs_path( $Global{FILENAME} ) ;

		&cursor( 'watch' ) ;
		&canvas::status( "Saving `$Global{FILENAME}'..." ) ;

        if( $Global{FILENAME} =~ /\.$Const{FILENAME_SUFFIX}$/o ) {
            $Global{WROTE_SIM} = 1 if &simulation::save( $Global{FILENAME} ) ; 
        }
        elsif( $Global{FILENAME} =~/\.ps$/o ) {
			$Canvas{CANVAS}->postscript( -file => $Global{FILENAME} ) ;
        }
        else {
			message( 'Warning', 'Save', 'Cannot save this file format' ) ;
		}
        if( $Global{WROTE_SIM} ) {
            &file::remember_name( 
                $Global{FILENAME}, 'LAST_FILE', $MenuFile, $Const{LAST_FILE_MAX} ) ;
		}

		&cursor() ;
		&canvas::status( '' ) ;
   }
}


sub remember_name {
    package main ;

    my( $filename, $Widget, $type, $max ) = @_ ;

    my $remembered = 0 ;
    for( my $i = 1 ; $i <= $max ; $i++ ) {
        $remembered = 1, last if $Opt{$type . "_$i"} eq $filename ;
    }
    if( not $remembered ) {
        $Widget->entryconfigure(
            $Opt{$type} . " " . $Opt{$type . "_" . $Opt{$type}},
            -label => $Opt{$type} . " " . $filename ) ;
        $Opt{$type . "_" . $Opt{$type}} = $filename ;
        $Opt{$type}++ ;
        $Opt{$type} = 1 if $Opt{$type} > $max ;
    }
}


sub save_as {
    package main ;

    &cursor( 'clock' ) ;
    $Opt{DIR}    = &abs_path( $Opt{DIR} ) ;
    my $dialog   = $Win->FileSelect( 
                        -directory => $Opt{DIR},
                        -filter    => "*$Const{FILE_SUFFIX}",
                        ) ;
    my $filename = $dialog->Show ;
    &cursor() ;

    if( $filename and -e $filename ) {
        &cursor( 'clock' ) ;

        my $msg = $Win->MesgBox(
                        -title     => "SimLife Overwrite File?",
                        -text      => "`$filename' exists - overwrite?",
                        -icon      => 'QUESTION',
                        -buttons   => [ 'Yes', 'No' ],
                        -defbutton => 'No',
                        -canbutton => 'No',
                        ) ;
        my $ans = $msg->Show ;

        &cursor() ;
        $filename = '' if $ans eq 'No' ;
    } 

   if( $filename ) {
        $Global{FILENAME} = &abs_path( $filename ) ;
        $Win->title( 'SimLife - ' . $Global{FILENAME} ) ;
		&file::save ;
    }
}


sub prompt_save {
    package main ;

    my $msg = $Win->MesgBox(
        -title     => 'SimLife Save Simulation?',
        -text      => "Save `$Global{FILENAME}'?", 
        -icon      => 'QUESTION',
        -buttons   => [ 'Yes', 'No' ],
        -defbutton => 'Yes',
        ) ;
    my $ans = $msg->Show ;

    &file::save if $ans eq 'Yes' ;
}


sub quit {
    package main ;

    &file::prompt_save unless $Global{WROTE_SIM} ;
    &write_opts ; 
    
    $Win->destroy ;
}


1 ;
