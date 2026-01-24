extends Node2D
@onready var data: Node2D = $DataStorage
@onready var disabled: Node2D = $Disabled
@onready var defense: Node2D = $Defense
@onready var label: Label = $Fuel/Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("scouting2")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	label.text=str("Fuel Count: ", data.fuel_t)
	if Input.is_action_just_pressed("auto"):
		get_tree().change_scene_to_file("res://Scenes/match_scouting.tscn")
	if Input.is_action_just_pressed("endgame"):
		data.time_disabled=disabled.time
		data.time_defense=defense.dtime
		data.time_offense=defense.otime
		data.time_shuttle=defense.ctime
		get_tree().change_scene_to_file("res://Scenes/match_scouting3.tscn")
	if Input.is_action_just_pressed("fuel1"):
		data.fuel_t+=1
		print(data.fuel_t)
	if Input.is_action_just_pressed("fuel-1"):
		data.fuel_t-=1
		print(data.fuel_t)
	if Input.is_action_just_pressed("fuel4"):
		data.fuel_t+=4
		print(data.fuel_t)
	if Input.is_action_just_pressed("fuel10"):
		data.fuel_t+=10
		print(data.fuel_t)
	if Input.is_action_just_pressed("0"):
		data.accuracy_t=0
		print("0")
	if Input.is_action_just_pressed("16"):
		data.accuracy_t=.1667
		print("16")
	if Input.is_action_just_pressed("33"):
		data.accuracy_t=.3333
		print("33")
	if Input.is_action_just_pressed("50"):
		data.accuracy_t=.50
		print("50")
	if Input.is_action_just_pressed("67"):
		data.accuracy_t=.6667
		print("67")
	if Input.is_action_just_pressed("83"):
		data.accuracy_t=.8333
		print("83")
	if Input.is_action_just_pressed("100"):
		data.accuracy_t=1
		print("100")
