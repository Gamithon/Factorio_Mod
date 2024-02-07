-- control.lua for Elemental Enemies Mod

-- Utility function to determine the elemental type based on nearby resources
local function determine_elemental_type(surface, position)
    -- Placeholder logic to determine elemental type
    -- In a real implementation, you would analyze the types and amounts of nearby resources to decide the elemental type
    local resources = surface.find_entities_filtered({area = {{position.x - 10, position.y - 10}, {position.x + 10, position.y + 10}}, type = "resource"})
    if #resources > 0 then
        -- Example: if any resource is found, arbitrarily choose "fire" for this draft
        return "fire"
    end
    return nil  -- No elemental type determined
end

-- Function to spawn an elemental enemy based on the determined type
local function spawn_elemental_enemy(surface, position, elemental_type)
    if elemental_type == "fire" then
        surface.create_entity({name = "elemental-biter-fire", position = position, force = "enemy"})
        -- You can expand this to include other elemental types, each with their specific entity name
    end
end

-- Event handler for when a new chunk is generated
local function on_chunk_generated(event)
    local surface = event.surface
    local area = event.area
    local center = {x = (area.left_top.x + area.right_bottom.x) / 2, y = (area.left_top.y + area.right_bottom.y) / 2}

    -- Determine the elemental type based on nearby resources
    local elemental_type = determine_elemental_type(surface, center)
    if elemental_type then
        -- Spawn the elemental enemy at the center of the chunk
        spawn_elemental_enemy(surface, center, elemental_type)
    end
end

-- Register the event handler for chunk generation
script.on_event(defines.events.on_chunk_generated, on_chunk_generated)

-- Additional event handlers and logic can be added here to further define the behavior and interactions of your elemental enemies
