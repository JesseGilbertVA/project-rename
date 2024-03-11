extends Node

@export var enemy_one: PackedScene
@export var enemy_two_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	$StartTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$HUD.update_timer(round($StageTimer.get_time_left()))
	if globals.player_health <= 0:
		game_over()

func game_over():
	get_tree().paused = true
	$HUD/GetReady.text = "Game over! You lose!"
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_file("res://start_menu.tscn")

#probably need to change variable name from enemy to something a little more specific
func _on_enemy_one_spawn_timer_timeout():
	var enemy = enemy_one.instantiate()
	var enemy_spawn_location = $EnemySpawnPath/EnemySpawnLocation
	enemy_spawn_location.progress_ratio = randf()
	var direction = enemy_spawn_location.rotation + PI / 2 #I still don't really understand radians fully, but this worked so?
	enemy.position = enemy_spawn_location.position
	#var velocity = Vector2(randf_range(250.0, 350.0), 0.0)
	#enemy.linear_velocity = velocity.rotated(direction) #uncomment this line and the above line for enemies flying in straight line
	add_child(enemy)


func _on_start_timer_timeout():
	$EnemyOneSpawnTimer.start()
	$StageTimer.start()
	$EnemyTwoTimer.start()


func _on_stage_timer_timeout():
	get_tree().paused = true
	$HUD/GetReady.text = "Complete!"
	globals.stage_level += 1
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://store.tscn")


func _on_base_area_body_entered(body):
	if body.is_in_group("enemies"):
		print("Base area entered.")
		globals.player_health -= 1


func _on_enemy_two_timer_timeout():
	var enemy = enemy_two_scene.instantiate()
	var enemy_spawn_location = $EnemySpawnPath/EnemySpawnLocation
	enemy_spawn_location.progress_ratio = randf()
	var direction = enemy_spawn_location.rotation + PI / 2 #I still don't really understand radians fully, but this worked so?
	enemy.position = enemy_spawn_location.position
	var velocity = Vector2(randf_range(350.0, 450.0), 0.0) #easy stage speed
	enemy.linear_velocity = velocity.rotated(direction)
	add_child(enemy)
