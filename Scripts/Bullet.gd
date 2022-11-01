extends Area2D

var speed = 0.4
var velocity = Vector2.ZERO


func _physics_process(delta):
	position += velocity * delta
