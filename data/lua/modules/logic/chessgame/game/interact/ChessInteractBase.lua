module("modules.logic.chessgame.game.interact.ChessInteractBase", package.seeall)

local var_0_0 = class("ChessInteractBase")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._target = arg_1_1
	arg_1_0._isMoving = false
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
	arg_5_0._srcX, arg_5_0._srcY = arg_5_0._target.mo.posX, arg_5_0._target.mo.posY
	arg_5_0._target.mo.posX = arg_5_1
	arg_5_0._target.mo.posY = arg_5_2
end

function var_0_0.moveTo(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if arg_6_0._target.avatar then
		local var_6_0 = {
			z = 0,
			x = arg_6_1,
			y = arg_6_2
		}
		local var_6_1 = ChessGameHelper.nodePosToWorldPos(var_6_0)
		local var_6_2 = arg_6_0._target.avatar

		arg_6_0:killMoveTween()

		arg_6_0._moveCallback = arg_6_3
		arg_6_0._moveCallbackObj = arg_6_4
		arg_6_0._isMoving = true
		arg_6_0._tweenIdMoveScene = ZProj.TweenHelper.DOLocalMove(var_6_2.sceneTf, var_6_1.x, var_6_1.y, var_6_1.z, 0.225, arg_6_0.onMoveCompleted, arg_6_0, nil, EaseType.Linear)

		arg_6_0:onMoveBegin()

		local var_6_3 = ChessGameHelper.ToDirection(arg_6_0._srcX or arg_6_0._target.mo.posX, arg_6_0._srcY or arg_6_0._target.mo.posY, arg_6_1, arg_6_2)

		arg_6_0:faceTo(var_6_3)
		arg_6_0:_setDirNodeShow(false)
	elseif arg_6_3 then
		arg_6_3(arg_6_4)
	end
end

function var_0_0.faceTo(arg_7_0, arg_7_1)
	arg_7_0._curDir = arg_7_1

	if arg_7_0._target.avatar then
		if not ChessInteractComp.DirectionSet[arg_7_0._curDir] then
			return
		end

		for iter_7_0, iter_7_1 in ipairs(ChessInteractComp.DirectionList) do
			local var_7_0 = arg_7_0._target.avatar["goFaceTo" .. iter_7_1]

			if not gohelper.isNil(var_7_0) then
				local var_7_1 = arg_7_1 == iter_7_1

				gohelper.setActive(var_7_0, var_7_1)
			end

			local var_7_2 = arg_7_0._target.avatar["goMovetoDir" .. iter_7_1]

			if not gohelper.isNil(var_7_2) then
				gohelper.setActive(var_7_2, arg_7_1 == iter_7_1)
			end
		end

		if arg_7_0._target.mo then
			arg_7_0._target.mo:setDirection(arg_7_1)
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
	arg_10_0:refreshAlarmArea()

	if arg_10_0._moveCallback then
		local var_10_0 = arg_10_0._moveCallback
		local var_10_1 = arg_10_0._moveCallbackObj

		arg_10_0._moveCallback = nil
		arg_10_0._moveCallbackObj = nil
		arg_10_0._isMoving = false

		var_10_0(var_10_1)
	end
end

function var_0_0.onDrawAlert(arg_11_0, arg_11_1)
	return
end

function var_0_0.setAlertActive(arg_12_0, arg_12_1)
	return
end

function var_0_0.refreshAlarmArea(arg_13_0)
	return
end

function var_0_0.onAvatarLoaded(arg_14_0)
	local var_14_0 = arg_14_0._curDir or arg_14_0._target.mo.direction or arg_14_0._target.mo:getConfig().dir

	if var_14_0 ~= nil and var_14_0 ~= 0 then
		arg_14_0:faceTo(var_14_0)
	end

	local var_14_1 = arg_14_0._target.avatar.loader

	if not var_14_1 then
		return
	end

	local var_14_2 = var_14_1:getInstGO()

	if not gohelper.isNil(var_14_2) then
		arg_14_0._animSelf = var_14_2:GetComponent(typeof(UnityEngine.Animator))
	end
end

function var_0_0.showDestoryAni(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0._animSelf then
		arg_15_0._animSelf:Update(0)
		arg_15_0._animSelf:Play("close", 0, 0)

		arg_15_0._closeAnimCallback = arg_15_1
		arg_15_0._closeAnimCallbackObj = arg_15_2

		TaskDispatcher.runDelay(arg_15_0._closeAnimCallback, arg_15_0._closeAnimCallbackObj, ChessGameEnum.CloseAnimTime)
	else
		arg_15_1(arg_15_2)
	end
end

function var_0_0.killMoveTween(arg_16_0)
	if arg_16_0._tweenIdMoveScene then
		ZProj.TweenHelper.KillById(arg_16_0._tweenIdMoveScene)

		arg_16_0._tweenIdMoveScene = nil
	end
end

function var_0_0.dispose(arg_17_0)
	arg_17_0:killMoveTween()
	TaskDispatcher.cancelTask(arg_17_0._closeAnimCallback, arg_17_0._closeAnimCallbackObj, ChessGameEnum.CloseAnimTime)
end

return var_0_0
