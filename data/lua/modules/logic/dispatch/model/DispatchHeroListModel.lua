module("modules.logic.dispatch.model.DispatchHeroListModel", package.seeall)

local var_0_0 = class("DispatchHeroListModel", ListScrollModel)

local function var_0_1(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0:isDispatched()
	local var_1_1 = arg_1_1:isDispatched()

	if var_1_0 ~= var_1_1 then
		return var_1_1
	end

	if arg_1_0.level ~= arg_1_1.level then
		return arg_1_0.level > arg_1_1.level
	end

	if arg_1_0.rare ~= arg_1_1.rare then
		return arg_1_0.rare > arg_1_1.rare
	end

	return arg_1_0.heroId > arg_1_1.heroId
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.reInit(arg_3_0)
	return
end

function var_0_0.onOpenDispatchView(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:initHeroList()
	arg_4_0:initSelectedHeroList(arg_4_2, arg_4_1 and arg_4_1.id)

	arg_4_0.maxSelectCount = arg_4_1 and arg_4_1.maxCount or 0
end

function var_0_0.initHeroList(arg_5_0)
	if arg_5_0.heroList then
		return
	end

	arg_5_0.heroList = {}

	local var_5_0 = HeroModel.instance:getList()

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		local var_5_1 = DispatchHeroMo.New()

		var_5_1:init(iter_5_1)
		table.insert(arg_5_0.heroList, var_5_1)
	end
end

function var_0_0.getDispatchHeroMo(arg_6_0, arg_6_1)
	if not arg_6_0.heroList then
		return
	end

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.heroList) do
		if iter_6_1.heroId == arg_6_1 then
			return iter_6_1
		end
	end
end

function var_0_0.refreshHero(arg_7_0)
	if not arg_7_0.heroList then
		return
	end

	table.sort(arg_7_0.heroList, var_0_1)
	arg_7_0:setList(arg_7_0.heroList)
end

function var_0_0.resetSelectHeroList(arg_8_0)
	arg_8_0.selectedHeroList = {}
	arg_8_0.selectedHeroIndexDict = {}
end

function var_0_0.initSelectedHeroList(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:resetSelectHeroList()

	if not arg_9_1 or not arg_9_2 then
		return
	end

	local var_9_0 = DispatchModel.instance:getDispatchMo(arg_9_1, arg_9_2)

	if not var_9_0 then
		return
	end

	for iter_9_0, iter_9_1 in ipairs(var_9_0.heroIdList) do
		local var_9_1 = arg_9_0:getDispatchHeroMo(iter_9_1)

		if var_9_1 then
			table.insert(arg_9_0.selectedHeroList, var_9_1)

			arg_9_0.selectedHeroIndexDict[var_9_1] = iter_9_0
		else
			logError(string.format("DispatchHeroListModel:initSelectedHeroList error, not found dispatched hero id: %s ", iter_9_1))
		end
	end
end

function var_0_0.canAddMo(arg_10_0)
	return #arg_10_0.selectedHeroList < arg_10_0.maxSelectCount
end

function var_0_0.selectMo(arg_11_0, arg_11_1)
	if not arg_11_1 then
		return
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.selectedHeroList) do
		if iter_11_1.heroId == arg_11_1.heroId then
			return
		end
	end

	table.insert(arg_11_0.selectedHeroList, arg_11_1)

	arg_11_0.selectedHeroIndexDict[arg_11_1] = #arg_11_0.selectedHeroList

	DispatchController.instance:dispatchEvent(DispatchEvent.ChangeSelectedHero)
end

function var_0_0.deselectMo(arg_12_0, arg_12_1)
	if not arg_12_1 then
		return
	end

	local var_12_0 = arg_12_0:getSelectedIndex(arg_12_1)

	if var_12_0 and var_12_0 > 0 then
		table.remove(arg_12_0.selectedHeroList, var_12_0)

		arg_12_0.selectedHeroIndexDict[arg_12_1] = nil

		for iter_12_0, iter_12_1 in ipairs(arg_12_0.selectedHeroList) do
			arg_12_0.selectedHeroIndexDict[iter_12_1] = iter_12_0
		end

		DispatchController.instance:dispatchEvent(DispatchEvent.ChangeSelectedHero)
	end
end

function var_0_0.getSelectedIndex(arg_13_0, arg_13_1)
	return arg_13_0.selectedHeroIndexDict[arg_13_1]
end

function var_0_0.getSelectedMoByIndex(arg_14_0, arg_14_1)
	return arg_14_0.selectedHeroList[arg_14_1]
end

function var_0_0.getSelectedHeroIdList(arg_15_0)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.selectedHeroList) do
		table.insert(var_15_0, iter_15_1.heroId)
	end

	return var_15_0
end

function var_0_0.getSelectedHeroCount(arg_16_0)
	return #arg_16_0.selectedHeroList
end

function var_0_0.getSelectedHeroList(arg_17_0)
	return arg_17_0.selectedHeroList
end

function var_0_0.setDispatchViewStatus(arg_18_0, arg_18_1)
	arg_18_0.dispatchViewStatus = arg_18_1
end

function var_0_0.canChangeHeroMo(arg_19_0)
	return arg_19_0.dispatchViewStatus == DispatchEnum.DispatchStatus.NotDispatch
end

function var_0_0.clear(arg_20_0)
	var_0_0.super.clear(arg_20_0)
	arg_20_0:_clearData()
end

function var_0_0._clearData(arg_21_0)
	arg_21_0:resetSelectHeroList()

	arg_21_0.heroList = nil
	arg_21_0.dispatchViewStatus = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
