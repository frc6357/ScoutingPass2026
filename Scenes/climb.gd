extends Node2D
@onready var animate_l1: AnimatedSprite2D = $L1/AnimatedSprite2D
@onready var animate_l2: AnimatedSprite2D = $L2/AnimatedSprite2D
@onready var animate_l3: AnimatedSprite2D = $L3/AnimatedSprite2D
@onready var timer: Timer = $"../Timer"
@onready var animate: AnimatedSprite2D = $left/AnimatedSprite2D
@onready var animate2: AnimatedSprite2D = $right/AnimatedSprite2D2
@onready var animate3: AnimatedSprite2D = $center/AnimatedSprite2D3
@onready var data: Node2D = $"../DataStorage"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animate_l1.play("no")
	animate_l2.play("no")
	animate_l3.play("no")
	animate.play("off")
	animate2.play("off")
	animate3.play("off")
var time_l1=0
var time_l2=0
var time_l3=0
var l1=false
var l2=false
var l3=false
var zone="none"
var points=0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("l1"):
		if l1 and not l2 and not l3:
			l1=false
			animate_l1.play("no")
			points=0
		else:
			points=10
			l1=true
			animate_l1.play("yes")
			time_l1=int(timer.time_left*10)
			time_l1=(float(time_l1))/10
			time_l1-=20
	if Input.is_action_just_pressed("l2"):
		if l2 and not l3:
			l2=false
			animate_l2.play("no")
			points=10
		elif l1:
			points=20
			l2=true
			animate_l2.play("yes")
			time_l2=int(timer.time_left*10)
			time_l2=(float(time_l2))/10
			time_l2-=20
	if Input.is_action_just_pressed("l3"):
		if l3:
			points=20
			l3=false
			animate_l3.play("no")
		elif l1 and l2:
			points=30
			l3=true
			animate_l3.play("yes")
			time_l3=int(timer.time_left*10)
			time_l3=(float(time_l3))/10
			time_l3-=20
	if Input.is_action_just_pressed("left"):
		data.c_zone="left"
		animate.play("on")
		animate2.play("off")
		animate3.play("off")
	if Input.is_action_just_pressed("right"):
		data.c_zone="right"
		animate2.play("on")
		animate.play("off")
		animate3.play("off")
	if Input.is_action_just_pressed("center"):
		data.c_zone="center"
		animate3.play("on")
		animate2.play("off")
		animate.play("off")
		
		
