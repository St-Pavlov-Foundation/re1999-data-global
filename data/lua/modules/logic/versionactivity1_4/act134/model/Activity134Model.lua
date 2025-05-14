module("modules.logic.versionactivity1_4.act134.model.Activity134Model", package.seeall)

local var_0_0 = class("Activity134Model", BaseModel)

function var_0_0.ctor(arg_1_0)
	arg_1_0.super:ctor()

	arg_1_0.serverTaskModel = BaseModel.New()
end

function var_0_0.onInitMo(arg_2_0, arg_2_1)
	arg_2_0.actId = arg_2_1.activityId

	arg_2_0:initStory(arg_2_1.hasGetBonusIds)
	arg_2_0:setTasksInfo(arg_2_1.tasks)
end

function var_0_0.getCurActivityID(arg_3_0)
	return arg_3_0.actId
end

function var_0_0.initStory(arg_4_0, arg_4_1)
	arg_4_0.storyMoList = {}
	arg_4_0.finishStoryCount = #arg_4_1
	arg_4_0.maxNeedClueCount = 0

	for iter_4_0, iter_4_1 in ipairs(Activity134Config.instance:getBonusAllConfig()) do
		local var_4_0 = Activity134StoryMo.New()

		var_4_0:init(iter_4_0, iter_4_1)

		var_4_0.status = arg_4_1[iter_4_1.id] and Activity134Enum.StroyStatus.Finish or Activity134Enum.StroyStatus.Orgin
		arg_4_0.maxNeedClueCount = Mathf.Max(arg_4_0.maxNeedClueCount, var_4_0.needTokensQuantity)

		table.insert(arg_4_0.storyMoList, var_4_0)
	end

	table.sort(arg_4_0.storyMoList, function(arg_5_0, arg_5_1)
		return arg_5_0.needTokensQuantity < arg_5_1.needTokensQuantity
	end)
end

function var_0_0.getStoryMoByIndex(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.storyMoList) do
		if iter_6_1.index == arg_6_1 then
			return iter_6_1
		end
	end
end

function var_0_0.getStoryMoById(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.storyMoList) do
		if arg_7_1 == iter_7_1.config.id then
			return iter_7_1
		end
	end
end

function var_0_0.getAllStoryMo(arg_8_0)
	return arg_8_0.storyMoList
end

function var_0_0.getStoryTotalCount(arg_9_0)
	return #arg_9_0.storyMoList
end

function var_0_0.getFinishStoryCount(arg_10_0)
	return arg_10_0.finishStoryCount
end

function var_0_0.getClueCount(arg_11_0)
	local var_11_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Act134Clue)

	if var_11_0 then
		return var_11_0.quantity
	end
end

function var_0_0.getMaxClueCount(arg_12_0)
	return arg_12_0.maxNeedClueCount
end

function var_0_0.checkGetStoryBonus(arg_13_0)
	local var_13_0 = arg_13_0:getClueCount()
	local var_13_1

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.storyMoList) do
		if iter_13_1.status == Activity134Enum.StroyStatus.Orgin and var_13_0 >= tonumber(iter_13_1.needTokensQuantity) then
			Activity134Rpc.instance:sendGet134BonusRequest(arg_13_0.actId, iter_13_1.config.id)

			var_13_1 = true
		end
	end

	return var_13_1
end

function var_0_0.onReceiveBonus(arg_14_0, arg_14_1)
	if not arg_14_1 then
		return
	end

	local var_14_0 = arg_14_0.storyMoList[arg_14_1]

	if not var_14_0 or var_14_0.status == Activity134Enum.StroyStatus.Finish then
		return
	end

	var_14_0.status = Activity134Enum.StroyStatus.Finish
	arg_14_0.finishStoryCount = Mathf.Max(arg_14_0.finishStoryCount, var_14_0.index)
end

function var_0_0.getTaskMoById(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.serverTaskModel) do
		if arg_15_1 == iter_15_1.config.id then
			return iter_15_1
		end
	end
end

function var_0_0.getTasksInfo(arg_16_0)
	return arg_16_0.serverTaskModel:getList()
end

function var_0_0.setTasksInfo(arg_17_0, arg_17_1)
	local var_17_0

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		local var_17_1 = arg_17_0.serverTaskModel:getById(iter_17_1.id)

		if var_17_1 then
			var_17_1:update(iter_17_1)
		else
			local var_17_2 = Activity134Config.instance:getTaskConfig(iter_17_1.id)

			if var_17_2 then
				local var_17_3 = TaskMo.New()

				var_17_3:init(iter_17_1, var_17_2)
				arg_17_0.serverTaskModel:addAtLast(var_17_3)
			end
		end

		var_17_0 = true
	end

	if var_17_0 then
		arg_17_0:sortList()
	end

	return var_17_0
end

function var_0_0.deleteInfo(arg_18_0, arg_18_1)
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in pairs(arg_18_1) do
		local var_18_1 = arg_18_0.serverTaskModel:getById(iter_18_1)

		if var_18_1 then
			var_18_0[iter_18_1] = var_18_1
		end
	end

	for iter_18_2, iter_18_3 in pairs(var_18_0) do
		arg_18_0.serverTaskModel:remove(iter_18_3)
	end

	local var_18_2 = next(var_18_0)

	if var_18_2 then
		arg_18_0:sortList()
	end

	return var_18_2
end

function var_0_0.sortList(arg_19_0)
	arg_19_0.serverTaskModel:sort(function(arg_20_0, arg_20_1)
		local var_20_0 = arg_20_0.finishCount > 0 and 3 or arg_20_0.progress >= arg_20_0.config.maxProgress and 1 or 2
		local var_20_1 = arg_20_1.finishCount > 0 and 3 or arg_20_1.progress >= arg_20_1.config.maxProgress and 1 or 2

		if var_20_0 ~= var_20_1 then
			return var_20_0 < var_20_1
		else
			return arg_20_0.config.id < arg_20_1.config.id
		end
	end)
end

function var_0_0.getBonusFillWidth(arg_21_0)
	local var_21_0 = arg_21_0:getClueCount()

	if var_21_0 <= 0 then
		return 0
	end

	local var_21_1 = 0
	local var_21_2 = 0
	local var_21_3 = 0
	local var_21_4 = 0
	local var_21_5 = arg_21_0:getStoryTotalCount()

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.storyMoList) do
		if var_21_0 > iter_21_1.needTokensQuantity then
			var_21_1 = iter_21_1.index

			break
		end
	end

	if var_21_0 > arg_21_0:getMaxClueCount() then
		var_21_1 = var_21_5
	end

	if var_21_1 == 0 then
		var_21_3 = -30
		var_21_4 = arg_21_0.storyMoList[1].needTokensQuantity
	elseif var_21_5 <= var_21_1 then
		var_21_3 = arg_21_0.storyMoList[var_21_5].needTokensQuantity
		var_21_4 = var_21_3
	else
		var_21_3 = arg_21_0.storyMoList[var_21_1].needTokensQuantity
		var_21_4 = arg_21_0.storyMoList[var_21_1 + 1].needTokensQuantity
	end

	local var_21_6 = var_21_4 == var_21_3 and 0 or (var_21_0 - var_21_3) / (var_21_4 - var_21_3)

	return 970 + 310 * (var_21_1 - 1 + var_21_6)
end

var_0_0.instance = var_0_0.New()

return var_0_0
