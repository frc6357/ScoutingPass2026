extends Node2D
@onready var timer: Timer = $"../Timer"
@onready var animate: AnimatedSprite2D = $AnimatedSprite2D
@onready var disabled: Node2D = $"../Disabled"
@onready var animate2: AnimatedSprite2D = $AnimatedSprite2D2
@onready var animate3: AnimatedSprite2D = $AnimatedSprite2D3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animate.play("offense")
var ds_time=0 # time where the timer started for cycling
var de_time=0 # time when the timer ended for cycling
var cs_time=0 # time where the timer started for cycling
var ce_time=0 # time when the timer ended for cycling
var os_time=1400 # time where the timer started for offense
var oe_time=0 # time when the timer ended for offense
var order=["offense"]
var dtime=0 #total time elapsed
var ctime=0 #total time elapsed
var otime=0 #total time elapsed
var active=false
var sleeping=false
var mode="offense"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if timer.time_left>0:
		if Input.is_action_just_pressed("defense_n"):
			if mode=="offense":
				mode="defense"
				order.append("defense")
				animate.play("defense") #changes to defense animation
				animate2.play("cycle")
				animate3.play("offense")
				oe_time=timer.time_left
				oe_time=(int(oe_time*10)) #rounds to the nearest tenth of a second
				otime+=float(os_time-oe_time)/10#adds to the total time disabled. Decreases to appropriate time.
				#sets the start time to the current time on the timer.
				ds_time=timer.time_left
				ds_time=(int(ds_time*10)) #rounds to the nearest tenth of a second
				print("offense time:",otime)
			elif mode=="defense":
				mode="cycle"
				order.append("cycle")
				animate.play("cycle") #changes to offense animation
				animate2.play("offense")
				animate3.play("defense")
				de_time=timer.time_left
				de_time=(int(de_time*10)) #rounds to the nearest tenth of a second
				dtime+=float(ds_time-de_time)/10#adds to the total time disabled. Decreases to appropriate time.
				#sets the start time to the current time on the timer.
				cs_time=timer.time_left
				cs_time=(int(cs_time*10)) #rounds to the nearest tenth of a second
				print("defense time:",dtime)
			elif mode=="cycle":
				mode="offense"
				order.append("offense")
				animate.play("offense") #changes to offense animation
				animate2.play("defense")
				animate3.play("cycle")
				ce_time=timer.time_left
				ce_time=(int(ce_time*10)) #rounds to the nearest tenth of a second
				ctime+=float(cs_time-ce_time)/10#adds to the total time disabled. Decreases to appropriate time.
				#sets the start time to the current time on the timer.
				os_time=timer.time_left
				os_time=(int(os_time*10)) #rounds to the nearest tenth of a second
				print("cycle time:",ctime)
		if Input.is_action_just_pressed("defense_p"):
			if mode=="cycle":
				mode="defense"
				order.append("defense")
				animate.play("defense") #changes to defense animation
				animate2.play("cycle")
				animate3.play("offense")
				ce_time=timer.time_left
				ce_time=(int(ce_time*10)) #rounds to the nearest tenth of a second
				ctime+=float(cs_time-ce_time)/10#adds to the total time disabled. Decreases to appropriate time.
				#sets the start time to the current time on the timer.
				ds_time=timer.time_left
				ds_time=(int(ds_time*10)) #rounds to the nearest tenth of a second
				print("cycle time:",ctime)
			elif mode=="offense":
				mode="cycle"
				order.append("cycle")
				animate.play("cycle") #changes to offense animation
				animate2.play("offense")
				animate3.play("defense")
				oe_time=timer.time_left
				oe_time=(int(oe_time*10)) #rounds to the nearest tenth of a second
				otime+=float(os_time-oe_time)/10#adds to the total time disabled. Decreases to appropriate time.
				#sets the start time to the current time on the timer.
				cs_time=timer.time_left
				cs_time=(int(cs_time*10)) #rounds to the nearest tenth of a second
				print("offense time:",otime)
			elif mode=="defense":
				mode="offense"
				order.append("offense")
				animate.play("offense") #changes to offense animation
				animate2.play("defense")
				animate3.play("cycle")
				de_time=timer.time_left
				de_time=(int(de_time*10)) #rounds to the nearest tenth of a second
				dtime+=float(ds_time-de_time)/10#adds to the total time disabled. Decreases to appropriate time.
				#sets the start time to the current time on the timer.
				os_time=timer.time_left
				os_time=(int(os_time*10)) #rounds to the nearest tenth of a second
				print("defense time:",dtime)
	else:
		if mode=="offensive":
			oe_time=timer.time_left
			oe_time=(int(oe_time*10)) #rounds to the nearest tenth of a second
			otime+=float(os_time-oe_time)/10#adds to the total time disabled. Decreases to appropriate time.
		if mode=="defensive":
			de_time=timer.time_left
			de_time=(int(de_time*10)) #rounds to the nearest tenth of a second
			dtime+=float(ds_time-oe_time)/10#adds to the total time disabled. Decreases to appropriate time.
		if mode=="cycle":
			ce_time=timer.time_left
			ce_time=(int(ce_time*10)) #rounds to the nearest tenth of a second
			ctime+=float(cs_time-oe_time)/10#adds to the total time disabled. Decreases to appropriate time.
