module("modules.logic.rouge.view.RougeCollectionCompCellItem", package.seeall)

slot0 = class("RougeCollectionCompCellItem", RougeCollectionBaseSlotCellItem)

function slot0.onInit(slot0, slot1, slot2, slot3, slot4)
	uv0.super.onInit(slot0, slot1, slot2, slot3, slot4)

	slot0._goeffect = gohelper.findChild(slot0.viewGO, "#effect")
end

slot0.PlayEffectDuration = 0.8

function slot0.onPlaceCollection(slot0, slot1)
	slot0:updateCellState(RougeEnum.LineState.Green)
	slot0:hideInsideLines(slot1)
end

function slot0._hideEffect(slot0)
	gohelper.setActive(slot0._goeffect, false)
end

function slot0.revertCellState(slot0, slot1)
	uv0.super.revertCellState(slot0, slot1)
end

function slot0.hideInsideLines(slot0, slot1)
	if slot1 then
		for slot5, slot6 in pairs(slot1) do
			if slot0._directionTranMap[slot6] then
				gohelper.setActive(slot7.gameObject, false)
			end
		end
	end
end

function slot0.playGetCollectionEffect(slot0)
	TaskDispatcher.cancelTask(slot0._hideEffect, slot0)
	TaskDispatcher.runDelay(slot0._hideEffect, slot0, uv0.PlayEffectDuration)
	gohelper.setActive(slot0._goeffect, true)
end

function slot0.__onDispose(slot0)
	TaskDispatcher.cancelTask(slot0._hideEffect, slot0)
	uv0.super.__onDispose(slot0)
end

return slot0
