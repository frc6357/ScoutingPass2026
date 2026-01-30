extends Node2D
@onready var data: Node2D = $DataStorage
@onready var label: Label = $Fouls/Label
@onready var bump: AnimatedSprite2D = $Bump/AnimatedSprite2D
@onready var trench: AnimatedSprite2D = $Trench/AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bump.play("no")
	trench.play("no")
	print("scouting4")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("endgame"):
		get_tree().change_scene_to_file("res://Scenes/match_scouting2.tscn")
	if Input.is_action_just_pressed("final"):
		get_tree().change_scene_to_file("res://Scenes/match_scouting_final.tscn")
	if Input.is_action_just_pressed("foul+"):
		data.fouls+=1
		label.text=str(data.fouls)
	if Input.is_action_just_pressed("foul-"):
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
