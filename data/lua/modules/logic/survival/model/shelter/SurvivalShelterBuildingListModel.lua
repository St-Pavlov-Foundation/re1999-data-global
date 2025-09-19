module("modules.logic.survival.model.shelter.SurvivalShelterBuildingListModel", package.seeall)

local var_0_0 = class("SurvivalShelterBuildingListModel", BaseModel)

function var_0_0.initViewParam(arg_1_0)
	arg_1_0.selectBuildingId = 0
end

function var_0_0.getSelectBuilding(arg_2_0)
	return arg_2_0.selectBuildingId
end

function var_0_0.setSelectBuilding(arg_3_0, arg_3_1)
	if arg_3_0.selectBuildingId == arg_3_1 then
		return
	end

	arg_3_0.selectBuildingId = arg_3_1

	return true
end

function var_0_0.isSelectBuilding(arg_4_0, arg_4_1)
	return arg_4_0.selectBuildingId == arg_4_1
end

function var_0_0.getShowList(arg_5_0)
	local var_5_0 = {}
	local var_5_1 = {}
	local var_5_2 = SurvivalShelterModel.instance:getWeekInfo().buildingDict

	if var_5_2 then
		for iter_5_0, iter_5_1 in pairs(var_5_2) do
			if iter_5_1:isEqualType(SurvivalEnum.BuildingType.Tent) then
				table.insert(var_5_1, iter_5_1)
			else
				table.insert(var_5_0, iter_5_1)
			end
		end
	end

	if #var_5_0 > 1 then
		table.sort(var_5_0, SurvivalShelterBuildingMo.sort)
	end

	if #var_5_1 > 1 then
		table.sort(var_5_1, SurvivalShelterBuildingMo.sort)
	end

	local var_5_3 = {}
	local var_5_4 = 2

	for iter_5_2, iter_5_3 in ipairs(var_5_0) do
		local var_5_5 = math.floor((iter_5_2 - 1) / var_5_4) + 1
		local var_5_6 = var_5_3[var_5_5]

		if not var_5_6 then
			var_5_6 = {}
			var_5_3[var_5_5] = var_5_6
		end

		table.insert(var_5_6, iter_5_3)
	end

	if arg_5_0.selectBuildingId == nil or arg_5_0.selectBuildingId == 0 then
		arg_5_0.selectBuildingId = var_5_0[1] and var_5_0[1].id
	end

	return var_5_3, var_5_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
