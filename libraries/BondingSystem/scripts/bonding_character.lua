---@class BondingCharacter : Object
---@overload fun(...) : BondingCharacter
local BondingCharacter = Class()

function BondingCharacter:init()
    -- Display name
    self.name = "Character"

    -- The character's personality
    self.personality = "Tough"

    -- The character's color (for About option) (Use default Text command colors or a hex code)
    self.charcolor = "pink" --  ("red", "blue", "yellow", "green", "white", "black", "purple", "maroon", "pink", "lime")

    -- The color for the "relationship" the player has with this character (for About option) (Use default Text command colors or a hex code)
    self.relationship_colors = {
        ["Best Friend"]    = "lime",
        ["Friend"]         = "green",
        ["Acquaintance"]   = "yellow",
        ["Stranger"]       = "AAAAAA",
        ["Disliked"]       = "red",
        ["Hated"]          = "maroon"
    }

    -- The color for the "personality" of this character (for About option) (Use default Text command colors or a hex code)
    self.personality_colors = {
        ["Tough"]        = "A00000",
        ["Lonely"]       = "yellow",
        ["Annoying"]     = "FF5D00",
        ["Shy"]          = "F47FFF",
        ["Friendly"]     = "lime",
        ["Naughty"]      = "A000A0",
        ["Relaxed"]      = "A1C6C6"
    }

    -- The character's information
    self.info = "* Test character with nothing interesting about them. Yep."

    -- Bond
    self.bond = 10

    -- If true, the character can join your party
    self.party = false

    -- The relationship needed to join your party
    self.party_relationship = 30
    -- The relationship needed to talk to this character
    self.talk_relationship = -10
    -- The relationship needed to gift stuff to this character
    self.gift_relationship = -5

    -- The actor used in the NPC object. Needed for the partying up option
    self.actor = nil
    -- The party member this character will be linked to
    self.party_member = nil

    -- Gifts that this character likes/doesn't mind/dislikes
    self.gifts = {
        Favorite = {"light/bouquet", "light/box_of_heart_candy"},
        Neutral = {"light/hot_chocolate"},
        Dislike = {"light/cards"}
    }
end

function BondingCharacter:getBond()
    return self.bond
end

function BondingCharacter:getPersonality()
    return self.personality
end

function BondingCharacter:getRelationship()
    if self.bond <= -10 then
        self.relationship = "Hated"
    elseif self.bond >= -9 and self.bond <= -1 then
        self.relationship = "Disliked"
    elseif self.bond >= 0 and self.bond <= 1 then
        self.relationship = "Stranger"
    elseif self.bond >= 2 and self.bond <= 15 then
        self.relationship = "Acquaintance"
    elseif self.bond >= 16 and self.bond <= 25 then
        self.relationship = "Friend"
    elseif self.bond >= 26 then
        self.relationship = "Best Friend"
    end
    return self.relationship
end

---- //// Dialogue functions | Sorry it's trash but like idk how else to code this lol

function BondingCharacter:getActionText_greet() -- when you interact with this character
    if self:getRelationship() == "Hated" then
        return "* You again...?", nil, nil
    elseif self:getRelationship() == "Disliked" then
        return "* You again...?", nil, nil
    elseif self:getRelationship() == "Stranger" then
        return "* Hey.", nil, nil
    elseif self:getRelationship() == "Acquaintance" then
        return "* Hey,[wait:5] "..Game.party[1].name..".", nil, nil
    elseif self:getRelationship() == "Friend"  then
        return "* Hi, "..Game.party[1].name.."!", nil, nil
    elseif self:getRelationship() == "Best Friend" then
        return "* Hi, "..Game.party[1].name.."!", nil, nil
    end
    return "* Placeholder", nil, nil
end

function BondingCharacter:getActionText_talk() -- when you talk to this character
    if self:getRelationship() == "Hated" then
        return Utils.pick({"* Placeholder", "* Placeholder"}), nil, nil
    elseif self:getRelationship() == "Disliked" then
        return Utils.pick({"* Placeholder", "* Placeholder"}), nil, nil
    elseif self:getRelationship() == "Stranger" then
        return Utils.pick({"* Placeholder", "* Placeholder"}), nil, nil
    elseif self:getRelationship() == "Acquaintance" then
        return Utils.pick({"* Placeholder", "* Placeholder"}), nil, nil
    elseif self:getRelationship() == "Friend" then
        return Utils.pick({"* Placeholder", "* Placeholder"}), nil, nil
    elseif self:getRelationship() == "Best Friend" then
        return Utils.pick({"* Placeholder", "* Placeholder"}), nil, nil
    end
    return "* Placeholder", nil, nil
end

