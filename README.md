# Calamity: Definitive Edition

This repository houses the Minecraft: Java Edition custom profile for Calamity.

Calamity is a two-laned attack and defend game mode for Minecraft: Java Edition. The goal of the game is to gain enough points to reach the score limit. The score limit is determined by how much ore is left in the central iron mines. The less iron ore in the mines, the lower the score limit will be.

Players can gain points for their team by crafting items with iron ingots, capturing resource points, and through killing other players. Players can remove iron ore from the central mines to lower the score limit, making it easier to win. If players venture into enemy territory, they can capture power status effects for their team, or even Enchanted Books to power-up their tools or weapons.

## Modified Minecraft elements
This game is played in survival mode, but some elements have been modified. This is an entirely uncomprehensive list:

- Redstone Lamps drop nothing
- Sea Lanterns drop nothing
- Players are prevented from placing blocks in the void crosslane
- Iron Nuggets cannot be gained from smelting Iron Tools
- New recipes
  - Chainmail Helmet, Chestplate, Leggings, and Boots can be crafted with Chain
  - Shields can be crafted with Chain in the place of the Iron Ingot
  - Crafting Table can be crafted with Scaffolding (2x2)
  - Flint and Steel can be crafted with Flint and Chain
  - Scaffolding can craft 4 Sticks (1x2)
  - Wooden Tools can be crafted using Scaffolding in the place of planks
  - Anvils can be crafted with only 7 iron ingots
- Edited game rules
  - Players will respawn instantly when they die
  - Players will not need to eat food, but they will not be oversaturated
- Used for development purposes, and unavailable for normal play
  - Nether Star (item)

## Features of the Calamity game mode
- Resource points
  - Has a modifiable charge and reset time (see map-specific rules below)
  - Players who are standing on the point when it is charged will receive items or status effects
  - Players can only use resource points outlined in their team's color
  - Points which give status effects are team wide, but only require one player to activate
- Spawn items
  - Players will first spawn with a set of iron tools. The first tool you use is the one you will respawn with. Use /trigger resetSpawnItem to change your chosen item on your next life.
  - Spawn items have 10 durability left, and the Curse of Vanishing
- Scoring points
  - Crafting items with iron ingots gives points equal the amount of iron ingots used in the recipe
    - Crafting Iron Blocks, Iron Nuggets, or Iron Ingots does not award points
  - Other point scoring is determined by map rules, see section below
- Enchanted Books
  - This resource point is located under your enemy's base
  - The output is determined by what item is held in your main hand
  - Holding a sword will produce a sword-related enchanted book (Knockback I)
  - Holding a tool will produce an enchanted book related to that tool
  - Every player in the server will be made aware if you are given an enchanted book
- Iron Mines
  - The iron mine in the crosslanes determines what the score limit is
  - Players can remove, add, or destroy iron ore to change the score limit
  - The amount of iron ore left in the mines is checked frequently

## Map-specific features for Calamity
Calamity is both the game mode, and the first arena introduced. I hope to make, or see the community make, more maps!

- Difficulty is set to normal
- Mobs will not spawn
- Resource points take 20 seconds (400 redstone ticks) to charge and reset
- Scoring
  - Players are awarded 1 point for capturing resource or status effect resource points
  - Players are awarded 20 points for capturing the Enchanted Book resource point
  - Players are awarded 1 point for killing other players

# Usage
To play or modify Calamity: Definitive Edition, you should follow these steps:

1. If using the GitHub website, click the green Code button at the top-right of this column.
1. Select Download ZIP and unzip the folder to a safe location.
1. Create a custom Installations profile in your Minecraft launcher. Search online for these instructions if you do not know how to. Check out the [Minecraft Wiki's page on Minecraft Launcher](https://minecraft.gamepedia.com/Minecraft_Launcher#Installations).
1. Point the custom installation profile directory to the base Calamity folder.
1. Launch Minecraft: Java Edition and open the world save.
1. Type `/function #calamity:load` to initalize the map. This will only need to be done once.
1. Menu functions can be accessed by through the game table in the lobby, or by typing `/trigger ` and seeing what autocomplete commands come up. Use [TAB] to cycle through what commands are currently available to you. All players can use these commands.

### Available commands
During the lobby stage:
- `/trigger startMatch`: Triggers 15 second countdown to start the match.
- `/trigger cancelStart`: Cancel match start. Available during the 15 second start match countdown.
- `/trigger selectTeam set 1`: Join the blue team. Available if you're not on a team.
- `/trigger selectTeam set 2`: Join the red team. Available if you're not on a team.
- `/trigger leaveTeam`: Leave your team. Available if you are on a team.
- `/trigger toggleSpectator`: Toggle between spectator and adventure gamemodes.

During the match:
- `/trigger gg`: If 75% of the team uses this command, the match will end.

After the match:
- `/trigger reset`: Reset the map to the default state so another match can be played


# Videos
- The original release video: https://www.youtube.com/watch?v=uS1vwXRyqtU
- Calamity 2 release trailer: https://www.youtube.com/watch?v=znPL4g3sRC8
- Calamity as played by Etho and MindCrack: https://www.youtube.com/watch?v=LLPkxIK3JoQ
- Calamity 4 trailer, the last version released: https://www.youtube.com/watch?v=Ggc9O2X2-xg
