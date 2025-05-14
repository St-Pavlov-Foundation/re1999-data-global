module("modules.logic.playercard.model.PlayerCardCritterPlaceListModel", package.seeall)

local var_0_0 = class("PlayerCardCritterPlaceListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
	arg_1_0:clearData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clearData()
end

function var_0_0.clearData(arg_3_0)
	arg_3_0:setIsSortByRareAscend(false)
	arg_3_0:setMatureFilterType(CritterEnum.MatureFilterType.All)
end

local function var_0_1(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getId()
	local var_4_1 = arg_4_1:getId()
	local var_4_2 = arg_4_0:getDefineId()
	local var_4_3 = arg_4_1:getDefineId()
	local var_4_4 = CritterConfig.instance:getCritterRare(var_4_2)
	local var_4_5 = CritterConfig.instance:getCritterRare(var_4_3)
	local var_4_6 = tonumber(var_4_0) == PlayerCardModel.instance:getSelectCritterUid()

	if var_4_6 ~= (tonumber(var_4_1) == PlayerCardModel.instance:getSelectCritterUid()) then
		return var_4_6
	end

	if var_4_4 ~= var_4_5 then
		if var_0_0.instance:getIsSortByRareAscend() then
			return var_4_4 < var_4_5
		else
			return var_4_5 < var_4_4
		end
	end

	local var_4_7 = arg_4_0:isMutate()

	if var_4_7 ~= arg_4_1:isMutate() then
		return var_4_7
	end

	local var_4_8 = arg_4_0:isMaturity()

	if var_4_8 ~= arg_4_1:isMaturity() then
		return var_4_8
	end

	if var_4_2 ~= var_4_3 then
		return var_4_2 < var_4_3
	end

	return var_4_0 < var_4_1
end

function var_0_0.setPlayerCardCritterList(arg_5_0, arg_5_1)
	local var_5_0 = CritterModel.instance:getAllCritters()
	local var_5_1 = {}
	local var_5_2 = not arg_5_0.matureFilterType or arg_5_0.matureFilterType == CritterEnum.MatureFilterType.All
	local var_5_3 = arg_5_0.matureFilterType == CritterEnum.MatureFilterType.Mature

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		local var_5_4 = true

		if arg_5_1 then
			var_5_4 = arg_5_1:isPassedFilter(iter_5_1)
		end

		if var_5_4 then
			if var_5_2 then
				var_5_1[#var_5_1 + 1] = iter_5_1
			else
				local var_5_5 = iter_5_1:isMaturity()

				if var_5_3 and var_5_5 or not var_5_3 and not var_5_5 then
					var_5_1[#var_5_1 + 1] = iter_5_1
				end
			end
		end
	end

	table.sort(var_5_1, var_0_1)
	arg_5_0:setList(var_5_1)
end

function var_0_0.setIsSortByRareAscend(arg_6_0, arg_6_1)
	arg_6_0._rareAscend = arg_6_1
end

function var_0_0.setMatureFilterType(arg_7_0, arg_7_1)
	arg_7_0.matureFilterType = arg_7_1
end

function var_0_0.getIsSortByRareAscend(arg_8_0)
	return arg_8_0._rareAscend
end

function var_0_0.getMatureFilterType(arg_9_0)
	return arg_9_0.matureFilterType
end

function var_0_0.selectMatureFilterType(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0:getMatureFilterType()

	if var_10_0 and var_10_0 == arg_10_1 then
		return
	end

	arg_10_0:setMatureFilterType(arg_10_1)
	arg_10_0:setPlayerCardCritterList(arg_10_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
