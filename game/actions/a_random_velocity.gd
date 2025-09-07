class_name RandomVelocityAction
extends Action

func query() -> QueryBuilder:
    return q.with_all([C_Velocity])

func _action(entities: Array) -> void:
    for entity in entities:
        # Randomly change the velocity
        var c_velocity = entity.get_component(C_Velocity) as C_Velocity
        c_velocity.velocity += Vector3(randf_range(-1, 1), randf_range(-1, 1), randf_range(-1, 1))