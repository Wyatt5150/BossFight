extends Area2D
class_name Bullet


@export var parryable : bool = false


@export var damage : int = 1
@export var lifespan : float = 4.0
@export var pierce : int = -1

var impassable : int = 3
var active = false
var times_hit = 0

func Fire():
	pass

func EndOfLife():
	self.collision_layer = 0
	self.collision_mask = 0
	self.queue_free()

"""DONT OVERIDE UNLESS NECESSARY"""
func _ready() -> void:
	self.area_entered.connect(Callable(self, "Hit"))
	self.hide()

func _Deflect(target_layer : int) -> void:
	self.collision_layer = target_layer+impassable
	self.collision_mask = target_layer+impassable
	
	self.direction.x *= -1

func _Fire() -> void:
	active = true
	self.show()
	Fire()
	if lifespan > 0:
		await get_tree().create_timer(lifespan).timeout
		EndOfLife()

func Hit(_area : Area2D):
	
	if _area is Hitbox:
		_area.Damage(damage)
		EndOfLife()
