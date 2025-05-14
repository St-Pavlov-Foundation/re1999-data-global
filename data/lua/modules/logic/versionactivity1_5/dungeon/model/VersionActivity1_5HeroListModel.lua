module("modules.logic.versionactivity1_5.dungeon.model.VersionActivity1_5HeroListModel", package.seeall)

local var_0_0 = class("VersionActivity1_5HeroListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.onOpenDispatchView(arg_3_0, arg_3_1)
	arg_3_0:initHeroList()
	arg_3_0:initSelectedHeroList(arg_3_1.id)

	arg_3_0.maxSelectCount = arg_3_1.maxCount
end

function var_0_0.resetSelectHeroList(arg_4_0)
	arg_4_0.selectedHeroList = {}
	arg_4_0.selectedHeroIndexDict = {}
end

function var_0_0.onCloseDispatchView(arg_5_0)
	arg_5_0:clearSelectedHeroList()
end

function var_0_0.initHeroList(arg_6_0)
	if arg_6_0.heroList then
		return
	end

	arg_6_0.heroList = {}

	for iter_6_0, iter_6_1 in ipairs(HeroModel.instance:getList()) do
		local var_6_0 = VersionActivity1_5DispatchHeroMo.New()

		var_6_0:init(iter_6_1)
		table.insert(arg_6_0.heroList, var_6_0)
	end
end

function var_0_0.initSelectedHeroList(arg_7_0, arg_7_1)
	arg_7_0.selectedHeroList = {}
	arg_7_0.selectedHeroIndexDict = {}

	if arg_7_1 then
		local var_7_0 = VersionActivity1_5DungeonModel.instance:getDispatchMo(arg_7_1)

		if var_7_0 then
			for iter_7_0, iter_7_1 in ipairs(var_7_0.heroIdList) do
				local var_7_1 = arg_7_0:getDispatchHeroMo(iter_7_1)

				if var_7_1 then
					table.insert(arg_7_0.selectedHeroList, var_7_1)

					arg_7_0.selectedHeroIndexDict[var_7_1] = iter_7_0
				else
					logError("not found dispatched hero id : " .. tostring(iter_7_1))
				end
			end
		end
	end
end

function var_0_0.getDispatchHeroMo(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.heroList) do
		if iter_8_1.heroId == arg_8_1 then
			return iter_8_1
		end
	end
end

function var_0_0.refreshHero(arg_9_0)
	arg_9_0:resortHeroList()
	arg_9_0:setList(arg_9_0.heroList)
end

function var_0_0.resortHeroList(arg_10_0)
	table.sort(arg_10_0.heroList, var_0_0._sortFunc)
end

function var_0_0._sortFunc(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:isDispatched()
	local var_11_1 = arg_11_1:isDispatched()

	if var_11_0 ~= var_11_1 then
		return var_11_1
	end

	if arg_11_0.level ~= arg_11_1.level then
		return arg_11_0.level > arg_11_1.level
	end

	if arg_11_0.rare ~= arg_11_1.rare then
		return arg_11_0.rare > arg_11_1.rare
	end

	return arg_11_0.heroId > arg_11_1.heroId
end

function var_0_0.canAddMo(arg_12_0)
	return #arg_12_0.selectedHeroList < arg_12_0.maxSelectCount
end

function var_0_0.canChangeHeroMo(arg_13_0)
	return arg_13_0.dispatchViewStatus == VersionActivity1_5DungeonEnum.DispatchStatus.NotDispatch
end

function var_0_0.selectMo(arg_14_0, arg_14_1)
	if not arg_14_1 then
		return
	end

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.selectedHeroList) do
		if iter_14_1.heroId == arg_14_1.heroId then
			return
		end
	end

	table.insert(arg_14_0.selectedHeroList, arg_14_1)

	arg_14_0.selectedHeroIndexDict[arg_14_1] = #arg_14_0.selectedHeroList

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.ChangeSelectedHero)
end

function var_0_0.deselectMo(arg_15_0, arg_15_1)
	if not arg_15_1 then
		return
	end

	local var_15_0 = 0

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.selectedHeroList) do
		if iter_15_1.heroId == arg_15_1.heroId then
			var_15_0 = iter_15_0
		end
	end

	if var_15_0 > 0 then
		table.remove(arg_15_0.selectedHeroList, var_15_0)

		arg_15_0.selectedHeroIndexDict[arg_15_1] = nil

		for iter_15_2, iter_15_3 in ipairs(arg_15_0.selectedHeroList) do
			arg_15_0.selectedHeroIndexDict[iter_15_3] = iter_15_2
		end

		VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.ChangeSelectedHero)
	end
end

function var_0_0.getSelectedIndex(arg_16_0, arg_16_1)
	return arg_16_0.selectedHeroIndexDict[arg_16_1]
end

function var_0_0.getSelectedMoByIndex(arg_17_0, arg_17_1)
	return arg_17_0.selectedHeroList[arg_17_1]
end

function var_0_0.getSelectedHeroCount(arg_18_0)
	return #arg_18_0.selectedHeroList
end

function var_0_0.getSelectedHeroList(arg_19_0)
	return arg_19_0.selectedHeroList
end

function var_0_0.getSelectedHeroIdList(arg_20_0)
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.selectedHeroList) do
		table.insert(var_20_0, iter_20_1.heroId)
	end

	return var_20_0
end

function var_0_0.setDispatchViewStatus(arg_21_0, arg_21_1)
	arg_21_0.dispatchViewStatus = arg_21_1
end

function var_0_0.clearSelectedHeroList(arg_22_0)
	arg_22_0.selectedHeroList = nil
	arg_22_0.selectedHeroIndexDict = nil
	arg_22_0.dispatchViewStatus = nil
end

function var_0_0.clear(arg_23_0)
	arg_23_0:clearSelectedHeroList()

	arg_23_0.heroList = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
