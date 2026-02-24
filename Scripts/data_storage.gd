extends Node2D


#all data is stored here as static variables. Any data not stored here will be deleted when changing files.

#This data should be consistently used
static var team="" #team number displayed here
static var pos=null #position on field (r1,b2,r3,etc...)
static var history=[] #stores the history of all recorded matches
static var matchNum=1 #which match number is currently active.
static var scoutName=""
static var updated #shows wheither or not the data has been updated
static var loaded=false #true once history is loaded (or not loaded if it doesn't exist) from file

#This data should be changed with seasons.
static var fuel=0
static var fuel_a=0
static var fuel_t=0
static var time_disabled=0
static var time_defense=0
static var time_offense=0
static var time_shuttle=0
static var accuracy_t=-1
static var accuracy_a=-1
static var shots=0
static var fuel_s=0
static var climb_t=0
static var climb_a=0
static var time_l1=0
static var time_l2=0
static var time_l3=0
static var pins=0
static var c_zone="none"
static var l1
static var l2
static var l3
static var fouls
static var trench=false
static var bump=false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	if not loaded:
		load_data()
		loaded=true
func _process(delta: float) -> void:
	pass

func update():
	updated=false
	for i in range(len(history)):
		#searches the list for a match of the number provided
		if matchNum==history[i][0]:
			updated=true
			
			#if the match number allready exists, replaces it with the new data
			history[i]=[
				matchNum,scoutName,team,fuel_a,fuel_t,fuel_s,shots,
				accuracy_a,accuracy_t,
				time_defense, time_offense,time_shuttle,time_disabled,
				l1,time_l1,l2,time_l2,l3,time_l3,c_zone,
				trench,bump,pins]

	if updated==false:
		#if no duplicate was found, adds data to the end of the list.
		history.append([matchNum,scoutName,team,fuel_a,fuel_t,fuel_s,shots,
			accuracy_a,accuracy_t,
			time_defense, time_offense,time_shuttle,time_disabled,
			l1,time_l1,l2,time_l2,l3,time_l3,c_zone,
			trench,bump,pins])
	for i in history:
		print (i)
	save_data()
var hfile
func unwrap(num):
	#sets variables to their appropriate values from a specific match
	hfile=history[num]
	matchNum=hfile[0]
	scoutName=hfile[1]
	team=hfile[2]
	fuel_a=hfile[3]
	fuel_t=hfile[4]
	fuel_s=hfile[5]
	shots=hfile[6]
	accuracy_a=hfile[7]
	accuracy_t=hfile[8]
	time_defense=hfile[9]
	time_offense=hfile[10]
	time_shuttle=hfile[11]
	time_disabled=hfile[12]
	l1=hfile[13]
	time_l1=hfile[14]
	l2=hfile[15]
	time_l2=hfile[16]
	l3=hfile[17]
	time_l3=hfile[18]
	c_zone=hfile[19]
	bump=hfile[20]
	trench=hfile[21]
	pins=hfile[22]
func reset(change=true):
	print("e")
	fuel=fuel_a+fuel_t
	fuel=0
	fuel_a=0
	fuel_t=0
	fuel_s=0
	time_disabled=0
	time_defense=0
	time_offense=0
	time_shuttle=0
	accuracy_t=.9
	accuracy_a=.9
	shots=0
	climb_t=0
	climb_a=0
	time_l1=0
	time_l2=0
	time_l3=0
	
	pins=0
	l1=false
	l2=false
	l3=false
	trench=false
	bump=false
	fouls=0
	c_zone="none"
	
	pos="r1"
	if change:
		get_tree().change_scene_to_file("res://Scenes/match_scouting.tscn")


static var SAVE_PATH="user://scouting_history.dat"
var file
var loaded_history
func save_data():
	file=FileAccess.open(SAVE_PATH,FileAccess.WRITE)
	if file:
		file.store_var(history)
		file.close()
		print("Array saved successfully!")
	else:
		print("Failed to open file for saving: ", FileAccess.get_open_error())

func load_data():
	if FileAccess.file_exists(SAVE_PATH):
		file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		if file:
			loaded_history = file.get_var()
			file.close()
			print("Data loaded successfully: ", loaded_history)
			history=loaded_history
			matchNum=len(history)+1
		else:
			print("Failed to open file for loading: ", FileAccess.get_open_error())
	else:
		print("Save file does not exist.")
	
