# Dynatrace AspectJ SDK Sample


This is a library that instruments and injects the Dynatrace header to an unsupported library.  
In this example, we are instrumenting com.pega.apache.http.protocol.HttpRequestExecutor

## Using

To use this, you will need to:

1. Add the `dist/dynatrace-pega-aspectj` folder to your classpath, ex: `-cp <install-folder>/dynatrace-pega-aspectj/*`
2. Add the aspectjweaver agent to your startup parameter, ex: `javaagent:<install-folder>/dynatrace-pega-aspectj/aspectjweaver.jar`
3. OPTIONAL: Add the java argument `-Dorg.aspectj.tracing.debug=true` for debugging purposes

## Building from Source

To build, you will need to install AspectJ, and put the ajc command on your path.  
Then, `cd` into the dist folderl and run `./build.sh`

## Sample SpringBoot App

There is a sample app on the sample-app folder.

You can run :

1. `./start-sample-app-upstream` to start the instrumented application
2. `./start-sample-app-downstream` to start the backend application

Then, make calls to `http://localhost:8080/service1` to generate load.

If everything works, and you have the OneAgent installed, the two purepaths will connect.
   


