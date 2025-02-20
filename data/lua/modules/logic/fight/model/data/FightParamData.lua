module("modules.logic.fight.model.data.FightParamData", package.seeall)

slot0 = FightDataBase("FightParamData")

function slot0.ctor(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0[slot6.key] = slot6.value
	end
end

return slot0
