extends Node2D
@onready var data: Node2D = $DataStorage

var changeName=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("main")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#changes to the appropriate scene when certain commands are triggered
	if Input.is_action_just_pressed("auto"):
		Input.vibrate_handheld(100)
		data.reset()
	if Input.is_action_just_pressed("pit"):
		Input.vibrate_handheld(100)
		get_tree().change_scene_to_file("res://Scenes/pit_scouting.tscn")
	if Input.is_action_just_pressed("strategy"):
		Input.vibrate_handheld(100)
		get_tree().change_scene_to_file("res://Scenes/strategy.tscn")
	if Input.is_action_just_pressed("history"):
		Input.vibrate_handheld(100)
		get_tree().change_scene_to_file("res://Scenes/history.tscn")
	if Input.is_action_just_pressed("minigame"):
		Input.vibrate_handheld(100)
		get_tree().change_scene_to_file("res://Scenes/minigame.tscn")
	if Input.is_action_just_pressed("name"):
		Input.vibrate_handheld(100)
		changeName=not changeName
		if changeName:
			DisplayServer.virtual_keyboard_show("")
		else:
			DisplayServer.virtual_keyboard_hide()
