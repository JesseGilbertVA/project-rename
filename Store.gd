extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$PurchaseText.text = ""
	get_tree().paused = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Health.text = "Health: " + str(globals.player_health) + " / " + str(globals.max_player_health)
	$Currency.text = "Currency: " + str(globals.player_currency)


func _on_next_stage_pressed():
	if globals.stage_level >= 1 and globals.stage_level <= 3:
		print('Proceeding to next easy level')
		get_tree().change_scene_to_file("res://Level Scenes/Easy/easy_scene.tscn")
	if globals.stage_level >= 4 and globals.stage_level <= 6:
		print('Proceeding to next medium level')
		get_tree().change_scene_to_file("res://Level Scenes/Medium/medium_scene.tscn")
	if globals.stage_level >= 7:
		print('Proceeding to next hard level')
		get_tree().change_scene_to_file("res://test_scene.tscn")


func _on_death_to_all_pressed():
	if globals.player_currency >= 15000 and globals.weapon_type != 3:
		globals.weapon_type = 3
		globals.player_currency -= 15000
		$PurchaseText.text = "What have you become..."
	elif globals.weapon_type == 3:
		$PurchaseText.text = "You are already a monster."
	else:
		$PurchaseText.text = "Insufficient funds."
	
	

func _on_increase_max_hp_pressed():
	if globals.player_currency >= 2000:
		globals.max_player_health += 1
		globals.player_currency -= 2000
		globals.player_health = globals.max_player_health
		$PurchaseText.text = "Max HP increased."
	else:
		$PurchaseText.text = "Insufficient funds."


func _on_restore_hp_pressed():
	if globals.player_currency >= 500 and globals.player_health < globals.max_player_health:
		globals.player_health += 1
		globals.player_currency -= 500
	if globals.player_health == globals.max_player_health:
		$PurchaseText.text = "HP is full."
	else:
		$PurchaseText.text = "Insufficient funds."


func _on_tri_laser_pressed():
	if globals.player_currency >= 3333 and globals.weapon_type != 2:
		globals.weapon_type = 2
		globals.player_currency -= 3333
		$PurchaseText.text = "Like a shotgun but better."
	elif globals.weapon_type == 2:
		$PurchaseText.text = "You already own that though?"
	else:
		$PurchaseText.text = "Insufficient funds."


func _on_player_shield_pressed():
	if globals.player_currency >= 1000 and globals.player_shield == false:
		globals.player_shield = true
		globals.player_currency -= 1000
		$PurchaseText.text = "Shield online."
	elif globals.player_shield == true:
		$PurchaseText.text = "You get to keep the shield forever."
	else:
		$PurchaseText.text = "Insufficient funds."


func _on_increase_player_speed_pressed():
	if globals.player_currency >= 250 and globals.player_move_speed == 150:
		globals.player_move_speed += 50
		globals.player_currency -= 250
		$PurchaseText.text = "You can upgrade you're speed two more times."
	elif globals.player_currency >= 250 and globals.player_move_speed == 200:
		globals.player_move_speed += 50
		globals.player_currency -= 250
		$PurchaseText.text = "You can upgrade you're speed one more time."
	elif globals.player_currency >= 250 and globals.player_move_speed == 250:
		globals.player_move_speed += 50
		globals.player_currency -= 250
		$PurchaseText.text = "Speed maxed."
	elif globals.player_move_speed == 300:
		$PurchaseText.text = "You're already too fast for your own good."
	else:
		$PurchaseText.text = "Insufficient funds."
