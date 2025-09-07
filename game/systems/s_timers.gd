class_name TimerSystem
extends System


func query() -> QueryBuilder:
	return q.with_all([C_Velocity, C_Timer])
	

func process(entity: Entity, delta: float) -> void:
	# Tick the timer down
	var c_timer = entity.get_component(C_Timer) as C_Timer
	c_timer.timer -= delta
	
	# Check to see if we went over the time limit
	if c_timer.timer <= 0.0:
		# reset the timer
		c_timer.timer = c_timer.time
		# Execute the actions assigned to this timer
		for action in c_timer.actions:
			if action:
				action.run_action([entity], {'c_timer': c_timer})
