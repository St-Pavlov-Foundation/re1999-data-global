module("modules.logic.versionactivity1_9.fairyland.view.element.FairyLandElementDoor", package.seeall)

slot0 = class("FairyLandElementDoor", FairyLandElementBase)

function slot0.onInitView(slot0)
	slot0.animator = slot0._go:GetComponent(typeof(UnityEngine.Animator))

	slot0:addEventCb(FairyLandController.instance, FairyLandEvent.DoStairAnim, slot0.onDoStairAnim, slot0)
end

function slot0.getState(slot0)
	if not FairyLandConfig.instance:getElementConfig(slot0:getElementId() - 1) or FairyLandModel.instance:isFinishElement(slot2) then
		return FairyLandEnum.ShapeState.CanClick
	end

	return FairyLandEnum.ShapeState.LockClick
end

function slot0.onClick(slot0)
	if slot0:getState() == FairyLandEnum.ShapeState.CanClick and not slot0._elements:isMoveing() then
		slot0:setFinish()
	end
end

function slot0.finish(slot0)
	FairyLandModel.instance:setPos(slot0:getPos(), true)
	slot0._elements:characterMove()
	slot0:onDestroy()
end

function slot0.onDoStairAnim(slot0, slot1)
	if slot1 == 46 then
		slot0.animator:Play("door_01", 0, 0)
	elseif slot1 == 48 then
		slot0.animator:Play("door_02", 0, 0)
	end
end

function slot0.onDestroy(slot0)
	slot0:onDestroyElement()

	if slot0.click then
		slot0.click:RemoveClickListener()
	end

	slot0:__onDispose()
end

function slot0.onDestroyElement(slot0)
end

return slot0
