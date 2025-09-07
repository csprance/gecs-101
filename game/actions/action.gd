## Actions are two parts and are similar to systems
## The first part is the query. This query runs on the entities passed into it and then passes the entities that match the query to the _action function
## This way you can create reusable actions that can be used in multiple places and only operate on specific entities.
## actions don't need to operate on any entities and if you pass in an empty array it will just run the execute function with no entities
@abstract
class_name Action
extends Resource

var q: QueryBuilder

## Meta Data for the Action. This can be changed in the editor
@export var meta = {
	'name': 'Default Action',
	'description': 'This is the default _action that is executed when no other _action is assigned',
}


## The query that the provided entities must match against to process
## Any entity that matches it will be processed any that don't will be ignored
## Leaivng this empty will return all entities passed in (or none if none are passed in)
func query() -> QueryBuilder:
	return q


## Override this with your own logic. This is what the _action does or when it's run what does it execute
## entities are the entities that passed the query or all entities if no query is provided
@abstract func _action(entities: Array) -> void


## Call this if you're running the _action from somewhere
func run_action(query_entities: Array = [], action_meta = null) -> void:
	q = ECS.world.query
	if action_meta:
		self.meta.merge(action_meta, true)
	

	var matching_entities = query().matches(query_entities)
	if matching_entities.is_empty():
		return
	
	# Run the _action on the entities that match the query on the next frame
	print('Running Action', {'meta': self.meta, 'entities': matching_entities})
	call_deferred('_action', matching_entities)
