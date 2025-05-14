module("modules.logic.versionactivity1_2.yaxian.controller.game.interacts.YaXianInteractTriggerFailHandle", package.seeall)

local var_0_0 = class("YaXianInteractTriggerFailHandle", YaXianInteractHandleBase)

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

	var_0_0.insertToAlertMap(arg_2_1, var_2_0 + 1, var_2_1)
	var_0_0.insertToAlertMap(arg_2_1, var_2_0 - 1, var_2_1)
	var_0_0.insertToAlertMap(arg_2_1, var_2_0, var_2_1 + 1)
	var_0_0.insertToAlertMap(arg_2_1, var_2_0, var_2_1 - 1)
end

function var_0_0.insertToAlertMap(arg_3_0, arg_3_1, arg_3_2)
	if YaXianGameController.instance:posCanWalk(arg_3_1, arg_3_2) then
		arg_3_0[arg_3_1] = arg_3_0[arg_3_1] or {}
		arg_3_0[arg_3_1][arg_3_2] = true
	end
end

function var_0_0.moveTo(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0._enableAlarm = false

	var_0_0.super.moveTo(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	YaXianGameController.instance:dispatchEvent(ActivityChessEvent.RefreshAlarmArea)
end

function var_0_0.onMoveCompleted(arg_5_0)
	var_0_0.super.onMoveCompleted(arg_5_0)

	arg_5_0._enableAlarm = true

	YaXianGameController.instance:dispatchEvent(ActivityChessEvent.RefreshAlarmArea)
end

function var_0_0.onAvatarLoaded(arg_6_0)
	var_0_0.super.onAvatarLoaded(arg_6_0)
	YaXianGameController.instance:dispatchEvent(ActivityChessEvent.RefreshAlarmArea)
end

function var_0_0.dispose(arg_7_0)
	arg_7_0._enableAlarm = false

	var_0_0.super.dispose(arg_7_0)
	YaXianGameController.instance:dispatchEvent(ActivityChessEvent.RefreshAlarmArea)
end

return var_0_0
