module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepCardEffectStatue", package.seeall)

local var_0_0 = VersionActivity2_6Enum.ActivityId.Xugouji
local var_0_1 = class("XugoujiGameStepCardEffectStatue", XugoujiGameStepBase)

function var_0_1.start(arg_1_0)
	local var_1_0 = arg_1_0._stepData.uid
	local var_1_1 = arg_1_0._stepData.status
	local var_1_2 = arg_1_0._stepData.isAdd

	Activity188Model.instance:updateCardEffectStatus(var_1_0, var_1_2, var_1_1)
	TaskDispatcher.runDelay(arg_1_0._doCardEffect, arg_1_0, 0.35)
end

function var_0_1._doCardEffect(arg_2_0)
	local var_2_0 = arg_2_0._stepData.uid

	if not Activity188Model.instance:getCardInfo(var_2_0) then
		arg_2_0.finish()
	end

	XugoujiController.instance:dispatchEvent(XugoujiEvent.CardEffectStatusUpdated, var_2_0)
	arg_2_0:_onCardEffectActionDone()
end

function var_0_1._onCardEffectActionDone(arg_3_0)
	TaskDispatcher.runDelay(arg_3_0.finish, arg_3_0, 0.5)
end

function var_0_1.finish(arg_4_0)
	var_0_1.super.finish(arg_4_0)
end

function var_0_1.dispose(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._doCardEffect, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.finish, arg_5_0)
	XugoujiGameStepBase.dispose(arg_5_0)
end

return var_0_1
