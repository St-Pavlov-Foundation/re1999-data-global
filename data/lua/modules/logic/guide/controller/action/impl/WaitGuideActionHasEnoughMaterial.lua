module("modules.logic.guide.controller.action.impl.WaitGuideActionHasEnoughMaterial", package.seeall)

slot0 = class("WaitGuideActionHasEnoughMaterial", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	BackpackController.instance:registerCallback(BackpackEvent.UpdateItemList, slot0._checkMaterials, slot0)

	slot0._materials = GameUtil.splitString2(slot0.actionParam, true, "|", "#")

	slot0:_checkMaterials()
end

function slot0._checkMaterials(slot0)
	slot1 = true

	for slot5, slot6 in ipairs(slot0._materials) do
		if ItemModel.instance:getItemQuantity(slot6[1], slot6[2]) < slot6[3] then
			slot1 = false

			break
		end
	end

	if slot1 then
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, slot0._checkMaterials, slot0)
end

return slot0
