extends Node2D
@onready var data: Node2D = $DataStorage
@onready var disabled: Node2D = $Disabled
@onready var defense: Node2D = $Defense


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("scouting2")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("auto"):
		data.time_disabled=disabled.time
		data.time_defense=defense.time
		get_tree().change_scene_to_file("res://Scenes/match_scouting.tscn")
	if Input.is_action_just_pressed("endgame"):
		get_tree().change_scene_to_file("res://Scenes/match_scouting3.tscn")
