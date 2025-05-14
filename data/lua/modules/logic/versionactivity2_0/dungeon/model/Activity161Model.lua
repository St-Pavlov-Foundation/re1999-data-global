module("modules.logic.versionactivity2_0.dungeon.model.Activity161Model", package.seeall)

local var_0_0 = class("Activity161Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.graffitiInfoMap = {}
	arg_2_0.curHasGetRewardMap = {}
	arg_2_0.curActId = 0
	arg_2_0.isNeedRefreshNewElement = false
end

function var_0_0.getActId(arg_3_0)
	return VersionActivity2_0Enum.ActivityId.DungeonGraffiti
end

function var_0_0.setGraffitiInfo(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.graffitiInfos or {}

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		local var_4_1 = Activity161Config.instance:getGraffitiCo(arg_4_1.activityId, iter_4_1.id)

		if var_4_1 then
			local var_4_2 = arg_4_0.graffitiInfoMap[iter_4_1.id]

			if not var_4_2 then
				var_4_2 = Activity161MO.New()

				var_4_2:init(iter_4_1, var_4_1)

				arg_4_0.graffitiInfoMap[iter_4_1.id] = var_4_2
			else
				var_4_2:updateInfo(iter_4_1)
			end
		end
	end

	arg_4_0:setHasGetRewardInfo(arg_4_1)
end

function var_0_0.setHasGetRewardInfo(arg_5_0, arg_5_1)
	if GameUtil.getTabLen(arg_5_0.curHasGetRewardMap) == 0 then
		local var_5_0 = Activity161Config.instance:getAllRewardCos(arg_5_1.activityId)

		for iter_5_0, iter_5_1 in pairs(var_5_0) do
			arg_5_0.curHasGetRewardMap[iter_5_1.rewardId] = false
		end
	end

	local var_5_1 = arg_5_1.gainedRewardIds or {}

	for iter_5_2, iter_5_3 in ipairs(var_5_1) do
		arg_5_0.curHasGetRewardMap[iter_5_3] = true
	end
end

function var_0_0.getFinalRewardHasGetState(arg_6_0)
	if #arg_6_0.curHasGetRewardMap > 0 then
		return arg_6_0.curHasGetRewardMap[#arg_6_0.curHasGetRewardMap]
	end

	return false
end

function var_0_0.getCurPaintedNum(arg_7_0)
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in pairs(arg_7_0.graffitiInfoMap) do
		if iter_7_1.state == Activity161Enum.graffitiState.IsFinished then
			var_7_0 = var_7_0 + 1
		end
	end

	return var_7_0
end

function var_0_0.setRewardInfo(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_1.rewardIds) do
		arg_8_0.curHasGetRewardMap[iter_8_1] = true
	end
end

function var_0_0.getItemsByState(arg_9_0, arg_9_1)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(arg_9_0.graffitiInfoMap) do
		if iter_9_1.state == arg_9_1 then
			table.insert(var_9_0, iter_9_1)
		end
	end

	return var_9_0
end

function var_0_0.getInCdGraffiti(arg_10_0)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(arg_10_0.graffitiInfoMap) do
		local var_10_1 = Activity161Config.instance:getGraffitiCo(arg_10_0:getActId(), iter_10_1.id)
		local var_10_2 = Activity161Config.instance:isPreMainElementFinish(var_10_1)

		if var_10_1.mainElementCd > 0 and iter_10_1:isInCdTime() and var_10_2 then
			table.insert(var_10_0, iter_10_1)
		end
	end

	return var_10_0
end

function var_0_0.getArriveCdGraffitiList(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = tabletool.copy(arg_11_1)
	local var_11_1 = {}

	for iter_11_0, iter_11_1 in pairs(arg_11_2) do
		var_11_1[iter_11_1.id] = true
	end

	for iter_11_2 = #var_11_0, 1, -1 do
		if var_11_1[var_11_0[iter_11_2].id] then
			table.remove(var_11_0, iter_11_2)
		end
	end

	return var_11_0
end

function var_0_0.setNeedRefreshNewElementsState(arg_12_0, arg_12_1)
	arg_12_0.isNeedRefreshNewElement = arg_12_1
end

function var_0_0.setGraffitiState(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.graffitiInfoMap[arg_13_1]

	if var_13_0 then
		var_13_0.state = arg_13_2
	else
		logError("graffitiMO is not exit, graffitiId: " .. arg_13_1)
	end
end

function var_0_0.isUnlockState(arg_14_0, arg_14_1)
	if arg_14_1.state == Activity161Enum.graffitiState.Normal or arg_14_1.state == Activity161Enum.graffitiState.IsFinished then
		return 1
	else
		return 0
	end
end

function var_0_0.ishaveUnGetReward(arg_15_0)
	local var_15_0 = arg_15_0.curHasGetRewardMap
	local var_15_1 = arg_15_0:getCurPaintedNum()
	local var_15_2 = Activity161Config.instance:getAllRewardCos(arg_15_0:getActId())
	local var_15_3 = {}

	for iter_15_0, iter_15_1 in ipairs(var_15_2) do
		if not var_15_0[iter_15_1.rewardId] and var_15_1 >= iter_15_1.paintedNum then
			table.insert(var_15_3, iter_15_1)
		end
	end

	if #var_15_3 > 0 then
		return true, var_15_3
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
