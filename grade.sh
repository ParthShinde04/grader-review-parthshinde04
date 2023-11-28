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

OUTPUT=$OUTPUT","

PHASE=1
FAILURES=0
TESTS=0
LENGTH=${#OUTPUT}
TEMPSTRING=""
for (( c=0; c<LENGTH; c++ ))
do
	CHAR=${OUTPUT:$c:1}
	# echo $CHAR
	if [[ $PHASE -eq 1 || $PHASE -eq 3 ]]
	then
		# Finding Semicolon for Tests Run
		if [[ $CHAR == ":" ]]
		then
			PHASE=$(($PHASE+1))
			TEMPSTRING=""
		fi
	elif [[ $PHASE -eq 2 || $PHASE -eq 4 ]]
	then
		# Getting Tests Run
		if [[ $CHAR == "," ]]
		then
			if [[ $PHASE -eq 2 ]]
			then
				TESTS=${TEMPSTRING:1}
			else
				FAILURES=${TEMPSTRING:1}
			fi
			PHASE=$(($PHASE+1))
		fi
		TEMPSTRING=$TEMPSTRING$CHAR
	fi
done

OKOUTPUT=`grep "OK" junitOutput.txt`
if [[ ${#OKOUTPUT} != 0 ]]
then
	OKOUTPUT=${OKOUTPUT#*\(}
	OKOUTPUT=${OKOUTPUT%[ ]*}
	TESTS=$OKOUTPUT
fi

# echo "PHASE: $PHASE"
# echo "FAILURES: $FAILURES"
# echo "TESTS: $TESTS"
PASSING=$(($TESTS-$FAILURES))
PERCENT=$(((100*$PASSING)/$TESTS))
echo "GRADE: $PERCENT% ($PASSING / $TESTS)"

cd ..