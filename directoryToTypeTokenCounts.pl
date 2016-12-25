#!/usr/bin/perl

# convert directory full of data to token count, type, 
# and an arbitrary literal 

# list contents of a directory
# for each file in the directory...
# for each line in the file...
# for each word in the line...
# normalize case, normalize punctuation, count

# output words ordered by token count and then alphabetically

# authors: Kevin Cohen and Foster Goss 303-916-2417

# catch typos
use strict "vars";

my %tokenCounts;

# this gets appended to every line--use it to label which corpus
# your data came from 
#my $literal_string = "LITERAL";  
my $literal_string = "CRAFT";  
#my $literal_string = "MIMIC2MD";

# list contents of directory
#my $directory_name = "/Users/kev/Dropbox/Negation/Code";
#my $directory_name = "/Users/kev/Dropbox/A-M/Corpora/MIMIC2/negationdist/";
my $directory_name = "/Users/kev/Dropbox/A-M/Corpora/craft-1.0/articles/txt/";
#my $directory_name = "/Users/kev/Dropbox/A-M/Corpora/MIMIC2/md/";
 
opendir(DIR, $directory_name) || die "Couldn't open directory $directory_name: $!\n";

my @directory_contents = readdir(DIR);

#my $file_name = "/Users/kev/Dropbox/Negation/Code/md.text.txt";
#my $file_name = "/Users/kev/Dropbox/A-M/Corpora/MIMIC2/md/kev_clinical_md.txt";

while (my $file_name = pop(@directory_contents)) {

    # filter file names--check to make sure that this/these work for you
    unless ($file_name =~ /txt$/) { next; }
    $file_name = $directory_name . $file_name;

    open(IN, $file_name) || die "Couldn't open input file $file_name\n";
 
    while (my $line = <IN>) {
	#print $line;
	chomp($line); 
	my @words = split(" ", $line);
	for (my $i; $i < @words; $i = $i + 1) {
	    #print "$words[$i]\n";
	    my $normalized_word = $words[$i];
	    $normalized_word = lc($normalized_word);
	    #print "$normalized_word\n";
            while ($normalized_word =~ /[\W]/) {
	    $normalized_word =~ s/[\W]+//;
	    }
	    #print "$normalized_word\n";
            # bug fix: this was outputing an empty string in the case
            # where the input was all punctuation 
            if ($normalized_word =~ /./) {
		$tokenCounts{$normalized_word}++;
	    }
	} # close for-loop through line
    } # close while-loop through file
} # close while-loop through directory contents

#my @normalized_words = sort {($tokenCounts{$b} cmp $tokenCounts{$a}) || ($a cmp $b)}  keys(%tokenCounts);
my @normalized_words = sort {($tokenCounts{$b} <=> $tokenCounts{$a}) || ($a cmp $b)}  keys(%tokenCounts);

for (my $i = 0; $i < @normalized_words; $i++) {
    #print "$normalized_words[$i]\n";
    #print "$tokenCounts{$normalized_words[$i]}\n";
    print "$tokenCounts{$normalized_words[$i]},$normalized_words[$i],$literal_string\n";

}
