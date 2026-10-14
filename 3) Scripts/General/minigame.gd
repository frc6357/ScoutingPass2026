extends Node2D
@onready var data: Node2D = $DataStorage
var fuel
var growth

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("game")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	fuel=int(data.fuel_g)
	growth=int(data.growth)
	if Input.is_action_just_pressed("main"):
		get_tree().change_scene_to_file("res://2) Scenes/Important/main.tscn")
	if Input.is_action_just_pressed("auto"):
		get_tree().change_scene_to_file("res://2) Scenes/Season_Specific/match_scouting.tscn")
