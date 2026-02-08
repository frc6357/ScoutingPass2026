extends Node2D


#all data is stored here as static variables. Any data not stored here will be deleted when changing files.
#all of this data should be changed with seasons.
static var team=null
static var pos=null
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
static var residual_f
static var residual_c
static var history=[]
static var matchNum=0
static var scoutName="none"
static var updated=true

static var fuel_g=0 #fuel generated in idle game
static var growth=0 #increase of fuel in idle game per second

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	fuel_g+=delta*growth
func update():
	if not updated:
		history.append([matchNum,scoutName,team,fuel_a,fuel_t,fuel_s,shots,
			accuracy_a,accuracy_t,
			time_defense, time_offense,time_shuttle,time_disabled,
			l1,time_l1,l2,time_l2,l3,time_l3,c_zone,
			trench,bump,pins])
		updated=true
	if updated and matchNum>=1:
		history[matchNum-1]=[
			matchNum,scoutName,team,fuel_a,fuel_t,fuel_s,shots,
			accuracy_a,accuracy_t,
			time_defense, time_offense,time_shuttle,time_disabled,
			l1,time_l1,l2,time_l2,l3,time_l3,c_zone,
			trench,bump,pins]
	for i in history:
		print (i)
var hfile
func unwrap(num):
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
func reset():
	updated=false #shows that the history has not been updated with new data.
	#this function sets all data to it's default setting.
	fuel=fuel_a+fuel_t
	matchNum+=1
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
	
	residual_f=0
	residual_c=0
	pins=0
	l1=false
	l2=false
	l3=false
	trench=false
	bump=false
	fouls=0
	c_zone="none"
	
	pos="r1"
	team=0000
	get_tree().change_scene_to_file("res://Scenes/match_scouting.tscn")
