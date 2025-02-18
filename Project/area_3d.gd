extends Area3D

# Set the rotation speed (degrees per second)
var spin_speed = 45 # 45 degrees per second

# Signal to indicate that the object has been collected
signal collected
@export var collected_count: int = 0

# Called every frame
func _process(delta):
	# Rotate the object around the Y axis (up direction)
	rotation_degrees.y += spin_speed * delta

# Called when something enters the Area3D
func _on_body_entered(body: Node3D) -> void:
	queue_free()  # Remove the object from the scene
	emit_signal("collected")  # Emit the collected signal
	collected_count += 1 # Increment the collected counter
