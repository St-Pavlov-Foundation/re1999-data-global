module("modules.logic.survival.controller.work.SurvivalDailyReportPushWork", package.seeall)

local var_0_0 = class("SurvivalDailyReportPushWork", SurvivalMsgPushWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	SurvivalModel.instance:setDailyReport(arg_1_0._msg.json)
	SurvivalController.instance:_getInfo()
	arg_1_0:onDone(true)
end

function var_0_0.onViewClose(arg_2_0, arg_2_1)
	if arg_2_1 == ViewName.SurvivalReportView then
		arg_2_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_3_0)
	var_0_0.super.clearWork(arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_3_0.onViewClose, arg_3_0)
end

return var_0_0
