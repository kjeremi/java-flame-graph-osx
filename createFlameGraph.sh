#!/bin/bash

# Usage : ./createFlameGraph.sh keyword
# keyword is a unique word in your classpath to recognise your JVM ex : Catalina for tomcat 
PROFILED_PID=$(jps -v |grep $1 | awk '{print $1}')
STACKFILE=stack_$PROFILED_PID
rm -f "$STACKFILE"
createGraph ()
{
	echo
    echo "Done! Stacks saved to $STACKFILE"
TMPSTACKS=/tmp/flamegraph-stacks-collapsed.txt
TMPPALETTE=/tmp/flamegraph-palette.map

./stackcollapse-jstack.pl $STACKFILE > $TMPSTACKS

# 1st run - hot: default
./flamegraph.pl --cp $TMPSTACKS > stack_$PROFILED_PID.svg

# 2nd run - blue: I/O
cp palette.map $TMPPALETTE
cat $TMPPALETTE | grep -v '\.read' | grep -v '\.write' | grep -v 'socketRead' | grep -v 'socketWrite' | grep -v 'socketAccept' > palette.map
./flamegraph.pl --cp --colors=io $TMPSTACKS > stack_$PROFILED_PID.svg

echo "Done! Now see the output in stack_$PROFILED_PID.svg"
exit 0
}

echo "Getting stacktraces from process $PROFILED_PID... Will stop on ^C or when the process exits."
trap createGraph SIGINT SIGTERM
while true; do
	    jstack "$PROFILED_PID" >> "$STACKFILE" && sleep 0.01 || break
    done
createGraph
    



