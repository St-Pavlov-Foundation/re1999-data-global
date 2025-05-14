module("modules.logic.versionactivity1_4.act136.model.Activity136Model", package.seeall)

local var_0_0 = class("Activity136Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.setActivityInfo(arg_3_0, arg_3_1)
	arg_3_0.curActivity136Id = arg_3_1.activityId
	arg_3_0.alreadyReceivedCharacterId = arg_3_1.selectHeroId

	Activity136Controller.instance:dispatchEvent(Activity136Event.ActivityDataUpdate)
end

function var_0_0.isActivity136InOpen(arg_4_0, arg_4_1)
	local var_4_0 = false
	local var_4_1 = arg_4_0:getCurActivity136Id()

	if var_4_1 then
		local var_4_2, var_4_3, var_4_4 = ActivityHelper.getActivityStatusAndToast(var_4_1)

		if var_4_2 == ActivityEnum.ActivityStatus.Normal then
			var_4_0 = true
		elseif var_4_3 and arg_4_1 then
			GameFacade.showToastWithTableParam(var_4_3, var_4_4)
		end
	end

	return var_4_0
end

function var_0_0.hasReceivedCharacter(arg_5_0)
	local var_5_0 = arg_5_0:getAlreadyReceivedCharacterId()

	return var_5_0 and var_5_0 ~= 0
end

function var_0_0.isShowRedDot(arg_6_0)
	local var_6_0 = false

	if arg_6_0:isActivity136InOpen() then
		var_6_0 = not arg_6_0:hasReceivedCharacter()
	end

	return var_6_0
end

function var_0_0.getAlreadyReceivedCharacterId(arg_7_0)
	return arg_7_0.alreadyReceivedCharacterId
end

function var_0_0.getCurActivity136Id(arg_8_0)
	return arg_8_0.curActivity136Id
end

function var_0_0.clear(arg_9_0)
	arg_9_0.curActivity136Id = nil
	arg_9_0.alreadyReceivedCharacterId = 0

	var_0_0.super.clear(arg_9_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
