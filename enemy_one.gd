extends RigidBody2D

signal enemy_hit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func i_am_test_function():
	print('success!')

func hit_by_laser():
	set_physics_process(false)
	linear_velocity = Vector2.ZERO
	$CollisionShape2D.set_deferred("disabled", true)
	$EnemyOneAnimatedSprite.play("death")
	#await get_tree().create_timer(0.25).timeout #re-enable once we actually have an animation
	globals.player_currency += 10
	print('Player currency: ' + str(globals.player_currency))
	queue_free()
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
