extends Node2D
@onready var data: Node2D = $DataStorage
@onready var matchD: Label = $Node2D/match
@onready var text_edit: TextEdit = $Name/TextEdit
@onready var text_edit2: TextEdit = $Robot/TextEdit
var changeName=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#sets the displays to their appropriate default values
	text_edit.text=data.scoutName
	text_edit2.text=str(data.team)
	matchD.text=str(data.matchNum)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#sets the values in data storage to the values displayed in the text.
	data.scoutName=text_edit.text
	data.team=text_edit2.text
	
	if Input.is_action_just_pressed("match+"):
		#adds 1 to the match number
		data.matchNum+=1
		matchD.text=str(data.matchNum)
		
	if Input.is_action_just_pressed("match-"):
		 #subtracts 1 from the match number (can't go below 1)
		if data.matchNum>1:
			data.matchNum-=1
		matchD.text=str(data.matchNum)
		
	if Input.is_action_just_pressed("auto"): 
		#moves to the match scouting file 1
		Input.vibrate_handheld(100)
		data.reset()
		
	if Input.is_action_just_pressed("pit"): 
		#moves to pit scouting file
		Input.vibrate_handheld(100)
		get_tree().change_scene_to_file("res://Scenes/pit_scouting.tscn")
		
	if Input.is_action_just_pressed("strategy"):
		#moves to strategy file
		Input.vibrate_handheld(100)
		get_tree().change_scene_to_file("res://Scenes/strategy.tscn")
		
	if Input.is_action_just_pressed("history"):
		#moves to the history file
		Input.vibrate_handheld(100)
		get_tree().change_scene_to_file("res://Scenes/history.tscn")
		
	if Input.is_action_just_pressed("help"):
		#moves to the help file
		Input.vibrate_handheld(100)
		data.reset(false)
		get_tree().change_scene_to_file("res://Scenes/help_auto.tscn")
