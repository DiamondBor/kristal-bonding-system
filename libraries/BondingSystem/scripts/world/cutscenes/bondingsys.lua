return {

    main_cutscene = function(cutscene, self)
            --[[]
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
            --]]
    
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
                                    BondingSystemLib:spawnheartsprites(mainmenu2, self.bond)
                                mainmenu:addChild(mainmenu2)
                            boxcomp:addChild(mainmenu)
                        inner:addChild(boxcomp)
                    outer:addChild(inner)
                Game.stage:addChild(outer)

            local f_text, f_port, f_char = self:getActionText_greet()
            local wait, textbox1 = cutscene:text(f_text, f_port, f_char, {top = false, advance = false})
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
                                        mainmenuchoicer:addChild(TextMenuItemComponent(Text("Talk"), function()
                                            mainmenuchoicer:setUnfocused()
                                            cutscene:after(function()
                                                outer:remove()
                                                outerchoicer:remove()
                                                Game.world:startCutscene("bondingsys.talkcs", self)
                                            end)
                                            cutscene:endCutscene()
                                        end))
                                    end
                                    ---------- // i can't figure out how to make the whole gifts thing so i, didn't
                                    --[[
                                    if self:getBond() >= self.gift_relationship then
                                        buttons = buttons + 1
                                        mainmenuchoicer:addChild(TextMenuItemComponent(Text("Gift"), function()
                                            mainmenuchoicer:setUnfocused()
                                            cutscene:after(function()
                                                outer:remove()
                                                outerchoicer:remove()
                                                Game.world:startCutscene("bondingsys.giftcs", self)
                                            end)
                                            cutscene:endCutscene()
                                        end))
                                    end
                                    --]]
                                    if self.party == true then
                                        if self:getBond() >= self.party_relationship then
                                            buttons = buttons + 1
                                            mainmenuchoicer:addChild(TextMenuItemComponent(Text("Party"), function()
                                                mainmenuchoicer:setUnfocused()
                                                cutscene:after(function()
                                                    outer:remove()
                                                    outerchoicer:remove()
                                                    Game.world:startCutscene("bondingsys.partycs", self)
                                                end)
                                                cutscene:endCutscene()
                                            end))
                                        end
                                    end
                                    buttons = buttons + 2
                                    mainmenuchoicer:addChild(TextMenuItemComponent(Text("About"), function()
                                        mainmenuchoicer:setUnfocused()
                                        cutscene:after(function()
                                            outer:remove()
                                            outerchoicer:remove()
                                            Game.world:startCutscene("bondingsys.aboutcs", self)
                                        end)
                                        cutscene:endCutscene()
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
    end,

    aboutcs = function(cutscene, self)
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
                                    BondingSystemLib:spawnheartsprites(mainmenu2, self.bond)
                                mainmenu:addChild(mainmenu2)
                            boxcomp:addChild(mainmenu)
                        inner:addChild(boxcomp)
                    outer:addChild(inner)
                Game.stage:addChild(outer)

            local wait, textbox3 = cutscene:text(self:getActionText_about() .. "[wait:20]", nil, nil, {top = false})
            Input.clear("confirm")
            cutscene:after(function()
                outer:remove()
                Game.world:startCutscene("bondingsys.main_cutscene", self)
            end)
            cutscene:endCutscene()
    end,

    talkcs = function(cutscene, self)
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
                                    BondingSystemLib:spawnheartsprites(mainmenu2, self.bond)
                                mainmenu:addChild(mainmenu2)
                            boxcomp:addChild(mainmenu)
                        inner:addChild(boxcomp)
                    outer:addChild(inner)
                Game.stage:addChild(outer)

                local f_text, f_port, f_char = self:getActionText_talk()
                local wait, textbox1 = cutscene:text(f_text .. "[wait:10]", f_port, f_char, {top = false})
                Input.clear("confirm")
            cutscene:after(function()
                outer:remove()
                Game.world:startCutscene("bondingsys.main_cutscene", self)
            end)
            cutscene:endCutscene()
    end,

    partycs = function(cutscene, self)
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
                                    BondingSystemLib:spawnheartsprites(mainmenu2, self.bond)
                                mainmenu:addChild(mainmenu2)
                            boxcomp:addChild(mainmenu)
                        inner:addChild(boxcomp)
                    outer:addChild(inner)
                Game.stage:addChild(outer)

                local choice = cutscene:textChoicer("* Do you want to party with\n[color:".. self.charcolor .."]".. self.name .."[color:reset]?", {"No", "     Yes"}, nil, nil, {top = false})
                Input.clear("confirm")
                if choice == 2 then
                    local f_text, f_port, f_char = self:getActionText_party()
                    local wait, textbox1 = cutscene:text(f_text .. "[wait:10]", f_port, f_char, {top = false})
                    Input.clear("confirm")
                    Game:addPartyMember(self.party_member)
                    Game.world:getCharacter(self.actor):convertToFollower()
                    cutscene:interpolateFollowers()
                    cutscene:attachFollowers()
                    outer:remove()
                else
                    cutscene:after(function()
                        outer:remove()
                        Game.world:startCutscene("bondingsys.main_cutscene", self)
                    end)
                end
            cutscene:endCutscene()
    end,

}