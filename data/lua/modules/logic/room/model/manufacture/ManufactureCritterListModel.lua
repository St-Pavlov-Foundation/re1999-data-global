module("modules.logic.room.model.manufacture.ManufactureCritterListModel", package.seeall)

local var_0_0 = class("ManufactureCritterListModel", ListScrollModel)
local var_0_1 = 1
local var_0_2 = 50
local var_0_3 = 5

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
	arg_1_0:clearData()
	arg_1_0:clearSort()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clearData()
	arg_2_0:clearSort()
end

function var_0_0.clearData(arg_3_0)
	arg_3_0._newList = nil
	arg_3_0._curPreviewIndex = 0
	arg_3_0.critterAttrPreviewDict = {}
	arg_3_0._buildingCritterAttrPreviewDict = {}
	arg_3_0._buildingCritterAttrDict = {}
end

function var_0_0.clearSort(arg_4_0)
	arg_4_0:setOrder(CritterEnum.OrderType.MoodDown)
end

local function var_0_4(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getId()
	local var_5_1 = arg_5_1:getId()
	local var_5_2 = RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(var_5_0)
	local var_5_3 = RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(var_5_1)
	local var_5_4 = var_5_2 and var_5_2.id
	local var_5_5 = var_5_3 and var_5_3.id
	local var_5_6 = ManufactureModel.instance:getCritterWorkingBuilding(var_5_0)
	local var_5_7 = ManufactureModel.instance:getCritterWorkingBuilding(var_5_1)
	local var_5_8 = false
	local var_5_9 = false
	local var_5_10 = var_0_0.instance:getTmpWorkingUid()

	if var_5_10 then
		var_5_8 = var_5_6 == var_5_10 or var_5_4 == var_5_10
		var_5_9 = var_5_7 == var_5_10 or var_5_5 == var_5_10
	end

	if var_5_8 ~= var_5_9 then
		return var_5_8
	end

	local var_5_11 = var_0_0.instance:getOrder()
	local var_5_12 = arg_5_0:getMoodValue()
	local var_5_13 = arg_5_1:getMoodValue()

	if var_5_12 ~= var_5_13 then
		if var_5_11 == CritterEnum.OrderType.MoodDown then
			return var_5_13 < var_5_12
		elseif var_5_11 == CritterEnum.OrderType.MoodUp then
			return var_5_12 < var_5_13
		end
	end

	local var_5_14 = arg_5_0:getDefineId()
	local var_5_15 = arg_5_1:getDefineId()
	local var_5_16 = CritterConfig.instance:getCritterRare(var_5_14)
	local var_5_17 = CritterConfig.instance:getCritterRare(var_5_15)

	if var_5_16 ~= var_5_17 then
		if var_5_11 == CritterEnum.OrderType.RareDown then
			return var_5_17 < var_5_16
		elseif var_5_11 == CritterEnum.OrderType.RareUp then
			return var_5_16 < var_5_17
		end
	end

	if var_5_14 ~= var_5_15 then
		return var_5_14 < var_5_15
	end

	return var_5_0 < var_5_1
end

function var_0_0.setCritterNewList(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0:clearData()

	arg_6_0._newList = {}

	local var_6_0 = CritterModel.instance:getAllCritters()

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_1 = iter_6_1:isMaturity()
		local var_6_2 = iter_6_1:isCultivating()

		if var_6_1 and not var_6_2 then
			local var_6_3

			if arg_6_2 then
				local var_6_4 = iter_6_1:getId()

				var_6_3 = ManufactureModel.instance:getCritterWorkingBuilding(var_6_4)
			end

			if not var_6_3 then
				local var_6_5 = true

				if arg_6_3 then
					var_6_5 = arg_6_3:isPassedFilter(iter_6_1)
				end

				if var_6_5 then
					table.insert(arg_6_0._newList, iter_6_1)
				end
			end
		end
	end

	arg_6_0:setTmpWorkingUid(arg_6_1)
	table.sort(arg_6_0._newList, var_0_4)
	arg_6_0:setTmpWorkingUid()
end

function var_0_0.setTmpWorkingUid(arg_7_0, arg_7_1)
	arg_7_0._tmpWorkingUid = arg_7_1
end

function var_0_0.getTmpWorkingUid(arg_8_0)
	return arg_8_0._tmpWorkingUid
end

function var_0_0.getPreviewCritterUidList(arg_9_0, arg_9_1)
	arg_9_1 = arg_9_1 or var_0_1

	local var_9_0 = {}
	local var_9_1 = arg_9_0._newList or arg_9_0:getList()
	local var_9_2 = #var_9_1
	local var_9_3 = var_9_2 <= arg_9_0._curPreviewIndex
	local var_9_4 = arg_9_1 <= var_9_2
	local var_9_5 = arg_9_0._curPreviewIndex - arg_9_1 <= var_0_3

	if not var_9_3 and var_9_4 and var_9_5 then
		local var_9_6 = arg_9_1 + (tonumber(CritterConfig.instance:getCritterConstStr(CritterEnum.ConstId.MaxPreviewCount)) or var_0_2) - 1

		for iter_9_0 = arg_9_1, var_9_6 do
			local var_9_7 = var_9_1[iter_9_0]

			if not var_9_7 then
				break
			end

			var_9_0[#var_9_0 + 1] = var_9_7:getId()
		end
	end

	return var_9_0
end

local var_0_5 = {}

function var_0_0.getPreviewAttrInfo(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_0.critterAttrPreviewDict

	if arg_10_2 then
		var_10_0 = (arg_10_3 == false and arg_10_0._buildingCritterAttrDict or arg_10_0._buildingCritterAttrPreviewDict)[arg_10_2] or arg_10_0.critterAttrPreviewDict
	end

	return var_10_0 and var_10_0[arg_10_1] or var_0_5
end

function var_0_0.setAttrPreview(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if not arg_11_1 then
		return
	end

	local var_11_0

	if arg_11_2 then
		local var_11_1 = arg_11_3 == false
		local var_11_2 = var_11_1 and arg_11_0._buildingCritterAttrDict or arg_11_0._buildingCritterAttrPreviewDict

		if not var_11_2[arg_11_2] or var_11_1 then
			var_11_2[arg_11_2] = {}
		end

		var_11_0 = var_11_2[arg_11_2]
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		local var_11_3 = iter_11_1.critterUid
		local var_11_4 = {
			isSpSkillEffect = iter_11_1.isSpSkillEffect,
			efficiency = iter_11_1.efficiency,
			moodCostSpeed = iter_11_1.moodChangeSpeed,
			moodChangeSpeed = iter_11_1.moodChangeSpeed,
			criRate = iter_11_1.criRate,
			skillTags = {}
		}

		tabletool.addValues(var_11_4.skillTags, iter_11_1.skillTags)

		arg_11_0.critterAttrPreviewDict[var_11_3] = var_11_4

		if var_11_0 then
			var_11_0[var_11_3] = var_11_4
		end
	end

	local var_11_5 = 0

	for iter_11_2, iter_11_3 in pairs(arg_11_0.critterAttrPreviewDict) do
		local var_11_6 = 0

		if arg_11_0._newList then
			for iter_11_4, iter_11_5 in ipairs(arg_11_0._newList) do
				if iter_11_5:getId() == iter_11_2 then
					var_11_6 = iter_11_4
				end
			end
		else
			local var_11_7 = arg_11_0:getById(iter_11_2)

			if var_11_7 then
				var_11_6 = arg_11_0:getIndex(var_11_7)
			end
		end

		if var_11_5 < var_11_6 then
			var_11_5 = var_11_6
		end
	end

	arg_11_0._curPreviewIndex = var_11_5
end

function var_0_0.setManufactureCritterList(arg_12_0)
	arg_12_0:setList(arg_12_0._newList)

	arg_12_0._newList = nil
end

function var_0_0.isCritterListEmpty(arg_13_0)
	return arg_13_0:getCount() <= 0
end

function var_0_0.setOrder(arg_14_0, arg_14_1)
	arg_14_0._order = arg_14_1
end

function var_0_0.getOrder(arg_15_0)
	return arg_15_0._order
end

var_0_0.instance = var_0_0.New()

return var_0_0
