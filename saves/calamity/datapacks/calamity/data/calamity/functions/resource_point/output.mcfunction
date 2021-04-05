# Called from: calamity:resource_point/handler

#---------------------------------------------------------------------------------------------------
# Purpose: Resource point has finished charging, check for nearby players and give resources or
#   apply team effects. Update players and state.
#---------------------------------------------------------------------------------------------------
# Update resource point state
tag @s add Resetting
tag @s remove Charging
scoreboard players operation @s PointTimer = PointResetTime mapRules

# Determine if nearby players are standing on bedrock (2 blocks down is y-3)
execute as @s[tag=TeamBlue] run tag @a[distance=..4,team=blue] add CheckIfStandingOnPoint
execute as @s[tag=TeamRed] run tag @a[distance=..4,team=red] add CheckIfStandingOnPoint

# We use this weird "if block" section because we know the shape of our resource point does not
#   exactly match Minecraft's search radius.
execute if entity @s[tag=Effect] as @a[tag=CheckIfStandingOnPoint,distance=..4] if block ~ ~-3 ~ minecraft:bedrock run tag @s add GiveEffects
execute if entity @s[tag=Effect] as @a[tag=CheckIfStandingOnPoint,distance=..4] if block ~ ~-2 ~ minecraft:bedrock run tag @s add GiveEffects
execute if entity @s[tag=AttackEffect] as @a[tag=CheckIfStandingOnPoint,distance=..4] if block ~ ~-3 ~ minecraft:bedrock run tag @s add AttackWithEffect
execute if entity @s[tag=AttackEffect] as @a[tag=CheckIfStandingOnPoint,distance=..4] if block ~ ~-2 ~ minecraft:bedrock run tag @s add AttackWithEffect
execute if entity @s[tag=Resource] as @a[tag=CheckIfStandingOnPoint,distance=..4] if block ~ ~-3 ~ minecraft:bedrock run tag @s add GiveResources
execute if entity @s[tag=Resource] as @a[tag=CheckIfStandingOnPoint,distance=..4] if block ~ ~-2 ~ minecraft:bedrock run tag @s add GiveResources
execute if entity @s[tag=Enchant] as @a[tag=CheckIfStandingOnPoint,distance=..4] if block ~ ~-3 ~ minecraft:bedrock run tag @s add Enchant
execute if entity @s[tag=Enchant] as @a[tag=CheckIfStandingOnPoint,distance=..4] if block ~ ~-2 ~ minecraft:bedrock run tag @s add Enchant
tag @a remove CheckIfStandingOnPoint

# A player successfully captured an important resource point, let's reward them for it!
# This section scores points towards the objective!
scoreboard players operation @a[tag=GiveEffects] captureScore = ScoreForCaptureResource mapRules
scoreboard players operation @a[tag=GiveResources] captureScore = ScoreForCaptureResource mapRules
scoreboard players operation @a[tag=Enchant] captureScore = ScoreForEnchantedItem mapRules

# A player has scored effects for their team, let's flag the whole team!
execute as @a[team=blue,tag=GiveEffects,limit=1] run tag @a[team=blue] add GiveEffects
execute as @a[team=red,tag=GiveEffects,limit=1] run tag @a[team=red] add GiveEffects
execute as @a[team=blue,tag=AttackWithEffect,limit=1] run tag @a[team=red] add GiveAttackEffect
execute as @a[team=blue,tag=AttackWithEffect,limit=1] run tag @a[team=blue] remove GiveAttackEffect
execute as @a[team=red,tag=AttackWithEffect,limit=1] run tag @a[team=blue] add GiveAttackEffect
execute as @a[team=red,tag=AttackWithEffect,limit=1] run tag @a[team=red] remove GiveAttackEffect

