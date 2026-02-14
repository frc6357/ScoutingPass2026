extends Node2D
@onready var animate_l1: AnimatedSprite2D = $L1/AnimatedSprite2D
@onready var animate_l2: AnimatedSprite2D = $L2/AnimatedSprite2D
@onready var animate_l3: AnimatedSprite2D = $L3/AnimatedSprite2D
@onready var timer: Timer = $"../Timer"
@onready var animate: AnimatedSprite2D = $left/AnimatedSprite2D
@onready var animate2: AnimatedSprite2D = $right/AnimatedSprite2D2
@onready var animate3: AnimatedSprite2D = $center/AnimatedSprite2D3
@onready var data: Node2D = $"../DataStorage"
var time_l1=0
var time_l2=0
var time_l3=0
var l1=false
var l2=false
var l3=false
var zone="none"
var points=0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time_l1=data.time_l1
	time_l2=data.time_l2
	time_l3=data.time_l3
	l1=data.l1
	l2=data.l2
	l3=data.l3
	zone=data.c_zone
	print(l1)
	if l3:
		animate_l3.play("yes")
	else:
		animate_l3.play("no")
	if l2:
		animate_l2.play("yes")
	else:
		animate_l2.play("no")
	if l1:
		animate_l1.play("yes")
	else:
		animate_l1.play("no")
	animate.play("off")
	animate2.play("off")
	animate3.play("off")
	if zone=="center":
		animate3.play("on")
	if zone=="left":
		animate.play("on")
	if zone=="right":
		animate2.play("on")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("l1"):
		if not l1 or l2:
			animate_l3.play("no")
			animate_l2.play("no")
			animate_l1.play("top")
			points=10
			l3=false
			l2=false
			l1=true
			time_l1=int(timer.time_left*10)
			time_l1=(float(time_l3))/10
			time_l1-=20
		else:
			animate_l3.play("no")
			animate_l2.play("no")
			animate_l1.play("no")
			points=0
			l3=false
			l2=false
			l1=false
	if Input.is_action_just_pressed("l2"):
		animate_l3.play("no")
		animate_l2.play("top")
		animate_l1.play("yes")
		points=20
		l3=false
		l2=true
		l1=true
		time_l2=int(timer.time_left*10)
		time_l2=(float(time_l3))/10
		time_l2-=20
	if Input.is_action_just_pressed("l3"):
		points=30
		l3=true
		l2=true
		l1=true
		animate_l3.play("top")
		animate_l2.play("yes")
		animate_l1.play("yes")
		time_l3=int(timer.time_left*10)
		time_l3=(float(time_l3))/10
		time_l3-=20
	if Input.is_action_just_pressed("left"):
		if data.c_zone=="center" or data.c_zone=="rightCenter":
			data.c_zone="leftCenter"
			animate.play("on")
			animate3.play("on")
			animate2.play("off")
		elif data.c_zone=="left":
			data.c_zone="none"
			animate.play("off")
		elif data.c_zone=="leftCenter":
			data.c_zone="left"
			animate3.play("off")
		else:
			data.c_zone="left"
			animate.play("on")
			animate2.play("off")
			animate3.play("off")
	if Input.is_action_just_pressed("right"):
		if data.c_zone=="center" or data.c_zone=="leftCenter":
			data.c_zone="rightCenter"
			animate.play("off")
			animate3.play("on")
			animate2.play("on")
		elif data.c_zone=="right":
			data.c_zone="none"
			animate2.play("off")
		elif data.c_zone=="rightCenter":
			data.c_zone="right"
			animate3.play("off")
		else:
			data.c_zone="right"
			animate2.play("on")
			animate.play("off")
			animate3.play("off")
	if Input.is_action_just_pressed("center"):
		if data.c_zone=="rightCenter" or data.c_zone=="leftCenter":
			data.c_zone="center"
			animate.play("off")
			animate3.play("on")
			animate2.play("off")
		elif data.c_zone=="center":
			data.c_zone="none"
			animate3.play("off")
		elif data.c_zone=="left":
			data.c_zone="leftCenter"
			animate3.play("on")
		elif data.c_zone=="right":
			data.c_zone="rightCenter"
			animate3.play("on")
		else:
			data.c_zone="center"
			animate3.play("on")
			animate.play("off")
			animate2.play("off")
		
		
