module("modules.logic.versionactivity1_4.act132.model.Activity132Mo", package.seeall)

local var_0_0 = class("Activity132Mo")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.selectCollectId = nil
	arg_1_0.contentStateDict = {}

	arg_1_0:initCfg()
end

function var_0_0.initCfg(arg_2_0)
	arg_2_0.collectDict = {}

	local var_2_0 = Activity132Config.instance:getCollectDict(arg_2_0.id)

	if var_2_0 then
		for iter_2_0, iter_2_1 in pairs(var_2_0) do
			arg_2_0.collectDict[iter_2_1.collectId] = Activity132CollectMo.New(iter_2_1)
		end
	end
end

function var_0_0.init(arg_3_0, arg_3_1)
	if not arg_3_1 then
		return
	end

	for iter_3_0 = 1, #arg_3_1.contents do
		local var_3_0 = arg_3_1.contents[iter_3_0]

		arg_3_0.contentStateDict[var_3_0.Id] = var_3_0.state
	end
end

function var_0_0.getCollectList(arg_4_0)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_0.collectDict) do
		table.insert(var_4_0, iter_4_1)
	end

	if #var_4_0 > 1 then
		table.sort(var_4_0, SortUtil.keyLower("collectId"))
	end

	return var_4_0
end

function var_0_0.getCollectMo(arg_5_0, arg_5_1)
	return arg_5_0.collectDict[arg_5_1]
end

function var_0_0.getContentState(arg_6_0, arg_6_1)
	return arg_6_0.contentStateDict[arg_6_1] or Activity132Enum.ContentState.Lock
end

function var_0_0.getSelectCollectId(arg_7_0)
	return arg_7_0.selectCollectId
end

function var_0_0.setSelectCollectId(arg_8_0, arg_8_1)
	arg_8_0.selectCollectId = arg_8_1
end

function var_0_0.setContentUnlock(arg_9_0, arg_9_1)
	for iter_9_0 = 1, #arg_9_1 do
		arg_9_0.contentStateDict[arg_9_1[iter_9_0]] = Activity132Enum.ContentState.Unlock
	end
end

function var_0_0.checkClueRed(arg_10_0, arg_10_1)
	local var_10_0 = Activity132Config.instance:getClueConfig(arg_10_0.id, arg_10_1)
	local var_10_1 = string.splitToNumber(var_10_0.contents, "#")

	if var_10_1 then
		for iter_10_0, iter_10_1 in ipairs(var_10_1) do
			if arg_10_0:getContentState(iter_10_1) == Activity132Enum.ContentState.CanUnlock then
				return true
			end
		end
	end
end

return var_0_0
