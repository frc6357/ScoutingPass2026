extends Node2D
@onready var qr: Node2D = $"QR code generator"
@onready var exit: TouchScreenButton = $exit
@onready var data: Node2D = $DataStorage


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	data.update_pit()
	qr.generate_pit()
  

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if exit.is_pressed():
		get_tree().change_scene_to_file("res://2) Scenes/Important/main.tscn")
