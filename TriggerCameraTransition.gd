extends Area2D

@export var camera_to_prioritize : PhantomCamera2D
@export var priority_enter_override : int = 2
@export var priority_exit_override : int = 0

func _ready() -> void:
	if not is_instance_valid(camera_to_prioritize):
		printerr("No camera assigned to ", name, ". Freeing")
		self.queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area is PlayerHitbox:
		camera_to_prioritize.set_priority(priority_enter_override)


func _on_area_exited(area: Area2D) -> void:
	if area is PlayerHitbox:
		camera_to_prioritize.set_priority(priority_exit_override)
