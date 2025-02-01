module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepDeleteObject", package.seeall)

slot0 = class("Va3ChessStepDeleteObject", Va3ChessStepBase)
slot1 = 0.1
slot2 = 1
slot3 = 0.7

function slot0.start(slot0)
	if (Va3ChessGameController.instance.interacts and slot2:get(slot0.originData.id) or nil) and slot3.config then
		if slot3.config.interactType == Va3ChessEnum.InteractType.Player or slot4 == Va3ChessEnum.InteractType.AssistPlayer then
			if slot0:checkPlayDisappearAnim(slot3, slot0.originData.reason) then
				return
			end
		elseif slot3:getHandler().playDeleteObjView then
			slot3:getHandler():playDeleteObjView(slot5)

			slot6 = uv0

			if slot5 == Va3ChessEnum.DeleteReason.Arrow or slot5 == Va3ChessEnum.DeleteReason.FireBall or slot5 == Va3ChessEnum.DeleteReason.MoveKill then
				slot6 = uv1
			end

			TaskDispatcher.runDelay(slot0.removeFinish, slot0, slot6)

			return
		end
	end

	slot0:removeFinish()
end

slot4 = {
	[Va3ChessEnum.DeleteReason.Falling] = {
		anim = "down"
	},
	[Va3ChessEnum.DeleteReason.EnemyKill] = {
		anim = "die",
		audio = AudioEnum.chess_activity142.Die
	},
	[Va3ChessEnum.DeleteReason.Change] = {
		anim = Activity142Enum.SWITCH_CLOSE_ANIM
	}
}

function slot0.checkPlayDisappearAnim(slot0, slot1, slot2)
	if slot1.avatar and slot1.avatar.goSelected and slot1.avatar.goSelected:GetComponent(typeof(UnityEngine.Animator)) then
		slot3:Play("close", 0, 0)
	end

	if slot2 == Va3ChessEnum.DeleteReason.Change then
		Activity142Controller.instance:dispatchEvent(Activity142Event.PlaySwitchPlayerEff, slot1.originData.posX, slot1.originData.posY)
	end

	if not gohelper.isNil(slot1:tryGetGameObject()) then
		gohelper.setActive(gohelper.findChild(slot3, "vx_disappear"), true)

		if not gohelper.isNil(gohelper.findChild(slot3, "piecea/vx_tracked")) and slot5:GetComponent(typeof(UnityEngine.Animator)) then
			slot6:Play("close", 0, 0)
		end

		if slot3:GetComponent(typeof(UnityEngine.Animator)) then
			slot7 = uv0[slot2] or {}

			slot6:Play(slot7.anim or "close", 0, 0)

			if slot7.audio then
				AudioMgr.instance:trigger(slot9)
			end
		end

		TaskDispatcher.runDelay(slot0.removeFinish, slot0, uv1)

		return true
	end

	return false
end

function slot0.removeFinish(slot0)
	slot1 = slot0.originData.id

	Va3ChessGameModel.instance:removeObjectById(slot1)
	Va3ChessGameController.instance:deleteInteractObj(slot1)

	if slot0.originData and slot0.originData.refreshAllKillEff then
		Va3ChessGameController.instance:refreshAllInteractKillEff()
	end

	slot0:finish()
end

function slot0.dispose(slot0)
	uv0.super.dispose(slot0)
	TaskDispatcher.cancelTask(slot0.removeFinish, slot0)
end

return slot0
