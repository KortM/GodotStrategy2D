extends KinematicBody2D

export var speed = 200
export var fire_rate = 1
var is_fire = true
var velocity = Vector2()
onready var target = position
var Bullet = preload("res://Prefubs/Bullet.tscn")
signal fire(bullet, direction, location, target)
# Called when the node enters the scene tree for the first time.
func _input(event):
	velocity = Vector2()
	if Input.is_action_pressed("click"):
		target = get_global_mouse_position()
	if event.is_action_pressed("fire"):
		emit_signal("fire",Bullet, rotation, $cell.global_position)

func _physics_process(delta):
	velocity = position.direction_to(target) * speed
	if position.distance_to(target) > 50:
		#velocity = velocity.normalized() * speed
		velocity = move_and_slide(velocity)
	look_at(get_global_mouse_position())
	detect_enemy()
	
func detect_enemy():
	for i in get_slide_count():
		#print(get_slide_collision(i))
		var collider = get_slide_collision(i)
		if collider.collider.name == 'enemy_foot':
			#print('Enemy.. Fire')
			emit_signal(
				"fire", Bullet, rotation, 
				$cell.global_position, 
				collider.collider.global_position
				)
				
func _on_unit_foot_fire(bullet, direction, location, target):
	if is_fire:
		var b = Bullet.instance()
		var main = get_tree().current_scene
		get_parent().add_child(b)
		b.rotation = direction
		b.position = location
		#print("Direction: ", direction, "Position",location)
		b.velocity = target
		b.velocity = b.velocity.rotated(direction)
		is_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		is_fire = true
	
	
	#print(b.velocity)