function BondingCharacter:getActionText_party() -- when you party up with this character
    if self:getRelationship() == "Hated" then
        return "* Placeholder", nil, nil
    elseif self:getRelationship() == "Disliked" then
        return "* Placeholder", nil, nil
    elseif self:getRelationship() == "Stranger" then
        return "* Placeholder", nil, nil
    elseif self:getRelationship() == "Acquaintance" then
        return "* Placeholder", nil, nil
    elseif self:getRelationship() == "Friend" then
        return "* Placeholder", nil, nil
    elseif self:getRelationship() == "Best Friend" then
        return "* Placeholder", nil, nil
    end
    return "* Placeholder", nil, nil
end

function BondingCharacter:getActionText_getgift(giftitem) -- when you give this character a gift
    local likemessage       = "* Placeholder", nil, nil -- If the character loves this gift
    local neutralmessage    = "* Placeholder", nil, nil -- If the character doesn't have an opinion this gift
    local dislikemessage    = "* Placeholder", nil, nil -- If the character doesn't like this gift

    for _, v in pairs(self.gifts.Favorite) do
        if v == giftitem.id then
            return likemessage
        end
    end
    for _, v in pairs(self.gifts.Neutral) do
        if v == giftitem.id then
            return neutralmessage
        end
    end
    for _, v in pairs(self.gifts.Dislike) do
        if v == giftitem.id then
            return dislikemessage
        end
    end
    return neutralmessage
end

function BondingCharacter:getActionText_about()
    local r_colortouse = "white"
    local p_colortouse = "white"
    for k, v in pairs(self.relationship_colors) do
        if k == self:getRelationship() then
            r_colortouse = self.relationship_colors[k]
        end
    end
    for k, v in pairs(self.personality_colors) do
        if k == self:getPersonality() then
            p_colortouse = self.personality_colors[k]
        end
    end
    return "[noskip][speed:1.3][spacing:-1.2][color:".. self.charcolor .."]".. self.name .." [color:reset]- Relationship: [color:".. r_colortouse .."]".. self:getRelationship() .."\n[color:reset]Bond: [color:".. r_colortouse .."]"..self:getBond().." [color:reset]- Personality: [color:".. p_colortouse .."]".. self.personality
end

----------------------------------------------
------                                  ------
----------------------------------------------

