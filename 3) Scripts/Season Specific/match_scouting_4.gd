extends Node2D

@onready var data: Node2D = $DataStorage
@onready var label: Label = $Fouls/Label
@onready var bump: AnimatedSprite2D = $Bump/AnimatedSprite2D
@onready var trench: AnimatedSprite2D = $Trench/AnimatedSprite2D
@onready var fuel_a: Label = $Labels/Fuel_A
@onready var fuel_t: Label = $Labels/Fuel_T
@onready var total: Label = $Labels/Total
@onready var climb_a: Label = $Labels/Climb_A
@onready var climb_e: Label = $Labels/Climb_E
@onready var climb_t: Label = $Labels/Climb_T

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#sets the bump and trench to their appropriate images.
	if data.bump:
		bump.play("yes")
	else:
		bump.play("no")
	if data.trench:
		trench.play("yes")
	else:
		trench.play("no")
	print("scouting4")
	#this section sets the text for the interface.
	fuel_a.text="Fuel Scored Auto: "+str(data.fuel_a)
	fuel_t.text="Fuel Scored Teleop: "+str(data.fuel_t)
	total.text="Fuel Scored Total: "+str(data.fuel_a+data.fuel_t)
	climb_a.text="Climb Points Auto: "+str(data.climb_a)
	climb_e.text="Climb Points Endgame: "+str(data.climb_t)
	climb_t.text="Climb Points Total: "+str(data.climb_t+data.climb_a)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#changes files when actions are called.
	if Input.is_action_just_pressed("endgame"):
		get_tree().change_scene_to_file("res://Scenes/match_scouting2.tscn")
	if Input.is_action_just_pressed("final"):
		get_tree().change_scene_to_file("res://Scenes/match_scouting_final.tscn")
		
	#increases/decreases the number displayed on the foul display.
	if Input.is_action_just_pressed("foul+"):
		data.fouls+=1
		label.text=str(data.fouls)
	if Input.is_action_just_pressed("foul-"):
		#insures foul number remains positive
		if data.fouls>=1:
			data.fouls-=1
			label.text=str(data.fouls)
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
