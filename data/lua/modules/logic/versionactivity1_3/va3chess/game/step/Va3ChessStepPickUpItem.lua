module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepPickUpItem", package.seeall)

local var_0_0 = class("Va3ChessStepPickUpItem", Va3ChessStepBase)

function var_0_0.start(arg_1_0)
	local var_1_0 = arg_1_0.originData.id
	local var_1_1 = 0
	local var_1_2 = Va3ChessGameController.instance.interacts

	if var_1_2 then
		local var_1_3 = var_1_2:get(var_1_0)

		if var_1_3 then
			local var_1_4 = var_1_3:tryGetGameObject()

			if not gohelper.isNil(var_1_4) then
				local var_1_5 = gohelper.findChild(var_1_4, "vx_daoju")

				gohelper.setActive(var_1_5, true)

				var_1_1 = var_1_5 and 1 or 0
			end
		end
	end

	AudioMgr.instance:trigger(AudioEnum.ChessGame.PickUpBottle)

	if var_1_1 ~= 0 then
		TaskDispatcher.runDelay(arg_1_0.delayCallPick, arg_1_0, var_1_1)
	else
		arg_1_0:delayCallPick()
	end
end

function var_0_0.delayCallPick(arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0.delayCallPick, arg_2_0)

	local var_2_0 = Va3ChessGameModel.instance:getActId()
	local var_2_1 = arg_2_0.originData.id

	if var_2_0 then
		local var_2_2 = Va3ChessConfig.instance:getInteractObjectCo(var_2_0, var_2_1)

		if var_2_2 then
			Va3ChessGameController.instance:registerCallback(Va3ChessEvent.RewardIsClose, arg_2_0.finish, arg_2_0)

			local var_2_3 = {
				collectionId = arg_2_0.originData.collectionId
			}

			if Va3ChessViewController.instance:openRewardView(var_2_0, var_2_2, var_2_3) then
				return
			end
		end
	end

	arg_2_0:finish()
end

function var_0_0.finish(arg_3_0)
	Va3ChessGameController.instance:unregisterCallback(Va3ChessEvent.RewardIsClose, arg_3_0.finish, arg_3_0)
	var_0_0.super.finish(arg_3_0)
end

function var_0_0.dispose(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0.delayCallPick, arg_4_0)
	Va3ChessGameController.instance:unregisterCallback(Va3ChessEvent.RewardIsClose, arg_4_0.finish, arg_4_0)
	var_0_0.super.dispose(arg_4_0)
end

return var_0_0
