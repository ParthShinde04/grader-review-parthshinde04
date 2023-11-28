Set -e

CPATH='.;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area
mkdir grading-area
git clone $1 student-submission


# if statement that checks if ListExamples.java exsists
if [[ -f student-submission/ListExamples.java ]]
then
    echo 'File is correct'
else
    echo 'Try Again'
    exit
fi


# Copy all files in student-submission to grading-area
cp student-submission/ListExamples.java grading-area
cp -r lib grading-area
cp GradeServer.java grading-area
cp Server.java grading-area
cp TestListExamples.java grading-area
echo 'Files moved to grading area'


# Runing junit from grading-area
cd grading-area
javac -cp .;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar *.java
java -cp .;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples
