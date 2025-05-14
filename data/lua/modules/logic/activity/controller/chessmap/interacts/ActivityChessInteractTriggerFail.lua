module("modules.logic.activity.controller.chessmap.interacts.ActivityChessInteractTriggerFail", package.seeall)

local var_0_0 = class("ActivityChessInteractTriggerFail", ActivityChessInteractBase)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._enableAlarm = true
end

function var_0_0.onDrawAlert(arg_2_0, arg_2_1)
	if not arg_2_0._enableAlarm then
		return
	end

	local var_2_0 = arg_2_0._target.originData.posX
	local var_2_1 = arg_2_0._target.originData.posY

	var_0_0.insertToAlertMap(arg_2_1, var_2_0, var_2_1)

	if arg_2_0._target.originData.data and arg_2_0._target.originData.data.alertArea then
		local var_2_2 = arg_2_0._target.originData.data.alertArea

		if #var_2_2 == 1 then
			local var_2_3 = var_2_2[1].x
			local var_2_4 = var_2_2[1].y
			local var_2_5 = arg_2_0._target.originData.posX
			local var_2_6 = arg_2_0._target.originData.posY
			local var_2_7 = ActivityChessMapUtils.ToDirection(var_2_5, var_2_6, var_2_3, var_2_4)

			arg_2_0:faceTo(var_2_7)
		end
	end
end

function var_0_0.insertToAlertMap(arg_3_0, arg_3_1, arg_3_2)
	if ActivityChessGameModel.instance:isPosInChessBoard(arg_3_1, arg_3_2) and ActivityChessGameModel.instance:getBaseTile(arg_3_1, arg_3_2) ~= ActivityChessEnum.TileBaseType.None then
		arg_3_0[arg_3_1] = arg_3_0[arg_3_1] or {}
		arg_3_0[arg_3_1][arg_3_2] = true
	end
end

function var_0_0.moveTo(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0._enableAlarm = false
	arg_4_0._moveTargetX = arg_4_1
	arg_4_0._moveTargetY = arg_4_2

	var_0_0.super.moveTo(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.RefreshAlarmArea)
end

function var_0_0.onMoveCompleted(arg_5_0)
	var_0_0.super.onMoveCompleted(arg_5_0)

	arg_5_0._enableAlarm = true

	if ActivityChessGameController.instance:searchInteractByPos(arg_5_0._moveTargetX, arg_5_0._moveTargetY, ActivityChessGameController.filterSelectable) > 0 then
		AudioMgr.instance:trigger(AudioEnum.ChessGame.SheriffCatch)
	end

	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.RefreshAlarmArea)
end

function var_0_0.onAvatarLoaded(arg_6_0)
	var_0_0.super.onAvatarLoaded(arg_6_0)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.RefreshAlarmArea)
end

function var_0_0.dispose(arg_7_0)
	arg_7_0._enableAlarm = false

	var_0_0.super.dispose(arg_7_0)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.RefreshAlarmArea)
end

return var_0_0
