extends SpringArm3D

@export var sensitivity : float = 0.003  
@export var vertical_limit : Vector2 = Vector2(-75, 75)  

var rotation_x : float = 0.0  

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * sensitivity * 100
		
		rotation_x -= event.relative.y * sensitivity * 100
		rotation_x = clamp(rotation_x, vertical_limit.x, vertical_limit.y)

		rotation_degrees.x = rotation_x

	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
