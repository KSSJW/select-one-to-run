# Select One To Run

A script that selects one of multiple matching files to run. 

## Instruction

1. Download or copy `Run.sh` from the repository.

2. Change the header parameters of `Run.sh`.

    > [!NOTE]
    > `Run.sh` will by default locate its own directory and scan for matching files.

    For example:

    - Directory structure:


    ```
    .
    |- MyJava-1.0.0.jar
    |- MyJava-1.1.0-beta.6.jar
    |- MyJava-2.0.3.jar
    |- Run.sh
    ```

    - Commands to be executed:

    ```
    java -Xms1G -Dglass.gtk.uiScale=1.5 -jar MyJava-<Version>.jar debug nogui
    ```

    - Parameters:

    ```
    STARTUP_COMMAND="java"
    STARTUP_PARAMETERS="-Xms1G -Dglass.gtk.uiScale=1.5 -jar"
    PROGRAMS_NAME="MyJava-*.jar"
    PROGRAMS_PARAMETERS="debug nogui"
    ```
3. Grant executable permissions.

    ```
    chmod +x Run.sh
    ```
4. Run the script.

    ```
    ./Run.sh
    ```