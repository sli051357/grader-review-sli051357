CPATH='.;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

# Detect whether file exists
file=`find student-submission -name "ListExamples.java"`
if [ -f $file ]; then 
   echo "File found"
else 
   echo "File ListExamples.java not found"
   exit 1
fi 

# What if list-examples is in a directory by itself?

# Copy files into grading-area
cp $file grading-area/
cp TestListExamples.java grading-area/ 
cp -r lib/ grading-area/

cd grading-area
javac -cp "$CPATH" *.java

if [ $? -ne 0 ]; then
    echo "Compilation error!"
    exit 1
fi

echo "Program compiled successfully!"

# actually run the program and report the grade
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > junit-output.txt

if grep -q FAILURES "junit-output.txt"; then 
    lastline=$( tail -n 2 junit-output.txt )
    totaltests=$( awk -F ': |,' '{print $2}' <<< $lastline )
    failures=$(awk -F ': |,' '{print $4}' <<< $lastline )
    successes=$((totaltests - failures))
else 
    lastline=$( tail -n 2 junit-output.txt )
    totaltests=$( awk -F '\\(| ' '{print $3}' <<< $lastline )
    successes=$totaltests
fi
echo "Your score is $successes / $totaltests"

exit 0