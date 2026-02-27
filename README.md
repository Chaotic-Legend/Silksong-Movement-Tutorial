[![Static Badge](https://img.shields.io/badge/Godot%20Engine-4.3-blue?style=plastic&logo=godotengine)](https://godotengine.org/) ![GitHub top language](https://img.shields.io/github/languages/top/Chaotic-Legend/Silksong-Movement-Tutorial?logo=godotengine)

# Silksong Movement Tutorial #
[Godot Tutorial 2D - Programming Silksong Movement - Part 1](https://www.youtube.com/watch?v=lNePLabodBk) by [IcyEngine](https://icyengine.itch.io/) ([Discord](https://discord.com/invite/Ev9g6kBPnN))

This tutorial video was designed as a beginner follow-along project that guides viewers through building a 2D player controller inspired by the platformer movement of Hornet from Hollow Knight: Silksong, demonstrating how movement states, collision behavior, input setup, and a robust GDScript code are structured and implemented in the Godot Engine to create a flexible and expandable 2D platforming game. It also served as the foundation for completing a structured implementation task on Feather, with the project integrated into the wider development workflow supporting the Handshake AI Project Moonstone initiative.

# Assets #
[Silksong Movement Tutorial Template Files](https://icyengine.itch.io/silksong-movement-tutorial) by [IcyEngine](https://icyengine.itch.io/) ([YouTube](https://www.youtube.com/@IcyEngine))

![Sprite Asset](assets/art/2d/player/stick_figure/sf_idle_pixel.png)

# Create a Godot task #
<ins> **Step 1: Context setting** </ins>
<br>
Please include the following context-setting data about the tutorial and segment you selected.

OS version: Windows 11 Pro

Application version: Godot Engine v4.6.1.stable.official [14d19694e]

<ins> Description of the task/project you selected </ins>
<br>
Inspired by the gameplay of Hollow Knight: Silksong, the selected project will implement and replicate Hornet's platforming movement, focusing on programming the basic movement and mechanics of a pixel art character in the Godot Engine. This tutorial covers setting up the project and keybinds, implementing a state machine, and programming moves such as falling, walking, jumping, double jumping, floating, ledge climbing, and ledge jumping. This task will follow a YouTube video tutorial titled "Godot Tutorial 2D - Programming Silksong Movement - Part 1" created by IcyEngine, using the time segment from approximately 00:49 to 22:24.

- Start Point: https://youtu.be/lNePLabodBk?si=gugDO2DURNJEcp2t&t=49
- End Point: https://youtu.be/lNePLabodBk?si=-RUTf52q6qv5uI3X&t=1344

In this segment, the video tutorial demonstrates a systematic process for programming the 2D platformer movement and mechanics from Hollow Knight: Silksong in the Godot Engine. It covers setting up the project with a character sprite and essential nodes, configuring keybinds, and building a robust state machine to manage various player actions. The video tutorial meticulously breaks down each movement, showing how to implement physics, animations, and transitions between states. The core of the development focuses on implementing distinct movement states such as falling with gravity, walking, single jumping, double jumping, controlled floating, ledge climbing, and canceling the ledge climb. Each step builds on the previous one, progressively introducing new constants, variables, and functions to form a cohesive, scalable character controller that recreates Hornet's platforming movement.

<ins> Briefly describe the inputs to / input state of this project. </ins>
<br>
The input state consists of a newly created Godot Engine project using the template files from the Tutorial Ready Template pack created by IcyEngine on itch.io. This project utilizes a pre-configured assets folder that includes a functional test level, several structured nodes, a starter player controller, and an original sprite asset of a blue stick figure character. This template controller utilizes a CharacterBody2D root node, a CollisionShape2D node configured with a capsule shape for the sprite, a Camera2D node that follows the player character during movement, and an AnimatedSprite2D node containing multiple animation frames. https://icyengine.itch.io/silksong-movement-tutorial

<ins> **Step 2: Task completion** </ins>
<br>
Screen recordings and intermediate artifacts.

<ins> Brief description of the breakpoint-1 </ins>
<br>
Starting with the YouTube video tutorial, I created a new Godot project named "Silksong Movement Tutorial," and uploaded the "assets" folder from the Tutorial Ready Template pack to the "res://" folder in Godot and navigated to the "scenes" folder, then to the "levels" folder, and clicked on the "pixel_level.tscn" file to load the first scene with the sprite asset. I then opened "Project Settings" from the "Project" menu in the top-left corner, navigated to the "Input Map" tab, and created new actions named "move_left," "move_right," "jump," and "sprint," assigning them to the A and D keys, the Space bar, and the Shift key to configure player movement controls. I then opened the player controller script to program the state machine, where I defined an enum to represent the player's movement states, created a variable to track the active state, and wrote functions to switch between states and process their behavior during physics updates so the character's movement logic could get organized and expanded cleanly.

<ins> Brief description of the breakpoint-2 </ins>
<br>
Continuing with the YouTube video tutorial, I refined the state machine logic in the GDScript by implementing behavior for both the "FALL" and "FLOOR" states. First, I right-clicked the "AnimatedSprite" child node, enabled "Access as Unique Name" from the drop-down menu, and then dragged the node into the script while holding the Ctrl key to create the reference. For the "FALL" state, I updated the script to apply gravity for each physics frame, allowing the player's downward velocity to increase naturally until reaching a defined limit, while still permitting horizontal movement based on player input. I introduced constants such as "FALL_GRAVITY," "FALL_VELOCITY," and "WALK_VELOCITY" to keep the movement values organized and adjustable in the script. I also created a reusable "handle_movement" function to process horizontal input, apply left–right velocity, and flip the sprite direction, ensuring consistent movement logic across states. During the "FALL" state, gravity is applied to the player's vertical velocity while executing the "handle_movement" function, allowing the player to retain horizontal control while airborne. For the "FLOOR" state, I implemented logic to handle idle standing, walking, and transitions between grounded and airborne behavior using Godot's built-in floor detection. I configured the script to trigger the appropriate animations depending on whether movement input is present, switching between idle and walk animations while reusing the same "handle_movement" function for horizontal motion. I also established the core state transitions: the player switches to the "FALL" state when no longer detected on the floor, and returns to the "FLOOR" state when landing, ensuring responsive movement within the Godot physics system.

<ins> Brief description of the breakpoint-3 </ins>
<br>
Following the YouTube video tutorial, I added a variable-height jump mechanic in Godot where the jump input duration determines the player character's jump height. The player character reaches maximum jump height when holding the Space key, but releasing it early cuts the jump short, which causes the player character to descend immediately. To support this behavior, I added a "Timer" node named "CoyoteTimer" as a child of the "PlayerController" node to provide a short grace period that still allows jumping shortly after leaving a platform. Inside the timer's settings, I changed the "Process Callback" to "Physics," set the "Wait Time" to 0.2 seconds to define the grace window, enabled "One Shot," and then right-clicked the "CoyoteTimer" node, enabled "Access as Unique Name" from the drop-down menu, and dragged it into the script to create a direct reference. In the GDScript, I added a constant named "JUMP_VELOCITY" with a value of -600.0 to define the initial upward force and another constant named "JUMP_DECELERATION" with a value of 1500.0 to control how quickly upward motion slows when the jump input is released. When entering the jump state, I start the jump animation, set the Y velocity, and stop the coyote timer, which is triggered when transitioning from the "FLOOR" state to the "FALL" state. Inside the "process_state" function, I define the jump behavior by gradually reducing the upward velocity toward zero while still allowing horizontal control through the "handle_movement" function. I also added logic to transition into the "FALL" state either when the jump button is released or when the vertical velocity becomes positive, ensuring a natural arc. Finally, I enabled transitions into the "JUMP" state from the "FLOOR" state when pressing the jump button and from the "FALL" state when pressing the jump button while the coyote timer remains active.

<ins> Brief description of the breakpoint-4 </ins>
<br>
Working with the YouTube video tutorial, I implemented the "DOUBLE_JUMP" state by defining a constant named "DOUBLE_JUMP_VELOCITY" with a value of -450.0 to control the upward force, and by introducing a boolean variable called "can_double_jump," initialized to false, to track whether the ability is available while airborne. When entering the "DOUBLE_JUMP" state, the script plays the "double_jump" animation, applies the upward motion by setting the player's Y velocity to "DOUBLE_JUMP_VELOCITY," and immediately sets the "can_double_jump" variable to false to prevent repeated jumps. Horizontal movement remains responsive during this state, allowing the player to retain full control while airborne. To prevent the animation from being overridden too quickly, I modified the "FALL" state so the standard fall animation plays when the previous state was not a double jump. The ability gets restored by resetting the "can_double_jump" variable to true when the player lands, with its movement logic integrated into the existing jump system rather than implemented as a separate state script. Finally, when pressing the jump button while airborne, the script first checks whether it can trigger a coyote time jump; if not, it then checks whether "can_double_jump" is true and, if so, transitions to the "DOUBLE_JUMP" state, allowing the player to jump a second time by pressing the Space key again.

<ins> Brief description of the breakpoint-5 </ins>
<br>
To implement the "FLOAT" state in my Godot project, inspired by the "Drifter's Cloak" in Silksong, which allows the Hornet to hover by pressing and holding the jump button while falling. To set this up, I first added a "FloatCooldown" Timer node as a child of the "PlayerController" node, changed the "Process Callback" to "Physics," set the "Wait Time" to 0.1 seconds, enabled "One Shot," and then right-clicked the "FloatCooldown" node, enabled "Access as Unique Name" from the drop-down menu, and dragged it into the script. I also introduced two new constants: "FLOAT_GRAVITY" with a value of 200.0 and "FLOAT_VELOCITY" with a value of 100.0, which control the upward force and reduced gravity while floating. Upon entering the float state, the script checks the "FloatCooldown" timer; if active, it reverts to the previous state to prevent an invalid float. If not on cooldown, the float animation plays, and the player's Y velocity is set to zero, allowing the character to hover in place. The "FLOAT" state mirrors the "FALL" state's motion handling, but uses "FLOAT_GRAVITY" and "FLOAT_VELOCITY" constants to produce a slower descent while maintaining horizontal control. To exit the "FLOAT" state, the player transitions back to the "FALL" state when the jump button is released, which also triggers the "FloatCooldown" Timer to prevent immediate reuse. By nesting the float transition within an "else" statement after the coyote timer and double jump checks, the script prioritizes those actions. This logic prevents the shared input from triggering a float prematurely while the player is in the "FALL" state.

<ins> Brief description of the breakpoint-6 </ins>
<br>
To implement the "LEDGE_CLIMB" state in my Godot project, I began by setting up crucial components in the "PlayerController" scene. This process involved adding a "RayCast2D" node named "LedgeClimbRayCast," positioned diagonally in front of the player for precise ledge detection, and another "RayCast2D" node called "LedgeSpaceRayCast," placed next to the player and pointing upward to verify clear space for climbing, making it slightly taller than the collider. Both "RayCast2D" nodes and the "PlayerCollider" node were set to "Access as Unique Name" from the drop-down menu to drag them into the script, and I introduced a "facing_direction" variable initialized to 1.0. In the "_ready" function, I specifically configured the "LedgeClimbRayCast" to ignore the player's own collision shape, preventing self-detection issues. Upon entering the "LEDGE_CLIMB" state, the script automatically activates the "ledge_climb" animation, sets the player's velocity to zero, precisely aligns the player's Y position with the detected ledge's collision point, and resets the "can_double_jump" variable to true. I updated the "handle_movement" function to dynamically adjust the "facing_direction" based on player input and correctly update each "RayCast2D" node's X position and target position, forcing a refresh to keep the collision data current during gameplay.

<ins> Brief description of the breakpoint-7 </ins>
<br>
Furthermore, I implemented four essential helper functions: "is_input_toward_facing" to verify that the player is moving in the facing direction, "is_ledge" to confirm valid ledge conditions by checking "is_on_wall_only," the "LedgeClimbRayCast" collision, and that the surface normal points upward, "is_space" to ensure there is enough room above the ledge by repositioning and updating the "LedgeSpaceRayCast," and "ledge_climb_offset" to perfectly snap the player to the ledge top using the collision shape's size. Within the "process_state" function for the "LEDGE_CLIMB" state, once the animation concludes, the idle animation begins, a calculated offset updates the player's position, and the state seamlessly transitions to the "FLOOR" state. Furthermore, I developed four essential helper functions: "is_input_toward_facing" to confirm input direction, "is_ledge" to validate ledge conditions, "is_space" to verify clear space above the ledge by repositioning and updating LedgeSpaceRayCast, and "ledge_climb_offset" to perfectly snap the player to the ledge top using the collision shape's size. Within the "process_state" function for the "LEDGE_CLIMB" state, once the animation concludes, the idle animation begins, a calculated offset updates the player's position, and the state seamlessly transitions to the "FLOOR" state. Finally, transitions into the "LEDGE_CLIMB" state are enabled from both the "FALL" and "FLOAT" states, triggered by an "elif" condition that checks for input toward the facing direction, confirms a valid ledge, and verifies there is enough space to complete the climb.

<ins> Brief description of the breakpoint-8 </ins>
<br>
Finishing with the YouTube video tutorial, I implemented the "LEDGE_JUMP" state, which involved defining a constant named "LEDGE_JUMP_VELOCITY" with a value of -500.0, which controls the upward force when the user presses the jump button. When the player enters the "LEDGE_JUMP" state, the script triggers an animation, reusing the "double_jump" animation for visual effect, and sets the player's Y velocity to "LEDGE_JUMP_VELOCITY." Similar to the "DOUBLE_JUMP" state, its logic gets incorporated into the "process_state" function as a condition alongside the normal "JUMP" state. The primary transition into this state originates from the "LEDGE_CLIMB" state, triggered by an "elif" statement that detects when the user presses the jump button. If detected, a "progress" variable calculates how far the player is into the climb animation when the jump cancel occurs. The "progress" value scales the horizontal value of the "ledge_climb_offset" variable to determine the player's jump distance from the ledge, and then the state transitions to "LEDGE_JUMP" rather than reverting to "FLOOR." Having completed a robust animated character controller with horizontal walking, falling, single jumping, double jumping, floating, ledge climbing, and ledge jumping, the next part of this project will introduce additional special moves, including wall sliding, wall jumping, wall climbing, sprinting, and dashing.

<ins> **Step 3: Task specification** </ins>
<br>
Prompt reference file(s).

<ins> Reference link/description </ins>
<br>
Godot Tutorial 2D - Programming Silksong Movement - Part 1 by [IcyEngine](https://www.youtube.com/@IcyEngine): https://www.youtube.com/watch?v=lNePLabodBk

<ins> Reference link/description </ins>
<br>
Silksong Movement Tutorial Files from the Tutorial Ready Template by [IcyEngine](https://itch.io/profile/icyengine): https://icyengine.itch.io/silksong-movement-tutorial

<ins> Final Prompt </ins>
<br>
In the Godot Engine, create a playable 2D game with a resolution of 1152 × 648 pixels, featuring a controllable player character using a pixel-art sprite asset. The scene should have a solid background color of #4d4d4d, and the player sprite should display sharply with preserved pixel detail using the "Nearest" texture filter. The player character is a blue sticker figure that can walk, jump, double jump, fall, float, climb ledges, and perform ledge jumps. All movement behaviors use constants defined in the GDScript code that are unchangeable at runtime, but can be adjusted in the code to fine-tune gameplay balance. These distinct constants include "FALL_GRAVITY" to control the gravity while falling, "FALL_VELOCITY" to control the falling speed, "WALK_VELOCITY" to control the walking speed, "JUMP_VELOCITY" to control the initial jump force, "JUMP_DECELERATION" to control the jump speed slowdown, "DOUBLE_JUMP_VELOCITY" to control the double jump speed, "FLOAT_GRAVITY" to control the gravity while slowly floating down, "FLOAT_VELOCITY" to control the vertical floating speed, and "LEDGE_JUMP_VELOCITY" to control the ledge jump speed.

The physics is configured with a gravity value of 980 pixels per second squared, ensuring that the player character responds naturally to falls and jumps in the game environment. The Input Map defines custom input actions to control the player character, with "move_left" bound to the A key for leftward movement, "move_right" bound to the D key for rightward movement, "jump" bound to the Space key for jumping, and "sprint" bound to the Shift key for sprinting. Player movement responds to input as follows: the A key moves the player left, the D key moves the player right, pressing the Space key once performs a normal single jump, pressing it twice performs a double jump, and pressing it a third time, holding the key, causes the player to float and descend slowly. Pressing and holding the Space key causes the player character to jump higher, and releasing all input keys immediately stops player movement during gameplay. The movement functionally allows the player character to jump briefly after walking off a ledge, commonly known as coyote time, and applies a cooldown to regulate how frequently the player can float.

The floating mechanic grants the player character the ability to pause and hover while airborne, and to repeat this action for precise midair control and maneuverability. The player controller incorporates ledge detection to identify climbable surfaces and confirm that adequate open space exists above or behind the player character to allow safe movement. If the required gameplay conditions have been satisfied, the character can automatically climb over the ledge or quickly press the Space key during the ledge climb to perform a ledge jump without colliding with surrounding geometry. The specific method used to detect ledges is flexible, but the climbing and ledge jumping behavior must function correctly and be clearly observable during gameplay. A movement state machine in the GDScript controls the player's behavior, enabling consistent transitions between falling, walking, jumping, double jumping, floating, ledge climbing, and ledge jumping. Each movement state responds correctly to the defined constants, timers, raycasts, and input actions, ensuring consistent behavior while allowing the gameplay to be easily tuned and adjusted.

<ins> Rubric Items </ins>
<br>
1. The project's viewport width value is 1152. 
- Confirm that the Viewport Width value is equal to 1152 by navigating to "Project Settings," then "Display," and then "Window."
- The prompt requires that the project's resolution be 1152 x 648, and because these values are adjustable individually, they should each receive partial credit.

2. The project's viewpoint height value is 648.
- Confirm that the Viewport Height value is equal to 648 by navigating to "Project Settings," then "Display," and then "Window."
- The prompt requires that the project's resolution be 1152 x 648, and because these values are adjustable individually, they should each receive partial credit.

3. The scene's background color is filled with the color #4d4d4d.
- Verify that the Default Clear Color hex value is #4d4d4d by clicking on "Project Settings," then "Rendering," and then "Environment."
- The prompt requires that the entire scene background have a color of #4d4d4d for the environment.

4. The project's physics gravity value is 980 pixels/s^2.
- Confirm that the Default Gravity value is equal to 980.0 px/s^2 by clicking on "Project Settings," then "Physics," and then "2D."
- The prompt requires that the project's physics gravity be exactly 980.0 pixels per second squared for the environment.

5. The project's default texture filter is assigned to nearest.
- Confirm that the Default Texture Filter is assigned to "Nearest" by clicking on "Project Settings," then "Rendering," and then "Textures."
- The prompt requires that the sprite asset display a clearly visible pixel-art texture with crisp edges and preserved detail.

6. The Input Map includes a "move_left" action bound to the A key.
- Confirm an input action exists with the A key by navigating to "Project Settings" and then to "Input Map" to see the "Action" list.
- The prompt requires that the A key be assigned as a keyboard input action to move the player character to the left.

7. The Input Map includes a "move_right" action bound to the D key.
- Confirm an input action exists with the D key by navigating to "Project Settings" and then to "Input Map" to see the "Action" list.
- The prompt requires that the D key be assigned as a keyboard input action to move the player character to the right.

8. The Input Map includes a "jump" action bound to the Space key.
- Confirm an input action exists with the Space key by navigating to "Project Settings" and then to "Input Map" to see the "Action" list.
- The prompt requires that the Space key be assigned as a keyboard input action to make the player character jump.

9. The Input Map includes a "sprint" action bound to the Shift key.
- Confirm an input action exists with the Shift key by navigating to "Project Settings" and then to "Input Map" to see the "Action" list.
- The prompt requires that the Shift key be assigned as a keyboard input action to make the player character sprint.

10. Pressing the A key moves the player character to the left.
- Run the main scene and press the A key to observe the sprite asset perform leftward movement.
- Pressing the A key should cause the sprite asset to move left, as required by the prompt.

11. Pressing the D key moves the player character to the right.
- Run the main scene and press the D key to observe the sprite asset perform rightward movement.
- Pressing the D key should cause the sprite asset to move right, as required by the prompt.

12. Pressing the Space key makes the player character jump up.
- Run the main scene and press the Space key to observe the sprite asset jump upward.
- Pressing the Space key should cause the sprite asset to jump up, as required by the prompt.

13. Pressing the Space key twice makes the player character double jump.
- Run the main scene and press the Space key twice to observe the sprite asset jump twice.
- Pressing the Space key twice should cause the sprite asset to double jump, as required by the mechanic in the prompt.

14. Pressing the Space key thrice makes the player character float down.
- Run the main scene and press the jump key three times, holding it down on the third press to make the player character float down.
- Pressing the Space key three times, holding it on the third press, should cause the player to float down, as required by the prompt.

15. Holding the Space key makes the player jump higher than tapping it.
- Run the main scene, quickly tap the Space key for a normal jump, and then press and hold the Space key for a high jump.
- Pressing and holding down the Space key should cause the sprite asset to jump up higher, as required by the mechanic in the prompt.

16. The player character can climb over any ledge when in close contact.
- Run the main scene, move close to any ledge in the level, and observe the player character automatically perform a ledge climb.
- The player character should automatically climb over any ledge when the game detects it as climbable, as required by the prompt.

17. Pressing the Space key during the ledge climb executes a ledge jump.
- Run the main scene, quickly press the Space key during a ledge climb, and observe the player character perform a ledge jump.
- The player character should jump over any ledge when pressing the Space key during the ledge climb, as required by the prompt.

18. The player character stops moving when any input key is released.
- Run the main scene, press any input action key, then release the action key, and observe whether movement ceases instantly.
- The prompt requires that the player character stop moving immediately when any pressed input action key is released.

19. The player character can briefly jump right after walking off any ledge.
- Run the main scene, walk off any platform, then quickly press the Space key to perform a jump right after leaving the ledge.
- The prompt requires that the player character have a coyote timer to allow players to fairly jump right after walking off any ledge.

20. The player character can repeatedly pause and float while airborne.
- Run the main scene, double jump off a high platform, and while in midair, repeatedly press and hold the Space key to float continually.
- The prompt requires that the player character can pause and float multiple times while airborne to use the cooldown time functionality.

21. The player character correctly transitions between movement states.
- Inspect the player GDScript code to confirm that there is an enum named STATE defining the distinct movement states: FALL, FLOOR, JUMP, DOUBLE_JUMP, FLOAT, LEDGE_CLIMB, and LEDGE_JUMP.
- The prompt requires a functional state machine implemented in code that controls all movement states of the player character.

22. A "FALL_GRAVITY" constant controls the player's gravity while falling.
- Inspect the GDScript code for an unchangeable constant named "FALL_GRAVITY" affecting the falling gravity of the player character.
- The prompt requires the GDScript code to define falling gravity as an unchangeable constant, but configurable for movement balance.

23. A "FALL_VELOCITY" constant controls the player's falling speed.
- Inspect the GDScript code for an unchangeable constant named "FALL_VELOCITY" affecting the fall speed of the player character.
- The prompt requires the GDScript code to define falling velocity as an unchangeable constant, but configurable for movement balance.

24. A "WALK_VELOCITY" constant controls the player's walking speed.
- Inspect the GDScript code for an unchangeable constant named "WALK_VELOCITY" affecting the walk speed of the player character.
- The prompt requires the GDScript code to define walk velocity as an unchangeable constant, but configurable for movement balance.

25. A "JUMP_VELOCITY" constant controls the player's initial jump force.
- Inspect the GDScript code for an unchangeable constant named "JUMP_VELOCITY" affecting the jump speed of the player character.
- The prompt requires the GDScript code to define jump velocity as an unchangeable constant, but configurable for movement balance.

26. A "JUMP_DECELERATION" constant controls the jump slowdown rate.
- Inspect the GDScript code for an unchangeable constant named "JUMP_DECELERATION" affecting the jump slowdown of the player.
- The prompt requires the GDScript code to define jump deceleration as an unchangeable constant, but configurable for jumping control.

27. A "DOUBLE_JUMP_VELOCITY" constant controls double jump force.
- Inspect the GDScript code for an unchangeable constant named "DOUBLE_JUMP_VELOCITY" affecting the double jump speed.
- The prompt requires the GDScript code to define the double jump velocity as an unchangeable constant, but configurable for jumping.

28. A "FLOAT_GRAVITY" constant controls the player's floating gravity.
- Inspect the GDScript code for an unchangeable constant named "FLOAT_GRAVITY" affecting the float gravity of the player character.
- The prompt requires the GDScript code to define the float gravity as an unchangeable constant, but configurable for movement balance.

29. A "FLOAT_VELOCITY" constant controls vertical speed while floating.
- Inspect the GDScript code for an unchangeable constant named "FLOAT_VELOCITY" affecting the floating speed of the player.
- The prompt requires the GDScript code to define float velocity as an unchangeable constant, but configurable for movement balance.

30. A "LEDGE_JUMP_VELOCITY" constant controls the ledge jump force.
- Inspect the GDScript code for an unchangeable constant named "LEDGE_JUMP_VELOCITY" affecting the player's ledge jump speed.
- The prompt requires the GDScript code to define the ledge jump velocity as an unchangeable constant, but configurable for jumping.
<br>
Godot - https://feather.openai.com/tasks/fa76dc0f-dfc9-47fd-8763-c71a335f2b59 - Fixing the corrections from the first review of my third Create a Godot task.
