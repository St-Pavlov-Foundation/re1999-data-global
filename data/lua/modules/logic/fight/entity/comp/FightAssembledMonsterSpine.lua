module("modules.logic.fight.entity.comp.FightAssembledMonsterSpine", package.seeall)

slot0 = class("FightAssembledMonsterSpine", FightUnitSpine)

function slot0.playBySub(slot0, slot1, slot2, slot3, slot4)
	if slot2 == "die" or slot2 == "idle" then
		return
	end

	slot0:play(slot2, slot3, slot4)
end

return slot0
