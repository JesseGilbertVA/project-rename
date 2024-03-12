extends Node

@export var enemy_one: PackedScene
@export var asteroid_scene: PackedScene
@export var enemy_two_scene: PackedScene
@export var green_enenmy: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	$StartTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$HUD.update_timer(round($StageTimer.get_time_left()))
	if globals.player_health <= 0:
		game_over()


#probably need to change variable name from enemy to something a little more specific
func _on_enemy_one_spawn_timer_timeout():
	var enemy = enemy_one.instantiate()
	var enemy_spawn_location = $EnemySpawnPath/EnemySpawnLocation
	enemy_spawn_location.progress_ratio = randf()
	var direction = enemy_spawn_location.rotation + PI / 2 #I still don't really understand radians fully, but this worked so?
	enemy.position = enemy_spawn_location.position
	var velocity = Vector2(randf_range(325.0, 325.0), 0.0) #speed up for medium stage
	enemy.linear_velocity = velocity.rotated(direction) #I dont even know what this line does fully, but it makes the bad guys move forward so
	add_child(enemy)


func _on_button_pressed():
	print("Heading to store")
	get_tree().change_scene_to_file("res://store.tscn")


func _on_start_timer_timeout():
	$EnemyOneSpawnTimer.start()
	$StageTimer.start()
	$AsteroidTimer.start()
	$EnemyTwoSpawnTimer.start()
	$GreenEnemyTimer.start()


func _on_stage_timer_timeout():
	get_tree().paused = true
	$HUD/GetReady.text = "Complete!"
	globals.stage_level += 1
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://store.tscn")
	
func game_over():
	$Player.hide()
	get_tree().paused = true
	$HUD/GetReady.text = "Game over! You lose!"
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_file("res://start_menu.tscn")


func _on_base_area_body_entered(body):
	if body.is_in_group("enemies"):
		print("Base area entered.")
		globals.player_health -= 1


func _on_asteroid_timer_timeout():
	var i = 0
	while i < 1:
		var asteroid = asteroid_scene.instantiate()
		var asteroid_spawn_location = $EnemySpawnPath/EnemySpawnLocation
		asteroid_spawn_location.progress_ratio = randf()
		var direction = asteroid_spawn_location.rotation + PI / 2 #I still don't really understand radians fully, but this worked so?
		asteroid.position = asteroid_spawn_location.position
		var velocity = Vector2(900.0, 0.0)
		asteroid.linear_velocity = velocity.rotated(direction) #I dont even know what this line does fully, but it makes the bad guys move forward so
		add_child(asteroid)
		i += 1

#This function does not require any movement based code as
#the enemy_two scene already has that code programmed in
func _on_enemy_two_spawn_timer_timeout():
	var enemy_two = enemy_two_scene.instantiate()
	var enemy_two_spawn_location = $EnemySpawnPath/EnemySpawnLocation
	enemy_two_spawn_location.progress_ratio = randf()
	var direction = enemy_two_spawn_location.rotation + PI / 2
	enemy_two.position = enemy_two_spawn_location.position
	add_child(enemy_two)


func _on_green_enemy_timer_timeout():
	var enemy = green_enenmy.instantiate()
	var enemy_spawn_location = $EnemySpawnPath/EnemySpawnLocation
	enemy_spawn_location.progress_ratio = randf()
	var direction = enemy_spawn_location.rotation + PI / 2 #I still don't really understand radians fully, but this worked so?
	enemy.position = enemy_spawn_location.position
	var velocity = Vector2(randf_range(200.0, 200.0), 0.0) #speed up for medium stage
	enemy.linear_velocity = velocity.rotated(direction) #I dont even know what this line does fully, but it makes the bad guys move forward so
	add_child(enemy)
