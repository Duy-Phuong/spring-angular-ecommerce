

To start, I made a new Java repl, searched for crawler4j, selected the edu.uci.ics:crawler4j package, added it, copy-pasted the quickstart example in crawler4j's README, and clicked "run."

# Setting Up Your Repl
Now that we’ve sorted all that out, create a .replit file in your project root and paste in the following:

```
language="Java"
run="cd YOURARTIFACTID && mvn clean install"
```

Remember! Replace the marked value with your own

This will automatically compile your code whenever you click the run button!

# Error "Source option 5 is no longer supported. Use 6 or later" on Maven compile
https://stackoverflow.com/questions/53034953/error-source-option-5-is-no-longer-supported-use-6-or-later-on-maven-compile


What helped me was these lines in pom.xml file
```
<!-- After groupId -->
<properties>
     <maven.compiler.source>1.8</maven.compiler.source>
     <maven.compiler.target>1.8</maven.compiler.target>
</properties>
```

run https://www.baeldung.com/java-run-jar-with-arguments

```
cd target
$ java -cp JarExample2.jar com.baeldung.jarArguments.JarExample "arg 1" arg2@


~/JavaMavenExample/target$ java -cp java-similarity-example-1.0-SNAPSHOT.jar common.string.JavaSimilarity
```


# Run java 

```
dir
javac Hello.java # gen class file
java Hello
```

or

You can add to run class that differ from Main class
```java
otherfile.main(args);
```