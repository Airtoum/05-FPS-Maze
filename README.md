# Optic Maze
A firstperson 3D game where you're in a colourful maze trying to reach the exit. Getting to the exit room isn't too hard, but the platform that lets you climb up to reach the exit doesn't work yet. In order to repair it, you need to find two blue donuts in the maze.

Getting to the donuts might pose to be an issue, however. Along your way, you'll face off against small eye creatures that will attack you if you look at them for too long! To make matters worse, you might also find floating cube enemies that become inert when you're looking at them but chase you when you aren't. 

The player can close their eyes by holding shift by default. The controls can be seen and edited during gameplay in the pause menu, which can be brought up by pressing ESC.

There are also 9 hidden treasure chests you can find.

## Implementation
Made in Godot v3.2.3

Tileset, chest, and Freeze Enemy made in Blender

Sound effects made with beepbox.co

Art made with Powerpoint

## References
Special thanks to user unfa on [this thread](https://godotengine.org/qa/2843/how-to-check-if-an-object-is-visible-in-3d-view) for explaining a way to detect if something is in the player's line of sight.

Ever so slightly inspired by Antichamber. Also kind of inspired by an old Minecraft adventure map I made where you had to get to a certain spot in order to see a button so you could shoot an arrow at it.

## Future Development
I feel like the level design is kind of lacking in this game. It feels like a whole lot more could be done with cleverer use of level design to better exemplify the mechanics of the Optical Enemy and the Freeze Enemy, and the interplay between them.

Also, the lights the player hangs for each tile they visit. Godot only lets ~7 lights impact a single object at a time, so once you start placing down your 8th light and above, the illumination starts acting weird. If you're looking the right direction, all of the lights that were placed earlier get culled, so the lights nearby start working normally, but if you look back at a place where lights were before, then it only factors in the earliest 7 lights, which are usually far away. This didn't seem necessary to be fixed for this assignment since it's just a small detail, but it is kind of ugly.

Remove the whole blue donut and exit ramp system. It's gross and bad. I originally wanted some kind of thing you could pick up but I was hitting time constraints.

More clever mechanics that involve where you're looking. Maybe add puzzles?

The maze looks kind of simplistic but the aesthetic has kind of grown on me. I still think there ought to be some visual tweaks, though.

## Created by
Airtoum
