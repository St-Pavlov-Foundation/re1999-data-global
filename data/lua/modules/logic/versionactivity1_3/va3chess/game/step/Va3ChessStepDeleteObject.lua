module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepDeleteObject", package.seeall)

local var_0_0 = class("Va3ChessStepDeleteObject", Va3ChessStepBase)
local var_0_1 = 0.1
local var_0_2 = 1
local var_0_3 = 0.7

function var_0_0.start(arg_1_0)
	local var_1_0 = arg_1_0.originData.id
	local var_1_1 = Va3ChessGameController.instance.interacts
	local var_1_2 = var_1_1 and var_1_1:get(var_1_0) or nil

	if var_1_2 and var_1_2.config then
		local var_1_3 = var_1_2.config.interactType
		local var_1_4 = arg_1_0.originData.reason

		if var_1_3 == Va3ChessEnum.InteractType.Player or var_1_3 == Va3ChessEnum.InteractType.AssistPlayer then
			if arg_1_0:checkPlayDisappearAnim(var_1_2, var_1_4) then
				return
			end
		elseif var_1_2:getHandler().playDeleteObjView then
			var_1_2:getHandler():playDeleteObjView(var_1_4)

			local var_1_5 = var_0_1

			if var_1_4 == Va3ChessEnum.DeleteReason.Arrow or var_1_4 == Va3ChessEnum.DeleteReason.FireBall or var_1_4 == Va3ChessEnum.DeleteReason.MoveKill then
				var_1_5 = var_0_2
			end

			TaskDispatcher.runDelay(arg_1_0.removeFinish, arg_1_0, var_1_5)

			return
		end
	end

	arg_1_0:removeFinish()
end

local var_0_4 = {
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

function var_0_0.checkPlayDisappearAnim(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1.avatar and arg_2_1.avatar.goSelected then
		local var_2_0 = arg_2_1.avatar.goSelected:GetComponent(typeof(UnityEngine.Animator))

		if var_2_0 then
			var_2_0:Play("close", 0, 0)
		end
	end

	if arg_2_2 == Va3ChessEnum.DeleteReason.Change then
		local var_2_1 = arg_2_1.originData.posX
		local var_2_2 = arg_2_1.originData.posY

		Activity142Controller.instance:dispatchEvent(Activity142Event.PlaySwitchPlayerEff, var_2_1, var_2_2)
	end

	local var_2_3 = arg_2_1:tryGetGameObject()

	if not gohelper.isNil(var_2_3) then
		local var_2_4 = gohelper.findChild(var_2_3, "vx_disappear")

		gohelper.setActive(var_2_4, true)

		local var_2_5 = gohelper.findChild(var_2_3, "piecea/vx_tracked")

		if not gohelper.isNil(var_2_5) then
			local var_2_6 = var_2_5:GetComponent(typeof(UnityEngine.Animator))

			if var_2_6 then
				var_2_6:Play("close", 0, 0)
			end
		end

		local var_2_7 = var_2_3:GetComponent(typeof(UnityEngine.Animator))

		if var_2_7 then
			local var_2_8 = var_0_4[arg_2_2] or {}
			local var_2_9 = var_2_8.anim or "close"

			var_2_7:Play(var_2_9, 0, 0)

			local var_2_10 = var_2_8.audio

			if var_2_10 then
				AudioMgr.instance:trigger(var_2_10)
			end
		end

		TaskDispatcher.runDelay(arg_2_0.removeFinish, arg_2_0, var_0_3)

		return true
	end

	return false
end

function var_0_0.removeFinish(arg_3_0)
	local var_3_0 = arg_3_0.originData.id

	Va3ChessGameModel.instance:removeObjectById(var_3_0)
	Va3ChessGameController.instance:deleteInteractObj(var_3_0)

	if arg_3_0.originData and arg_3_0.originData.refreshAllKillEff then
		Va3ChessGameController.instance:refreshAllInteractKillEff()
	end

	arg_3_0:finish()
end

function var_0_0.dispose(arg_4_0)
	var_0_0.super.dispose(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0.removeFinish, arg_4_0)
end

return var_0_0
