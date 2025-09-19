module("modules.logic.survival.model.shelter.SurvivalShelterNpcListModel", package.seeall)

local var_0_0 = class("SurvivalShelterNpcListModel", ListScrollModel)

function var_0_0.initViewParam(arg_1_0)
	arg_1_0.selectNpcId = 0
end

function var_0_0.setSelectNpcId(arg_2_0, arg_2_1)
	if arg_2_0.selectNpcId == arg_2_1 then
		return
	end

	arg_2_0.selectNpcId = arg_2_1

	return true
end

function var_0_0.isSelectNpc(arg_3_0, arg_3_1)
	return arg_3_0.selectNpcId == arg_3_1
end

function var_0_0.getSelectNpc(arg_4_0)
	return arg_4_0.selectNpcId
end

function var_0_0.refreshList(arg_5_0, arg_5_1)
	local var_5_0 = {}
	local var_5_1 = SurvivalShelterModel.instance:getWeekInfo().npcDict

	if var_5_1 then
		for iter_5_0, iter_5_1 in pairs(var_5_1) do
			if SurvivalBagSortHelper.filterNpc(arg_5_1, iter_5_1) then
				table.insert(var_5_0, iter_5_1)
			end
		end
	end

	if #var_5_0 > 1 then
		table.sort(var_5_0, SurvivalShelterNpcMo.sort)
	end

	local var_5_2 = {}
	local var_5_3 = 4

	for iter_5_2, iter_5_3 in ipairs(var_5_0) do
		local var_5_4 = math.floor((iter_5_2 - 1) / var_5_3) + 1
		local var_5_5 = var_5_2[var_5_4]

		if not var_5_5 then
			var_5_5 = {
				id = iter_5_2,
				dataList = {}
			}
			var_5_2[var_5_4] = var_5_5
		end

		table.insert(var_5_5.dataList, iter_5_3)
	end

	if arg_5_0.selectNpcId == nil or arg_5_0.selectNpcId == 0 then
		arg_5_0.selectNpcId = var_5_0[1] and var_5_0[1].id
	end

	arg_5_0:setList(var_5_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
