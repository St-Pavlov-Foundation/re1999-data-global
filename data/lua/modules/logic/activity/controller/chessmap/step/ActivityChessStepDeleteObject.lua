module("modules.logic.activity.controller.chessmap.step.ActivityChessStepDeleteObject", package.seeall)

slot0 = class("ActivityChessStepDeleteObject", ActivityChessStepBase)

function slot0.start(slot0)
	slot2 = slot0.originData.x
	slot3 = slot0.originData.y
	slot4 = ActivityChessGameModel.instance:getActId()

	if ActivityChessGameController.instance.interacts and slot5:get(slot0.originData.id) and slot6.config and slot6.config.interactType == ActivityChessEnum.InteractType.Player and slot0:checkPlayDisappearAnim(slot6) then
		return
	end

	slot0:removeFinish()
end

function slot0.checkPlayDisappearAnim(slot0, slot1)
	if slot1.avatar and slot1.avatar.goSelected and slot1.avatar.goSelected:GetComponent(typeof(UnityEngine.Animator)) then
		slot2:Play("close", 0, 0)
	end

	if not gohelper.isNil(slot1:tryGetGameObject()) then
		gohelper.setActive(gohelper.findChild(slot2, "vx_disappear"), true)

		if not gohelper.isNil(gohelper.findChild(slot2, "piecea/vx_tracked")) and slot4:GetComponent(typeof(UnityEngine.Animator)) then
			slot5:Play("close", 0, 0)
		end

		if slot2:GetComponent(typeof(UnityEngine.Animator)) then
			slot5:Play("close", 0, 0)
		end

		AudioMgr.instance:trigger(AudioEnum.ChessGame.PlayerDisappear)
		TaskDispatcher.runDelay(slot0.removeFinish, slot0, 0.7)

		return true
	end

	return false
end

function slot0.removeFinish(slot0)
	slot1 = slot0.originData.id

	ActivityChessGameModel.instance:removeObjectById(slot1)
	ActivityChessGameController.instance:deleteInteractObj(slot1)
	slot0:finish()
end

function slot0.dispose(slot0)
	uv0.super.dispose(slot0)
	TaskDispatcher.cancelTask(slot0.removeFinish, slot0)
end

return slot0
