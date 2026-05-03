class_name VelocitySystem
extends System

func query() -> QueryBuilder:
    return q.with_all([C_Velocity]).iterate([C_Velocity])


func process(entities: Array[Entity], components: Array, delta: float) -> void:
    for i in range(entities.size()):
        var velocity_component: C_Velocity = components[0][i]
        # Update the entity's position based on its velocity
        var position: Vector3 = entities[i].transform.origin
        position += velocity_component.velocity * delta
        entities[i].transform.origin = position
