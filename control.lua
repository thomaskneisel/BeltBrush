require("defines")

-- defines gui checkbox count
-- and beltplace count
BB_CHECKBOX_COUNT = 4

local function getBeltAmount(player)
	if not global.BB_glob_amount then
		for checkbox = 1, BB_CHECKBOX_COUNT, 1 do
			if player.gui.top.BB_flow_main["BB_check_"..checkbox].state == true then
				global.BB_glob_amount = checkbox - 1
				break;
			end
		end
	end
	return global.BB_glob_amount
end

local directionMap = {
	[defines.direction.north] = function(position, beltNumber)
		return { x = position.x + beltNumber, y=position.y }
		end,
	[defines.direction.east] = function(position, beltNumber)
		return { x = position.x, y=position.y + beltNumber}
		end,
	[defines.direction.south] = function(position, beltNumber)
		return { x = position.x - beltNumber, y=position.y }
		end,
	[defines.direction.west] = function(position, beltNumber)
		return { x = position.x, y=position.y - beltNumber }
		end,
}

local function placeBelt(event, player)
	local entity = event.created_entity
	local position = entity.position
	local surface = game.get_surface(1)
	local inventorys = { 
		main = player.get_inventory(defines.inventory.player_main), 
		quickbar = player.get_inventory(defines.inventory.player_quickbar) 
	}

	if getBeltAmount(player) == 0 then
		do return end
	end

	for belt = 1, getBeltAmount(player), 1 do
		local newEnitiy = {name = entity.name, position = directionMap[entity.direction](position, belt), direction = entity.direction, force = entity.force}
		if game.get_surface(1).can_place_entity(newEnitiy) then
			if player.cursor_stack.valid_for_read and player.cursor_stack.count >= 1 then
				surface.create_entity(newEnitiy)
				player.cursor_stack.count = player.cursor_stack.count - 1
			elseif inventorys.main.get_item_count(entity.name) > 0 then				
				if inventorys.main.remove({name = entity.name, count = 1}) then
					surface.create_entity(newEnitiy)
				end				
			elseif inventorys.quickbar.get_item_count(entity.name) > 0 then				
				if inventorys.quickbar.remove({name = entity.name, count = 1}) then
					surface.create_entity(newEnitiy)
				end				
			end
		end		
	end
end

local function on_built_entity (event)
	if event.created_entity.type == "transport-belt" then
		local player = game.players[event.player_index]
		placeBelt(event, player)
	end
end

local function on_tick(event)
	for i,player in pairs(game.players) do
		if not player.gui.top.BB_flow_main then
			player.gui.top.add{type = "flow", name = "BB_flow_main", direction = "horizontal"}
			player.gui.top.BB_flow_main.add{type = "label", name = "BB_label_EX", caption = "BB:"}

			for checkbox = 1, BB_CHECKBOX_COUNT, 1 do
				player.gui.top.BB_flow_main.add{type = "label", name = "BB_label_"..checkbox, caption = checkbox}
				player.gui.top.BB_flow_main.add{type = "checkbox", name = "BB_check_"..checkbox, state = true}
			end
		end
	end
end

local function on_gui_click(event)
	local checkboxPrefix = "BB_check_"
	-- goolge "early return" :) to prevent "pyramid of doom" ... google it, again ;)
	if not string.match(event.element.name, checkboxPrefix) then
		do return end
	end
	
	-- unset all checkboxes and set just one checkbox
	local player = game.players[event.player_index]
	for checkbox = 1, BB_CHECKBOX_COUNT, 1 do
		player.gui.top.BB_flow_main[checkboxPrefix..checkbox].state = false
	end
	player.gui.top.BB_flow_main[event.element.name].state = true

	-- string index base 0, so + 1 for all chars, and -1 to place ADDITIONAL belts, to the one the player sets
	local checkboxNumber = tonumber(string.sub(event.element.name, string.len(checkboxPrefix)+1))
	global.BB_glob_amount = checkboxNumber-1
end

-- register event handlers
script.on_event(defines.events.on_tick, on_tick)
script.on_event(defines.events.on_built_entity, on_built_entity)
script.on_event(defines.events.on_gui_click, on_gui_click)
