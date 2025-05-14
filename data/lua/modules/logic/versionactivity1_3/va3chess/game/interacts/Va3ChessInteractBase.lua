module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractBase", package.seeall)

local var_0_0 = class("Va3ChessInteractBase")

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

function var_0_0.updatePos(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._srcX, arg_5_0._srcY = arg_5_0._target.originData.posX, arg_5_0._target.originData.posY
	arg_5_0._target.originData.posX = arg_5_1
	arg_5_0._target.originData.posY = arg_5_2
end

function var_0_0.moveTo(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if arg_6_0._target.avatar and arg_6_0._target.avatar.sceneTf then
		local var_6_0, var_6_1, var_6_2 = Va3ChessGameController.instance:calcTilePosInScene(arg_6_1, arg_6_2, arg_6_0._target.avatar.order, true)
		local var_6_3 = arg_6_0._target.avatar

		arg_6_0:killMoveTween()

		arg_6_0._moveCallback = arg_6_3
		arg_6_0._moveCallbackObj = arg_6_4
		arg_6_0._tweenIdMoveScene = ZProj.TweenHelper.DOLocalMove(var_6_3.sceneTf, var_6_0, var_6_1, var_6_2, 0.225, arg_6_0.onMoveCompleted, arg_6_0, nil, EaseType.Linear)

		arg_6_0:onMoveBegin()

		local var_6_4 = Va3ChessMapUtils.ToDirection(arg_6_0._srcX, arg_6_0._srcY, arg_6_1, arg_6_2)

		arg_6_0:faceTo(var_6_4)
		arg_6_0:_setDirNodeShow(false)
	elseif arg_6_3 then
		arg_6_3(arg_6_4)
	end
end

function var_0_0.faceTo(arg_7_0, arg_7_1)
	arg_7_0._curDir = arg_7_1

	if arg_7_0._target.avatar then
		if not Va3ChessInteractObject.DirectionSet[arg_7_0._curDir] then
			return
		end

		for iter_7_0, iter_7_1 in ipairs(Va3ChessInteractObject.DirectionList) do
			local var_7_0 = arg_7_0._target.avatar["goFaceTo" .. iter_7_1]

			if not gohelper.isNil(var_7_0) then
				gohelper.setActive(var_7_0, arg_7_1 == iter_7_1)
			end

			local var_7_1 = arg_7_0._target.avatar["goMovetoDir" .. iter_7_1]

			if not gohelper.isNil(var_7_1) then
				gohelper.setActive(var_7_1, arg_7_1 == iter_7_1)
			end
		end

		if arg_7_0._target.originData then
			arg_7_0._target.originData:setDirection(arg_7_1)
		end
	end

	if arg_7_0._target.chessEffectObj and arg_7_0._target.chessEffectObj.refreshEffectFaceTo then
		arg_7_0._target.chessEffectObj:refreshEffectFaceTo()
	end
end

function var_0_0._setDirNodeShow(arg_8_0, arg_8_1)
	if arg_8_0._target.avatar then
		local var_8_0 = arg_8_0._target.avatar.goNextDirection

		if not gohelper.isNil(var_8_0) then
			gohelper.setActive(var_8_0, arg_8_1)
		end
	end
end

function var_0_0.onMoveBegin(arg_9_0)
	return
end

function var_0_0.onMoveCompleted(arg_10_0)
	arg_10_0:_setDirNodeShow(true)

	if arg_10_0._moveCallback then
		local var_10_0 = arg_10_0._moveCallback
		local var_10_1 = arg_10_0._moveCallbackObj

		arg_10_0._moveCallback = nil
		arg_10_0._moveCallbackObj = nil

		var_10_0(var_10_1)
	end
end

function var_0_0.onDrawAlert(arg_11_0, arg_11_1)
	return
end

function var_0_0.setAlertActive(arg_12_0, arg_12_1)
	return
end

function var_0_0.onAvatarLoaded(arg_13_0)
	local var_13_0 = arg_13_0._curDir or arg_13_0._target.originData.direction

	if var_13_0 ~= nil and var_13_0 ~= 0 then
		arg_13_0:faceTo(var_13_0)
	end
end

function var_0_0.killMoveTween(arg_14_0)
	if arg_14_0._tweenIdMoveScene then
		ZProj.TweenHelper.KillById(arg_14_0._tweenIdMoveScene)

		arg_14_0._tweenIdMoveScene = nil
	end
end

function var_0_0.dispose(arg_15_0)
	arg_15_0:killMoveTween()
end

return var_0_0
