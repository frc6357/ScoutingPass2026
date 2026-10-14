extends Node2D
@onready var number: TextEdit = $Number
@onready var height_1: TextEdit = $Height1
@onready var height_2: TextEdit = $Height2
@onready var width: TextEdit = $Width
@onready var drive_train: TextEdit = $DriveTrain
@onready var capacity: TextEdit = $Capacity
@onready var favorite: TextEdit = $Favorite
@onready var length: TextEdit = $Lenth
@onready var c_yes: TouchScreenButton = $cYes
@onready var t_yes: TouchScreenButton = $tYes
@onready var m_yes: TouchScreenButton = $mYes
@onready var c_no: TouchScreenButton = $cNo
@onready var t_no: TouchScreenButton = $tNo
@onready var m_no: TouchScreenButton = $mNo
@onready var cy: AnimatedSprite2D = $cYes/AnimatedSprite2D
@onready var ty: AnimatedSprite2D = $tYes/AnimatedSprite2D
@onready var my: AnimatedSprite2D = $mYes/AnimatedSprite2D
@onready var cn: AnimatedSprite2D = $cNo/AnimatedSprite2D
@onready var tn: AnimatedSprite2D = $tNo/AnimatedSprite2D
@onready var mn: AnimatedSprite2D = $mNo/AnimatedSprite2D
@onready var data: Node2D = $DataStorage
@onready var done: TouchScreenButton = $Done
@onready var exit: TouchScreenButton = $exit
@onready var intake: TextEdit = $Intake

var team =""
var e_height =""
var u_height =""
var w=""
var l=""
var storage=""
var drive=""
var fav=""
var climb=false
var turret=false
var multi=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DisplayServer.screen_set_orientation(DisplayServer.SCREEN_PORTRAIT)
	print("pit_scouting")
	cn.play("on")
	tn.play("on")
	mn.play("on")
	cy.play("off")
	ty.play("off")
	my.play("off")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if exit.is_pressed():
		get_tree().change_scene_to_file("res://2) Scenes/Important/main.tscn")
	if done.is_pressed():
		print("done")
		get_tree().change_scene_to_file("res://2) Scenes/General/pit_2.tscn")
	if c_yes.is_pressed():
		data.climb=true
		cy.play("on")
		cn.play("off")
	if c_no.is_pressed():
		data.climb=false
		cn.play("on")
		cy.play("off")
	if t_yes.is_pressed():
		turret=false
		data.turret=false
		ty.play("on")
		tn.play("off")
	if t_no.is_pressed():
		turret=false
		data.turret=true
		tn.play("on")
		ty.play("off")
	if m_yes.is_pressed():
		multi=true
		data.multi_launcher=true
		my.play("on")
		mn.play("off")
	if m_no.is_pressed():
		multi=true
		mn.play("on")
		my.play("off")
		data.multi_launcher=false
	
	data.team=number.text
	e_height=height_2.text
	data.height=height_1.text
	w=width.text
	l=length.text
	fav=favorite.text
	storage=capacity.text
	data.storage_capacity=capacity.text
	data.drive=drive_train.text
	data.favorite=favorite.text
	data.intake=intake.text
