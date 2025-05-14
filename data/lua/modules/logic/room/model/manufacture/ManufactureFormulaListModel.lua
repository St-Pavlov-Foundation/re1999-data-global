module("modules.logic.room.model.manufacture.ManufactureFormulaListModel", package.seeall)

local var_0_0 = class("ManufactureFormulaListModel", ListScrollModel)
local var_0_1 = 1
local var_0_2 = 200
local var_0_3 = 2
local var_0_4 = 262

function var_0_0.sortFormula(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.id
	local var_1_1 = arg_1_1.id
	local var_1_2 = ManufactureConfig.instance:getItemId(var_1_0)
	local var_1_3 = ManufactureConfig.instance:getItemId(var_1_1)

	if var_1_2 ~= var_1_3 then
		return var_1_2 < var_1_3
	end

	local var_1_4 = ManufactureConfig.instance:getUnitCount(var_1_0)
	local var_1_5 = ManufactureConfig.instance:getUnitCount(var_1_1)

	if var_1_4 ~= var_1_5 then
		return var_1_4 < var_1_5
	end

	return var_1_0 < var_1_1
end

function var_0_0.setManufactureFormulaItemList(arg_2_0, arg_2_1)
	local var_2_0 = {}

	arg_2_0._isNoMat = true

	local var_2_1 = RoomMapBuildingModel.instance:getBuildingMOById(arg_2_1)

	if var_2_1 then
		local var_2_2 = var_2_1.buildingId

		arg_2_0._isNoMat = RoomConfig.instance:getBuildingType(var_2_2) == RoomBuildingEnum.BuildingType.Collect

		local var_2_3 = var_2_1:getLevel()
		local var_2_4 = ManufactureConfig.instance:getAllManufactureItems(var_2_2)

		for iter_2_0, iter_2_1 in ipairs(var_2_4) do
			if var_2_3 >= ManufactureConfig.instance:getManufactureItemNeedLevel(var_2_2, iter_2_1) then
				local var_2_5 = {
					id = iter_2_1,
					buildingUid = arg_2_1
				}

				var_2_0[#var_2_0 + 1] = var_2_5
			end
		end
	end

	table.sort(var_2_0, arg_2_0.sortFormula)
	arg_2_0:setList(var_2_0)
end

function var_0_0.getInfoList(arg_3_0, arg_3_1)
	local var_3_0 = {}
	local var_3_1 = arg_3_0:getList()

	if not var_3_1 or #var_3_1 <= 0 then
		return var_3_0
	end

	for iter_3_0, iter_3_1 in ipairs(var_3_1) do
		local var_3_2 = arg_3_0._isNoMat and var_0_1 or var_0_3
		local var_3_3 = arg_3_0._isNoMat and var_0_2 or var_0_4

		table.insert(var_3_0, SLFramework.UGUI.MixCellInfo.New(var_3_2, var_3_3, nil))
	end

	return var_3_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
