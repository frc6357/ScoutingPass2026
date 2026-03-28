extends TextEdit
@onready var qr: Node2D = $"../../QR code generator"

var t
var t1
var t2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _gui_input(event): #closes the text edit when enter is pressed
	if event is InputEventKey and event.pressed:
		# Check for Enter (Keypad Enter or Return)
		if event.keycode == KEY_ENTER or event.physical_keycode == KEY_KP_ENTER:
			# Prevent the newline from being added
			accept_event() 
			# Release focus to "close" it
			release_focus()
			print("TextEdit Closed")
			t=self.text.split("-")
			t1=t[0]
			t2=t[-1]
			print("first: "+t1+". last"+t2)
			qr.generate_between(t1,t2)
