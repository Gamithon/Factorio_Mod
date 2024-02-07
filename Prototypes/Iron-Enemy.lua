-- prototypes/enemy.lua for Elemental Enemies Mod

-- Copy the prototype for a small biter from the base game
local iron_elemental_biter = table.deepcopy(data.raw["unit"]["small-biter"])

-- Modify the prototype to create an iron-elemental version
iron_elemental_biter.name = "iron-elemental-biter"
iron_elemental_biter.max_health = iron_elemental_biter.max_health * 1.2  -- Increase health
iron_elemental_biter.resistances = {  -- Add resistance to physical damage
    {
        type = "physical",
        decrease = 3,
        percent = 20
    }
}
iron_elemental_biter.movement_speed = iron_elemental_biter.movement_speed * 0.9  -- Reduce speed

-- Adjust the tint to give it a metallic look to represent its iron elemental nature
iron_elemental_biter.run_animation.layers[1].tint = {r = 0.7, g = 0.7, b = 0.7, a = 1}

-- Add the new iron elemental enemy to the game
data:extend({iron_elemental_biter})
