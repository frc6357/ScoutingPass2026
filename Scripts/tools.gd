extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("tools")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("main"):
		get_tree().change_scene_to_file("res://Scenes/main.tscn")
