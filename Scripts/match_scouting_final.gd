extends Node2D
@onready var qr_code: Node2D = $"QR code generator"
@onready var data: Node2D = $DataStorage
@onready var timer: Timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	data.update()
	qr_code.generate()
	print("scouting final")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("misc") and timer.time_left<=98:
		Input.vibrate_handheld(75)
		get_tree().change_scene_to_file("res://Scenes/match_scouting2.tscn")
	if Input.is_action_just_pressed("main") and timer.time_left<=98:
		Input.vibrate_handheld(75)
		data.matchNum+=1
		get_tree().change_scene_to_file("res://Scenes/main.tscn")
