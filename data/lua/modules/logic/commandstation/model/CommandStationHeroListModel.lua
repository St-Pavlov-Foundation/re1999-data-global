module("modules.logic.commandstation.model.CommandStationHeroListModel", package.seeall)

local var_0_0 = class("CommandStationHeroListModel", ListScrollModel)

function var_0_0.initHeroList(arg_1_0)
	if arg_1_0:getCount() > 0 then
		return
	end

	local var_1_0 = HeroModel.instance:getList()
	local var_1_1 = {}
	local var_1_2 = {}
	local var_1_3 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		if arg_1_0:heroIsUsed(iter_1_1.heroId) then
			table.insert(var_1_3, iter_1_1)
		elseif arg_1_0:heroIsSpecial(iter_1_1.heroId) then
			table.insert(var_1_2, iter_1_1)
		else
			table.insert(var_1_1, iter_1_1)
		end
	end

	tabletool.addValues(var_1_1, var_1_3)
	tabletool.addValues(var_1_2, var_1_1)
	arg_1_0:setList(var_1_2)
end

function var_0_0.clearHeroList(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.clearSelectedHeroList(arg_3_0)
	arg_3_0._selectedHero = {}
end

function var_0_0.setSelectedHeroNum(arg_4_0, arg_4_1)
	arg_4_0._maxSelectedHeroNum = arg_4_1
	arg_4_0._selectedHero = {}
end

function var_0_0.getEmptyIndex(arg_5_0)
	for iter_5_0 = 1, arg_5_0._maxSelectedHeroNum do
		if not arg_5_0._selectedHero[iter_5_0] then
			return iter_5_0
		end
	end
end

function var_0_0.setSelectedHero(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._selectedHero[arg_6_1] = arg_6_2
	arg_6_0._selectedHero[arg_6_2] = arg_6_1

	CommandStationController.instance:dispatchEvent(CommandStationEvent.DispatchHeroListChange)
end

function var_0_0.cancelSelectedHero(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	local var_7_0 = arg_7_0._selectedHero[arg_7_1]

	arg_7_0._selectedHero[arg_7_1] = nil

	if var_7_0 then
		arg_7_0._selectedHero[var_7_0] = nil
	end

	CommandStationController.instance:dispatchEvent(CommandStationEvent.DispatchHeroListChange)
end

function var_0_0.getHeroSelectedIndex(arg_8_0, arg_8_1)
	return arg_8_1 and arg_8_0._selectedHero[arg_8_1]
end

function var_0_0.getHeroByIndex(arg_9_0, arg_9_1)
	return arg_9_0._selectedHero and arg_9_0._selectedHero[arg_9_1]
end

function var_0_0.getSelectedHeroNum(arg_10_0)
	for iter_10_0 = 1, arg_10_0._maxSelectedHeroNum do
		if not arg_10_0._selectedHero[iter_10_0] then
			return iter_10_0 - 1
		end
	end

	return arg_10_0._maxSelectedHeroNum
end

function var_0_0.getSelectedHeroIdList(arg_11_0)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._selectedHero) do
		table.insert(var_11_0, iter_11_1.heroId)
	end

	return var_11_0
end

function var_0_0.setSpecialHeroList(arg_12_0, arg_12_1)
	arg_12_0._specialHeroList = arg_12_1
end

function var_0_0.heroIsSpecial(arg_13_0, arg_13_1)
	return arg_13_0._specialHeroList and tabletool.indexOf(arg_13_0._specialHeroList, arg_13_1)
end

function var_0_0.initAllEventSelectedHeroList(arg_14_0)
	arg_14_0._allEventSelectedHeroList = CommandStationModel.instance:getAllEventHeroList()
end

function var_0_0.heroIsUsed(arg_15_0, arg_15_1)
	return arg_15_0._allEventSelectedHeroList and arg_15_0._allEventSelectedHeroList[arg_15_1] ~= nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
