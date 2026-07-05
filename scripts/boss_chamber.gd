extends Node2D

func _process(delta):
	if Global.is_in_boss_battle == true:
		$walls.visible = true
		$walls.collision_enabled = true
		if Global.is_in_boss_battle_camera == true:
			$lock.visible=true
			$lock.collision_enabled=true
	else:
		$walls.visible = false
		$walls.collision_enabled = false
		$lock.visible=false
		$lock.collision_enabled=false
			
