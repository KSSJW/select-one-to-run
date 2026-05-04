#!/bin/bash

# For example:
#   Directory structure:
#     .
#     |- MyJava-1.0.0.jar
#     |- MyJava-1.1.0-beta.6.jar
#     |- MyJava-2.0.3.jar
#     |- Run.sh
#
#   Commands to be executed:
#     java -Xms1G -Dglass.gtk.uiScale=1.5 -jar MyJava-<Version>.jar debug nogui
#
#   Parameters:
#     STARTUP_COMMAND="java"
#     STARTUP_PARAMETERS="-Xms1G -Dglass.gtk.uiScale=1.5 -jar"
#     PROGRAMS_NAME="MyJava-*.jar"
#     PROGRAMS_PARAMETERS="debug nogui"
STARTUP_COMMAND=""
STARTUP_PARAMETERS=""
PROGRAMS_NAME=""
PROGRAMS_PARAMETERS=""

trap 'exit 130' INT

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd 2>/dev/null)"
if [ -z "$SCRIPT_DIR" ]; then
  echo -e "\e[31mUnable to locate the directory of the script.\e[0m"
  read
  exit 1
fi

cd "$SCRIPT_DIR" || {
  echo -e "\e[31mFailed to switch directory:\e[0m $SCRIPT_DIR"
  read
  exit 1
}

echo "Current directory: $SCRIPT_DIR"
echo

PROGRAMS=($PROGRAMS_NAME)

if [ ! -e "${PROGRAMS[0]}" ]; then
  echo -e "\e[31mFailed to find $PROGRAMS_NAME.\e[0m"
  read
  exit 1
fi

if [ ${#PROGRAMS[@]} -eq 1 ]; then
  selected="${PROGRAMS[0]}"
else
  echo -e "\e[33mMultiple files found, please choose:\e[0m"
  for i in "${!PROGRAMS[@]}"; do
    echo "$((i+1)). ${PROGRAMS[$i]}"
  done
  echo

  read -p "Please enter a number to select a file: " choice

  if ! [[ "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -lt 1 ] || [ "$choice" -gt ${#PROGRAMS[@]} ]; then
    echo -e "\e[31mInvalid input.\e[0m"
    echo
    exec "$0"
  fi

  selected="${PROGRAMS[$((choice-1))]}"
fi

echo -e "\e[32mRunning $selected ...\e[0m"
echo

$STARTUP_COMMAND $STARTUP_PARAMETERS $selected $PROGRAMS_PARAMETERS || {
  echo
  read -p "Enter to exit."
  exit 1
}