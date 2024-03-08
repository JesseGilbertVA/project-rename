extends Area2D

var speed = 1250

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.x * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

#this function is such shit my god
func _on_body_entered(body):
	print('laser entered body')
	body.play_animation()
	queue_free()
	
