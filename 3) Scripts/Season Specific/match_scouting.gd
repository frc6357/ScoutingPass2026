extends Node2D

# --- REFERENCES ---
@onready var beached: TouchScreenButton = $beached
@onready var animate2: AnimatedSprite2D = $beached/AnimatedSprite2D

@onready var timer: Timer = $Timer
@onready var data: Node = $DataStorage
@onready var l1: TouchScreenButton = $L1
@onready var animate: AnimatedSprite2D = $L1/AnimatedSprite2D
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
@onready var color_picker: ColorPickerButton = $Canvas/ColorPicker
@onready var brush_slider: HSlider = $Canvas/BrushSlider
@onready var save_button: Button = $SaveButton

# Auto Fuel Buttons
@onready var fuel_minus1: TouchScreenButton = $"Fuel/-1"
@onready var fuel_plus1: TouchScreenButton = $"Fuel/+1"
@onready var fuel_plus5: TouchScreenButton = $"Fuel/+5"
@onready var fuel_plus10:TouchScreenButton = $"Fuel/+10"

# Climb Button
@onready var climb_button: TextureButton = $Buttons/ClimbButton

# Drawing variables
var brush_size := 5
var paint_color := Color.BLUE
var img: Image
@warning_ignore("shadowed_variable_base_class")
var draw_texture: ImageTexture
var drawing := false
var wait=0
var fuely
#changed the file name
@export var canvas_img_path := "res://Assets/Screenshot 2026-03-04 170207.png"
@export var canvas_size := Vector2i(550, 266)
@export var archive_path := "user://archive/"

func _ready():
	animate.play("no")
	animate2.play("no")
	team_input.text = str(data.team)
	match_input.text = str(data.matchNum)
	print("scouting")

	# --- Initialize Canvas ---
	if FileAccess.file_exists(canvas_img_path):
		var tex: Texture2D = load(canvas_img_path)
		img = tex.get_image()
		img.resize(canvas_size.x, canvas_size.y)
	else:
		img = Image.create(canvas_size.x, canvas_size.y, false, Image.FORMAT_RGBA8)
		img.fill(Color.WHITE)

	draw_texture = ImageTexture.create_from_image(img)
	canvas.texture = draw_texture

	# Connect signals
	team_input.text_submitted.connect(_on_team_entered)
	match_input.text_submitted.connect(_on_match_entered)
	color_picker.color_changed.connect(_on_color_changed)
	brush_slider.value_changed.connect(_on_brush_changed)
	climb_button.pressed.connect(_on_Climb_pressed)

	# Create archive folder
	if not DirAccess.dir_exists_absolute(archive_path):
		DirAccess.make_dir_recursive_absolute(archive_path)

		_update_labels()



func _process(_delta):

	if Input.is_action_just_pressed("l1"):
		data.climb_a=not data.climb_a
		if data.climb_a:
			animate.play("top")
		else:
			animate.play("no")
	if Input.is_action_just_pressed("l2"):
		data.beached=not data.beached
		if data.beached:
			animate2.play("yes")
		else:
			animate2.play("no")

	if Input.is_action_just_pressed("main") and timer.time_left <= 98:
		Input.vibrate_handheld(75)
		save()
		get_tree().change_scene_to_file("res://2) Scenes/Important/main.tscn")

	if Input.is_action_just_pressed("teleop") and timer.time_left <= 98:
		Input.vibrate_handheld(75)
		save()
		get_tree().change_scene_to_file("res://2) Scenes/Season_Specific/match_scouting2.tscn")
	if Input.is_action_just_pressed("fuel1"):
		data.fuel_a+=1
		print(data.fuel_a)
		Input.vibrate_handheld(40)
		_update_labels()
	elif Input.is_action_just_pressed("fuel-1"):
		data.fuel_a-=1
		print(data.fuel_a)
		_update_labels()
	elif Input.is_action_just_pressed("fuel5"):
		data.fuel_a+=5
		print(data.fuel_a)
		Input.vibrate_handheld(70)
		_update_labels()
	elif Input.is_action_just_pressed("fuel10"):
		data.fuel_a+=10
		print(data.fuel_a)
		Input.vibrate_handheld(100)
		_update_labels()
func _update_labels():
	autofuel_label.text = "Auto Fuel: " + str(data.fuel_a)
	climb_label.text = "Climb: " + str(data.climb_t)


# --- Text Input ---
func _on_team_entered(text: String):
	data.team = int(text)


func _on_match_entered(text: String):
	data.matchNum = int(text)


# --- Auto Fuel Buttons ---
func _adjust_autofuel(amount: int):
	data.fuel_a = max(0, data.fuel_a + amount)
	_update_labels()



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
	if event is InputEventScreenTouch and not(fuel_minus1.is_pressed() or fuel_plus1.is_pressed()  or fuel_plus5.is_pressed() or fuel_plus10.is_pressed() or l1.is_pressed() or beached.is_pressed()):
		drawing = event.pressed
	if drawing:
		var paintPos: Vector2 = Vector2(event.position.x-(canvas_size[0]/2)*1.3,event.position.y-canvas.position.y-(canvas_size[1]/2)*1.3)		
		_paint(self.to_local(paintPos))
		draw_texture.update(img)

	elif (event is InputEventScreenDrag or event is InputEventMouseMotion) and drawing:
		_draw_motion(event)


func _draw_motion(event):

	var pos = to_local(event.position)
	var prev = pos - event.relative

	var distance = prev.distance_to(pos)
	var steps = ceil(distance)

	for i in range(steps):
		var interp = prev.lerp(pos, float(i) / float(steps))
		_paint(interp)

		draw_texture.update(img)


func _paint(pos: Vector2):

	var radius = brush_size

	for x in range(-radius, radius):
		for y in range(-radius, radius):

			if x * x + y * y <= radius * radius:

				var px = int(pos.x + x)
				var py = int(pos.y + y)

				if px >= 0 and py >= 0 and px < canvas_size.x and py < canvas_size.y:
					img.set_pixel(px, py, paint_color)


# --- Save Canvas + Dataset ---
func save():

	var timestamp = str(Time.get_unix_time_from_system())

	var img_path = archive_path + "drawing_" + timestamp + ".png"
	var err = img.save_png(img_path)

	if err == OK:
		print("Saved drawing to:", img_path)
	else:
		print("Error saving drawing:", err)

	var dataset = {
	"team_number": data.team,
	"match_number": data.matchNum,
	"autofuel_t": data.fuel_a,
	"climb_t": data.climb_t,
	"drawing_file": img_path
	}

	var file_path = archive_path + "match_" + timestamp + ".json"
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(dataset))
		file.close()
		print("Saved dataset to:", file_path)
	else:
		print("Error saving dataset JSON")
