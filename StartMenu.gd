extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	globals.player_health = 3
	globals.stage_level = 1
	globals.player_currency = 0
	globals.max_player_health = 3
	globals.death_to_all = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://Level Scenes/Easy/easy_scene.tscn")


func _on_exit_game_pressed():
	get_tree().quit()
