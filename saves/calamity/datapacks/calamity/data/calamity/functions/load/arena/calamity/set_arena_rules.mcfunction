# Called from: #calamity:load

#---------------------------------------------------------------------------------------------------
# Purpose: Game rules control global elements of the game.
#---------------------------------------------------------------------------------------------------
# Removing and readding objectives complete wipes the set data and sets these values.
scoreboard objectives remove mapRules
scoreboard objectives add mapRules dummy
    # PointChargeTime: Point refers to resource points, a physical location on the map where players
    #   can gain  resources or status effects for their team. ChargeTime refers to how much time
    #   must pass before resources or status effects are given. ResetTime refers to how much time
    #   must passes before the the resource point can be used again. 
    # 20 redstone ticks = 1 second
    # 400/20 = 20 seconds
	scoreboard players set PointChargeTime mapRules 400
	scoreboard players set PointResetTime mapRules 400

    # Let's control the points distribution at a central location, so we can alter them quickly
    #   instead of hunting through several files.
    scoreboard players set ScoreForCaptureResource mapRules 1
    scoreboard players set ScoreForEnchantedItem mapRules 13
    scoreboard players set ScoreForKill mapRules 1

    # The percentage of players who has to trigger the gg trigger before the team will forfeit
    # Number has to be between 0(%) and 100(%). This has to live here in-case an arena is built for
    # different team sizes.
    scoreboard players set PercentPlayersToForfeit mapRules 75

# Count Iron Ore and set the objective. The amount of iron ore left in the mine is the score
# teams must get to win the game.
function calamity:load/count_iron_ore