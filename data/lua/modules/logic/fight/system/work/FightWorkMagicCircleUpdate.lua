module("modules.logic.fight.system.work.FightWorkMagicCircleUpdate", package.seeall)

slot0 = class("FightWorkMagicCircleUpdate", FightEffectBase)

function slot0.onStart(slot0)
	if FightModel.instance:getMagicCircleInfo() then
		if slot1.magicCircleId == slot0._actEffectMO.magicCircle.magicCircleId then
			slot1:refreshData(slot0._actEffectMO.magicCircle)
		end

		if lua_magic_circle.configDict[slot2] then
			FightController.instance:dispatchEvent(FightEvent.UpdateMagicCircile, slot2)
		else
			logError("术阵表找不到id:" .. slot2)
		end
	end

	slot0:_delayDone()
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
