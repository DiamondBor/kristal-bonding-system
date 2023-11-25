function Mod:init()
    --local nightFX = RecolorFX(52/255,66/255,226/255,1, 50)
    --Game.world:addFX(nightFX)
    print("Loaded "..self.info.name.."!")
end

function Mod:load(data, new_file, index)
    self.time = data.time or 0
end
function Mod:save(data)
    data.time = self.time
end

function Mod:postUpdate()
    self.time = self.time + 1
    if self.time >= 72000 then
        self.time = 0
    end
    --print(self.time)
end