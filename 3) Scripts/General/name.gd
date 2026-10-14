extends Node2D
@onready var text_edit: TextEdit = $TextEdit
@onready var data: Node2D = $"../DataStorage"

var keys = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
var text =""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	'''
	for key in keys:
		if Input.is_action_just_pressed(key):
			text+=key
			label.text="Scouter Name: "+text
	if Input.is_action_just_pressed("delete"):
		text = text.left(-1)
		label.text="Scouter Name: "+text
	if Input.is_action_just_pressed("space"):
		text+=" "
		label.text="Scouter Name: "+text
	if Input.is_action_just_pressed("enter"):
		DisplayServer.virtual_keyboard_hide()
	'''
		
		
