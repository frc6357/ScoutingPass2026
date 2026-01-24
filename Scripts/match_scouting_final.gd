extends Node2D
@onready var qr_code: Node2D = $"QR code generator"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	qr_code.generate()
	print("scouting final")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("misc"):
		get_tree().change_scene_to_file("res://Scenes/match_scouting4.tscn")
	if Input.is_action_just_pressed("main"):
		get_tree().change_scene_to_file("res://Scenes/main.tscn")
