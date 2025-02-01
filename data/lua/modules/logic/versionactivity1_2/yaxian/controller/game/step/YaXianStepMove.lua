module("modules.logic.versionactivity1_2.yaxian.controller.game.step.YaXianStepMove", package.seeall)

slot0 = class("YaXianStepMove", YaXianStepBase)

function slot0.start(slot0)
	if not YaXianGameController.instance:getInteractItem(slot0.originData.id) then
		logError("not found interactObj, id : " .. tostring(slot0.originData.id))
		slot0:finish()
	end

	slot0.interactItem = slot1

	if slot1:getHandler() then
		slot2:moveToFromMoveStep(slot0.originData, slot0.finish, slot0)

		return
	end

	logError("interact not found handle, interactId : " .. slot0.originData.id)
	slot0:finish()
end

function slot0.finish(slot0)
	uv0.super.finish(slot0)
end

function slot0.dispose(slot0)
	if slot0.interactItem and slot0.interactItem:getHandler() then
		slot1:stopAllAction()
	end
end

return slot0
