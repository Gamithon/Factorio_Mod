--control.lua

-- Function to initialize or reset global tables
local function initialize_global_data()
    global.has_joined_before = global.has_joined_before or {}
end

-- Call the initialization function on mod startup
script.on_init(initialize_global_data)

-- Call the initialization function when the mod configuration changes (e.g., mod added to existing save)
script.on_configuration_changed(initialize_global_data)

-- Function for when a player joins the game
script.on_event(defines.events.on_player_joined_game, function(event)
    local player_index = event.player_index
    local player = game.get_player(player_index)

    if player then
        -- Initialize the global table if not already initialized (safeguard)
        if not global.has_joined_before then
            initialize_global_data()
        end

        -- Check if the player has joined before
        if global.has_joined_before[player_index] then
            -- The player has joined before; display the welcome back message
            player.print("Welcome back, " .. player.name)
        else
            -- First time the player has joined, greet them
            player.print("Warmest considerings, " .. player.name)
            global.has_joined_before[player_index] = true
        end
    end
end)
