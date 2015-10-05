# java-flame-graph-osx
Bunch of scripts to generate flameGraph of a Java process on OSX 

It's based on the brillant work of Brendan Gregg ([Java Flame Graphs](http://www.brendangregg.com/blog/2014-06-12/java-flame-graphs.html)) and on the scripts provided by [mik01aj](https://gist.github.com/mik01aj/1811bb1ccf7dd5f716ce).


If you're on Linux, a better methods is available [here](http://techblog.netflix.com/2015/07/java-in-flames.html). It uses perf_events to profile  java method calls and system calls. On Osx a bug with Dtrace + jstack prevents for doing the same. 
So we only have access to the java stack. It's not perfect but enough in most of the case. 

## How generate a flame graph

* Git clone this repository
* Found a specific unique keyword in the command line of the java process you want to graph (ex Catalina for tomcat). 
* Run `./createFlameGraph.sh <keywork>`
* Open the svg file generated with your web browser.

## How read a flame graph

Each stack represents the sum of the time consummes by a method's call. The larger of the stack is, the longer it will take to excute the method. 
It gives you a good overview on where your process has spent its time during the sampling period. 

It's not a time line the stacks aren't in chronological order. 

You can zoom in by clicking on a stack. 