# Check for resource point type and give resources/effects
execute as @s[tag=Log] run give @a[distance=..4,tag=GiveResources] minecraft:oak_log 16
execute as @s[tag=Scaffolding] run give @a[distance=..4,tag=GiveResources] minecraft:scaffolding 16
execute as @s[tag=GoldIngot] run give @a[distance=..4,tag=GiveResources] minecraft:gold_ingot 24
execute as @s[tag=Chain] run give @a[distance=..4,tag=GiveResources] minecraft:chain 24
execute as @s[tag=Cobblestone] run give @a[distance=..4,tag=GiveResources] minecraft:cobblestone 9
execute as @s[tag=Arrow] run give @a[distance=..4,tag=GiveResources] minecraft:arrow 16
execute as @s[tag=TNT] run give @a[distance=..4,tag=GiveResources] minecraft:tnt 3
execute as @s[tag=Regeneration] run effect give @a[tag=GiveEffects] minecraft:regeneration 45
execute as @s[tag=Resistance] run effect give @a[tag=GiveEffects] minecraft:resistance 45
execute as @s[tag=Strength] run effect give @a[tag=GiveEffects] minecraft:strength 45
execute as @s[tag=Speed] run effect give @a[tag=GiveEffects] minecraft:speed 45 1
execute as @s[tag=Haste] run effect give @a[tag=GiveEffects] minecraft:haste 45 3
# Attack
execute as @s[tag=MiningFatigue] run effect give @a[tag=GiveAttackEffect] minecraft:mining_fatigue 45 1
execute as @s[tag=Blindness] run effect give @a[tag=GiveAttackEffect] minecraft:blindness 45
execute as @s[tag=Blindness] run effect give @a[tag=AttackWithEffect] minecraft:glowing 45

# We've identified that a player is standing on a resource point type called "Enchant". Now let's
#   check what item they are holding in their main hand. This will determine what kind of book they
#   are
tag @a[tag=Enchant] add CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:bow"}}] minecraft:punch 2
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:bow"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:crossbow"}}] minecraft:multishot 1
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:crossbow"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:wooden_axe"}}] minecraft:sharpness 2
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:wooden_axe"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:stone_axe"}}] minecraft:sharpness 2
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:stone_axe"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:golden_axe"}}] minecraft:sharpness 2
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:golden_axe"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:iron_axe"}}] minecraft:sharpness 2
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:iron_axe"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:diamond_axe"}}] minecraft:sharpness 2
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:diamond_axe"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:wooden_hoe"}}] minecraft:fortune 3
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:wooden_hoe"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:stone_hoe"}}] minecraft:fortune 3
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:stone_hoe"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:golden_hoe"}}] minecraft:fortune 3
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:golden_hoe"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:iron_hoe"}}] minecraft:fortune 3
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:iron_hoe"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:diamond_hoe"}}] minecraft:fortune 3
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:diamond_hoe"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:wooden_pickaxe"}}] minecraft:efficiency 2
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:wooden_pickaxe"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:stone_pickaxe"}}] minecraft:efficiency 2
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:stone_pickaxe"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:golden_pickaxe"}}] minecraft:efficiency 2
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:golden_pickaxe"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:iron_pickaxe"}}] minecraft:efficiency 2
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:iron_pickaxe"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:diamond_pickaxe"}}] minecraft:efficiency 2
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:diamond_pickaxe"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:wooden_shovel"}}] minecraft:efficiency 3
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:wooden_shovel"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:stone_shovel"}}] minecraft:efficiency 3
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:stone_shovel"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:golden_shovel"}}] minecraft:efficiency 3
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:golden_shovel"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:iron_shovel"}}] minecraft:efficiency 3
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:iron_shovel"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:diamond_shovel"}}] minecraft:efficiency 2
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:diamond_shovel"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:wooden_sword"}}] minecraft:knockback 1
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:wooden_sword"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:stone_sword"}}] minecraft:knockback 1
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:stone_sword"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:golden_sword"}}] minecraft:knockback 1
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:golden_sword"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:iron_sword"}}] minecraft:knockback 1
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:iron_sword"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:diamond_sword"}}] minecraft:knockback 2
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:diamond_sword"}}] remove CheckForValidItem

enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:diamond_sword"}}] minecraft:knockback 2
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:diamond_sword"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:diamond_sword"}}] minecraft:knockback 2
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:diamond_sword"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:diamond_sword"}}] minecraft:knockback 2
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:diamond_sword"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:diamond_sword"}}] minecraft:knockback 2
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:diamond_sword"}}] remove CheckForValidItem

enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:leather_helmet"}}] minecraft:protection
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:leather_helmet"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:leather_chestplate"}}] minecraft:protection
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:leather_chestplate"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:leather_leggings"}}] minecraft:protection
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:leather_leggings"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:leather_boots"}}] minecraft:protection
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:leather_boots"}}] remove CheckForValidItem

enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:chainmail_helmet"}}] minecraft:thorns 1
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:chainmail_helmet"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:chainmail_chestplate"}}] minecraft:thorns 1
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:chainmail_chestplate"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:chainmail_leggings"}}] minecraft:thorns 1
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:chainmail_leggings"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:chainmail_boots"}}] minecraft:thorns 1
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:chainmail_boots"}}] remove CheckForValidItem

enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:iron_helmet"}}] minecraft:protection 2
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:iron_helmet"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:iron_chestplate"}}] minecraft:protection 2
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:iron_chestplate"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:iron_leggings"}}] minecraft:protection 2
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:iron_leggings"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:iron_boots"}}] minecraft:protection 2
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:iron_boots"}}] remove CheckForValidItem

enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:golden_helmet"}}] minecraft:blast_protection 2
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:golden_helmet"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:golden_chestplate"}}] minecraft:blast_protection 2
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:golden_chestplate"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:golden_leggings"}}] minecraft:blast_protection 2
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:golden_leggings"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:golden_boots"}}] minecraft:blast_protection 2
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:golden_boots"}}] remove CheckForValidItem

enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:diamond_helmet"}}] minecraft:protection
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:diamond_helmet"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:diamond_chestplate"}}] minecraft:protection
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:diamond_chestplate"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:diamond_leggings"}}] minecraft:protection
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:diamond_leggings"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:diamond_boots"}}] minecraft:protection
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:diamond_boots"}}] remove CheckForValidItem

enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:netherite_helmet"}}] minecraft:fire_protection
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:netherite_helmet"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:netherite_chestplate"}}] minecraft:fire_protection
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:netherite_chestplate"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:netherite_leggings"}}] minecraft:fire_protection
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:netherite_leggings"}}] remove CheckForValidItem
enchant @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:netherite_boots"}}] minecraft:fire_protection
tag @a[tag=CheckForValidItem,nbt={SelectedItem: {id: "minecraft:netherite_boots"}}] remove CheckForValidItem

# We must handle messaging different for this section, as we will likely expand it it to be more
#   clear. Players will want to know or learn what item gives what Enchanted Book, so we should
#   work that in some day, but not in alpha.
# TODO: Expand messages to include custom message for each book type.
tellraw @a[tag=Enchant,tag=!CheckForValidItem] {"translate":"calamity.resourcePoint.enchantedItem.valid","color": "gray","italic": true,"with":[{"translate":"calamity.enchanted.item","color":"white"}]}
tellraw @a[tag=Enchant,tag=CheckForValidItem] {"translate":"calamity.resourcePoint.enchantedItem.invalid","color": "gray","italic": true,"with":[{"translate":"item.minecraft.enchanted_book","color":"white"}]}
execute if entity @a[tag=Enchant,team=blue] run tellraw @a {"translate":"calamity.resourcePoint.enchantedItem.announced","color":"blue","with":[{"translate":"calamity.enchanted.item","color":"white"},{"translate":"team.blue"},{"translate":"b","color":"blue","font": "calamity:icons"}]}

execute if entity @a[tag=Enchant,team=red] run tellraw @a {"translate":"calamity.resourcePoint.enchantedItem.announced","color":"red","with":[{"translate":"calamity.enchanted.item","color":"white"},{"translate":"team.red"},{"translate":"r","color": "red","font": "calamity:icons"}]}

# No valid item found, give default book
# Default book should be a rather innoculous, but useful book. Should not be a book meant for
#   for combat, as we want to continue promoting good logistics.
give @a[tag=CheckForValidItem] minecraft:enchanted_book{StoredEnchantments: [{id: "minecraft:mending", lvl: 1s}]}
tag @a[tag=CheckForValidItem] remove CheckForValidItem

# Play success sounds
execute as @a[tag=GiveEffects] run playsound minecraft:entity.generic.drink player @s
execute as @s[tag=GiveResources] run playsound minecraft:entity.player.levelup master @a ~ ~ ~ 0.5 0.5
execute as @s[tag=Enchant] run playsound minecraft:entity.player.levelup master @a ~ ~ ~ 0.5 0.5
execute as @a[tag=Enchant,team=blue] run playsound calamity:calamity.announcer.enchanted.item master @a[team=red] ~ ~ ~ 500
execute as @a[tag=Enchant,team=red] run playsound calamity:calamity.announcer.enchanted.item master @a[team=blue] ~ ~ ~ 500

# Give title message and resource/effect
tag @a[tag=GiveResources] add GiveMessage
tag @a[tag=GiveResources] remove GiveResources
tag @a[tag=GiveEffects] add GiveMessage
tag @a[tag=GiveEffects] remove GiveEffects
tag @a[tag=AttackWithEffect] add GiveMessageAttack
tag @a[tag=AttackWithEffect] remove AttackWithEffect
tag @a[tag=GiveAttackEffect] add GiveMessageAttacked
tag @a[tag=GiveAttackEffect] remove GiveAttackEffect
tag @a[tag=Enchant] remove Enchant

