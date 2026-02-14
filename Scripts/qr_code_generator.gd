extends Node2D
@onready var data: Node2D = $"../DataStorage"
@onready var qr_code: QRCodeRect = $QRCodeRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
var e
var storedData
func generate():
	storedData=("http://localhost:5000/add-data?data="+
	str(data.scoutName)+","+str(data.matchNum)+","+str(data.team)+","+str(data.fuel_a)+","+str(data.fuel_t)+
	","+str(data.fuel_s)+","+str(data.shots)+
	","+str(data.accuracy_a)+","+str(data.accuracy_t)+
	","+str(data.time_defense)+","+str(data.time_offense)+
	","+str(data.time_shuttle)+","+str(data.time_disabled)+
	","+str(data.l1)+","+str(data.time_l1)+","+str(data.l2)+
	","+str(data.time_l2)+","+str(data.l3)+","+str(data.time_l3)+","+str(data.c_zone)+
	","+str(data.trench)+","+str(data.bump)+","+str(data.pins)+"~~~~~~~~~~~~~~~~~~~~~~~").to_utf8_buffer() #The QR code has an error where the program crashes when the size of stored data is exactly 112. To fix this, I added ~ to the end of it (which are removed automatically by the HTTP Server) 
	#storedData=("http://localhost:5000/add-data?data=none,0,0,0,33,0,0,0.9,1,0,3.7,0,0,false,0,false,0,false,0,none,false,false,0").to_utf8_buffer()
	qr_code._qr.put_byte(storedData)
	qr_code._update_qr()
	print(qr_code.data)
	'''
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
	'''
