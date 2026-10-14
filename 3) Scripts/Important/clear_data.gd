extends Node2D
@onready var display: Node2D = $"activated display"
@onready var history: Node2D = $".."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	display.visible=false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("clear_data"):
		history.clearing=true
		display.visible=true
	if Input.is_action_just_pressed("no") and history.clearing:
		history.clearing=false
		display.visible=false
	if Input.is_action_just_pressed("yes") and history.clearing:
		history.clear()
		history.clearing=false
		display.visible=false
