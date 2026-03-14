extends Node2D
@onready var timer: Timer = $"../Timer"
@onready var mode_i: AnimatedSprite2D = $Mode
@onready var data: Node2D = $"../DataStorage"
@onready var disabled2: Node2D = $"../Disabled"
@onready var climb: Node2D = $"../Climb"


# Called when the node enters the scene tree for the first time.
var done=false
var ds_time=0 # time where the timer started for cycling
var de_time=0 # time when the timer ended for cycling
var cs_time=0 # time where the timer started for cycling
var ce_time=0 # time when the timer ended for cycling
var os_time=20000 # time where the timer started for offense *10
var oe_time=0 # time when the timer ended for offense
var order=["offense"]
var dtime=0 #total time elapsed
var ctime=0 #total time elapsed
var otime=0 #total time elapsed
var active=false
var sleeping=false
var mode="offense"
var d=false
func _ready() -> void:
	mode_i.play("offense")
	dtime=data.time_defense
	ctime=data.time_shuttle
	otime=data.time_offense
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("endgame") and timer.time_left<=198:
		Input.vibrate_handheld(75)
		if mode=="offense":
			oe_time=timer.time_left
			oe_time=(int(oe_time*10)) #rounds to the nearest tenth of a second
			otime+=float(os_time-oe_time)/10#adds to the total time disabled. Decreases to appropriate time.
		if mode=="defense":
			de_time=timer.time_left
			de_time=(int(de_time*10)) #rounds to the nearest tenth of a second
			dtime+=float(ds_time-de_time)/10#adds to the total time disabled. Decreases to appropriate time.
		if mode=="shuttle":
			ce_time=timer.time_left
			ce_time=(int(ce_time*10)) #rounds to the nearest tenth of a second
			ctime+=float(cs_time-ce_time)/10#adds to the total time disabled. Decreases to appropriate time
		data.time_disabled=disabled2.time
		data.time_defense=dtime
		data.time_offense=otime
		data.time_shuttle=ctime
		data.time_l1=climb.time_l1
		data.time_l2=climb.time_l2
		data.time_l3=climb.time_l3
		data.climb_t=climb.points
		data.l1=climb.l1
		data.l2=climb.l2
		data.l3=climb.l3
		get_tree().change_scene_to_file("res://Scenes/match_scouting_final.tscn")
	if timer.time_left>20:
		if Input.is_action_just_pressed("defense") and d==false and done==false:
			Input.vibrate_handheld(75)
			if mode=="offense":
				oe_time=timer.time_left
				oe_time=(int(oe_time*10)) #rounds to the nearest tenth of a second
				otime+=float(os_time-oe_time)/10#adds to the total time disabled. Decreases to appropriate time.
				#sets the start time to the current time on the timer.
				print("offense time:",otime)
			elif mode=="shuttle":
				ce_time=timer.time_left
				ce_time=(int(ce_time*10)) #rounds to the nearest tenth of a second
				ctime+=float(cs_time-ce_time)/10
				print("shuttle time:",ctime)
			mode="defense"
			order.append("defense")
			mode_i.play("defense") #changes to defense animation
			ds_time=timer.time_left
			ds_time=(int(ds_time*10)) #rounds to the nearest tenth of a second
		if Input.is_action_just_pressed("offense") and d==false:
			Input.vibrate_handheld(100)
			if mode=="defense":
				de_time=timer.time_left
				de_time=(int(de_time*10)) #rounds to the nearest tenth of a second
				dtime+=float(ds_time-de_time)/10#adds to the total time disabled. Decreases to appropriate time.
				#sets the start time to the current time on the timer.
				print("defense time:",dtime)
			elif mode=="shuttle":
				ce_time=timer.time_left
				ce_time=(int(ce_time*10)) #rounds to the nearest tenth of a second
				ctime+=float(cs_time-ce_time)/10
				print("shuttle time:",ctime)
			mode="offense"
			order.append("offense")
			mode_i.play("offense") #changes to defense animation
			os_time=timer.time_left
			os_time=(int(os_time*10)) #rounds to the nearest tenth of a second
		if Input.is_action_just_pressed("shuttle") and d==false:
			Input.vibrate_handheld(50)
			if mode=="defense":
				de_time=timer.time_left
				de_time=(int(de_time*10)) #rounds to the nearest tenth of a second
				dtime+=float(ds_time-de_time)/10#adds to the total time disabled. Decreases to appropriate time.
				#sets the start time to the current time on the timer.
				print("defense time:",dtime)
			elif mode=="offense":
				oe_time=timer.time_left
				oe_time=(int(oe_time*10)) #rounds to the nearest tenth of a second
				otime+=float(os_time-oe_time)/10
				print("offense time:",otime)
			mode="shuttle"
			order.append("shuttle")
			mode_i.play("shuttle") #changes to defense animation
			cs_time=timer.time_left
			cs_time=(int(cs_time*10)) #rounds to the nearest tenth of a second
	else:
		if mode=="offense":
			oe_time=timer.time_left
			oe_time=(int(oe_time*10)) #rounds to the nearest tenth of a second
			otime+=float(os_time-oe_time)/10#adds to the total time disabled. Decreases to appropriate time.
		if mode=="defense":
			de_time=timer.time_left
			de_time=(int(de_time*10)) #rounds to the nearest tenth of a second
			dtime+=float(ds_time-oe_time)/10#adds to the total time disabled. Decreases to appropriate time.
		if mode=="shuttle":
			ce_time=timer.time_left
			ce_time=(int(ce_time*10)) #rounds to the nearest tenth of a second
			ctime+=float(cs_time-oe_time)/10#adds to the total time disabled. Decreases to appropriate time
		data.time_disabled=disabled2.time
		data.time_defense=dtime
		data.time_offense=otime
		data.time_shuttle=ctime
		data.time_l1=climb.time_l1
		data.time_l2=climb.time_l2
		data.time_l3=climb.time_l3
		data.l1=climb.l1
		data.l2=climb.l2
		data.l3=climb.l3
		data.climb_t=climb.points
		done=true
func disabled():
	#stops the timer for defense/offense/shuttling (depending on which is selected.
	d=true
	print("disabled")
	if mode=="offense":
		oe_time=timer.time_left
		oe_time=(int(oe_time*10)) #rounds to the nearest tenth of a second
		otime+=float(os_time-oe_time)/10#adds to the total time disabled. Decreases to appropriate time.
		print("offense time:",otime)
	if mode=="defense":
		de_time=timer.time_left
		de_time=(int(de_time*10)) #rounds to the nearest tenth of a second
		dtime+=float(ds_time-de_time)/10#adds to the total time disabled. Decreases to appropriate time.
		print("defense time:",dtime)
	if mode=="shuttle":
		ce_time=timer.time_left
		ce_time=(int(ce_time*10)) #rounds to the nearest tenth of a second
		ctime+=float(cs_time-ce_time)/10#adds to the total time disabled. Decreases to appropriate time.
		print("shuttle time:",ctime)
func enabled():
	print("enabled")
	d=false
	if mode=="defense":
		ds_time=timer.time_left
		ds_time=(int(ds_time*10)) #rounds to the nearest tenth of a second
	if mode=="offense":
		os_time=timer.time_left
		os_time=(int(os_time*10)) #rounds to the nearest tenth of a second
	if mode=="shuttle":
		cs_time=timer.time_left
		cs_time=(int(cs_time*10)) #rounds to the nearest tenth of a second
