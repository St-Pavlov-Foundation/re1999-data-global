module("modules.logic.room.model.manufacture.OneKeyAddPopListModel", package.seeall)

local var_0_0 = class("OneKeyAddPopListModel", ListScrollModel)

var_0_0.MINI_COUNT = 1

local var_0_1 = 1
local var_0_2 = 200
local var_0_3 = 2
local var_0_4 = 262

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.clear(arg_2_0)
	var_0_0.super.clear(arg_2_0)

	arg_2_0._strCache = nil

	arg_2_0:setSelectedManufactureItem()
end

function var_0_0.resetSelectManufactureItemFromCache(arg_3_0)
	if not arg_3_0._strCache then
		arg_3_0._strCache = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.RoomManufactureOneKeyCustomize, "")
	end

	local var_3_0 = string.splitToNumber(arg_3_0._strCache or "", "|")

	arg_3_0:setSelectedManufactureItem(var_3_0[1], var_3_0[2])
end

function var_0_0.recordSelectManufactureItem(arg_4_0)
	local var_4_0, var_4_1 = arg_4_0:getSelectedManufactureItem()

	if var_4_0 then
		arg_4_0._strCache = string.format("%s|%s", var_4_0, var_4_1)

		GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.RoomManufactureOneKeyCustomize, arg_4_0._strCache)
	end
end

function var_0_0.setOneKeyFormulaItemList(arg_5_0, arg_5_1)
	local var_5_0 = {}
	local var_5_1 = {}

	arg_5_0._isNoMat = true

	local var_5_2 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		local var_5_3 = RoomMapBuildingModel.instance:getBuildingMOById(iter_5_1)

		if var_5_3 then
			local var_5_4 = var_5_3.buildingId

			arg_5_0._isNoMat = RoomConfig.instance:getBuildingType(var_5_4) == RoomBuildingEnum.BuildingType.Collect

			local var_5_5 = var_5_3:getLevel()
			local var_5_6 = ManufactureConfig.instance:getAllManufactureItems(var_5_4)

			for iter_5_2, iter_5_3 in ipairs(var_5_6) do
				local var_5_7 = ManufactureConfig.instance:getUnitCount(iter_5_3)
				local var_5_8 = ManufactureConfig.instance:getItemId(iter_5_3)

				if (not var_5_2[var_5_8] or var_5_7 < var_5_2[var_5_8]) and var_5_5 >= ManufactureConfig.instance:getManufactureItemNeedLevel(var_5_4, iter_5_3) then
					var_5_0[var_5_8] = {
						id = iter_5_3,
						buildingUid = iter_5_1
					}
					var_5_2[var_5_8] = var_5_7
				end
			end
		end
	end

	for iter_5_4, iter_5_5 in pairs(var_5_0) do
		var_5_1[#var_5_1 + 1] = iter_5_5
	end

	table.sort(var_5_1, ManufactureFormulaListModel.sortFormula)
	arg_5_0:setList(var_5_1)
end

function var_0_0.setSelectedManufactureItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._selectedManufacture = arg_6_1
	arg_6_0._selectedManufactureCount = arg_6_2 or var_0_0.MINI_COUNT
end

function var_0_0.getInfoList(arg_7_0, arg_7_1)
	local var_7_0 = {}
	local var_7_1 = arg_7_0:getList()

	if not var_7_1 or #var_7_1 <= 0 then
		return var_7_0
	end

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		local var_7_2 = arg_7_0._isNoMat and var_0_1 or var_0_3
		local var_7_3 = arg_7_0._isNoMat and var_0_2 or var_0_4

		table.insert(var_7_0, SLFramework.UGUI.MixCellInfo.New(var_7_2, var_7_3, nil))
	end

	return var_7_0
end

function var_0_0.getSelectedManufactureItem(arg_8_0)
	if not arg_8_0._strCache then
		arg_8_0:resetSelectManufactureItemFromCache()
	end

	return arg_8_0._selectedManufacture, arg_8_0._selectedManufactureCount or var_0_0.MINI_COUNT
end

function var_0_0.getTabDataList(arg_9_0)
	local var_9_0 = {}
	local var_9_1 = {}
	local var_9_2 = ManufactureModel.instance:getAllPlacedManufactureBuilding()

	for iter_9_0, iter_9_1 in ipairs(var_9_2) do
		local var_9_3 = iter_9_1.buildingId
		local var_9_4 = RoomConfig.instance:getBuildingType(var_9_3)
		local var_9_5 = var_9_1[var_9_4]

		if not var_9_5 then
			var_9_5 = {}
			var_9_1[var_9_4] = var_9_5
		end

		var_9_5[#var_9_5 + 1] = iter_9_1.id
	end

	for iter_9_2, iter_9_3 in pairs(var_9_1) do
		if iter_9_2 == RoomBuildingEnum.BuildingType.Collect then
			var_9_0[#var_9_0 + 1] = iter_9_3
		else
			for iter_9_4, iter_9_5 in ipairs(iter_9_3) do
				var_9_0[#var_9_0 + 1] = {
					iter_9_5
				}
			end
		end
	end

	return var_9_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
