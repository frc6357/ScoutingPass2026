extends Node2D
#this file sets the information displayed in the qr code 
#DO NOT CHANGE OR DELETE THIS FILE AT THE START OF A NEW SEASON.

@onready var data: Node2D = $DataStorage
@onready var qr: Node2D = $"QR code generator"
@onready var label: Label = $Label
@onready var label_2: Label = $Label2
@onready var pit: TouchScreenButton = $Pit/TouchScreenButton
@onready var animate_pit: AnimatedSprite2D = $Pit

# Called when the node enters the scene tree for the first time.
var matchNum=1
var num=0
var clearing=false
var mode
func _ready() -> void:
	mode="match"
	animate_pit.play("match")
	if len(data.history)>=1: #checks to see if any data has been recorded
		data.unwrap(num) #sets the variables in data to the values that were recorded in a given match
		label.text="Match "+str(data.matchNum)
		label_2.text="Team "+str(data.team) 
		qr.generate() #generates a QR code with the data
		label.position.y=-300
	else:
		#Since it can't collect data that doesn't exist, it will move the qr code and 
		#display an error message
		label.position.y=-200
		qr.position.x=-1000
		label.text="You have not recorded data yet"
		label_2.text=""


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("main") and not clearing:
		get_tree().change_scene_to_file("res://Scenes/main.tscn")
	if Input.is_action_just_pressed("pit")and len(data.pit_history)>=1:
		if mode=="pit":
			animate_pit.play("match")
			mode="match"
			num=0
			data.unwrap(num)
			label_2.text="Team "+str(data.team)
			qr.generate()
			label.text="Match "+str(data.matchNum)
		else:
			animate_pit.play("pit")
			num=0
			mode="pit"
			data.unwrap_pit(num)
			label_2.text="Pit Data"
			qr.generate_pit()
			label.text="Team "+str(data.team)
	if mode=="match":
		if Input.is_action_just_pressed("previous") and len(data.history)>=1 and not clearing:
			num-=1
			if num <0: #warps to the end of the list if at the begining.
				num=len(data.history)-1 
			data.unwrap(num)
			label_2.text="Team "+str(data.team)
			qr.generate()
			label.text="Match "+str(data.matchNum)

		if Input.is_action_just_pressed("next") and len(data.history)>=1 and not clearing:
			num+=1
			if num >=len(data.history): #warps to the front of the list if at the end.
				num=0
			data.unwrap(num)
			label_2.text="Team "+str(data.team)
			qr.generate()
			label.text="Match "+str(data.matchNum)
	elif mode=="pit":
		if Input.is_action_just_pressed("previous") and len(data.pit_history)>=1 and not clearing:
			num-=1
			if num <0: #warps to the end of the list if at the begining.
				num=len(data.pit_history)-1 
			data.unwrap_pit(num) #sets the displayed data to the data in pit_history
			label.text="Team "+str(data.team)
			qr.generate_pit()
			label_2.text="Pit Data"

		if Input.is_action_just_pressed("next") and len(data.pit_history)>=1 and not clearing:
			num+=1
			if num >=len(data.pit_history): #warps to the front of the list if at the end.
				num=0
			data.unwrap_pit(num) #sets the displayed data to the data in pit_history
			label.text="Team "+str(data.team)
			qr.generate_pit()
			label_2.text="Pit Data"
func clear():
	data.history=[]
	data.pit_history=[]
	data.save_data()
	qr.position.x=-1500
	label.position.y=-200
	label.text="You have not recorded data yet"
	label_2.text=""
