require("defines")

function Place_north(event, PI)

	BB_var_name = event.created_entity.name
	BB_var_X = event.created_entity.position.x
	BB_var_Y = event.created_entity.position.y
	BB_var_dir = event.created_entity.direction
	BB_var_force = event.created_entity.force
	for i=1, 3, 1 do
		if i <= BB_glob_amount then
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
		if i <= BB_glob_amount then
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
				if i <= BB_glob_amount then
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
		if i <= BB_glob_amount then
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

script.on_event(defines.events.on_built_entity, function(event)
	
	if event.created_entity.type == "transport-belt" then

		-- remember selected checkbox
		local player = game.players[event.player_index]
		for checkbox = 1, 4, 1 do
			if player.gui.top.BB_flow_main["BB_check_"..checkbox].state == true then
				BB_glob_amount = checkbox - 1
				break;
			end
		end
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
	
	for i,player in pairs(game.players) do
		if not player.gui.top.BB_flow_main then
			player.gui.top.add{type = "flow", name = "BB_flow_main", direction = "horizontal"}
			player.gui.top.BB_flow_main.add{type = "label", name = "BB_label_EX", caption = "BB:"}
			player.gui.top.BB_flow_main.add{type = "label", name = "BB_label_1", caption = "1"}
			player.gui.top.BB_flow_main.add{type = "checkbox", name = "BB_check_1", state = true}
			player.gui.top.BB_flow_main.add{type = "label", name = "BB_label_2", caption = "2"}
			player.gui.top.BB_flow_main.add{type = "checkbox", name = "BB_check_2", state = false}
			player.gui.top.BB_flow_main.add{type = "label", name = "BB_label_3", caption = "3"}
			player.gui.top.BB_flow_main.add{type = "checkbox", name = "BB_check_3", state = false}
			player.gui.top.BB_flow_main.add{type = "label", name = "BB_label_4", caption = "4"}
			player.gui.top.BB_flow_main.add{type = "checkbox", name = "BB_check_4", state = false}
		end
	end
end)


script.on_event(defines.events.on_gui_click, function(event)

	-- goolge "early return" :) to prevent "pyramid of doom" ... google it, again ;)
	if not string.match(event.element.name, "BB_check_") then
		do return end
	end

	local player = game.players[event.player_index]
	for checkbox = 1, 4, 1 do
		player.gui.top.BB_flow_main["BB_check_"..checkbox].state = false
	end
	player.gui.top.BB_flow_main[event.element.name].state = true
end)
