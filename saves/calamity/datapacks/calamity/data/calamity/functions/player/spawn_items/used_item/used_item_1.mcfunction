# called from the advancement calamity:spawn_items/used_item/used_item_1

tag @s add GiveSelectedStartingItem
scoreboard players set @s selectedItem 101

# revoke the advancement so the player can get it again
advancement revoke @s only calamity:spawn_items/used_item/used_item_1