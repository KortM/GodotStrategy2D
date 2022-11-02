extends Area2D

onready var Bullet = preload("res://Prefubs/Bullet.tscn")
var target = position
var shoot_rate = 0.4
var is_fire = true
var velocity = Vector2.ZERO
export var speed = 0.4

func detect_unit(delta):
	for i in get_overlapping_bodies():
		if i.name == 'unit_foot':
			#print('Enemy')
			look_at(i.position)
			if is_fire:
				fire(i.global_position)
			move(target, delta)
				
				

func fire(target):
	var main = get_tree().current_scene
	var bullet = Bullet.instance()
	main.add_child(bullet)
	bullet.position = $Position2D.global_position
	bullet.rotation = $Position2D.rotation
	bullet.velocity = target.rotated(rotation)
	is_fire = false
	yield(get_tree().create_timer(shoot_rate), "timeout")
	is_fire = true

func move(target, delta):
	velocity = target.rotated(rotation)
	position += velocity * speed * delta
	
func _physics_process(delta):
	detect_unit(delta)
