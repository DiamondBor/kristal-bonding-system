local NPC, super = Class("NPC", true)

function NPC:init(actor, x, y, properties)
    super.init(self, actor, x, y)

    self.bondingchara = nil
    if properties["bond"] then
        self.bondingchara = BondingSystemLib:createBondingCharacter(properties["bond"])
    end

    --[[]
    if self.bondingchara ~= nil then
        print(self.bondingchara)
        if self.bondingchara.party_member ~= nil then
            print(self.bondingchara.party_member)
            if Game:hasPartyMember(self.bondingchara.party_member) then
                print(Game:hasPartyMember(self.bondingchara.party_member))
                self:remove()
            end
        end
    end
    --]]
end

function NPC:onInteract(player, dir)
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
end

return NPC