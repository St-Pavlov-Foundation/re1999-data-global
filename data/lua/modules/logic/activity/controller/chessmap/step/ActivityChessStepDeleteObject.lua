module("modules.logic.activity.controller.chessmap.step.ActivityChessStepDeleteObject", package.seeall)

local var_0_0 = class("ActivityChessStepDeleteObject", ActivityChessStepBase)

function var_0_0.start(arg_1_0)
	local var_1_0 = arg_1_0.originData.id
	local var_1_1 = arg_1_0.originData.x
	local var_1_2 = arg_1_0.originData.y
	local var_1_3 = ActivityChessGameModel.instance:getActId()
	local var_1_4 = ActivityChessGameController.instance.interacts

	if var_1_4 then
		local var_1_5 = var_1_4:get(var_1_0)

		if var_1_5 and var_1_5.config and var_1_5.config.interactType == ActivityChessEnum.InteractType.Player and arg_1_0:checkPlayDisappearAnim(var_1_5) then
			return
		end
	end

	arg_1_0:removeFinish()
end

function var_0_0.checkPlayDisappearAnim(arg_2_0, arg_2_1)
	if arg_2_1.avatar and arg_2_1.avatar.goSelected then
		local var_2_0 = arg_2_1.avatar.goSelected:GetComponent(typeof(UnityEngine.Animator))

		if var_2_0 then
			var_2_0:Play("close", 0, 0)
		end
	end

	local var_2_1 = arg_2_1:tryGetGameObject()

	if not gohelper.isNil(var_2_1) then
		local var_2_2 = gohelper.findChild(var_2_1, "vx_disappear")

		gohelper.setActive(var_2_2, true)

		local var_2_3 = gohelper.findChild(var_2_1, "piecea/vx_tracked")

		if not gohelper.isNil(var_2_3) then
			local var_2_4 = var_2_3:GetComponent(typeof(UnityEngine.Animator))

			if var_2_4 then
				var_2_4:Play("close", 0, 0)
			end
		end

		local var_2_5 = var_2_1:GetComponent(typeof(UnityEngine.Animator))

		if var_2_5 then
			var_2_5:Play("close", 0, 0)
		end

		AudioMgr.instance:trigger(AudioEnum.ChessGame.PlayerDisappear)
		TaskDispatcher.runDelay(arg_2_0.removeFinish, arg_2_0, 0.7)

		return true
	end

	return false
end

function var_0_0.removeFinish(arg_3_0)
	local var_3_0 = arg_3_0.originData.id

	ActivityChessGameModel.instance:removeObjectById(var_3_0)
	ActivityChessGameController.instance:deleteInteractObj(var_3_0)
	arg_3_0:finish()
end

function var_0_0.dispose(arg_4_0)
	var_0_0.super.dispose(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0.removeFinish, arg_4_0)
end

return var_0_0