function BondingCharacter:startDialogue()
    --[[
    Game.world:startCutscene(function(cutscene)
        --[
        local outerchoicer = Component(FixedSizing(640, 480))
                outerchoicer.x = 203
                outerchoicer.y = -1
                outerchoicer:setLayout(VerticalLayout({ gap = 0, align = "center" }))
                outerchoicer:setOverflow("hidden")
                local innerchoicer = Component(FillSizing(), FitSizing())
                    innerchoicer:setLayout(HorizontalLayout({ gap = 0, align = "center" }))
                    local boxcompchoicer  = BoxComponent(FitSizing())
                        local mainmenuchoicer = BasicMenuComponent(FixedSizing(126, 100))
                                --self.cellmainmenu:addChild(SoulMenuItemComponent(Text("MAP"), function() end))

                                mainmenuchoicer:setPadding(-6, -12, 20, 0)
                                mainmenuchoicer:setLayout(VerticalLayout({ gap = 6, align = "start" }))
                                --mainmenuchoicer:addChild(Text(self.name))

                                mainmenuchoicer:addChild(TextMenuItemComponent(Text("Talk"), function() end))

                        boxcompchoicer:addChild(mainmenuchoicer)
                    innerchoicer:addChild(boxcompchoicer)
                outerchoicer:addChild(innerchoicer)
            Game.stage:addChild(outerchoicer)
            mainmenuchoicer:setFocused()
        --]

        local outer = Component(FixedSizing(640, 480))
                outer.x = -164
                outer.y = 24
                outer:setLayout(VerticalLayout({ gap = 0, align = "center" }))
                outer:setOverflow("hidden")
                local inner = Component(FillSizing(), FitSizing())
                    inner:setLayout(HorizontalLayout({ gap = 0, align = "center" }))
                    local boxcomp  = BoxComponent(FitSizing())
                        local mainmenu = BasicMenuComponent(FixedSizing(200, 50))
                                mainmenu:setPadding(-6, -12, 20, 0)
                                mainmenu:setLayout(VerticalLayout({ gap = 6, align = "start" }))
                                mainmenu:addChild(Text(self.name))
                            local mainmenu2 = BasicMenuComponent(FixedSizing(200, 50))
                                mainmenu2:setPadding(0, 0, 20, 0)
                                mainmenu2:setLayout(HorizontalLayout({ gap = 8, align = "start" }))

                                if self.bond < 0 then
                                    mainmenu2:addChild(Sprite("bondingsys/ui/heart_red"))
                                    mainmenu2:addChild(Sprite("bondingsys/ui/heart_red"))
                                    mainmenu2:addChild(Sprite("bondingsys/ui/heart_red"))
                                    mainmenu2:addChild(Sprite("bondingsys/ui/heart_red"))
                                    mainmenu2:addChild(Sprite("bondingsys/ui/heart_red"))
                                else
                                    if self.bond == 0 then
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_outline"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_outline"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_outline"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_outline"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_outline"))
                                    elseif self.bond >= 1 and self.bond <= 10 then
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_half"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_outline"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_outline"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_outline"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_outline"))
                                    elseif self.bond >= 11 and self.bond <= 15 then
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_filled"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_half"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_outline"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_outline"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_outline"))
                                    elseif self.bond >= 16 and self.bond <= 25 then
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_filled"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_filled"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_outline"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_outline"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_outline"))
                                    elseif self.bond >= 26 and self.bond <= 40 then
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_filled"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_filled"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_half"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_outline"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_outline"))
                                    elseif self.bond >= 41 and self.bond <= 50 then
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_filled"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_filled"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_filled"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_outline"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_outline"))
                                    elseif self.bond >= 51 and self.bond <= 60 then
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_filled"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_filled"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_filled"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_half"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_outline"))
                                    elseif self.bond >= 61 and self.bond <= 75 then
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_filled"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_filled"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_filled"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_filled"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_outline"))
                                    elseif self.bond >= 76 and self.bond <= 85 then
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_filled"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_filled"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_filled"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_filled"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_half"))
                                    elseif self.bond >= 86 then
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_filled"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_filled"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_filled"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_filled"))
                                        mainmenu2:addChild(Sprite("bondingsys/ui/heart_filled"))
                                    end
                                end
                                
                            mainmenu:addChild(mainmenu2)
                        boxcomp:addChild(mainmenu)
                    inner:addChild(boxcomp)
                outer:addChild(inner)
            Game.stage:addChild(outer)
        --[[]
        local wait, textbox1 = cutscene:text("* test", nil, nil, {top = false, advance = false})
        cutscene:wait(function() return not textbox1:isTyping() end)
        local outerchoicer = Component(FixedSizing(640, 480))
                outerchoicer.x = 203
                outerchoicer.y = -1
                outerchoicer:setLayout(VerticalLayout({ gap = 0, align = "center" }))
                outerchoicer:setOverflow("hidden")
                local innerchoicer = Component(FillSizing(), FitSizing())
                    innerchoicer:setLayout(HorizontalLayout({ gap = 0, align = "center" }))
                    local boxcompchoicer  = BoxComponent(FitSizing())
                        local mainmenuchoicer = BasicMenuComponent(FixedSizing(126, 100))
                                local buttons = 0

                                mainmenuchoicer:setPadding(0, 0, 20, 0)
                                mainmenuchoicer:setLayout(VerticalLayout({ gap = 6, align = "start" }))

                                if self:getBond() >= self.talk_relationship then
                                    buttons = buttons + 1
                                    mainmenuchoicer:addChild(TextMenuItemComponent(Text("Talk"), function() end))
                                end
                                if self:getBond() >= self.gift_relationship then
                                    buttons = buttons + 1
                                    mainmenuchoicer:addChild(TextMenuItemComponent(Text("Gift"), function() end))
                                end
                                if self.party == true then
                                    if self:getBond() >= self.party_relationship then
                                        buttons = buttons + 1
                                        mainmenuchoicer:addChild(TextMenuItemComponent(Text("Party"), function() end))
                                    end
                                end
                                buttons = buttons + 2
                                mainmenuchoicer:addChild(TextMenuItemComponent(Text("About"), function()
                                    mainmenuchoicer:setUnfocused()
                                    --textbox1:setText(self:getActionText_about(), nil, nil, {top = false, advance = false, wait = true})
                                    --local wait, textbox3 = cutscene:text(self:getActionText_about(), nil, nil, {top = false, advance = false, wait = true})
                                    local wait, textbox3 = cutscene:text("* cocaine", nil, nil, {top = false, advance = false, wait = true})
                                    
                                end))
                                mainmenuchoicer:addChild(TextMenuItemComponent(Text("End"), function()
                                    textbox1:remove()
                                    outer:remove()
                                    outerchoicer:remove()
                                end))

                                if buttons > 3 then
                                    mainmenuchoicer:setPadding(0, 0, 20, 0)
                                    mainmenuchoicer:setLayout(VerticalLayout({ gap = 2, align = "start" }))
                                    mainmenuchoicer:setScrollbar(ScrollbarComponent({gutter = "dotted", margins = {8, 0, 0, 0}, arrows = false}))
                                    mainmenuchoicer:setOverflow("scroll")
                                    mainmenuchoicer:setScrollType("paged")
                                    outerchoicer.x = 195
                                end

                        boxcompchoicer:addChild(mainmenuchoicer)
                    innerchoicer:addChild(boxcompchoicer)
                outerchoicer:addChild(innerchoicer)
            Game.stage:addChild(outerchoicer)
            mainmenuchoicer:setFocused()
        cutscene:wait(function() return textbox1:isRemoved() end)
        --outer:remove()
        --outerchoicer:remove()
    end)
    ]]
    Game.world:startCutscene("bondingsys.main_cutscene", self)
end

return BondingCharacter