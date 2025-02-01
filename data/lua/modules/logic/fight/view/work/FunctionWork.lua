module("modules.logic.fight.view.work.FunctionWork", package.seeall)

slot0 = class("FunctionWork", BaseWork)

function slot0.ctor(slot0, slot1, slot2, slot3)
	slot0:setParam(slot1, slot2, slot3)
end

function slot0.setParam(slot0, slot1, slot2, slot3)
	slot0._func = slot1
	slot0._target = slot2
	slot0._param = slot3
end

function slot0.onStart(slot0)
	slot0._func(slot0._target, slot0._param)
	slot0:onDone(true)
end

return slot0
