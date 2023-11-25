local Susie, super = Class(BondingCharacter, "susie")

function Susie:init()
    super.init(self)
    
    -- Display name
    self.name = "Susie"

    -- The character's personality
    self.personality = "Tough"

    -- The character's information
    self.info = "* Test character with nothing interesting about them. Yep."

    -- Bond & Relationship
    self.bond = 1

    -- If true, the character can join your party
    self.party = true

    -- The relationship needed to join your party
    self.party_relationship = -5
    -- The relationship needed to talk to this character
    self.talk_relationship = -10
    -- The relationship needed to gift stuff to this character
    self.gift_relationship = -5

    self.actor = "susie_lw"
    -- The party member this character will be linked to
    self.party_member = "susie"

    -- Gifts that this character likes/doesn't mind/dislikes
    self.gifts = {
        Favorite = {"light/bouquet", "light/box_of_heart_candy"},
        Neutral = {"light/hot_chocolate"},
        Dislike = {"light/cards"}
    }
end

return Susie