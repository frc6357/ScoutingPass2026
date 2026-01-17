extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("main")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#changes to the appropriate scene when certain commands are triggered
	if Input.is_action_just_pressed("auto"):
		get_tree().change_scene_to_file("res://Scenes/match_scouting.tscn")
	if Input.is_action_just_pressed("pit"):
		get_tree().change_scene_to_file("res://Scenes/pit_scouting.tscn")
	if Input.is_action_just_pressed("strategy"):
		get_tree().change_scene_to_file("res://Scenes/strategy.tscn")
	if Input.is_action_just_pressed("tools"):
		get_tree().change_scene_to_file("res://Scenes/tools.tscn")
	if Input.is_action_just_pressed("minigame"):
		get_tree().change_scene_to_file("res://Scenes/minigame.tscn")
