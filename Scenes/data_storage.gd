extends Node2D
static var fuel=0
static var fuel_a=0
static var fuel_t=0
static var time_disabled=0
static var time_defense=0
static var time_offense=0
static var time_shuttle=0
static var accuracy_t=-1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
func reset():
	fuel=fuel_a+fuel_t
	fuel=0
	fuel_a=0
	fuel_t=0
	time_disabled=0
	time_defense=0
	time_offense=0
	time_shuttle=0
	accuracy_t=-1
	get_tree().change_scene_to_file("res://Scenes/match_scouting.tscn")
