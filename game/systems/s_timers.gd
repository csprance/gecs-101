class_name TimerSystem
extends System


func query() -> QueryBuilder:
    return q.with_all([C_Velocity, C_Timer]).iterate([C_Timer])


func process(entities: Array[Entity], components: Array, delta: float) -> void:
    for i in range(entities.size()):
        # Tick the timer down
        var c_timer: C_Timer = components[0][i]
        c_timer.timer -= delta

        # Check to see if we went over the time limit
        if c_timer.timer <= 0.0:
            # reset the timer
            c_timer.timer = c_timer.time
            # Execute the actions assigned to this timer
            for action in c_timer.actions:
                if action:
                    action.run_action([entities[i]], {'c_timer': c_timer})
