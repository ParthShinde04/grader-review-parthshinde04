Set -e

CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

# if statement that checks if ListExamples.java exsists
if [[ -f student-submission/ListExamples.java ]]
then
    echo 'Correct file submitted!'
else
    echo 'Try Again, the file ListExamples.java does not seem to be in the repository!'
    exit
fi

# Copy all files in student-submission to grading-area
cp student-submission/ListExamples.java grading-area
echo 'Copied all files in student-submission into grading-area!'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
