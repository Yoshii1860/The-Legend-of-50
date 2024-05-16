# The Legend of 50
This is a coursework project from Harvard University`s CS50G.

# Implemented Features

Health-Restoring Hearts:
- Lucky Loot: Enemies now have a chance to drop hearts upon defeat, offering a welcome health boost in the heat of battle.
- Full Recovery: Picking up a dropped heart completely replenishes the player's health, allowing them to quickly recover and continue fighting.

Portable Power:
- Pot Luck: Randomly scattered throughout the game world are helpful pots waiting to be discovered.
- Visual Feedback: Picking up a pot triggers a unique animation that depicts the player carrying the pot, adding a visual cue to the gameplay.
- Strategic Choice: While carrying a pot, the player's sword arm is temporarily disabled. This introduces an interesting decision-making element - prioritize ranged attacks with the pot or switch back to sword for close combat.

Explosive Projectiles:
- Thrilling Throws: Players can unleash a new offensive tactic by throwing the carried pot. The throwing direction aligns with the player's facing direction, allowing for precise aiming.
- Destructive Trajectory: Thrown pots travel in a straight line until they hit something:
  - A wall - The pot shatters upon impact.
  - An enemy (dealing 1 point damage) - The pot explodes, dealing damage to the enemy and then shatters.
  - After traveling more than four tiles - The pot reaches its effective range and shatters.
