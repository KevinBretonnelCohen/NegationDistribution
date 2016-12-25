echo CRAFT type count with negative prefix:
egrep ',(un|no|a|de|dis|anti|il|im|in|ir)[A-Za-z0-9]+,' ../Data/CRAFT.type.token.txt | egrep 'CRAFT' | wc -l
echo CRAFT type count without negative prefix:
egrep -v ',(un|no|a|de|dis|anti|il|im|in|ir)[A-Za-z0-9]+,' ../Data/CRAFT.type.token.txt | egrep 'CRAFT' | wc -l
echo MIMIC type count with negative prefix:
egrep ',(un|no|a|de|dis|anti|il|im|in|ir)[A-Za-z0-9]+,' ../Data/MIMIC2MD.type.token.txt | egrep 'MIMIC' | wc -l
echo MIMIC type count without negative prefix:
egrep -v ',(un|no|a|de|dis|anti|il|im|in|ir)[A-Za-z0-9]+,' ../Data/MIMIC2MD.type.token.txt | egrep 'MIMIC' | wc -l
# -h suppresses the file name in the grep output
egrep -h ',(un|no|a|de|dis|anti|il|im|in|ir)[A-Za-z0-9]+,' CRAFT.type.token.txt > CRAFTandMIMIC.type.token.with.prefix.csv
egrep -h ',(un|no|a|de|dis|anti|il|im|in|ir)[A-Za-z0-9]+,' MIMIC.type.token.txt >> CRAFTandMIMIC.type.token.with.prefix.csv
# -h suppresses the file name in the grep output
egrep -hv ',(un|no|a|de|dis|anti|il|im|in|ir)[A-Za-z0-9]+,' CRAFT.type.token.txt > CRAFTandMIMIC.type.token.without.prefix.csv
egrep -hv ',(un|no|a|de|dis|anti|il|im|in|ir)[A-Za-z0-9]+,' MIMIC.type.token.txt >> CRAFTandMIMIC.type.token.without.prefix.csv
echo Total type count with prefix:
wc -l CRAFTandMIMIC.type.token.with.prefix.csv
echo Total type count without prefix:
wc -l CRAFTandMIMIC.type.token.without.prefix.csv

# TODO: set a variable for the minimal counts and for the sample size
echo Non-biomedical multimorphemic distractors count:
wc -l /Users/kev/Dropbox/Negation/Data/distractors.nonbiomedical.multimorphemic.csv
echo Distractors, biomedical, not ambiguous, count:
wc -l /Users/kev/Dropbox/Negation/Data/distractors.not.ambiguous.biomedical.csv
echo Distractors, not ambiguous, non-biomedical, count: 
wc -l /Users/kev/Dropbox/Negation/Data/distractors.not.ambiguous.nonbiomedical.csv
echo Negatives, Wikipedia Plain English count:
wc -l /Users/kev/Dropbox/Negation/Data/negatives.wikipedia.plain.english.csv 

echo Making the experimental data...
# TODO WOULD BE NICE TO HAVE A WAY TO TIME-STAMP THE FILE
echo Deleting current version of output file... 
rm experiment.data.set.for.annotation.csv
echo Pull random sample of negatives from CRAFT...
./randomizeTypeTokenFiles.pl >> experiment.data.set.for.randomization.csv 
echo Pull random sample of negatives from MIMIC...
./randomizeTypeTokenFiles.pl >> experiment.data.set.for.randomization.csv 
echo Pull random sample of non-negatives from CRAFT...
echo Pull random sample of non-negatives from MIMIC...
echo Adding non-biomedical multimorphemic distractors...
./randomizeTypeTokenFiles.pl >> experiment.data.set.for.randomization.csv 
echo Adding non-biomedical unambiguous distractors...
./randomizeTypeTokenFiles.pl >> experiment.data.set.for.randomization.csv 
echo Adding non-biomedical ambiguous distractors...
./randomizeTypeTokenFiles.pl >> experiment.data.set.for.randomization.csv 
echo Adding non-biomedical negatives...
./randomizeTypeTokenFiles.pl >> experiment.data.set.for.randomization.csv 
echo Adding biomedical non-ambiguous distractors...
./randomizeTypeTokenFiles.pl >> experiment.data.set.for.randomization.csv 
echo Verifying data set size...
wc -l experiment.data.set.for.randomization.csv

echo Randomizing the entire sample...
# sample size is set to 100000 because you already have the amount of data
# that you want from the earlier steps
# ...similarly, minimum number of tokens is set to 0 because you already
# specified the number of tokens in the earlier steps; 0 because that's
# the number that I put for the distractors in the data files 
# ...no need to blow the output file away before creating it because 
# I'm using >, not >>
./randomizeTypeTokenFiles.pl experiment.data.set.for.randomization.csv 100000 0 > experiment.data.set.for.annotation.csv
echo Verifying data set size for annotation...
wc -l experiment.data.set.for.annotation.csv
