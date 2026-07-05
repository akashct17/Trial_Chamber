extends Node2D
#change this
@onready var level_one=preload("res://scenes/level_one.tscn")
@onready var level_two=preload("res://scenes/level_two.tscn")
@onready var level_three=preload("res://scenes/level_three.tscn")

var current_level_scene: Node = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Menu.visible=true
	$gameon.visible=false
	$gameover.visible=false
	$gamewin.visible=false
	

func _process(delta: float) -> void:
	if Global.game_win==true:
		$Menu.visible=false
		$gameon.visible=false
		$gameover.visible=false
		$gamewin.visible=true
		if(Global.current_level==3):
			$"gamewin/Next Level".visible=false
		$"../soundtrack/level1/AudioStreamPlayer".stop()
		$"../soundtrack/level2/AudioStreamPlayer".stop()
		$"../soundtrack/level3/AudioStreamPlayer".stop()
	if Global.game_over==true:
		$Menu.visible=false
		$gameon.visible=false
		$gameover.visible=true
		$gamewin.visible=false
		$"../soundtrack/level1/AudioStreamPlayer".stop()
		$"../soundtrack/level2/AudioStreamPlayer".stop()
		$"../soundtrack/level3/AudioStreamPlayer".stop()
		
	$gameon/coin/Label.text=str(Global.coins)
	$gamewin/coin2/Label.text=str(Global.coins)

	update_hearts()
	
	
func update_hearts():
	if(Global.health>=3):
		Global.health=3
		$gameon/hearts/normal/h1.visible=true
		$gameon/hearts/normal/h2.visible=true
		$gameon/hearts/normal/h3.visible=true
	elif(Global.health==2):
		Global.health=2
		$gameon/hearts/normal/h1.visible=true
		$gameon/hearts/normal/h2.visible=false
		$gameon/hearts/normal/h3.visible=true
	elif(Global.health==1):
		Global.health=1
		$gameon/hearts/normal/h1.visible=true
		$gameon/hearts/normal/h2.visible=false
		$gameon/hearts/normal/h3.visible=false
	elif(Global.health<1):
		$gameon/hearts/normal/h1.visible=false
		$gameon/hearts/normal/h2.visible=false
		$gameon/hearts/normal/h3.visible=false
	if(Global.active_power_up==true):
		$gameon/hearts/powerup.visible=true
	else:
		$gameon/hearts/powerup.visible=false


func _on_buttomute_pressed() -> void:
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)

func _on_buttonlevel_one_pressed() -> void:
		$Menu.visible=false
		$gameon.visible=true
		current_level_scene=level_one.instantiate()
		$"../soundtrack/level1/AudioStreamPlayer".play()
		Global.current_level=1
		add_sibling(current_level_scene)
		
func _on_buttonlevel_two_pressed() -> void:
		$Menu.visible=false
		$gameon.visible=true
		current_level_scene=level_two.instantiate()
		$"../soundtrack/level2/AudioStreamPlayer".play()
		Global.current_level=2
		add_sibling(current_level_scene)
		
func _on_buttonlevel_three_pressed() -> void:
		$Menu.visible=false
		$gameon.visible=true
		current_level_scene=level_three.instantiate()
		$"../soundtrack/level3/AudioStreamPlayer".play()
		Global.current_level=3
		add_sibling(current_level_scene)

func _on_buttonpause_pressed() -> void:
	Global.reset_values()
	get_tree().reload_current_scene()

func _on_buttonmenu_pressed() -> void:
	Global.reset_values()
	get_tree().reload_current_scene()


func _on_button_next_pressed() -> void:
	if(Global.current_level==1):
		if current_level_scene:
			current_level_scene.queue_free()
		Global.reset_values()
		$Menu.visible=false
		$gameon.visible=true
		$gamewin.visible=false
		current_level_scene=level_two.instantiate()
		$"../soundtrack/level2/AudioStreamPlayer".play()
		Global.current_level=2
		add_sibling(current_level_scene)
		Global.game_win = false
	elif(Global.current_level==2):
		print(current_level_scene)
		if current_level_scene:
			current_level_scene.queue_free()
		$Menu.visible=false
		$gameon.visible=true
		$gamewin.visible=false
		current_level_scene=level_three.instantiate()
		$"../soundtrack/level3/AudioStreamPlayer".play()
		Global.current_level=3
		add_sibling(current_level_scene)
		Global.game_win = false
	elif(Global.current_level==3):
		pass
