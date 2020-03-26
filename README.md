# Toy Robot

## Description
Toy Robot is a game to deploy robot in a grid and move them around. There are certain kind of rules such as
1. Collision between robots must be ignored
2. Moving to edges are ignored
3. There are several commands for the robot: Move, Place, Left, Right, Report

## To run it
1. Go to the `command.txt` file and put the commands that you want to
2. Type `./bin/run` to run the program with the given commands in terminal.
3. At the end, the result will be printed out.

## Implementations

Robot and Board models:
- Robot: 
	- This model holds some information about the robot such as Name, Direction, X position and Y position. 
	- Some business logic like Move, Left and Right 
- Board: 
	- This model holds some information about the size of the board which will be referred by the Robot.
	- Some business logic like finding whether a Robot is existed on a X, Y position to prevent collision.

TXTPARSER:
- Currently the commands are in a `.txt` file and TXTParser is to read the commands and make a set of commands related to the robots.

Command Executor:
- With the output from TXTParser, the Command Executor will run the commands to run the robots on the board.

## Future Improvements
There are several improvements that can be extend here:
1. Using a Database to store the status of the robots. With this way, we will not need hold the status of these robots in memory.
2. Instead of printing the result, we could use a frontend framework to show the robots' position.
3. Instead of using a `.txt` file with a parser that has high posibility of error proning, we can use a frontend framework to send commands to the backend in a more structure way. 