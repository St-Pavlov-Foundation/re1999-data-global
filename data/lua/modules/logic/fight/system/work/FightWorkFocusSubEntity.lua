module("modules.logic.fight.system.work.FightWorkFocusSubEntity", package.seeall)

slot0 = class("FightWorkFocusSubEntity", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0._entityMO = slot1
	slot0._entityId = slot0._entityMO.id .. "focusSub"
end

function slot0.onStart(slot0)
	if FightDataHelper.entityMgr:isSub(slot0._entityMO.id) then
		for slot6, slot7 in ipairs(slot0.context.subEntityList) do
			if slot7.id == slot0._entityId then
				slot0:onDone(true)

				return
			end
		end

		slot3 = GameSceneMgr.instance:getCurScene().entityMgr

		if not (slot0._entityMO and slot0._entityMO:getSpineSkinCO()) then
			slot0:onDone(true)

			return
		end

		FightController.instance:registerCallback(FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
		slot3:buildTempSpineByName(nil, slot0._entityId, slot0._entityMO.side, nil, slot4)
	else
		slot0:onDone(true)
	end
end

function slot0._onSpineLoaded(slot0, slot1)
	if slot0._entityId == slot1.unitSpawn.id then
		table.insert(slot0.context.subEntityList, slot1.unitSpawn)
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
end

return slot0
