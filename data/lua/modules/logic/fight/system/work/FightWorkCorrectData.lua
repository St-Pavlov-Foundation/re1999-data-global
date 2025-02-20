module("modules.logic.fight.system.work.FightWorkCorrectData", package.seeall)

slot0 = class("FightWorkCorrectData", BaseWork)

function slot0.onStart(slot0, slot1)
	if FightModel.instance:getCurRoundMO() and slot2._exPointMODict then
		for slot7, slot8 in pairs(slot3) do
			if FightDataHelper.entityMgr:getById(slot7) and slot8.currentHp and slot8.currentHp ~= slot9.currentHp then
				slot9:setHp(slot8.currentHp)
				FightController.instance:dispatchEvent(FightEvent.OnCurrentHpChange, slot7)
			end
		end
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
