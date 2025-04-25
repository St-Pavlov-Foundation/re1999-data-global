module("modules.logic.fight.model.data.FightParamData", package.seeall)

slot0 = FightDataClass("FightParamData")
slot0.ParamKey = {
	ProgressSkill = 1,
	ProgressId = 2
}

function slot0.onConstructor(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0[slot6.key] = slot6.value
	end
end

return slot0
