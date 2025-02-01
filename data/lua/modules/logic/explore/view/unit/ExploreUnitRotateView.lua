module("modules.logic.explore.view.unit.ExploreUnitRotateView", package.seeall)

slot0 = class("ExploreUnitRotateView", ExploreUnitBaseView)
slot1 = ExploreEnum.TriggerEvent.Rotate .. "#%d"

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1, "ui/viewres/explore/exploreunitrotate.prefab")
end

function slot0.onInit(slot0)
	slot0._btnLeft = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_left")
	slot0._btnRight = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_right")
end

function slot0.addEventListeners(slot0)
	slot0._btnLeft:AddClickListener(slot0.doRotate, slot0, false)
	slot0._btnRight:AddClickListener(slot0.doRotate, slot0, true)
end

function slot0.removeEventListeners(slot0)
	slot0._btnLeft:RemoveClickListener()
	slot0._btnRight:RemoveClickListener()
end

function slot0.doRotate(slot0, slot1)
	slot2 = 0
	slot3 = 0

	for slot7, slot8 in pairs(slot0.unit.mo.triggerEffects) do
		if slot8[1] == ExploreEnum.TriggerEvent.Rotate then
			slot2 = slot7

			if slot1 then
				slot3 = -tonumber(slot8[2])
			end

			break
		end
	end

	if slot2 <= 0 then
		return
	end

	ExploreRpc.instance:sendExploreInteractRequest(slot0.unit.id, slot2, string.format(uv0, slot3), slot0.onRotateRecv, slot0)
end

function slot0.onRotateRecv(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	if not slot0.unit then
		return
	end

	slot4 = slot0.unit.mo.unitDir

	slot0.unit:doRotate(slot4 - string.splitToNumber(slot3.params, "#")[2], slot4)
end

function slot0.onDestroy(slot0)
	slot0._btnLeft = nil
	slot0._btnRight = nil
end

return slot0
