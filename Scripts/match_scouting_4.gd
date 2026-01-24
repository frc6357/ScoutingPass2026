extends Node2D
@onready var data: Node2D = $DataStorage


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("scouting4")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("endgame"):
		get_tree().change_scene_to_file("res://Scenes/match_scouting3.tscn")
	if Input.is_action_just_pressed("final"):
		get_tree().change_scene_to_file("res://Scenes/match_scouting_final.tscn")
