module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractPedal", package.seeall)

local var_0_0 = class("Va3ChessInteractPedal", Va3ChessInteractBase)
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = {
	Down = "donw",
	Up = "up",
	DownIdle = "down_idle",
	UpIdle = "up_idle"
}

function var_0_0.refreshPedalStatus(arg_1_0)
	local var_1_0 = (arg_1_0._target.originData:getPedalStatusInDataField() or var_0_1) == var_0_2

	if arg_1_0._isPress == var_1_0 then
		return
	end

	arg_1_0._isPress = var_1_0

	if arg_1_0._isPress then
		arg_1_0:playAnima(var_0_3.Down, 0, 0)
	else
		arg_1_0:playAnima(var_0_3.Up, 0, 0)
	end
end

function var_0_0.onAvatarLoaded(arg_2_0)
	var_0_0.super.onAvatarLoaded(arg_2_0)

	local var_2_0 = arg_2_0._target.avatar.loader

	if not var_2_0 then
		return
	end

	local var_2_1 = var_2_0:getInstGO()

	if not gohelper.isNil(var_2_1) then
		arg_2_0._animSelf = var_2_1:GetComponent(typeof(UnityEngine.Animator))
	end

	arg_2_0:playAnima(var_0_3.UpIdle, 0, 1)
end

function var_0_0.playAnima(arg_3_0, arg_3_1, ...)
	if arg_3_0._animSelf then
		arg_3_0._animSelf:Play(arg_3_1, ...)
	end
end

function var_0_0.dispose(arg_4_0)
	var_0_0.super.dispose(arg_4_0)
end

return var_0_0
