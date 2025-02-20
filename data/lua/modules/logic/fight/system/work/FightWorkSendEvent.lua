module("modules.logic.fight.system.work.FightWorkSendEvent", package.seeall)

slot0 = class("FightWorkSendEvent", FightWorkItem)

function slot0.onAwake(slot0, slot1, ...)
	slot0._eventName = slot1
	slot0._param = {
		...
	}
	slot0._paramCount = select("#", ...)
end

function slot0.onStart(slot0)
	slot0:com_sendFightEvent(slot0._eventName, unpack(slot0._param, 1, slot0._paramCount))
	slot0:onDone(true)
end

return slot0
