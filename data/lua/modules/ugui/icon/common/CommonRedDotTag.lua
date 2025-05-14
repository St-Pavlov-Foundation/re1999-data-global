module("modules.ugui.icon.common.CommonRedDotTag", package.seeall)

local var_0_0 = class("CommonRedDotTag", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1

	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, arg_1_0.refreshRelateDot, arg_1_0)
end

function var_0_0.refreshDot(arg_2_0)
	if arg_2_0.overrideFunc then
		local var_2_0, var_2_1 = pcall(arg_2_0.overrideFunc, arg_2_0.overrideFuncObj, arg_2_0)

		if not var_2_0 then
			logError(string.format("CommonRedDotTag:overrideFunc dotId:%s error:%s", arg_2_0.dotId, var_2_1))
		end

		return
	end

	local var_2_2 = RedDotModel.instance:isDotShow(arg_2_0.dotId, 0)

	if arg_2_0.reverse then
		var_2_2 = not var_2_2
	end

	gohelper.setActive(arg_2_0.go, var_2_2)
end

function var_0_0.refreshRelateDot(arg_3_0, arg_3_1)
	arg_3_0:refreshDot()
end

function var_0_0.setScale(arg_4_0, arg_4_1)
	transformhelper.setLocalScale(arg_4_0.go.transform, arg_4_1, arg_4_1, arg_4_1)
end

function var_0_0.setId(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.dotId = arg_5_1
	arg_5_0.reverse = arg_5_2
end

function var_0_0.overrideRefreshDotFunc(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.overrideFunc = arg_6_1
	arg_6_0.overrideFuncObj = arg_6_2
end

function var_0_0.onDestroy(arg_7_0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, arg_7_0.refreshRelateDot, arg_7_0)
end

return var_0_0
