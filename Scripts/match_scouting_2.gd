extends Node2D
@onready var data: Node2D = $DataStorage
@onready var disabled: Node2D = $Disabled
@onready var defense: Node2D = $Defense
@onready var label: Label = $Fuel/Label
@onready var label2: Label = $Pinning/Label
@onready var bump: AnimatedSprite2D = $Bump/AnimatedSprite2D
@onready var trench: AnimatedSprite2D = $Trench/AnimatedSprite2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if data.bump:
		bump.play("yes")
	else:
		bump.play("no")
	if data.trench:
		trench.play("yes")
	else:
		trench.play("no")
	print("scouting2")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	label.text=str("Fuel Count: ", data.fuel_t)
	if Input.is_action_just_pressed("trench"):
		data.trench=not data.trench
		if data.trench:
			trench.play("yes")
		else:
			trench.play("no")
	if Input.is_action_just_pressed("bump"):
		data.bump=not data.bump

		if data.bump:
			bump.play("yes")
		else:
			bump.play("no")

	if Input.is_action_just_pressed("auto"):
		get_tree().change_scene_to_file("res://Scenes/match_scouting.tscn")
	if Input.is_action_just_pressed("cycle"):
		data.shots+=1
		print("cycle")
	if Input.is_action_just_pressed("pin+"):
		data.pins+=1
		label2.text=str(data.pins)
	if Input.is_action_just_pressed("pin-") and  data.pins>=1:
		data.pins-=1
		label2.text=str(data.pins)
	if Input.is_action_just_pressed("fuel1"):
		if defense.mode=="offense":
			data.fuel_t+=1
		else:
			data.fuel_s+=1
		print(data.fuel_t)
	if Input.is_action_just_pressed("fuel-1"):
		if defense.mode=="offense":
			data.fuel_t-=1
		else:
			data.fuel_s-=1
		print(data.fuel_t)
	if Input.is_action_just_pressed("fuel4"):
		if defense.mode=="offense":
			data.fuel_t+=4
		else:
			data.fuel_s+=4
		print(data.fuel_t)
	if Input.is_action_just_pressed("fuel10"):
		if defense.mode=="offense":
			data.fuel_t+=10
		else:
			data.fuel_s+=10
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
