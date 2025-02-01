module("modules.logic.gm.controller.sequencework.DoStringActionWork", package.seeall)

slot0 = class("DoStringActionWork", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0._actionStr = slot1
end

function slot0.onStart(slot0, slot1)
	if loadstring(slot0._actionStr) then
		slot2()
	end

	slot0:onDone(true)
end

return slot0
