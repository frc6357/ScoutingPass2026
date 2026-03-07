extends Node2D
@onready var input: TextEdit = $Custom/Input
@onready var data: Node2D = $DataStorage
@onready var raw: AnimatedSprite2D = $"Raw Data/Yes"
@onready var server: AnimatedSprite2D = $"Http Server/Yes"
@onready var command: AnimatedSprite2D = $"Command Line/Yes"
@onready var custom: AnimatedSprite2D = $Custom/Yes
@onready var cu_button: TouchScreenButton = $Custom/Button
@onready var co_button: TouchScreenButton = $"Command Line/Button"
@onready var s_button: TouchScreenButton = $"Http Server/Button"
@onready var r_button: TouchScreenButton = $"Raw Data/Button"
@onready var exit: TouchScreenButton = $exit

var c=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input.text=data.customPrefix
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if exit.is_pressed():
		get_tree().change_scene_to_file("res://Scenes/main.tscn")
	raw.play("off")
	server.play("off")
	command.play("off")
	custom.play("off")

	data.customPrefix=input.text
	if cu_button.is_pressed():
		data.export="custom"
	if co_button.is_pressed():
		data.export="command"
		data.prefix="curl http://localhost:5000/add-data?data="
		data.prefix2="curl http://localhost:5000/add-pit-data?data="
	if s_button.is_pressed():
		data.export="server"
		data.prefix="http://localhost:5000/add-data?data="
		data.prefix2="http://localhost:5000/add-pit-data?data="
	if r_button.is_pressed():
		data.export="raw"
		data.prefix=""
		data.prefix2=""
	if data.export=="custom":
		data.prefix=input.text
		data.prefix2=input.text
		custom.play("on")
	if data.export=="command":
		command.play("on")
	if data.export=="server":
		server.play("on")
	if data.export=="raw":
		raw.play("on")
