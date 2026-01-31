extends Node2D
@onready var data: Node2D = $"../DataStorage"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
var e
func generate():
	print("fuel auto: ",data.fuel_a)
	print("fuel tele: ",data.fuel_t)
	print("fuel total: ",data.fuel_t+data.fuel_a)
	print("defense time: ",data.time_defense)
	print("offense time: ",data.time_offense)
	print("shuttle time: ",data.time_shuttle)
	print("disabled time: ",data.time_disabled)
	print("accuracy tele: ",str(float(data.accuracy_t)*100),"%")
	print("shots taken: ",data.shots)
	print("fuel shuttled: ", data.fuel_s)
	if data.shots>0:
		e=(data.time_offense/data.shots)*100
		e=int(e)
		e=float(e)
		e=e/100
	else:
		e=0
	print("seconds per cycle: ",e)
	if data.shots>0:
		e=((data.fuel_t+data.fuel_a)/data.shots)*100
		e=int(e)
		e=float(e)
		e=e/100
	else:
		e=0
	print("points per cycle: ",e)
	if data.time_shuttle>0:
		e=((data.fuel_s)/data.time_shuttle)*100
		e=int(e)
		e=float(e)
		e=e/100
	else:
		e=0
	print("fuel shuttled per second: ",e)
	if data.time_l1>0:
		print("time left l1:",data.time_l1)
	if data.time_l2>0:
		print("time left l2:",data.time_l2)
	if data.time_l3>0:
		print("time left l3:",data.time_l3)
	print("climb points tele: ", data.climb_t)
