extends Area2D

@export var speed = 400
@export var Bullet : PackedScene
var screen_size
var cooldown = 0.3

signal player_hit

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	cooldown -= delta
	#Player input, no rotation allowed
	if Input.is_action_pressed('move_up'):
		velocity.y -= 1
	if Input.is_action_pressed('move_down'):
		velocity.y += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	
	#I have no idea what I am doing
	velocity = velocity.normalized() * speed
	position += velocity * delta
	position.x = clamp(position.x, 30, screen_size.x - 30)
	position.y = clamp(position.y, 30, screen_size.y - 30) #I DONT KNOW IF THIS IS THE BEST WAY TO HANDLE THIS KEEP IT IN MIND IF I NEED TO FIX IT
	#position = position.clamp(Vector2.ZERO, screen_size) #SAVING THIS OLD LINE JUST IN CASE
	
	#base laser
	if globals.death_to_all == true:
		if Input.is_action_pressed("shoot"):
			shoot()
	else:
		if Input.is_action_pressed("shoot") and cooldown <= 0:
			shoot()
			cooldown = 0.3
	

func _on_body_entered(body):
	print('player hit')
	player_hit.emit()
	globals.player_health -= 1
	body.queue_free()

# lowercase b is a fucking horrible name for this variable, but basically all we are doing is declaring that as the bullet we are creating
func shoot():
	var b = Bullet.instantiate()
	owner.add_child(b) #the owner tag is crucial here so that it attaches to the main scene node and not the player node
	b.transform = $LaserSpawn.global_transform #i dont really know what this does but it works
	
