require("defines")

function Place_north(event, PI)

	BB_var_name = event.created_entity.name
	BB_var_X = event.created_entity.position.x
	BB_var_Y = event.created_entity.position.y
	BB_var_dir = event.created_entity.direction
	BB_var_force = event.created_entity.force
	for i=1, 3, 1 do
		if i <= BB_glob_amount[PI] then
			if game.players[PI].cursor_stack.valid_for_read == true then
				if game.get_surface(1).can_place_entity{name = BB_var_name, position = {x = (BB_var_X + i), y = (BB_var_Y)}, direction = BB_var_dir, force = BB_var_force} then
					if game.players[PI].cursor_stack.count >= 1 then
						game.get_surface(1).create_entity{name = BB_var_name, position = {x = (BB_var_X + i), y = (BB_var_Y)}, direction = BB_var_dir, force = BB_var_force}
						game.players[PI].cursor_stack.count = game.players[PI].cursor_stack.count - 1
					end
				end
			end
		else
			break
		end
	end

end

function Place_east(event, PI)

	BB_var_name = event.created_entity.name
	BB_var_X = event.created_entity.position.x
	BB_var_Y = event.created_entity.position.y
	BB_var_dir = event.created_entity.direction
	BB_var_force = event.created_entity.force
	for i=1, 3, 1 do
		if i <= BB_glob_amount[PI] then
			if game.players[PI].cursor_stack.valid_for_read == true then
				if game.get_surface(1).can_place_entity{name = BB_var_name, position = {x = (BB_var_X), y = (BB_var_Y + i)}, direction = BB_var_dir, force = BB_var_force} then
					if game.players[PI].cursor_stack.count >= 1 then
						game.get_surface(1).create_entity{name = BB_var_name, position = {x = (BB_var_X), y = (BB_var_Y + i)}, direction = BB_var_dir, force = BB_var_force}
						game.players[PI].cursor_stack.count = game.players[PI].cursor_stack.count - 1
					end
				end
			end
		else
			break
		end
	end

end

function Place_south(event, PI)

	BB_var_name = event.created_entity.name
	BB_var_X = event.created_entity.position.x
	BB_var_Y = event.created_entity.position.y
	BB_var_dir = event.created_entity.direction
	BB_var_force = event.created_entity.force
	for i=1, 3, 1 do
				if i <= BB_glob_amount[PI] then
			if game.players[PI].cursor_stack.valid_for_read == true then
				if game.get_surface(1).can_place_entity{name = BB_var_name, position = {x = (BB_var_X - i), y = (BB_var_Y)}, direction = BB_var_dir, force = BB_var_force} then
					if game.players[PI].cursor_stack.count >= 1 then
						game.get_surface(1).create_entity{name = BB_var_name, position = {x = (BB_var_X - i), y = (BB_var_Y)}, direction = BB_var_dir, force = BB_var_force}
						game.players[PI].cursor_stack.count = game.players[PI].cursor_stack.count - 1
					end
				end
			end
		else
			break
		end
	end

end

function Place_west(event, PI)

	BB_var_name = event.created_entity.name
	BB_var_X = event.created_entity.position.x
	BB_var_Y = event.created_entity.position.y
	BB_var_dir = event.created_entity.direction
	BB_var_force = event.created_entity.force
	for i=1, 3, 1 do
		if i <= BB_glob_amount[PI] then
			if game.players[PI].cursor_stack.valid_for_read == true then
				if game.get_surface(1).can_place_entity{name = BB_var_name, position = {x = (BB_var_X), y = (BB_var_Y - i)}, direction = BB_var_dir, force = BB_var_force} then
					if game.players[PI].cursor_stack.count >= 1 then
						game.get_surface(1).create_entity{name = BB_var_name, position = {x = (BB_var_X), y = (BB_var_Y - i)}, direction = BB_var_dir, force = BB_var_force}
						game.players[PI].cursor_stack.count = game.players[PI].cursor_stack.count - 1
					end
				end
			end
		else
			break
		end
	end

