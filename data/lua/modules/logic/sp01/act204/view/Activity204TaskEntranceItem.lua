module("modules.logic.sp01.act204.view.Activity204TaskEntranceItem", package.seeall)

local var_0_0 = class("Activity204TaskEntranceItem", Activity204EntranceItemBase)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._golimitTask = gohelper.findChild(arg_1_0.go, "root/#gp_limitTask")
end

function var_0_0.addEventListeners(arg_2_0)
	var_0_0.super.addEventListeners(arg_2_0)
	arg_2_0:addEventCb(Activity204Controller.instance, Activity204Event.UpdateTask, arg_2_0._onUpdateTask, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	var_0_0.super.removeEventListeners(arg_3_0)
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	var_0_0.super.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0:_chcekHasAnyLimitTask()
end

function var_0_0._onUpdateTask(arg_5_0)
	arg_5_0:_chcekHasAnyLimitTask()
	arg_5_0:updateReddot()
end

function var_0_0._chcekHasAnyLimitTask(arg_6_0)
	local var_6_0 = Activity204Model.instance:getActMo(arg_6_0._actId)

	if not var_6_0 then
		return
	end

	gohelper.setActive(arg_6_0._golimitTask, var_6_0:hasAnyLimitTask())
end

function var_0_0.updateReddot(arg_7_0)
	if arg_7_0._actCfg and arg_7_0._actCfg.redDotId ~= 0 then
		RedDotController.instance:addRedDot(arg_7_0._goRedPoint, arg_7_0._actCfg.redDotId, nil, arg_7_0.checkReddotFunc, arg_7_0)
	end
end

function var_0_0.checkReddotFunc(arg_8_0, arg_8_1)
	arg_8_1:defaultRefreshDot()

	arg_8_1.show = arg_8_1.show or Activity204Model.instance:hasNewTask(arg_8_0._actId)

	local var_8_0 = RedDotConfig.instance:getRedDotCO(arg_8_0._actCfg.redDotId)
	local var_8_1 = var_8_0 and var_8_0.style

	arg_8_1:showRedDot(var_8_1)
end

return var_0_0
