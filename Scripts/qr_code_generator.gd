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
func generate_pit(): #generates a qr code for 1 robot's pit scouting data
	storedData=(data.prefix2+data.team+","+data.storage_capacity+","+str(data.turret)+","+str(data.multi_launcher)+","+str(data.height)+","+str(data.drive)+","+str(data.climb)+","+str(data.intake)+","+str(data.favorite)).to_utf8_buffer()
	qr_code._qr.put_byte(storedData)
	qr_code._update_qr()
	print(qr_code.data)
var combinedData
func generate_all_pit(): #generates a qr code for ALL pit scouting data
	combinedData=''
	#puts all pit data into one list with individual teams seperated by ` (can be replaced with \n if needed)
	for i in range(len(data.pit_history)):
		combinedData+=str(data.pit_history[i])
		if i<len(data.pit_history)-1:
			combinedData+="`"
	#removes unnessisary characters which can cause issues with http server (or other exporting methoods)
	combinedData=combinedData.replace("[","").replace("]","").replace('"',"").replace(" ","")
	combinedData=data.prefix2+combinedData
	print("combined data: "+combinedData)
	storedData=(combinedData).to_utf8_buffer() #puts the data into a form in which it can be stored in a qr code
	qr_code._qr.put_byte(storedData)
	qr_code._update_qr()
	print("data: "+qr_code.data)
func generate():
	#this is the data that will be put in the qr code MAKE SURE TO KEEP THE PREFIX
	storedData=(data.prefix+
	str(data.scoutName)+","+str(data.matchNum)+","+str(data.team)+","+str(data.fuel_a)+","+str(data.fuel_t)+
	","+str(data.fuel_s)+","+str(data.shots)+
	","+str(data.accuracy_a)+","+str(data.accuracy_t)+
	","+str(data.time_defense)+","+str(data.time_offense)+
	","+str(data.time_shuttle)+","+str(data.time_disabled)+
	","+str(data.l1)+","+str(data.time_l1)+","+str(data.l2)+
	","+str(data.time_l2)+","+str(data.l3)+","+str(data.time_l3)+","+str(data.c_zone)+
	","+str(data.trench)+","+str(data.bump)+","+str(data.pins)+",~~~~~~~~~~~~~~~~~~~~~~~").to_utf8_buffer() #The QR code has an error where the program crashes when the size of stored data is exactly 112. To fix this, I added ~ to the end of it (which are removed automatically by the HTTP Server) 
	#storedData=("http://localhost:5000/add-data?data=none,0,0,0,33,0,0,0.9,1,0,3.7,0,0,false,0,false,0,false,0,none,false,false,0").to_utf8_buffer()
	qr_code._qr.put_byte(storedData)
	qr_code._update_qr()
	print(qr_code.data)
	
