module("modules.logic.fight.system.work.FightWorkFunction", package.seeall)

slot0 = class("FightWorkFunction", FightWorkItem)

function slot0.onAwake(slot0, slot1, slot2, ...)
	slot0._func = slot1
	slot0._target = slot2
	slot0._param = {
		...
	}
	slot0._paramCount = select("#", ...)
end

function slot0.onStart(slot0)
	slot0._func(slot0._target, unpack(slot0._param, 1, slot0._paramCount))
	slot0:onDone(true)
end

return slot0
