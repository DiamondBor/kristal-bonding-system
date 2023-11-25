BondingCharacter          = libRequire("bonding_system", "scripts/bonding_character")

BondingSystemLib = {}
local lib = BondingSystemLib

function lib:preInit()
    
    self.bonding_characters = {}

    for _,path,bonds in Registry.iterScripts("data/bonds") do
        assert(bonds ~= nil, '"bonds/'..path..'.lua" does not return value')
        bonds.id = bonds.id or path
        self.bonding_characters[bonds.id] = bonds
    end
    
end

function lib:init()

    Utils.hook(AbstractMenuComponent, "getMenuItems", function(orig,self)
        local components = {}
        for _, child in ipairs(self.children) do
            if child:includes(AbstractMenuItemComponent) then
                table.insert(components, child)
            elseif child:includes(Text) then
                table.insert(components, child)
            elseif child:includes(Sprite) then
                table.insert(components, child)
            end
        end
        return components
    end)

    --[[
    Utils.hook(NPC, "init", function(orig, self, actor, x, y, properties)
        orig(self)
        self.bondingchara = nil
        if properties["bond"] then
            self.bondingchara = BondingSystemLib:createBondingCharacter(properties["bond"])
        end
    end)

    Utils.hook(NPC, "onInteract", function(orig, self, player, dir)
        --orig(self)
        if self.talk_sprite then
            self:setSprite(self.talk_sprite)
        end
        if self.turn then
            self:facePlayer()
        end
        self.interact_count = self.interact_count + 1
    
        if self.script then
            Registry.getEventScript(self.script)(self, player, dir)
        end
        if self.set_flag then
            Game:setFlag(self.set_flag, (self.set_value == nil and true) or self.set_value)
        end
        if self.bondingchara ~= nil then
            self.bondingchara:startDialogue()
        else
            if self.cutscene then
                self.world:startCutscene(self.cutscene, self, player, dir):after(function()
                    self:onTextEnd()
                end)
                return true
            elseif #self.text > 0 then
                self.world:startCutscene(function(cutscene)
                    cutscene:setSpeaker(self, self.talk)
                    local text = self.text
                    local text_index = Utils.clamp(self.interact_count, 1, #text)
                    if type(text[text_index]) == "table" then
                        text = text[text_index]
                    end
                    for _,line in ipairs(text) do
                        cutscene:text(line)
                    end
                end):after(function()
                    self:onTextEnd()
                end)
                return true
            end
        end
        
    end)--]]
end

function lib:registerBondingCharacter(id)
    self.bonding_characters[id] = class
end

function lib:getBondingCharacter(id)
    return self.bonding_characters[id]
end

function lib:createBondingCharacter(id, ...)
    if self.bonding_characters[id] then
        return self.bonding_characters[id](...)
    else
        error("Attempt to create non existent bond character \"" .. tostring(id) .. "\"")
    end
end

--[[]
function lib:registerDebugOptions(debug)

    debug:registerOption("modify_bond", "Modify Character Bond", "Change your bond with a character.", function()
        debug:enterMenu("modify_bond", 0)
    end)

    debug:registerMenu("modify_bond", "Modify Character Bond", "search")
    for id,_ in pairs(Registry.encounters) do
        debug:registerOption("dark_encounter_select", id, "Start this encounter.", function()
            Game:setFlag("current_battle_system#", "deltarune")
            Game:encounter(id)
            debug:closeMenu()
        end)
    end

    debug:registerMenu("wave_select_light", "Wave Select", "search")

    local waves_list = {}
    for id,_ in pairs(Registry.waves) do
        table.insert(waves_list, id)
    end

    table.sort(waves_list, function(a, b)
        return a < b
    end)

    for _,id in ipairs(waves_list) do
        debug:registerOption("wave_select_light", id, "Start this wave.", function()
            Game.battle:setState("ENEMYDIALOGUE", {id})
            debug:closeMenu()
        end)
    end
end--]]

