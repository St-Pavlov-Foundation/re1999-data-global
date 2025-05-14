module("modules.logic.versionactivity1_6.decalogpresent.model.DecalogPresentModel", package.seeall)

local var_0_0 = class("DecalogPresentModel", BaseModel)

var_0_0.REWARD_INDEX = 1

function var_0_0.getDecalogPresentActId(arg_1_0)
	return ActivityEnum.Activity.V2a5_DecaLogPresent
end

function var_0_0.isDecalogPresentOpen(arg_2_0)
	local var_2_0 = false
	local var_2_1 = arg_2_0:getDecalogPresentActId()

	if ActivityType101Model.instance:isOpen(var_2_1) then
		var_2_0 = true
	end

	return var_2_0
end

function var_0_0.isShowRedDot(arg_3_0)
	local var_3_0 = false
	local var_3_1 = arg_3_0:getDecalogPresentActId()

	if ActivityType101Model.instance:isOpen(var_3_1) then
		var_3_0 = ActivityType101Model.instance:isType101RewardCouldGetAnyOne(var_3_1)
	end

	return var_3_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
