extends Node


@export_range(0, 1) var drop_percent: float = .5
@export var health_component: Node
@export var orb_scene: PackedScene


func _ready():
	(health_component as HealthComponent).died.connect(on_died)
	
	
func on_died():
	if randf() > drop_percent:
		return
	
	if orb_scene == null:
		return
	if not owner is Node2D:
		return
	var spawn_position = (owner as Node2D).global_position
	var orb_instance = orb_scene.instantiate() as Node2D
	
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	
	entities_layer.add_child(orb_instance)
	orb_instance.position = spawn_position
