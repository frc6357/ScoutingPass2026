extends Node2D
@onready var data: Node2D = $"../DataStorage"
@onready var label: Label = $Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#adds and subtracts from the displayed number based on input.
	#Residual is the distance between the total points the scouters say were scored and the actual ammount.
	if Input.is_action_just_pressed("f+"):
		data.residual_f+=1
		label.text=str(data.residual_f)
	if Input.is_action_just_pressed("f-"):
		data.residual_f-=1
		label.text=str(data.residual_f)
