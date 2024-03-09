extends Node

@export var enemy_one: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	$StartTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$HUD.update_timer(round($StageTimer.get_time_left()))


#probably need to change variable name from enemy to something a little more specific
func _on_enemy_one_spawn_timer_timeout():
	var enemy = enemy_one.instantiate()
	var enemy_spawn_location = $EnemySpawnPath/EnemySpawnLocation
	enemy_spawn_location.progress_ratio = randf()
	var direction = enemy_spawn_location.rotation + PI / 2 #I still don't really understand radians fully, but this worked so?
	enemy.position = enemy_spawn_location.position
	var velocity = Vector2(randf_range(250.0, 350.0), 0.0)
	enemy.linear_velocity = velocity.rotated(direction) #I dont even know what this line does fully, but it makes the bad guys move forward so

	add_child(enemy)


func _on_button_pressed():
	print("Heading to store")
	get_tree().change_scene_to_file("res://store.tscn")


func _on_start_timer_timeout():
	$EnemyOneSpawnTimer.start()
	$StageTimer.start()


func _on_stage_timer_timeout():
	get_tree().paused = true
	$HUD/GetReady.text = "Complete!"
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://store.tscn")


func _on_base_area_body_entered(body):
	print("Base area entered.")
	globals.player_health -= 1
