extends Node2D
@onready var timer: Timer = $"../Timer"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
var s_time # time where the timer started
var e_time # time when the timer ended
var time=0 #total time elapsed
var active=false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("defense"):
		if active==false:
			active=true
			#sets the start time to the current time on the timer.
			s_time=timer.time_left
			s_time=(int(s_time*10))/10 #rounds to the nearest tenth of a second
		elif active:
			active=false
			#sets the end time to the current time on the timer.
			e_time=timer.time_left
			e_time=(int(e_time*10))/10 #rounds to the nearest tenth of a second
			time+=s_time-e_time #adds to the total time disabled
			print("defense time:",time)
