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
var wait=0
var change=0
@onready var fuely: Sprite2D = $Fuel/Fuel
@onready var defends: AnimatedSprite2D = $"defense?/AnimatedSprite2D"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	display.play("65")
	if data.defends:
		defends.play("on")
	else:
		defends.play("off")
			
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
		Input.vibrate_handheld(200)
	if Input.is_action_just_pressed("trench"):
		Input.vibrate_handheld(100)
		data.trench=not data.trench
		if data.trench:
			trench.play("yes")
		else:
			trench.play("no")
	if Input.is_action_just_pressed("bump"):
		Input.vibrate_handheld(100)
		data.bump=not data.bump

		if data.bump:
			bump.play("yes")
		else:
			bump.play("no")

	if Input.is_action_just_pressed("auto"):
		Input.vibrate_handheld(75)
		get_tree().change_scene_to_file("res://Scenes/match_scouting.tscn")
	if Input.is_action_just_pressed("cycle"):
		data.shots+=1
		print("cycle")
	if Input.is_action_just_pressed("pin+"):
		Input.vibrate_handheld(100)
		data.pins+=1
		label2.text=str(data.pins)
	if Input.is_action_just_pressed("pin-") and data.pins>0:
		Input.vibrate_handheld(100)
		data.pins-=1
		label2.text=str(data.pins)
	if Input.is_action_pressed("fuel1"):
		if (wait==0 or (wait >40 and wait%5==0)):
			data.fuel_t+=1
			fuely.fuel1()
		wait+=1
		print(data.fuel_t)
		Input.vibrate_handheld(40)
	elif Input.is_action_pressed("fuel-1"):
		if (wait==0 or (wait >40 and wait%5==0)) and data.fuel_t>0:
			data.fuel_t-=1
		wait+=1
		print(data.fuel_t)
	elif Input.is_action_pressed("fuel5"):
		if (wait==0 or (wait >40 and wait%8==0)):
			fuely.fuel5()
			data.fuel_t+=5
		wait+=1
		print(data.fuel_t)
		Input.vibrate_handheld(70)
	elif Input.is_action_pressed("fuel10"):
		if (wait==0 or (wait >40 and wait%11==0)):
			data.fuel_t+=10
			fuely.fuel10()
		wait+=1
		print(data.fuel_t)
		Input.vibrate_handheld(100)
	else:
		wait=0		
	if Input.is_action_just_pressed("50"):
		Input.vibrate_handheld(50)
		data.accuracy_t=.50
		print("50")
		display.play("50")
	if Input.is_action_just_pressed("75"):
		Input.vibrate_handheld(65)
		data.accuracy_t=.65
		print("75")
		display.play("65")
	if Input.is_action_just_pressed("90"):
		Input.vibrate_handheld(80)
		data.accuracy_t=.8
		print("90")
		display.play("80")
	if Input.is_action_just_pressed("100"):
		Input.vibrate_handheld(95)
		data.accuracy_t=.95
		print("100")
		display.play("95")
	if Input.is_action_just_pressed("defends"):
		data.defends=not data.defends
		if data.defends:
			defends.play("on")
		else:
			defends.play("off")
			
