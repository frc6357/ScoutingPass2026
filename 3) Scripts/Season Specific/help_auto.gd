extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("scouting1")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("main"):
		Input.vibrate_handheld(75)
		get_tree().change_scene_to_file("res://2) Scenes/Important/main.tscn")
	if Input.is_action_just_pressed("teleop"):
		Input.vibrate_handheld(75)
		get_tree().change_scene_to_file("res://2) Scenes/Season_Specific/help_tele.tscn")
