extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$GetReadyTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Health.text = "Health: " + str(globals.player_health) + " / " + str(globals.max_player_health)
	$Currency.text = "Currency: " + str(globals.player_currency)
	$CurrentStage.text = "Current Stage: " + str(globals.stage_level)


func _on_get_ready_timer_timeout():
	$GetReady.text = ""

#This function is called in each gameplay scene's _process function
func update_timer(time_remaining):
	$TimeRemaining.text = "Time Remaining: " + str(time_remaining) 
