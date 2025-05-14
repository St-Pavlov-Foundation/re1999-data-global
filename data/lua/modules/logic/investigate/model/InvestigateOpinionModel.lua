module("modules.logic.investigate.model.InvestigateOpinionModel", package.seeall)

local var_0_0 = class("InvestigateOpinionModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._isInitOpinionInfo = false
	arg_1_0._connectedId = {}
	arg_1_0._unLockedId = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.getIsInitOpinionInfo(arg_3_0)
	return arg_3_0._isInitOpinionInfo
end

function var_0_0.initOpinionInfo(arg_4_0, arg_4_1)
	arg_4_0._isInitOpinionInfo = true

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.intelBox) do
		for iter_4_2, iter_4_3 in ipairs(iter_4_1.clueIds) do
			arg_4_0._connectedId[iter_4_3] = iter_4_3
		end
	end

	for iter_4_4, iter_4_5 in ipairs(arg_4_1.clueIds) do
		arg_4_0._unLockedId[iter_4_5] = iter_4_5
	end
end

function var_0_0.isUnlocked(arg_5_0, arg_5_1)
	return arg_5_0._unLockedId[arg_5_1] ~= nil
end

function var_0_0.setInfo(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._mo = arg_6_1
	arg_6_0._moList = arg_6_2
end

function var_0_0.getInfo(arg_7_0)
	return arg_7_0._mo, arg_7_0._moList
end

function var_0_0.getLinkedStatus(arg_8_0, arg_8_1)
	return arg_8_0._connectedId[arg_8_1] ~= nil
end

function var_0_0.setLinkedStatus(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._connectedId[arg_9_1] = arg_9_2
end

function var_0_0.allOpinionLinked(arg_10_0, arg_10_1)
	local var_10_0 = InvestigateConfig.instance:getInvestigateAllClueInfos(arg_10_1)

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if not arg_10_0:getLinkedStatus(iter_10_1.id) then
			return false
		end
	end

	return true
end

var_0_0.instance = var_0_0.New()

return var_0_0
