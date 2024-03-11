extends CharacterBody2D

@export var speed = randf_range(350.0, 450.0)
@onready var player = get_node("../Player") #Probably need to understand this a little bit better
var player_position
var target_position

func _physics_process(delta):
	player_position = player.position
	target_position = (player.position - position).normalized()
	velocity = Vector2(target_position * speed)
	if position.distance_to(player_position) > 3:
		move_and_slide()
		look_at(player_position)

func hit_by_laser():
	globals.player_currency += 5
	queue_free()
