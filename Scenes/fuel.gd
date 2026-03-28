extends Sprite2D
@onready var data: Node2D = $"../../DataStorage"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.scale.x=.1+data.fuel_t*.001
	self.scale.y=.1+data.fuel_t*.001
	if self.scale.x>.6:
		self.scale.x=.6
		self.scale.y=.6

var extra=0
var sub=0
var maxSub=.005
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if extra>0:
		sub+=.00005
		if sub>maxSub:
			sub=maxSub
		extra-=sub
		self.scale.x-=sub
		self.scale.y-=sub
	else:
		sub=0
		self.scale.x=.1+data.fuel_t*.001
		self.scale.y=.1+data.fuel_t*.001
		if self.scale.x>.6:
			self.scale.x=.6
			self.scale.y=.6
func fuel1():
	if data.fuel_t>500:
		extra+=.001
		self.scale.x+=.005
		self.scale.y+=.005
		extra+=.004
func fuel5():
	if data.fuel_t>500:
		extra+=.005
	self.scale.x+=.015
	self.scale.y+=.015
	extra+=.01
func fuel10():
	if data.fuel_t>500:
		extra+=.01
	self.scale.x+=.03
	self.scale.y+=.03
	extra+=.02
	
