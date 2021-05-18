tool
extends Node2D

export (NodePath) var body_a setget set_body_a
export (Vector2) var body_a_position = Vector2.ZERO
export (NodePath) var body_b setget set_body_b
export (Vector2) var body_b_position = Vector2.ZERO
export (float) var length
export (float) var k

var b0:PhysicsBody2D = null
var b1:PhysicsBody2D = null

var rb0:RigidBody2D = null
var rb1:RigidBody2D = null

func _ready():
	set_body_a(body_a)
	set_body_b(body_b)

func _get_configuration_warning():
	if not body_a or not body_b:
		return 'you need to set 2 bodies dud'
	return ''


func _physics_process(delta):
	var distance = b0.position - b1.position - rb1.linear_velocity*delta
	var distance_length = distance.length()
	var over_extension_length = distance_length - length
	if over_extension_length > 0:
		#apply rope tension
		if(rb1.linear_velocity.dot(distance)<0):
			var normal = -rb1.linear_velocity.project(distance)
			rb1.apply_central_impulse(normal*rb1.mass)
		
		#apply spring force to correct errors
		rb1.apply_central_impulse(distance.normalized()*k*over_extension_length*delta)
		
#		print(over_extension_length)

func set_body_a(path:NodePath):
	body_a = path
	b0 = get_node(path) as PhysicsBody2D
	rb0 = b0 as RigidBody2D

func set_body_b(path:NodePath):
	body_b = path
	b1 = get_node(path) as PhysicsBody2D
	rb1 = b1 as RigidBody2D

func get_point_velocity(body:RigidBody2D, point:Vector2):
	return body.linear_velocity + Vector2(-point.y,point.x)*body.angular_velocity

