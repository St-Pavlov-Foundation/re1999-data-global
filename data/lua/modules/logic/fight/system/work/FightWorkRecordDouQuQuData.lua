module("modules.logic.fight.system.work.FightWorkRecordDouQuQuData", package.seeall)

slot0 = class("FightWorkRecordDouQuQuData", FightWorkItem)

function slot0.onStart(slot0)
	slot1.entity2HeroId = FightDataModel.instance.douQuQuMgr.entity2HeroId or {}
	slot1.entity2HeroId[slot1.index] = {}
	slot7 = FightDataHelper.entityMgr

	for slot6, slot7 in pairs(slot5.getAllEntityMO(slot7)) do
		slot1.entity2HeroId[slot2][slot7.id] = slot7.modelId
	end

	slot0:onDone(true)
end

return slot0
