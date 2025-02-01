module("modules.logic.fight.system.work.FightWorkMagicCircleAdd", package.seeall)

slot0 = class("FightWorkMagicCircleAdd", FightEffectBase)

function slot0.onStart(slot0)
	if FightModel.instance:getMagicCircleInfo() then
		slot1:refreshData(slot0._actEffectMO.magicCircle)

		if lua_magic_circle.configDict[slot0._actEffectMO.magicCircle.magicCircleId] then
			slot0:com_registTimer(slot0._delayDone, math.max(slot3.enterTime / 1000, 0.7) / FightModel.instance:getSpeed())
			FightController.instance:dispatchEvent(FightEvent.AddMagicCircile, slot2)

			return
		end

		logError("术阵表找不到id:" .. slot2)
	end

	slot0:_delayDone()
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
