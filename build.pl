#!/usr/bin/env perl

use Getopt::Long;
use Data::Dumper;
use File::Find;
use Cwd;


my $srcPath = "src";
my $includePath = "include";
my $buildPath = "build";


my @c_files;
find(
    sub {
        return unless /\.c$/;
        push @c_files, $File::Find::name;
    },
    $srcPath
);

my @asm_files;
find(
    sub {
        return unless /\.s$/;
        push @asm_files, $File::Find::name;
    },
    $srcPath
);



foreach $c_file (@c_files){
    if( $c_file =~ /(\w*)\/(\w+)\.\w+/g ) {
        my $command = "-fno-stack-protector -ffreestanding -nostdlib -nostartfiles -nodefaultlibs -g -ggdb -Wall -Wextra -c -m32 -march=i686 -I" . $includePath . " " .
                        $c_file . " -o " . $buildPath . "/$1_$2" . ".o";
        my $k = system "gcc", (split ' ', $command) ;
        if($k != 0){
            #print $command . "\n";
            print STDERR "Error1\n";
            exit 1;
        }
    }
    else{
        print STDERR "Error2\n";
        exit 1;
    }
}

foreach $asm_file (@asm_files){
    if( $asm_file =~ /(\w*)\/(\w+)\.\w+/g ) {
        my $command = "-g --32 -march=i686 src/start.s -o build/start.o" .
                        $asm_file . " -o " . $buildPath . "/$1_$2" . ".o";
        #Dump $command;
        my $k = system "as", (split ' ', $command) ;
        if($k != 0){
            #print $command . "\n";
            print STDERR "Error1\n";
            exit 1;
        }
    }
    else{
        print STDERR "Error2\n";
        exit 1;
    }
}

my $out_files = ``;
find(
    sub {
        return unless /\.o$/;
        $out_files .= " " . $File::Find::name;
    },
    $buildPath
);

$out_files =~ s/\n/ /g;
my $linker_cmd = "-melf_i386 -T linker.ld". $out_files ." -o ".$buildPath ."/final";
print "\n";
if((system "ld", (split ' ', $linker_cmd)) != 0){
    print STDERR "Error3\n";
    exit 1;
}

exit 0;
