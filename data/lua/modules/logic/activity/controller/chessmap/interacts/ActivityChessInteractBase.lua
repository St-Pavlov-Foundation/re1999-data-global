module("modules.logic.activity.controller.chessmap.interacts.ActivityChessInteractBase", package.seeall)

local var_0_0 = class("ActivityChessInteractBase")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._target = arg_1_1
end

function var_0_0.onSelectCall(arg_2_0)
	return
end

function var_0_0.onCancelSelect(arg_3_0)
	return
end

function var_0_0.onSelectPos(arg_4_0, arg_4_1, arg_4_2)
	return
end

function var_0_0.moveTo(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if arg_5_0._target.avatar then
		local var_5_0 = arg_5_0._target.originData.posX
		local var_5_1 = arg_5_0._target.originData.posY

		arg_5_0._target.originData.posX = arg_5_1
		arg_5_0._target.originData.posY = arg_5_2

		local var_5_2, var_5_3, var_5_4 = ActivityChessGameController.instance:calcTilePosInScene(arg_5_1, arg_5_2, arg_5_0._target.avatar.order)
		local var_5_5 = arg_5_0._target.avatar

		arg_5_0:killMoveTween()

		arg_5_0._moveCallback = arg_5_3
		arg_5_0._moveCallbackObj = arg_5_4
		arg_5_0._tweenIdMoveScene = ZProj.TweenHelper.DOLocalMove(var_5_5.sceneTf, var_5_2, var_5_3, var_5_4, 0.3, arg_5_0.onMoveCompleted, arg_5_0, nil, EaseType.Linear)

		local var_5_6 = ActivityChessMapUtils.ToDirection(var_5_0, var_5_1, arg_5_1, arg_5_2)

		arg_5_0:faceTo(var_5_6)
	elseif arg_5_3 then
		arg_5_3(arg_5_4)
	end
end

function var_0_0.faceTo(arg_6_0, arg_6_1)
	arg_6_0._curDir = arg_6_1

	if arg_6_0._target.avatar then
		if not ActivityChessInteractObject.DirectionSet[arg_6_0._curDir] then
			return
		end

		for iter_6_0, iter_6_1 in ipairs(ActivityChessInteractObject.DirectionList) do
			local var_6_0 = arg_6_0._target.avatar["goFaceTo" .. iter_6_1]

			if not gohelper.isNil(var_6_0) then
				gohelper.setActive(var_6_0, arg_6_1 == iter_6_1)
			end
		end
	end
end

function var_0_0.onMoveCompleted(arg_7_0)
	if arg_7_0._moveCallback then
		local var_7_0 = arg_7_0._moveCallback
		local var_7_1 = arg_7_0._moveCallbackObj

		arg_7_0._moveCallback = nil
		arg_7_0._moveCallbackObj = nil

		var_7_0(var_7_1)
	end
end

function var_0_0.onDrawAlert(arg_8_0, arg_8_1)
	return
end

function var_0_0.onAvatarLoaded(arg_9_0)
	local var_9_0 = arg_9_0._curDir or arg_9_0._target.originData.direction

	if var_9_0 ~= nil and var_9_0 ~= 0 then
		arg_9_0:faceTo(var_9_0)
	end
end

function var_0_0.killMoveTween(arg_10_0)
	if arg_10_0._tweenIdMoveScene then
		ZProj.TweenHelper.KillById(arg_10_0._tweenIdMoveScene)

		arg_10_0._tweenIdMoveScene = nil
	end
end

function var_0_0.dispose(arg_11_0)
	arg_11_0:killMoveTween()
end

return var_0_0
