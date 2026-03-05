extends Node2D
@onready var timer: Timer = $Timer

# --- REFERENCES ---
@onready var data: Node = $DataStorage

# Labels
@onready var team_label: Label = $TeamNumberLabel
@onready var match_label: Label = $MatchNumberLabel
@onready var autofuel_label: Label = $FuelLabel
@onready var climb_label: Label = $ClimbLabel

# Text input
@onready var team_input: LineEdit = $TeamNumberInput
@onready var match_input: LineEdit = $MatchNumberInput

# Canvas
@onready var canvas: Sprite2D = $Canvas
@onready var color_picker: ColorPickerButton = $ColorPicker
@onready var brush_slider: HSlider = $BrushSlider
@onready var save_button: Button = $SaveButton

# Auto Fuel Buttons
@onready var fuel_minus1: TextureButton = $Buttons/FuelMinus1
@onready var fuel_plus1: TextureButton = $Buttons/FuelPlus1
@onready var fuel_plus5: TextureButton = $Buttons/FuelPlus5
@onready var fuel_plus10: TextureButton = $Buttons/FuelPlus10

# Climb Button
@onready var climb_button: TextureButton = $Buttons/ClimbButton

# Drawing variables
var brush_size := 5
var paint_color := Color.RED
var img: Image
var drawing := false
@export var canvas_img_path := "res://my_image.png"
@export var canvas_size := Vector2i(512, 512)
@export var archive_path := "user://archive/"

func _ready():
	# --- Initialize Canvas ---
	var tex: ImageTexture
	if FileAccess.file_exists(canvas_img_path):
		tex = load(canvas_img_path)
		img = tex.get_image()
		img.resize(canvas_size.x, canvas_size.y)
	else:
		img = Image.new()
		img.create(canvas_size.x, canvas_size.y, false, Image.FORMAT_RGBA8)
		img.fill(Color.WHITE)
	canvas.texture = ImageTexture.create_from_image(img)

	# Connect signals
	team_input.connect("text_entered", Callable(self, "_on_team_entered"))
	match_input.connect("text_entered", Callable(self, "_on_match_entered"))
	color_picker.connect("color_changed", Callable(self, "_on_color_changed"))
	brush_slider.connect("value_changed", Callable(self, "_on_brush_changed"))
	save_button.connect("pressed", Callable(self, "_on_save_pressed"))

	fuel_minus1.connect("pressed", Callable(self, "_on_FuelMinus1_pressed"))
	fuel_plus1.connect("pressed", Callable(self, "_on_FuelPlus1_pressed"))
	fuel_plus5.connect("pressed", Callable(self, "_on_FuelPlus5_pressed"))
	fuel_plus10.connect("pressed", Callable(self, "_on_FuelPlus10_pressed"))

	climb_button.connect("pressed", Callable(self, "_on_Climb_pressed"))

	# Create archive folder if missing
	var dir = DirAccess.open("user://")
	if not dir.dir_exists(archive_path):
		dir.make_dir_recursive(archive_path)
	
	# Initial label update
	_update_labels()

func _process(_delta):
	# Keep team and match number labels updated
	team_label.text = "Team Number: "+ str(data.team)
	match_label.text = "Match Number: "+ str(data.matchNum)
	if Input.is_action_just_pressed("main") and timer.time_left<=98:
		Input.vibrate_handheld(75)
		get_tree().change_scene_to_file("res://Scenes/main.tscn")
	if Input.is_action_just_pressed("teleop") and timer.time_left<=98:
		Input.vibrate_handheld(75)
		get_tree().change_scene_to_file("res://Scenes/match_scouting2.tscn")

# --- Update Labels ---
func _update_labels():
	autofuel_label.text = "Auto Fuel: "+ str(data.fuel_a)
	climb_label.text = "Climb: "+ str(data.climb_a)

# --- Text Input ---
func _on_team_entered(text: String):
	data.team = int(text)

func _on_match_entered(text: String):
	data.matchNum = int(text)

# --- Auto Fuel Buttons ---
func _adjust_autofuel(amount: int):
	data.fuel_a = max(0, data.fuel_a + amount)
	_update_labels()

func _on_FuelMinus1_pressed(): _adjust_autofuel(-1)
func _on_FuelPlus1_pressed(): _adjust_autofuel(1)
func _on_FuelPlus5_pressed(): _adjust_autofuel(5)
func _on_FuelPlus10_pressed(): _adjust_autofuel(10)

# --- Climb Button ---
func _on_Climb_pressed():
	data.climb_t = clamp(data.climb_t + 15, 0, 30)
	_update_labels()

# --- Color & Brush ---
func _on_color_changed(color: Color):
	paint_color = color

func _on_brush_changed(value: float):
	brush_size = int(value)

# --- Canvas Drawing ---
func _input(event):
	if event is InputEventScreenTouch or event is InputEventMouseButton:
		drawing = event.pressed
		if drawing:
			_paint(to_local(event.position))
	elif (event is InputEventScreenDrag or event is InputEventMouseMotion) and drawing:
		_draw_motion(event)

func _draw_motion(event):
	var pos = to_local(event.position)
	var prev = pos - event.relative
	var distance = prev.distance_to(pos)
	var steps = ceil(distance)
	for i in range(steps):
		var interp = prev.linear_interpolate(pos, i / steps)
		_paint(interp)
	canvas.texture.update(img)

func _paint(pos: Vector2):
	# Draw smooth circle at position
	draw_circle(pos.floor(), brush_size, paint_color)

# --- Save Canvas + Dataset ---
func _on_save_pressed():
	# Save PNG
	var timestamp = str(Time.get_unix_time_from_system())
	var img_path = archive_path + "drawing_" + timestamp + ".png"
	var err = img.save_png(img_path)
	img.lock()
	if err == OK:
		print("Saved drawing to:", img_path)
	else:
		print("Error saving drawing:", err)

	# Save dataset JSON
	var dataset = {
		"team_number": data.team_number,
		"match_number": data.match_number,
		"autofuel_t": data.autofuel_t,
		"climb_t": data.climb_t,
		"drawing_file": img_path
	}

	var file_path = archive_path + "match_" + timestamp + ".json"
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	if file:
		file.store_string(dataset.to_json())
		file.close()
		print("Saved dataset to:", file_path)
	else:
		print("Error saving dataset JSON")
