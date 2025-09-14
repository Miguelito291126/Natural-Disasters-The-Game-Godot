extends Area3D

@onready var tsunami = $tsunami
var speed = 100
var tsunami_strength = 100
var direction = Vector3(0, 0, 1)
var distance_traveled = 0.0
var total_distance = 4097.0  # Adjust this value based on your scene

func _physics_process(delta):
	position += direction * speed * delta

	for body in get_overlapping_bodies():
		if body.is_in_group("movable_objects") and body.is_class("RigidBody3D"):
			var force = direction.normalized() * tsunami_strength * delta
			body.apply_central_impulse(force)
			body.freeze = false
		elif body.is_in_group("player"):
			body.velocity = direction * speed * 100 * delta


func _on_body_entered(body:Node3D) -> void:
	if body.is_in_group("player"):
		body.IsInWater = true
		if body.camera_node:
			body.IsUnderWater = true


func _on_body_exited(body:Node3D) -> void:
	if body.is_in_group("player"):
		body.IsInWater = false
		if body.camera_node:
			body.IsUnderWater = false
