extends Node2D
@onready var data: Node2D = $"../DataStorage"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func generate():
	print("fuel auto: ",data.fuel_a)
	print("fuel tele: ",data.fuel_t)
	print("fuel total: ",data.fuel_t+data.fuel_a)
	print("defense time: ",data.time_defense)
	print("offense time: ",data.time_offense)
	print("shuttle time: ",data.time_shuttle)
	print("disabled time: ",data.time_disabled)
	print("accuracy tele: ",str(float(data.accuracy_t)*100),"%")
