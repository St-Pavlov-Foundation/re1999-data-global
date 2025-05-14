module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractDestroyable", package.seeall)

local var_0_0 = class("Va3ChessInteractDestroyable", Va3ChessInteractBase)

function var_0_0.onAvatarLoaded(arg_1_0)
	var_0_0.super.onAvatarLoaded(arg_1_0)

	local var_1_0 = arg_1_0._target.avatar.loader

	if not var_1_0 then
		return
	end

	local var_1_1 = var_1_0:getInstGO()

	if not gohelper.isNil(var_1_1) then
		arg_1_0._animSelf = var_1_1:GetComponent(typeof(UnityEngine.Animator))
	end

	arg_1_0._target.interoperableFlag = gohelper.findChild(var_1_1, "icon")
end

local var_0_1 = "switch"

function var_0_0.playDeleteObjView(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.Role2ChessGame1_3.BreakBoughs)

	if arg_2_0._animSelf then
		arg_2_0._animSelf:Play(var_0_1)
	end
end

function var_0_0.showStateView(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == Va3ChessEnum.ObjState.Idle then
		arg_3_0:showIdleStateView()
	elseif arg_3_1 == Va3ChessEnum.ObjState.Interoperable then
		arg_3_0:showInteroperableStateView(arg_3_2)
	end
end

function var_0_0.showIdleStateView(arg_4_0)
	gohelper.setActive(arg_4_0._target.interoperableFlag, false)
end

function var_0_0.showInteroperableStateView(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0._target.interoperableFlag, true)
end

return var_0_0
