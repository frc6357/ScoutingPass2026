extends Node2D

'''
This is the Data Storage Script. 
This is where any data that is supposed to remain constant across all files
should be stored.
This is also where that data is saved to or loaded from your device.
Some variables here will be changed each season, however,
YOU SHOULD NOT DELETE THIS FILE UNDER ANY CIRCUMSTANCES
'''



#All data should be stored as static variables.
#Any data not stored as a static variable will be deleted when changing files.

#These variables should be consistently used for each season
static var team="" #team number displayed here
static var pos=null #position on field (r1,b2,r3,etc...)

static var history=[] #stores the history of all recorded matches
static var pit_history=[] #stores the history of all pit scouting.

static var matchNum=1 #the current match number
static var scoutName="" #the name of whoever's scouting
static var updated #shows wheither or not the data has been updated
static var loaded=false #true once history is loaded (or not loaded if it doesn't exist) from file

static var prefix ="curl http://localhost:5000/add-data?data=" #must be put before all match data you want to add to http server.
static var prefix2="curl http://localhost:5000/add-pit-data?data=" #must be put before all pit scouting data you want to add to http server.
static var customPrefix="" #can be customized by the user to connect to a different server.
static var export="command" #sets the default export method to command prompt.

#These variables change each season. Feel free to delete them:

#match scouting
static var intake
static var climb=false
static var fuel=0
static var fuel_a=0
static var fuel_t=0
static var time_disabled=0
static var time_defense=0
static var defense
static var defends=false
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
static var beached=false
static var c_zone="none"
static var l1
static var l2
static var l3
static var fouls
static var trench=false
static var bump=false
static var height=0
static var drive ="none"
#pit scouting
static var storage_capacity="0"
static var turret=false
static var multi_launcher=false
static var favorite


func _ready() -> void:
	#loads the data from the user's files
	if not loaded:
		load_data()
		loaded=true

func update():
	updated=false
	for i in range(len(history)):
		#searches the list for a match of the number provided
		if matchNum==history[i][1]:
			updated=true
			
			#if the match number allready exists, replaces it with the new data
			#This list should be changed based on which variables you are using this season
			#Make sure that scoutName is the first variable, matchNum is the second, and team is the third regardless of season.
			history[i]=[
				scoutName,matchNum,team,fuel_a,fuel_t,fuel_s,shots,
				accuracy_a,accuracy_t,
				time_defense, time_offense,time_shuttle,time_disabled,
				l1,time_l1,l2,time_l2,l3,time_l3,c_zone,
				trench,bump,pins,defends]

	if updated==false:
		#if no duplicate was found, adds data to the end of the list.
		history.append([scoutName,matchNum,team,fuel_a,fuel_t,fuel_s,shots,
			accuracy_a,accuracy_t,
			time_defense, time_offense,time_shuttle,time_disabled,
			l1,time_l1,l2,time_l2,l3,time_l3,c_zone,
			trench,bump,pins,defends])
	for i in history:
		print (i)
	save_data()
func update_pit():
	updated=false
	for i in range(len(pit_history)):
		#searches the list for a match of the number provided
		if str(team)==pit_history[i][0]:
			updated=true
			
			#if the match number allready exists, replaces it with the new data
			pit_history[i]=[
				team,storage_capacity,turret,multi_launcher,height,drive,climb,intake,favorite]

	if updated==false:
		#if no duplicate was found, adds data to the end of the list.
		pit_history.append([
				team,storage_capacity,turret,multi_launcher,height,drive,climb,intake,favorite])
	for i in pit_history:
		print (i)
	save_data()
var hfile
func unwrap_pit(num):
	hfile=pit_history[num]
	team=hfile[0]
	storage_capacity=hfile[1]
	turret=hfile[2]
	multi_launcher=hfile[3]
	height=hfile[4]
	drive=hfile[5]
	climb=hfile[6]
	intake=hfile[7]
	favorite=hfile[8]
func unwrap(num):
	#sets variables to their appropriate values from a specific match
	hfile=history[num]
	scoutName=hfile[0]
	matchNum=hfile[1]
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
	#defends=hfile[23]
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
	defends=false
	pins=0
	l1=false
	l2=false
	l3=false
	trench=false
	bump=false
	climb=false
	intake=false
	fouls=0
	c_zone="none"
	
	pos="r1"
	if change:
		get_tree().change_scene_to_file("res://2) Scenes/Season_Specific/match_scouting.tscn")


static var SAVE_PATH="user://scouting_history.dat"
var file
var loaded_history
func save_data():
	file=FileAccess.open(SAVE_PATH,FileAccess.WRITE)
	if file:
		file.store_var([history,pit_history])
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
			history=loaded_history[0]
			pit_history=loaded_history[1]
			matchNum=len(history)+1
		else:
			print("Failed to open file for loading: ", FileAccess.get_open_error())
	else:
		print("Save file does not exist.")
	