# Resources
title @a[tag=GiveMessage] times 5 30 10
execute as @s[tag=Log] run title @a[distance=..4,tag=GiveMessage] actionbar {"translate":"calamity.resourcePoint.output.item","with":[{"translate":"block.minecraft.birch_log"},{"text":"16"}]}
execute as @s[tag=GoldIngot] run title @a[distance=..4,tag=GiveMessage] actionbar {"translate":"calamity.resourcePoint.output.item","with":[{"translate":"item.minecraft.gold_ingot"},{"text":"24"}]}
execute as @s[tag=Cobblestone] run title @a[distance=..4,tag=GiveMessage] actionbar {"translate":"calamity.resourcePoint.output.item","with":[{"translate":"block.minecraft.cobblestone"},{"text":"9"}]}
execute as @s[tag=Arrow] run title @a[distance=..4,tag=GiveMessage] actionbar {"translate":"calamity.resourcePoint.output.item","with":[{"translate":"item.minecraft.arrow"},{"text":"32"}]}
execute as @s[tag=TNT] run title @a[distance=..4,tag=GiveMessage] actionbar {"translate":"calamity.resourcePoint.output.item","with":[{"translate":"block.minecraft.tnt"},{"text":"3"}]}
execute as @s[tag=Points] run title @a[distance=..4,tag=GiveMessage] actionbar {"translate":"calamity.resourcePoint.output.item","with":[{"translate":"block.minecraft.tnt"},{"text":"3"}]}
# Effects
execute as @s[tag=Regeneration] run title @a[tag=GiveMessage] actionbar {"translate":"calamity.resourcePoint.output.effect","with":[{"translate":"effect.minecraft.regeneration"},{"text":"45"}]}
execute as @s[tag=Resistance] run title @a[tag=GiveMessage] actionbar {"translate":"calamity.resourcePoint.output.effect","with":[{"translate":"effect.minecraft.resistance"},{"text":"45"},{"translate":"calamity.resourcePoint.output.effect.level2"}]}
execute as @s[tag=Strength] run title @a[tag=GiveMessage] actionbar {"translate":"calamity.resourcePoint.output.effect","with":[{"translate":"effect.minecraft.strength"},{"text":"45"}]}
execute as @s[tag=MiningFatigue] run title @a[tag=GiveMessageAttack] actionbar {"translate":"calamity.resourcePoint.output.attackEffect","with":[{"translate":"effect.minecraft.mining_fatigue"},{"text":"45"}]}
execute as @s[tag=MiningFatigue] run title @a[tag=GiveMessageAttacked] actionbar {"translate":"calamity.resourcePoint.output.attackedEffect","with":[{"translate":"effect.minecraft.mining_fatigue"},{"text":"45"}]}
execute as @s[tag=Strength] run title @a[tag=GiveMessage] actionbar {"translate":"calamity.resourcePoint.output.effect","with":[{"translate":"effect.minecraft.strength"},{"text":"45"}]}
execute as @s[tag=Blindness] run title @a[tag=GiveMessageAttack] actionbar {"translate":"calamity.resourcePoint.output.effect","with":[{"translate":"effect.minecraft.glowing"},{"text":"30"}]}
execute as @s[tag=Blindness] run title @a[tag=GiveMessageAttacked] actionbar {"translate":"calamity.resourcePoint.output.attackedEffect","with":[{"translate":"effect.minecraft.blindness"},{"text":"30"}]}
execute as @s[tag=Speed] run title @a[tag=GiveMessage] actionbar {"translate":"calamity.resourcePoint.output.effect","with":[{"translate":"effect.minecraft.speed"},{"text":"45"},{"translate":"calamity.resourcePoint.output.effect.level2"}]}
execute as @s[tag=Haste] run title @a[tag=GiveMessage] actionbar {"translate":"calamity.resourcePoint.output.effect","with":[{"translate":"effect.minecraft.haste"},{"text":"45"},{"translate":"calamity.resourcePoint.output.effect.level2"}]}
tag @a[tag=GiveMessage] remove GiveMessage
tag @a[tag=GiveMessageAttack] remove GiveMessageAttack
tag @a[tag=GiveMessageAttacked] remove GiveMessageAttacked

# Update signs
execute as @s[tag=FacingWest] run data merge block ~-3 ~ ~ {Text2: "{\"translate\":\"calamity.resourcePoint.sign.activated\"}"}
execute as @s[tag=FacingEast] run data merge block ~3 ~ ~ {Text2: "{\"translate\":\"calamity.resourcePoint.sign.activated\"}"}

# Tag which caused the handler to call this function
tag @s remove Output