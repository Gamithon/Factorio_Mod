-- data.lua for Elemental Enemies Mod
-- First draft

-- Ensure Rampant is loaded
if not mods["Rampant"] then
    error("Rampant mod is not found. Elemental Enemies mod requires Rampant to function.")
end

-- Define a new elemental biter prototype based on vanilla biter
local elemental_biter = table.deepcopy(data.raw["unit"]["small-biter"])

-- Modify the prototype for elemental properties
elemental_biter.name = "elemental-biter-fire"
elemental_biter.max_health = elemental_biter.max_health * 1.5  -- Increase health
elemental_biter.attack_parameters.ammo_type.action.action_delivery.target_effects.damage.amount = elemental_biter.attack_parameters.ammo_type.action.action_delivery.target_effects.damage.amount * 1.5  -- Increase damage
elemental_biter.resistances = {  -- Adjust resistances for elemental properties
    {
        type = "fire",
        decrease = 0,
        percent = 100  -- Immune to fire
    },
    {
        type = "physical",
        decrease = 5,
        percent = 10  -- Slightly more resistant to physical damage
    }
}
elemental_biter.run_animation.layers[1].tint = {r = 1, g = 0.4, b = 0, a = 1}  -- Change color to indicate fire element

-- Add the new elemental enemy to the game
data:extend({elemental_biter})

-- Example function to spawn elemental enemies based on resources (stub, needs to be expanded)
function spawn_elemental_enemies_on_resources(surface, position)
    -- Placeholder logic to check for nearby resources and decide to spawn elemental enemies
    -- In a real implementation, this function would analyze nearby resources and spawn appropriate elemental enemies
    if surface.count_entities_filtered({area = {{position.x - 10, position.y - 10}, {position.x + 10, position.y + 10}}, type = "resource"}) > 0 then
        surface.create_entity({name = "elemental-biter-fire", position = position, force = "enemy"})
    end
end

-- Register an event handler for on_chunk_generated to spawn elemental enemies based on resources
script.on_event(defines.events.on_chunk_generated, function(event)
    local surface = event.surface
    local area = event.area
    local center = {x = (area.left_top.x + area.right_bottom.x) / 2, y = (area.left_top.y + area.right_bottom.y) / 2}
    spawn_elemental_enemies_on_resources(surface, center)
end)
