extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$GetReadyTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Health.text = "Health: " + str(globals.player_health)
	$Currency.text = "Currency: " + str(globals.player_currency)


func _on_get_ready_timer_timeout():
	$GetReady.text = ""

func update_timer(time_remaining):
	$TimeRemaining.text = "Time Remaining: " + str(time_remaining)
