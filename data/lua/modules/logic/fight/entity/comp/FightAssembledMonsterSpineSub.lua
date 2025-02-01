module("modules.logic.fight.entity.comp.FightAssembledMonsterSpineSub", package.seeall)

slot0 = class("FightAssembledMonsterSpineSub")

function slot0.play(slot0, ...)
	slot0.unitSpawn.mainSpine:playBySub(slot0.unitSpawn, ...)
end

function slot0.ctor(slot0, slot1)
	slot0.unitSpawn = slot1
end

function slot0.__index(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1]
	else
		return slot0.unitSpawn.mainSpine[slot1]
	end
end

return slot0
