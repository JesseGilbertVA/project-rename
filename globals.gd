extends Node

#Global variables
var stage_level = 1
var player_currency = 500000
var player_health = 3
var max_player_health = 3 #Technically an upgradable item but whatever

#Weapons/Upgrades/PowerUps
var weapon_type = 1 #We need to document which weapon type belongs to which number association
var player_shield = false

# Called when the node enters the scene tree for the first time.
func _ready():
	print('autoload loaded! Player currency is:')
	print(player_currency)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
