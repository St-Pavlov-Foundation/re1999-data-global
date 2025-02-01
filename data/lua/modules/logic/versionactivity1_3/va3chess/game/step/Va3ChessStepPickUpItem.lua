module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepPickUpItem", package.seeall)

slot0 = class("Va3ChessStepPickUpItem", Va3ChessStepBase)

function slot0.start(slot0)
	slot2 = 0

	if Va3ChessGameController.instance.interacts and slot3:get(slot0.originData.id) and not gohelper.isNil(slot4:tryGetGameObject()) then
		slot6 = gohelper.findChild(slot5, "vx_daoju")

		gohelper.setActive(slot6, true)

		slot2 = slot6 and 1 or 0
	end

	AudioMgr.instance:trigger(AudioEnum.ChessGame.PickUpBottle)

	if slot2 ~= 0 then
		TaskDispatcher.runDelay(slot0.delayCallPick, slot0, slot2)
	else
		slot0:delayCallPick()
	end
end

function slot0.delayCallPick(slot0)
	TaskDispatcher.cancelTask(slot0.delayCallPick, slot0)

	if Va3ChessGameModel.instance:getActId() and Va3ChessConfig.instance:getInteractObjectCo(slot1, slot0.originData.id) then
		Va3ChessGameController.instance:registerCallback(Va3ChessEvent.RewardIsClose, slot0.finish, slot0)

		if Va3ChessViewController.instance:openRewardView(slot1, slot3, {
			collectionId = slot0.originData.collectionId
		}) then
			return
		end
	end

	slot0:finish()
end

function slot0.finish(slot0)
	Va3ChessGameController.instance:unregisterCallback(Va3ChessEvent.RewardIsClose, slot0.finish, slot0)
	uv0.super.finish(slot0)
end

function slot0.dispose(slot0)
	TaskDispatcher.cancelTask(slot0.delayCallPick, slot0)
	Va3ChessGameController.instance:unregisterCallback(Va3ChessEvent.RewardIsClose, slot0.finish, slot0)
	uv0.super.dispose(slot0)
end

return slot0
