extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Player currency: " + str(globals.player_currency))
	get_tree().paused = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	print("Deducted player currency by 10.")
	globals.player_currency -= 10
	print("Playern now has: " + str(globals.player_currency))


func _on_button_2_pressed():
	print("Deducted player currency by 5.")
	globals.player_currency -= 5
	print("Playern now has: " + str(globals.player_currency))



func _on_button_3_pressed():
	print("Transition back to level stage")
	get_tree().change_scene_to_file("res://test_scene.tscn")
