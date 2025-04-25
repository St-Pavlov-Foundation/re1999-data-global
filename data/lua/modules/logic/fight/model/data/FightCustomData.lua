module("modules.logic.fight.model.data.FightCustomData", package.seeall)

slot0 = FightDataClass("FightCustomData")
slot0.CustomDataType = {
	Act183 = 1
}

function slot0.onConstructor(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0[slot6.type] = slot6.data
	end
end

return slot0
