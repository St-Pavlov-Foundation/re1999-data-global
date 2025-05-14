module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractTrap", package.seeall)

local var_0_0 = class("Va3ChessInteractTrap", Va3ChessInteractBase)

function var_0_0.showStateView(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_1 == Va3ChessEnum.ObjState.Idle then
		arg_1_0:showIdleStateView()
	elseif arg_1_1 == Va3ChessEnum.ObjState.Interoperable then
		arg_1_0:showInteroperableStateView(arg_1_2)
	end
end

function var_0_0.showIdleStateView(arg_2_0)
	local var_2_0 = arg_2_0._target.originData.posX
	local var_2_1 = arg_2_0._target.originData.posY

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmAreaOnXY, var_2_0, var_2_1, false)
end

function var_0_0.showInteroperableStateView(arg_3_0, arg_3_1)
	if arg_3_1.objType == Va3ChessEnum.InteractType.Player then
		local var_3_0 = arg_3_0._target.originData.posX
		local var_3_1 = arg_3_0._target.originData.posY

		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmAreaOnXY, var_3_0, var_3_1, true)
	end
end

function var_0_0.playDeleteObjView(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.Role2ChessGame1_3.DeductHp)
end

function var_0_0.dispose(arg_5_0)
	arg_5_0:showIdleStateView()
	var_0_0.super.dispose(arg_5_0)
end

return var_0_0
