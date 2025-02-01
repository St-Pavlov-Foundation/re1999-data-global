module("modules.logic.timer.controller.FrameTimerController", package.seeall)

slot0 = class("FrameTimerController", BaseController)
slot1 = _G.FrameTimer
slot2 = table.insert
slot3 = _G.rawset
slot4 = _G.callWithCatch
slot5 = {}
slot6 = {}

function slot7(slot0)
	if not slot0 then
		return
	end

	if not slot0.func then
		return
	end

	slot0:Stop()
	uv0(uv1, slot0.func, nil)

	slot0.func = nil

	uv2(uv3, slot0)
end

function slot8()
	for slot3, slot4 in pairs(uv0) do
		uv1(slot4)
	end
end

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	uv0()
end

function slot0.register(slot0, slot1, slot2, slot3, slot4)
	slot5 = nil

	if #uv2 > 0 then
		table.remove(uv2):Reset(function ()
			if uv0 then
				uv1(uv0, uv2)
			end

			if uv3.loop <= 0 then
				uv4(uv3)
			end
		end, slot3 or 3, slot4 or 1)
	else
		slot5 = uv3.New(slot6, slot3, slot4)
	end

	uv4[slot6] = slot5

	return slot5
end

function slot0.unregister(slot0, slot1)
	uv0(slot1)
end

function slot0.onDestroyViewMember(slot0, slot1)
	if slot0[slot1] then
		uv0(slot0[slot1])

		slot0[slot1] = nil
	end
end

slot0.instance = slot0.New()

return slot0
