module("modules.logic.activity.controller.chessmap.step.ActivityChessStepPickUpItem", package.seeall)

local var_0_0 = class("ActivityChessStepPickUpItem", ActivityChessStepBase)

function var_0_0.start(arg_1_0)
	local var_1_0 = arg_1_0.originData.id
	local var_1_1 = ActivityChessGameController.instance.interacts

	if var_1_1 then
		local var_1_2 = var_1_1:get(var_1_0)

		if var_1_2 then
			local var_1_3 = var_1_2:tryGetGameObject()

			if not gohelper.isNil(var_1_3) then
				local var_1_4 = gohelper.findChild(var_1_3, "vx_daoju")

				gohelper.setActive(var_1_4, true)
			end
		end
	end

	AudioMgr.instance:trigger(AudioEnum.ChessGame.PickUpBottle)
	TaskDispatcher.runDelay(arg_1_0.delayCallPick, arg_1_0, 1)
end

function var_0_0.delayCallPick(arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0.delayCallPick, arg_2_0)

	local var_2_0 = ActivityChessGameModel.instance:getActId()
	local var_2_1 = arg_2_0.originData.id

	if var_2_0 then
		local var_2_2 = Activity109Config.instance:getInteractObjectCo(var_2_0, var_2_1)

		if var_2_2 then
			ActivityChessGameController.instance:registerCallback(ActivityChessEvent.RewardIsClose, arg_2_0.finish, arg_2_0)
			ViewMgr.instance:openView(ViewName.ActivityChessGameRewardView, {
				config = var_2_2
			})

			return
		end
	end

	arg_2_0:finish()
end

function var_0_0.finish(arg_3_0)
	ActivityChessGameController.instance:unregisterCallback(ActivityChessEvent.RewardIsClose, arg_3_0.finish, arg_3_0)
	var_0_0.super.finish(arg_3_0)
end

function var_0_0.dispose(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0.delayCallPick, arg_4_0)
	ActivityChessGameController.instance:unregisterCallback(ActivityChessEvent.RewardIsClose, arg_4_0.finish, arg_4_0)
	var_0_0.super.dispose(arg_4_0)
end

return var_0_0
