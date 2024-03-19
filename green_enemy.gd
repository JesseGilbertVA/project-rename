extends RigidBody2D

var health = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func hit_by_laser():
	health -= 1
	if health == 0:
		set_physics_process(false)
		linear_velocity = Vector2.ZERO
		$CollisionShape2D.set_deferred("disabled", true)
		#await get_tree().create_timer(0.25).timeout #re-enable once we actually have an animation
		globals.player_currency += 20
		print('Player currency: ' + str(globals.player_currency))
		queue_free()
	else:
		$AnimatedSprite2D.play("hit")


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
