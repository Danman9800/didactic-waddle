extends Node2D

@export var score := 0
@export var time_left := 0.0
@export var score_incerment := 10
@export var rifle_height := 698
@export var rifle_offset := 90

signal score_changed

func _ready():
	# this is important otherwise it will cause some issues
	$Crosshair.animation = "Idle" 
	# this keeps mouse hidden during gameplay
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	# setting rifle position.y
	$Rifle.position.y = rifle_height


func _process(_delta):
	# storing mouse pos respective to player in 'mouse_pos'
	var mouse_pos := get_local_mouse_position() 
	 # setting cross-hair's position to that of mouse (don't try to linear interpolate the values it won't work)
	$Crosshair.position = mouse_pos
	# setting Rifle's position.x to that of mouse (don't try to linear interpolate the values it won't work)
	$Rifle.position.x = mouse_pos.x+rifle_offset
	# getting the list of areas in the cross-hair's area
	var targets_in = $Crosshair/HitZone.get_overlapping_areas()
	
	if Input.is_action_just_pressed("Shoot"):
		# to indicate a shot 
		$Crosshair.animation = "Shoot" 
		 # for checking if there is an target in the cross-hair's area
		for target in targets_in:
			if target.is_in_group("targets"):
				score += score_incerment
				emit_signal("score_changed", score)
				print("Got'em", score) # temp remove in production - Aditya V.
	# resetting cross-hair's animation
	elif Input.is_action_just_released("Shoot"):
		$Crosshair.animation = "Idle"
	
	
