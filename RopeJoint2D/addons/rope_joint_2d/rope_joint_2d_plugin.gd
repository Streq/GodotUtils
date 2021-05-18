tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("RopeJoint2D", "Node2D", preload("rope_joint_2d.gd"), null)


func _exit_tree():
	remove_custom_type("RopeJoint2D")
