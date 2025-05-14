module("modules.logic.activity.controller.ActivityBeginnerController", package.seeall)

local var_0_0 = class("ActivityBeginnerController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:_initHandlers()
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0._initHandlers(arg_3_0)
	if arg_3_0._handlerList then
		return
	end

	arg_3_0._handlerList = {
		[ActivityEnum.Activity.StoryShow] = {
			arg_3_0.checkRedDotWithActivityId,
			arg_3_0.checkFirstEnter
		},
		[ActivityEnum.Activity.DreamShow] = {
			arg_3_0.checkRedDot,
			arg_3_0.checkFirstEnter
		},
		[ActivityEnum.Activity.ClassShow] = {
			arg_3_0.checkRedDotWithActivityId,
			arg_3_0.checkFirstEnter
		},
		[ActivityEnum.Activity.V2a4_WarmUp] = {
			arg_3_0.checkRedDotWithActivityId,
			Activity125Controller.checkRed_Task
		}
	}
	arg_3_0._defaultHandler = {
		arg_3_0.checkRedDotWithActivityId
	}
end

function var_0_0.showRedDot(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._handlerList[arg_4_1]

	if not var_4_0 then
		if arg_4_1 == DoubleDropModel.instance:getActId() then
			var_4_0 = arg_4_0._handlerList[ActivityEnum.Activity.ClassShow]
		else
			var_4_0 = arg_4_0._defaultHandler
		end
	end

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if iter_4_1(arg_4_0, arg_4_1) then
			return true
		end
	end

	return false
end

function var_0_0._getRedDotId(arg_5_0, arg_5_1)
	local var_5_0 = ActivityConfig.instance:getActivityCo(arg_5_1)

	if not var_5_0 then
		return 0
	end

	local var_5_1 = var_5_0.redDotId

	if var_5_1 > 0 then
		return var_5_1
	end

	local var_5_2 = var_5_0.showCenter
	local var_5_3 = ActivityConfig.instance:getActivityCenterCo(var_5_2)

	if not var_5_3 then
		return 0
	end

	return var_5_3.reddotid
end

function var_0_0.checkRedDot(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:_getRedDotId(arg_6_1)

	if var_6_0 > 0 then
		return RedDotModel.instance:isDotShow(var_6_0)
	end

	return false
end

function var_0_0.checkRedDotWithActivityId(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:_getRedDotId(arg_7_1)

	if var_7_0 > 0 then
		return RedDotModel.instance:isDotShow(var_7_0, arg_7_1)
	end

	return false
end

function var_0_0.checkFirstEnter(arg_8_0, arg_8_1)
	local var_8_0 = PlayerPrefsKey.FirstEnterActivityShow .. "#" .. tostring(arg_8_1) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
	local var_8_1 = PlayerPrefsHelper.getString(var_8_0, "")

	return string.nilorempty(var_8_1)
end

function var_0_0.setFirstEnter(arg_9_0, arg_9_1)
	local var_9_0 = PlayerPrefsKey.FirstEnterActivityShow .. "#" .. tostring(arg_9_1) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)

	PlayerPrefsHelper.setString(var_9_0, "hasEnter")
end

function var_0_0.checkActivityNewStage(arg_10_0, arg_10_1)
	return ActivityModel.instance:getActivityInfo()[arg_10_1]:isNewStageOpen()
end

var_0_0.instance = var_0_0.New()

return var_0_0
