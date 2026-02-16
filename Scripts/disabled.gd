extends Node2D
@onready var timer: Timer = $"../Timer"
@onready var animate: AnimatedSprite2D = $AnimatedSprite2D
@onready var defense: Node2D = $"../Defense"
@onready var data: Node2D = $"../DataStorage"


# Called when the node enters the scene tree for the first time.
var s_time # time where the timer started
var e_time # time when the timer ended
var time=0 #total time elapsed
var active=false
func _ready() -> void:
	time=data.time_disabled
	animate.play("enabled")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("disabled"):
		if active==false:
			Input.vibrate_handheld(500)
			defense.disabled()
			active=true
			#sets the start time to the current time on the timer.
			s_time=timer.time_left
			s_time=((int(s_time*10))) #rounds to the nearest tenth of a second
			animate.play("disabled")
		elif active:
			defense.enabled()
			active=false
			#sets the end time to the current time on the timer.
			e_time=timer.time_left
			e_time=(int(e_time*10)) #rounds to the nearest tenth of a second
			time+=float(s_time-e_time)/10#adds to the total time disabled. Decreases to appropriate time.
			print("disabled time:",time)
			animate.play("enabled")
