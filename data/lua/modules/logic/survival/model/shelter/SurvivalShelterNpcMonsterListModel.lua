module("modules.logic.survival.model.shelter.SurvivalShelterNpcMonsterListModel", package.seeall)

local var_0_0 = class("SurvivalShelterNpcMonsterListModel", ListScrollModel)
local var_0_1 = 4

function var_0_0.initViewParam(arg_1_0)
	arg_1_0.selectNpcIds = {}
end

function var_0_0.setSelectNpcId(arg_2_0, arg_2_1)
	if arg_2_0:isSelectNpc(arg_2_1) then
		return false
	end

	arg_2_0.selectNpcIds[#arg_2_0.selectNpcIds + 1] = arg_2_1

	return true
end

function var_0_0.setSelectNpcByList(arg_3_0, arg_3_1)
	arg_3_0.selectNpcIds = {}

	if arg_3_1 == nil then
		return
	end

	for iter_3_0 = 1, #arg_3_1 do
		local var_3_0 = arg_3_1[iter_3_0]

		arg_3_0:setSelectNpcId(var_3_0)
	end
end

function var_0_0.cancelSelect(arg_4_0, arg_4_1)
	if not arg_4_0:isSelectNpc(arg_4_1) then
		return false
	end

	local var_4_0 = -1

	for iter_4_0 = 1, #arg_4_0.selectNpcIds do
		if arg_4_0.selectNpcIds[iter_4_0] == arg_4_1 then
			var_4_0 = iter_4_0

			break
		end
	end

	if var_4_0 == -1 then
		return false
	end

	for iter_4_1 = #arg_4_0.selectNpcIds, 1, -1 do
		if iter_4_1 == var_4_0 then
			table.remove(arg_4_0.selectNpcIds, iter_4_1)

			break
		end
	end

	return true
end

function var_0_0.canSelect(arg_5_0)
	return arg_5_0:getSelectCount() < var_0_1
end

function var_0_0.getSelectCount(arg_6_0)
	return #arg_6_0.selectNpcIds
end

function var_0_0.isSelectNpc(arg_7_0, arg_7_1)
	for iter_7_0 = 1, #arg_7_0.selectNpcIds do
		if arg_7_0.selectNpcIds[iter_7_0] == arg_7_1 then
			return true
		end
	end

	return false
end

function var_0_0.getSelectList(arg_8_0)
	return arg_8_0.selectNpcIds
end

function var_0_0.sort(arg_9_0, arg_9_1)
	local var_9_0 = SurvivalShelterMonsterModel.instance:calRecommendNum(arg_9_0.id)
	local var_9_1 = SurvivalShelterMonsterModel.instance:calRecommendNum(arg_9_1.id)

	if var_9_0 == var_9_1 then
		return arg_9_0.id < arg_9_1.id
	end

	return var_9_1 < var_9_0
end

function var_0_0.refreshList(arg_10_0)
	local var_10_0 = {}
	local var_10_1 = {}
	local var_10_2 = {}
	local var_10_3 = SurvivalShelterModel.instance:getWeekInfo().npcDict

	if var_10_3 then
		for iter_10_0, iter_10_1 in pairs(var_10_3) do
			local var_10_4 = iter_10_1:getShelterNpcStatus()

			if var_10_4 == SurvivalEnum.ShelterNpcStatus.InBuild then
				var_10_0[#var_10_0 + 1] = iter_10_1
			elseif var_10_4 == SurvivalEnum.ShelterNpcStatus.InDestoryBuild then
				var_10_1[#var_10_1 + 1] = iter_10_1
			end
		end
	end

	if #var_10_0 > 1 then
		table.sort(var_10_0, var_0_0.sort)
	end

	if #var_10_1 > 1 then
		table.sort(var_10_1, var_0_0.sort)
	end

	if #var_10_2 > 1 then
		table.sort(var_10_2, var_0_0.sort)
	end

	tabletool.addValues(var_10_0, var_10_1)
	tabletool.addValues(var_10_0, var_10_2)

	local var_10_5 = {}
	local var_10_6 = 2

	for iter_10_2, iter_10_3 in ipairs(var_10_0) do
		local var_10_7 = math.floor((iter_10_2 - 1) / var_10_6) + 1
		local var_10_8 = var_10_5[var_10_7]

		if not var_10_8 then
			var_10_8 = {
				id = iter_10_2,
				dataList = {}
			}
			var_10_5[var_10_7] = var_10_8
		end

		table.insert(var_10_8.dataList, iter_10_3)
	end

	arg_10_0:setList(var_10_5)
end

var_0_0.instance = var_0_0.New()

return var_0_0
