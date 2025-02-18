extends Area3D

var spin_speed = 45 # Rotation speed
signal collected

func _ready():
	var hud = get_tree().get_first_node_in_group("HUD")
	if hud:
		connect("collected", Callable(hud, "_on_treasure_collected"))

func _process(delta):
	rotation_degrees.y += spin_speed * delta

func _on_body_entered(body: Node3D) -> void:
	queue_free()
	emit_signal("collected")
