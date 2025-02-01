module("modules.logic.fight.system.work.FightWorkMagicCircleDelete", package.seeall)

slot0 = class("FightWorkMagicCircleDelete", FightEffectBase)

function slot0.onStart(slot0)
	if FightModel.instance:getMagicCircleInfo() and slot1:deleteData(tonumber(slot0._actEffectMO.reserveId)) then
		if lua_magic_circle.configDict[slot2] then
			slot0:com_registTimer(slot0._delayDone, math.max(slot3.closeTime / 1000, 0.3) / FightModel.instance:getSpeed())
			FightController.instance:dispatchEvent(FightEvent.DeleteMagicCircile, slot2)

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
