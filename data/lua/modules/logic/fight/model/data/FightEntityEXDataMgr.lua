module("modules.logic.fight.model.data.FightEntityEXDataMgr", package.seeall)

slot0 = FightDataClass("FightEntityEXDataMgr")

function slot0.onConstructor(slot0)
	slot0._exDataDic = {}
end

function slot0.getEntityEXData(slot0, slot1)
	slot2 = slot0._exDataDic[slot1]
	slot3 = slot2

	if not slot2 then
		slot0._exDataDic[slot1] = {}
	end

	return slot2, slot3
end

function slot0.setEXDataAfterAddEntityMO(slot0, slot1)
	slot2 = slot0:getEntityEXData(slot1.id)

	tabletool.clear(slot2)
	slot0:initEntityExData(slot2)
end

function slot0.initEntityExData(slot0, slot1)
	slot0:initAboutExpoint(slot1)
end

function slot0.initAboutExpoint(slot0, slot1)
	slot1.playCardAddExPoint = 1
	slot1.simulateAddExpoint = 0
end

function slot0.onStageChanged(slot0)
	for slot4, slot5 in pairs(slot0._exDataDic) do
		slot0:initAboutExpoint(slot5)
	end
end

function slot0.addExPoint(slot0, slot1)
	slot2, slot3 = slot0:getEntityEXData(slot1)

	if not slot3 then
		slot0:initAboutExpoint(slot2)
	end

	slot2.simulateAddExpoint = slot2.simulateAddExpoint + slot2.playCardAddExPoint
end

function slot0.getSimulateAddExpoint(slot0, slot1)
	slot2, slot3 = slot0:getEntityEXData(slot1)

	if not slot3 then
		slot0:initAboutExpoint(slot2)
	end

	return slot2.simulateAddExpoint
end

return slot0
