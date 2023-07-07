extends Node

var web
var main
var main_r = preload("res://scenes/Main.tscn")
var root

func _ready():
	if(OS.get_distribution_name() == ""): web = true
	root = get_tree().root
	main = root.get_node("Main")
	
func quit():
	get_tree().quit()
