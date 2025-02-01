module("modules.logic.activity.controller.chessmap.step.ActivityChessStepPickUpItem", package.seeall)

slot0 = class("ActivityChessStepPickUpItem", ActivityChessStepBase)

function slot0.start(slot0)
	if ActivityChessGameController.instance.interacts and slot2:get(slot0.originData.id) and not gohelper.isNil(slot3:tryGetGameObject()) then
		gohelper.setActive(gohelper.findChild(slot4, "vx_daoju"), true)
	end

	AudioMgr.instance:trigger(AudioEnum.ChessGame.PickUpBottle)
	TaskDispatcher.runDelay(slot0.delayCallPick, slot0, 1)
end

function slot0.delayCallPick(slot0)
	TaskDispatcher.cancelTask(slot0.delayCallPick, slot0)

	if ActivityChessGameModel.instance:getActId() and Activity109Config.instance:getInteractObjectCo(slot1, slot0.originData.id) then
		ActivityChessGameController.instance:registerCallback(ActivityChessEvent.RewardIsClose, slot0.finish, slot0)
		ViewMgr.instance:openView(ViewName.ActivityChessGameRewardView, {
			config = slot3
		})

		return
	end

	slot0:finish()
end

function slot0.finish(slot0)
	ActivityChessGameController.instance:unregisterCallback(ActivityChessEvent.RewardIsClose, slot0.finish, slot0)
	uv0.super.finish(slot0)
end

function slot0.dispose(slot0)
	TaskDispatcher.cancelTask(slot0.delayCallPick, slot0)
	ActivityChessGameController.instance:unregisterCallback(ActivityChessEvent.RewardIsClose, slot0.finish, slot0)
	uv0.super.dispose(slot0)
end

return slot0