function lib:spawnheartsprites(menu, bond)
    if bond < 0 then
        menu:addChild(Sprite("bondingsys/ui/heart_red"))
        menu:addChild(Sprite("bondingsys/ui/heart_red"))
        menu:addChild(Sprite("bondingsys/ui/heart_red"))
        menu:addChild(Sprite("bondingsys/ui/heart_red"))
        menu:addChild(Sprite("bondingsys/ui/heart_red"))
    else
        if bond == 0 then
            menu:addChild(Sprite("bondingsys/ui/heart_outline"))
            menu:addChild(Sprite("bondingsys/ui/heart_outline"))
            menu:addChild(Sprite("bondingsys/ui/heart_outline"))
            menu:addChild(Sprite("bondingsys/ui/heart_outline"))
            menu:addChild(Sprite("bondingsys/ui/heart_outline"))
        elseif bond >= 1 and bond <= 10 then
            menu:addChild(Sprite("bondingsys/ui/heart_half"))
            menu:addChild(Sprite("bondingsys/ui/heart_outline"))
            menu:addChild(Sprite("bondingsys/ui/heart_outline"))
            menu:addChild(Sprite("bondingsys/ui/heart_outline"))
            menu:addChild(Sprite("bondingsys/ui/heart_outline"))
        elseif bond >= 11 and bond <= 15 then
            menu:addChild(Sprite("bondingsys/ui/heart_filled"))
            menu:addChild(Sprite("bondingsys/ui/heart_half"))
            menu:addChild(Sprite("bondingsys/ui/heart_outline"))
            menu:addChild(Sprite("bondingsys/ui/heart_outline"))
            menu:addChild(Sprite("bondingsys/ui/heart_outline"))
        elseif bond >= 16 and bond <= 25 then
            menu:addChild(Sprite("bondingsys/ui/heart_filled"))
            menu:addChild(Sprite("bondingsys/ui/heart_filled"))
            menu:addChild(Sprite("bondingsys/ui/heart_outline"))
            menu:addChild(Sprite("bondingsys/ui/heart_outline"))
            menu:addChild(Sprite("bondingsys/ui/heart_outline"))
        elseif bond >= 26 and bond <= 40 then
            menu:addChild(Sprite("bondingsys/ui/heart_filled"))
            menu:addChild(Sprite("bondingsys/ui/heart_filled"))
            menu:addChild(Sprite("bondingsys/ui/heart_half"))
            menu:addChild(Sprite("bondingsys/ui/heart_outline"))
            menu:addChild(Sprite("bondingsys/ui/heart_outline"))
        elseif bond >= 41 and bond <= 50 then
            menu:addChild(Sprite("bondingsys/ui/heart_filled"))
            menu:addChild(Sprite("bondingsys/ui/heart_filled"))
            menu:addChild(Sprite("bondingsys/ui/heart_filled"))
            menu:addChild(Sprite("bondingsys/ui/heart_outline"))
            menu:addChild(Sprite("bondingsys/ui/heart_outline"))
        elseif bond >= 51 and bond <= 60 then
            menu:addChild(Sprite("bondingsys/ui/heart_filled"))
            menu:addChild(Sprite("bondingsys/ui/heart_filled"))
            menu:addChild(Sprite("bondingsys/ui/heart_filled"))
            menu:addChild(Sprite("bondingsys/ui/heart_half"))
            menu:addChild(Sprite("bondingsys/ui/heart_outline"))
        elseif bond >= 61 and bond <= 75 then
            menu:addChild(Sprite("bondingsys/ui/heart_filled"))
            menu:addChild(Sprite("bondingsys/ui/heart_filled"))
            menu:addChild(Sprite("bondingsys/ui/heart_filled"))
            menu:addChild(Sprite("bondingsys/ui/heart_filled"))
            menu:addChild(Sprite("bondingsys/ui/heart_outline"))
        elseif bond >= 76 and bond <= 85 then
            menu:addChild(Sprite("bondingsys/ui/heart_filled"))
            menu:addChild(Sprite("bondingsys/ui/heart_filled"))
            menu:addChild(Sprite("bondingsys/ui/heart_filled"))
            menu:addChild(Sprite("bondingsys/ui/heart_filled"))
            menu:addChild(Sprite("bondingsys/ui/heart_half"))
        elseif bond >= 86 then
            menu:addChild(Sprite("bondingsys/ui/heart_filled"))
            menu:addChild(Sprite("bondingsys/ui/heart_filled"))
            menu:addChild(Sprite("bondingsys/ui/heart_filled"))
            menu:addChild(Sprite("bondingsys/ui/heart_filled"))
            menu:addChild(Sprite("bondingsys/ui/heart_filled"))
        end
    end
end

return lib