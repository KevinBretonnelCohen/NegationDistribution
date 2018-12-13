#!/usr/bin/perl

# Purpose: take a directory containing text files.
# Count the number of negatives every 10K words.
# probably undercounts negated *things* because it
# doesn't account for coordination or scope of any
# sort--but, at least gives you a count of the
# negation words.

use strict "vars";

my $increment = 10000;
my $tokens = 0;
my $count_negatives = 0;

my $directory;

if (@ARGV) {
    $directory = pop(@ARGV);
} else {
    my $directory = "../craft-1.0/articles/txt";
    #my $directory = "../junkdir";
}

my $DEBUG = 0;

opendir (DIR, $directory) || die "Couldn't open directory $directory: $!\n";

$DEBUG && print "Directory: $directory\n";

my @files = readdir(DIR);

my $files_count = @files;

for (my $i = 0; $i < $files_count; $i++) {
    $DEBUG && print "checking file type: $files[$i]\n";

    if ($files[$i] =~ /.txt$/) {
	$DEBUG && print "File: $files[$i]\n";
	open (IN, "$directory/$files[$i]") || die "Couldn't open file $files[$i]: $!\n";
	while (my $line = <IN>) {
	    # check number of tokens that you've seen--
	    # it's not ever likely to ever match the increment,
	    # but probably close enough
	    if ($tokens >= $increment) {
		print "$count_negatives\n";
		$tokens = 0;
		$count_negatives = 0;
	    } else {
		my @tokens = split(" ", $line);
		$tokens += $#tokens;
	    }
	    #for ($line =~ /\b(no|not|none|denies|nothing)\b/i) {
	    for ($line =~ /\b(no|not|none|denies|nothing)\b/gi) {
		$count_negatives++;
	    } # loop through this line
	} # loop through lines in this file
    }
} # loop through list of files
