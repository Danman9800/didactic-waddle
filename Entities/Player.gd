extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Crosshair.animation = "Idle"
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _process(_delta):
	var mouse_pos := get_local_mouse_position()
	$Crosshair.position = mouse_pos
	$Rifle.position.x = lerp($Rifle.position.x, mouse_pos.x+5, 0.6)
	
	var targets_in = $Crosshair/HitZone.get_overlapping_areas()
	
	
	if Input.is_action_just_pressed("Shoot"):
		$Crosshair.animation = "Shoot"
		for target in targets_in:
			if target.is_in_group("targets"):
				print("Got'em")
				
	elif Input.is_action_just_released("Shoot"):
		$Crosshair.animation = "Idle"
	
	
