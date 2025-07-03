module("modules.logic.activitywelfare.model.Activity160Model", package.seeall)

local var_0_0 = class("Activity160Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.infoDic = {}
end

function var_0_0.setInfo(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.activityId
	local var_3_1 = arg_3_0:getActInfo(var_3_0)

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.act160Infos) do
		var_3_1[iter_3_1.id] = iter_3_1
	end

	Activity160Controller.instance:dispatchEvent(Activity160Event.InfoUpdate, var_3_0)
end

function var_0_0.updateInfo(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.activityId

	arg_4_0:getActInfo(var_4_0)[arg_4_1.act160Info.id] = arg_4_1.act160Info

	Activity160Controller.instance:dispatchEvent(Activity160Event.InfoUpdate, var_4_0)
end

function var_0_0.finishMissionReply(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.activityId

	arg_5_0:getActInfo(var_5_0)[arg_5_1.act160Info.id] = arg_5_1.act160Info

	Activity160Controller.instance:dispatchEvent(Activity160Event.InfoUpdate, var_5_0)

	if arg_5_1.isReadMail then
		Activity160Controller.instance:dispatchEvent(Activity160Event.HasReadMail, var_5_0, arg_5_1.act160Info.id)
	end
end

function var_0_0.getActInfo(arg_6_0, arg_6_1)
	if not arg_6_0.infoDic[arg_6_1] then
		arg_6_0.infoDic[arg_6_1] = {}
	end

	return arg_6_0.infoDic[arg_6_1]
end

function var_0_0.getCurMission(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getActInfo(arg_7_1)

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if iter_7_1.state ~= 2 then
			return iter_7_0
		end
	end

	return var_7_0[#var_7_0].id
end

function var_0_0.hasRewardClaim(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getActInfo(arg_8_1)

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		if iter_8_1.state == 1 then
			return true
		end
	end

	return false
end

function var_0_0.hasRewardCanGet(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getActInfo(arg_9_1)

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		if iter_9_1.state ~= 2 then
			return true
		end
	end

	return false
end

function var_0_0.allRewardReceive(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getActInfo(arg_10_1)

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		if iter_10_1.state ~= 2 then
			return false
		end
	end

	return true
end

function var_0_0.isMissionCanGet(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0:getActInfo(arg_11_1)

	return var_11_0[arg_11_2] and var_11_0[arg_11_2].state == 1
end

function var_0_0.isMissionFinish(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0:getActInfo(arg_12_1)

	return var_12_0[arg_12_2] and var_12_0[arg_12_2].state == 2
end

var_0_0.instance = var_0_0.New()

return var_0_0
