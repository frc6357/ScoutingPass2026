extends Node2D
@onready var qr: Node2D = $"QR code generator"
@onready var exit: TouchScreenButton = $exit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	qr.generate_pit()
  

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if exit.is_pressed():
		get_tree().change_scene_to_file("res://Scenes/main.tscn")
