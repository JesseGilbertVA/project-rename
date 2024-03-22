extends Area2D

@export var speed = globals.player_move_speed
@export var Bullet : PackedScene
@export var TriLaser : PackedScene
var screen_size
var cooldown = 0.3
var shield_active = false

signal player_hit

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	if globals.player_shield == true:
		shield_active = true
		$ShieldSprite.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	cooldown -= delta #VITAL bit of code for cooldowns
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
	position.x = clamp(position.x, 25, screen_size.x - 25)
	position.y = clamp(position.y, 11, screen_size.y - 13) #I DONT KNOW IF THIS IS THE BEST WAY TO HANDLE THIS KEEP IT IN MIND IF I NEED TO FIX IT
	#position = position.clamp(Vector2.ZERO, screen_size) #SAVING THIS OLD LINE JUST IN CASE
	
	match globals.weapon_type:
		1: #base laser
			if Input.is_action_pressed("shoot") and cooldown <= 0:
				basic_shoot()
				cooldown = 0.3
		2: #tri laser
			if Input.is_action_pressed("shoot") and cooldown <= 0:
				triple_shoot()
				cooldown = 0.5
		3: #death to all who enter laser
			if Input.is_action_pressed("shoot"):
				basic_shoot()
	

func _on_body_entered(body):
	if shield_active == true:
		$ShieldSprite.hide()
		shield_active = false
		body.queue_free()
	else:
		print('player hit')
		$AnimatedSprite2D.play("hit")
		player_hit.emit()
		globals.player_health -= 1
		body.queue_free()

# lowercase b is a fucking horrible name for this variable, but basically all we are doing is declaring that as the bullet we are creating
func basic_shoot():
	var b = Bullet.instantiate()
	owner.add_child(b) #the owner tsdag is crucial here so that it attaches to the main scene node and not the player node
	b.transform = $LaserSpawn.global_transform
	
func triple_shoot():
	var b = Bullet.instantiate()
	var b2 = Bullet.instantiate()
	var b3 = Bullet.instantiate()
	owner.add_child(b) #the owner tag is crucial here so that it attaches to the main scene node and not the player node
	owner.add_child(b2)
	owner.add_child(b3)
	b.transform = $LaserSpawn.global_transform
	b2.transform = $LaserSpawn.global_transform
	b3.transform = $LaserSpawn.global_transform
	b2.rotation = deg_to_rad(-10)
	b3.rotation = deg_to_rad(10)
