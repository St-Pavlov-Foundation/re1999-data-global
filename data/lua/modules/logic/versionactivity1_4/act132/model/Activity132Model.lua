module("modules.logic.versionactivity1_4.act132.model.Activity132Model", package.seeall)

local var_0_0 = class("Activity132Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.setActivityInfo(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0:getActMoById(arg_3_1.activityId)

	if var_3_0 then
		var_3_0:init(arg_3_1)
	end
end

function var_0_0.getActMoById(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return
	end

	local var_4_0 = arg_4_0:getById(arg_4_1)

	if not var_4_0 then
		var_4_0 = Activity132Mo.New(arg_4_1)

		arg_4_0:addAtLast(var_4_0)
	end

	return var_4_0
end

function var_0_0.getContentState(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:getActMoById(arg_5_1)

	if not var_5_0 then
		return
	end

	return var_5_0:getContentState(arg_5_2)
end

function var_0_0.setSelectCollectId(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:getActMoById(arg_6_1)

	if not var_6_0 then
		return
	end

	var_6_0:setSelectCollectId(arg_6_2)
	Activity132Controller.instance:dispatchEvent(Activity132Event.OnChangeCollect)
end

function var_0_0.getSelectCollectId(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getActMoById(arg_7_1)

	if not var_7_0 then
		return
	end

	return var_7_0:getSelectCollectId()
end

function var_0_0.setContentUnlock(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getActMoById(arg_8_1.activityId)

	if not var_8_0 then
		return
	end

	return var_8_0:setContentUnlock(arg_8_1.contentId)
end

function var_0_0.checkClueRed(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:getActMoById(arg_9_1)

	if not var_9_0 then
		return
	end

	return var_9_0:checkClueRed(arg_9_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
