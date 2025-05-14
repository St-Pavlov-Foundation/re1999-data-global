module("modules.logic.guide.controller.action.BaseGuideAction", package.seeall)

local var_0_0 = class("BaseGuideAction", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.guideId = arg_1_1
	arg_1_0.stepId = arg_1_2
	arg_1_0.actionParam = arg_1_3
end

function var_0_0.checkGuideLock(arg_2_0)
	local var_2_0 = GuideModel.instance:getLockGuideId()

	if not var_2_0 then
		return false
	end

	return var_2_0 ~= arg_2_0.guideId
end

function var_0_0.onStart(arg_3_0, arg_3_1)
	logNormal(string.format("<color=#EA00B3>start guide_%d_%d %s</color>", arg_3_0.guideId, arg_3_0.stepId, arg_3_0.__cname))
	GuideBlockMgr.instance:startBlock()

	arg_3_0.context = arg_3_1
	arg_3_0.status = WorkStatus.Running
end

function var_0_0.onDestroy(arg_4_0)
	logNormal(string.format("<color=#EA00B3>destroy guide_%d_%d %s</color>", arg_4_0.guideId, arg_4_0.stepId, arg_4_0.__cname))
	GuideBlockMgr.instance:startBlock()
	var_0_0.super.onDestroy(arg_4_0)
end

return var_0_0
