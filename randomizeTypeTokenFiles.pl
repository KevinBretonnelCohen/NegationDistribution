#!/usr/bin/perl

# take a file in the format that we're using for the negation experiment,
# randomize the contents, and spit out a specified number.

# can also set a value for minimum number of tokens that need to be in the
# corpus before you'll include it in the randomized set.

# Usage:
# ./randomizeTypeTokenFiles.pl input_file size_of_sample (minimum_tokens)

# TODO this reads in an entire file at once, which I hate to do--too easy
# to blow away your memory...

use strict 'vars'; 
use List::Util qw(shuffle);

my $infile_name = $ARGV[0];
my @unrandomized_lines; #

my $size_of_sample = 10000; # maximum sample size--defaults to 10,000,
# or you can set it on the command line

if ($ARGV[1]) {
    $size_of_sample = $ARGV[1];
}

my $minimum_tokens = 2; # this optionally sets the minimum number of times
# that a type has to occur in the corpus before you'll consider it for 
# including in the sample--the goal is to avoid spelling errors, which
# tend to only occur once, for the most part. It defaults to 1; you can
# override that on the command line (see immediately below).
#if ($ARGV[2]) {
#    $minimum_tokens = $ARGV[2];
#}

open(IN, $infile_name) || die "Couldn't open file named <$infile_name>: $!\n";

# read in the data that you want to randomize
while (my $line = <IN>) {
    # remove the newline
    chomp($line);

    # validate input
    $line =~ /^[0-9]+\,.+\,(CRAFT|MIMIC2MD)$/ || die "Bad input line: <$line>\n";

    # debug
    #print "$line\n";

    # check for minimum number of tokens desired
    my @line_contents = split(",", $line);
    my $number_of_tokens = $line_contents[0];
    
    # store it away
    if ($number_of_tokens >= $minimum_tokens) {
	push (@unrandomized_lines, $line);
    }

    # debug
    #my $length = @unrandomized_lines;
    #print "Length: " . $length . "\n"; 
}

# you've read in all of the data; now randomize it
my @randomized_lines = shuffle(@unrandomized_lines);

# debug
my $randomized_array_length = @randomized_lines;
#print "Randomized Length: $randomized_array_length\n";

# this is clunky, but I want to be able to record the sample size;
# here I turn that into the corresponding index into the array of
# randomized numbers

# make sure that you're not trying to take a bigger
# sample than you have in your data 
my $index;
if ($size_of_sample > $randomized_array_length) {
    $index = $randomized_array_length - 1;
} else {
    $index = $size_of_sample - 1;
}

# debug
#print "Size of sample: $size_of_sample\n";
#print "Index: $index\n";


# I can't believe I can't figure out how to use slice...
#my @sample = @randomized_lines[0,$index];
my @sample = kevinSlice($index, @randomized_lines);

# debug
#print "<@sample>";

# OK, now you have a random sample.  
# so, output it.
for (my $i = 0; $i <= $index; $i++) {
    print "$sample[$i]\n";
} 

# because I am apparently too stupid to be able to figure
# out how to use slices correctly
sub kevinSlice() {
    my ($index, @randomized_lines) = @_;
    my @sample = ();
    for (my $i = 0; $i <= $index; $i++) {
        push(@sample, $randomized_lines[$i]);
    }

    return @sample;
} # close subroutine definition kevinSlice()
