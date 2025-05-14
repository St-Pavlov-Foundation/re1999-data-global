module("modules.logic.reddot.controller.RedDotController", package.seeall)

local var_0_0 = class("RedDotController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0._checkExpire, arg_2_0)
end

function var_0_0.onInitFinish(arg_3_0)
	return
end

function var_0_0.addConstEvents(arg_4_0)
	return
end

function var_0_0.addNotEventRedDot(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_5_1, CommonRedDotIconNoEvent)

	var_5_0:setShowType(arg_5_4)
	var_5_0:setCheckShowRedDotFunc(arg_5_2, arg_5_3)

	return var_5_0
end

function var_0_0.addRedDotTag(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	local var_6_0 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_6_1, CommonRedDotTag)

	var_6_0:setId(arg_6_2, arg_6_3)
	var_6_0:overrideRefreshDotFunc(arg_6_4, arg_6_5)
	var_6_0:refreshDot()

	return var_6_0
end

function var_0_0.addRedDot(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	return arg_7_0:addMultiRedDot(arg_7_1, {
		{
			id = arg_7_2,
			uid = arg_7_3
		}
	}, arg_7_4, arg_7_5)
end

function var_0_0.addMultiRedDot(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = MonoHelper.getLuaComFromGo(arg_8_1, CommonRedDotIcon) or MonoHelper.addNoUpdateLuaComOnceToGo(arg_8_1, CommonRedDotIcon)

	var_8_0:setMultiId(arg_8_2)
	var_8_0:overrideRefreshDotFunc(arg_8_3, arg_8_4)
	var_8_0:refreshDot()

	return var_8_0
end

function var_0_0.getRedDotComp(arg_9_0, arg_9_1)
	return (MonoHelper.getLuaComFromGo(arg_9_1, CommonRedDotIcon))
end

function var_0_0.CheckExpireDot(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._checkExpire, arg_10_0)
	TaskDispatcher.runRepeat(arg_10_0._checkExpire, arg_10_0, 1)
end

function var_0_0._checkExpire(arg_11_0)
	local var_11_0 = RedDotModel.instance:getLatestExpireTime()

	if var_11_0 == 0 then
		TaskDispatcher.cancelTask(arg_11_0._checkExpire, arg_11_0)

		return
	end

	if var_11_0 <= ServerTime.now() then
		TaskDispatcher.cancelTask(arg_11_0._checkExpire, arg_11_0)
		RedDotRpc.instance:sendGetRedDotInfosRequest()
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
