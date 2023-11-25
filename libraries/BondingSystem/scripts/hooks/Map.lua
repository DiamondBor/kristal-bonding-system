local Map, super = Class("Map", true)

function Map:loadObjects(layer, depth, layer_type)
    local parent = layer_type == "controllers" and self.world.controller_parent or self.world

    self.events_by_layer[layer.name] = {}
    for _,v in ipairs(layer.objects) do
        v.width = v.width or 0
        v.height = v.height or 0
        v.center_x = v.x + v.width/2
        v.center_y = v.y + v.height/2

        if v.gid then
            local tx,ty,tw,th = self:getTileObjectRect(v)
            v.center_x = tx + tw/2
            v.center_y = ty + th/2
        end

        local obj_type = v.type or v.class
        if obj_type == "" then
            obj_type = v.name
        end

        local uid = self:getUniqueID().."#"..tostring(v.properties["uid"] or v.id)
        if not Game:getFlag(uid..":dont_load") then
            local skip_loading = false
            if v.properties["cond"] then
                local env = setmetatable({}, {__index = function(t, k)
                    return Game.flags[uid..":"..k] or Game.flags[k] or _G[k]
                end})
                skip_loading = not setfenv(loadstring("return "..v.properties["cond"]), env)()
            elseif v.properties["bond"] then
                local bonding = BondingSystemLib:createBondingCharacter(v.properties["bond"])
                if bonding ~= nil then
                    if bonding.party == true then
                        if bonding.party_member ~= nil then
                            if Game:hasPartyMember(bonding.party_member) == true then
                                skip_loading = true
                            end
                        end
                    end
                end
            elseif v.properties["flagcheck"] then
                local inverted, flag = Utils.startsWith(v.properties["flagcheck"], "!")

                local result = Game.flags[uid..":"..flag] or Game.flags[flag]
                local value = v.properties["flagvalue"]
                local is_true
                if value ~= nil then
                    is_true = result == value
                elseif type(result) == "number" then
                    is_true = result > 0
                else
                    is_true = result
                end

                if is_true then
                    skip_loading = inverted
                else
                    skip_loading = not inverted
                end
            end

            if not skip_loading then
                local obj
                if layer_type == "controllers" then
                    obj = self:loadController(obj_type, v)
                else
                    obj = self:loadObject(obj_type, v)
                end
                if obj then
                    obj.x = obj.x + (layer.offsetx or 0)
                    obj.y = obj.y + (layer.offsety or 0)
                    if not obj.object_id then
                        obj.object_id = v.id
                    end
                    if not obj.unique_id then
                        obj.unique_id = v.properties["uid"]
                    end
                    obj.layer = depth
                    obj.data = v

                    if v.properties["usetile"] and v.gid and obj.applyTileObject then
                        obj:applyTileObject(v, self)
                    end

                    parent:addChild(obj)

                    table.insert(self.events, obj)

                    self.events_by_name[v.name] = self.events_by_name[v.name] or {}
                    table.insert(self.events_by_name[v.name], obj)
                    table.insert(self.events_by_layer[layer.name], obj)

                    if v.id then
                        self.events_by_id[v.id] = obj
                        self.next_object_id = math.max(self.next_object_id, v.id)
                    end
                end
            end
        end
    end
end

return Map