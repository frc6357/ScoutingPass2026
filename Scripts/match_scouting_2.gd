extends Node2D
@onready var data: Node2D = $DataStorage
@onready var disabled: Node2D = $Disabled
@onready var defense: Node2D = $Defense
@onready var label: Label = $Fuel/Fuel/Label
@onready var label2: Label = $Pinning/Label
@onready var bump: AnimatedSprite2D = $Bump/AnimatedSprite2D
@onready var trench: AnimatedSprite2D = $Trench/AnimatedSprite2D
@onready var display: AnimatedSprite2D = $Accuracy/display
@onready var fire: AnimatedSprite2D = $fire_animation



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	display.play("75")
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
	label.text=str(data.fuel_t)
	if Input.is_action_just_pressed("cycle"):
		fire.play("fire")
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
	if Input.is_action_just_pressed("fuel5"):
		if defense.mode=="offense":
			data.fuel_t+=5
		else:
			data.fuel_s+=5
		print(data.fuel_t)
	if Input.is_action_just_pressed("fuel10"):
		if defense.mode=="offense":
			data.fuel_t+=10
		else:
			data.fuel_s+=10
		print(data.fuel_t)
	if Input.is_action_just_pressed("50"):
		data.accuracy_t=.50
		print("50")
		display.play("50")
	if Input.is_action_just_pressed("75"):
		data.accuracy_t=.75
		print("75")
		display.play("75")
	if Input.is_action_just_pressed("90"):
		data.accuracy_t=.9
		print("90")
		display.play("90")
	if Input.is_action_just_pressed("100"):
		data.accuracy_t=1
		print("100")
		display.play("100")