end

function Changecheckboxes(clicked, PI)

	if clicked == "1" then
		game.players[PI].gui.top.BB_flow_main.BB_check_1.state = true
		BB_glob_amount[PI] = 0
	else
		game.players[PI].gui.top.BB_flow_main.BB_check_1.state = false
	end

	if clicked == "2" then
		game.players[PI].gui.top.BB_flow_main.BB_check_2.state = true
		BB_glob_amount[PI] = 1
	else
		game.players[PI].gui.top.BB_flow_main.BB_check_2.state = false
	end

	if clicked == "3" then
		game.players[PI].gui.top.BB_flow_main.BB_check_3.state = true
		BB_glob_amount[PI] = 2
	else
		game.players[PI].gui.top.BB_flow_main.BB_check_3.state = false
	end

	if clicked == "4" then
		game.players[PI].gui.top.BB_flow_main.BB_check_4.state = true
		BB_glob_amount[PI] = 3
	else
		game.players[PI].gui.top.BB_flow_main.BB_check_4.state = false
	end

end

script.on_event(defines.events.on_built_entity, function(event)

	if event.created_entity.type == "transport-belt" then
		if event.created_entity.direction == defines.direction.north then
			Place_north(event, event.player_index)
		elseif event.created_entity.direction == defines.direction.east then
			Place_east(event, event.player_index)
		elseif event.created_entity.direction == defines.direction.south then
			Place_south(event, event.player_index)
		elseif event.created_entity.direction == defines.direction.west then
			Place_west(event, event.player_index)
		end
	end


end)

script.on_event(defines.events.on_tick, function(event)

	for i in ipairs(game.players) do
		if not game.players[i].gui.top.BB_flow_main then
			game.players[i].gui.top.add{type = "flow", name = "BB_flow_main", direction = "horizontal"}
			game.players[i].gui.top.BB_flow_main.add{type = "label", name = "BB_label_EX", caption = "BB:"}
			game.players[i].gui.top.BB_flow_main.add{type = "label", name = "BB_label_1", caption = "1"}
			game.players[i].gui.top.BB_flow_main.add{type = "checkbox", name = "BB_check_1", state = true}
			BB_glob_amount[i] = 0
			game.players[i].gui.top.BB_flow_main.add{type = "label", name = "BB_label_2", caption = "2"}
			game.players[i].gui.top.BB_flow_main.add{type = "checkbox", name = "BB_check_2", state = false}
			game.players[i].gui.top.BB_flow_main.add{type = "label", name = "BB_label_3", caption = "3"}
			game.players[i].gui.top.BB_flow_main.add{type = "checkbox", name = "BB_check_3", state = false}
			game.players[i].gui.top.BB_flow_main.add{type = "label", name = "BB_label_4", caption = "4"}
			game.players[i].gui.top.BB_flow_main.add{type = "checkbox", name = "BB_check_4", state = false}
		end
	end

end)


script.on_event(defines.events.on_gui_click, function(event)

	if event.element.name == "BB_check_1" then
	BB_var_1 = "1"
	Changecheckboxes(BB_var_1, event.player_index)
	elseif event.element.name == "BB_check_2" then
	BB_var_1 = "2"
	Changecheckboxes(BB_var_1, event.player_index)
	elseif event.element.name == "BB_check_3" then
	BB_var_1 = "3"
	Changecheckboxes(BB_var_1, event.player_index)
	elseif event.element.name == "BB_check_4" then
	BB_var_1 = "4"
	Changecheckboxes(BB_var_1, event.player_index)
	end

end)

--[[remote.add_interface("BB_test", {

	test = function()

		for i in ipairs(game.players) do

			game.players[i].print("amount = " .. tostring(game.players[i].get_inventory(defines.inventory.player_main).get_item_count("basic-transport-belt")))

		end

	end

} )
--]]