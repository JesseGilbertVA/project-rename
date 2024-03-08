extends RigidBody2D

signal enemy_hit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_body_entered(body):
	print('enemy body entered')


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print('new enemy body enters')
	
	
func i_am_test_function():
	print('success!')

func play_animation():
	set_physics_process(false)
	$EnemyOneAnimatedSprite.play("death")
	await get_tree().create_timer(0.25).timeout
	globals.player_currency += 10
	print('Player currency: ' + str(globals.player_currency))
	queue_free()
	
	
