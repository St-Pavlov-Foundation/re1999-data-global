module("modules.logic.guide.controller.GuidePriorityController", package.seeall)

local var_0_0 = class("GuidePriorityController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._guideIdList = {}
	arg_1_0._guideObjDict = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._guideIdList = {}
	arg_2_0._guideObjDict = {}

	TaskDispatcher.cancelTask(arg_2_0._onFrame, arg_2_0)
end

function var_0_0.add(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = arg_3_4 and arg_3_4 > 0 and arg_3_4 or 0.01
	local var_3_1 = Time.time

	arg_3_0._guideObjDict[arg_3_1] = {
		guideId = arg_3_1,
		callback = arg_3_2,
		callbackObj = arg_3_3,
		time = var_3_1 + var_3_0
	}

	if not tabletool.indexOf(arg_3_0._guideIdList, arg_3_1) then
		table.insert(arg_3_0._guideIdList, arg_3_1)
	end

	local var_3_2 = var_3_0

	for iter_3_0, iter_3_1 in pairs(arg_3_0._guideObjDict) do
		if var_3_2 < iter_3_1.time - var_3_1 then
			var_3_2 = iter_3_1.time - var_3_1
		end
	end

	TaskDispatcher.cancelTask(arg_3_0._onTimeEnd, arg_3_0)
	TaskDispatcher.runDelay(arg_3_0._onTimeEnd, arg_3_0, var_3_2)
end

function var_0_0.remove(arg_4_0, arg_4_1)
	arg_4_0._guideObjDict[arg_4_1] = nil

	tabletool.removeValue(arg_4_0._guideIdList, arg_4_1)
end

function var_0_0._onTimeEnd(arg_5_0)
	if #arg_5_0._guideIdList == 0 then
		return
	end

	local var_5_0 = arg_5_0._guideIdList
	local var_5_1 = arg_5_0._guideObjDict

	arg_5_0._guideIdList = {}
	arg_5_0._guideObjDict = {}

	local var_5_2 = var_5_1[GuideConfig.instance:getHighestPriorityGuideId(var_5_0)]

	if var_5_2 then
		var_5_2.callback(var_5_2.callbackObj)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
