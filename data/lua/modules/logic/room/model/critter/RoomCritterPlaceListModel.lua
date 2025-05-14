module("modules.logic.room.model.critter.RoomCritterPlaceListModel", package.seeall)

local var_0_0 = class("RoomCritterPlaceListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
	arg_1_0:clearData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clearData()
end

function var_0_0.clearData(arg_3_0)
	arg_3_0:setOrder(CritterEnum.OrderType.MoodUp)
end

local function var_0_1(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getId()
	local var_4_1 = arg_4_1:getId()
	local var_4_2 = ManufactureModel.instance:getCritterRestingBuilding(var_4_0)
	local var_4_3 = ManufactureModel.instance:getCritterRestingBuilding(var_4_1)
	local var_4_4 = false
	local var_4_5 = false
	local var_4_6 = var_0_0.instance:getTmpBuildingUid()

	if var_4_6 then
		var_4_4 = var_4_2 == var_4_6
		var_4_5 = var_4_3 == var_4_6
	end

	if var_4_4 ~= var_4_5 then
		return var_4_4
	end

	local var_4_7 = var_0_0.instance:getOrder()
	local var_4_8 = arg_4_0:getMoodValue()
	local var_4_9 = arg_4_1:getMoodValue()

	if var_4_8 ~= var_4_9 then
		if var_4_7 == CritterEnum.OrderType.MoodDown then
			return var_4_9 < var_4_8
		elseif var_4_7 == CritterEnum.OrderType.MoodUp then
			return var_4_8 < var_4_9
		end
	end

	local var_4_10 = arg_4_0:getDefineId()
	local var_4_11 = arg_4_1:getDefineId()
	local var_4_12 = CritterConfig.instance:getCritterRare(var_4_10)
	local var_4_13 = CritterConfig.instance:getCritterRare(var_4_11)

	if var_4_12 ~= var_4_13 then
		if var_4_7 == CritterEnum.OrderType.RareDown then
			return var_4_13 < var_4_12
		elseif var_4_7 == CritterEnum.OrderType.RareUp then
			return var_4_12 < var_4_13
		end
	end

	local var_4_14 = false
	local var_4_15 = ManufactureModel.instance:getCritterWorkingBuilding(var_4_0)
	local var_4_16 = RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(var_4_0)

	if var_4_15 or var_4_16 then
		var_4_14 = true
	end

	local var_4_17 = false
	local var_4_18 = ManufactureModel.instance:getCritterWorkingBuilding(var_4_1)
	local var_4_19 = RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(var_4_1)

	if var_4_18 or var_4_19 then
		var_4_17 = true
	end

	if var_4_14 ~= var_4_17 then
		return var_4_14
	end

	local var_4_20 = var_4_2 and true or false
	local var_4_21 = var_4_3 and true or false

	if var_4_20 ~= var_4_21 then
		return var_4_21
	end

	if var_4_10 ~= var_4_11 then
		return var_4_10 < var_4_11
	end

	return var_4_0 < var_4_1
end

function var_0_0.setCritterPlaceList(arg_5_0, arg_5_1)
	local var_5_0 = {}
	local var_5_1 = CritterModel.instance:getAllCritters()

	for iter_5_0, iter_5_1 in ipairs(var_5_1) do
		if not iter_5_1:isCultivating() then
			table.insert(var_5_0, iter_5_1)
		end
	end

	arg_5_0:setTmpBuildingUid(arg_5_1)
	table.sort(var_5_0, var_0_1)
	arg_5_0:setTmpBuildingUid()
	arg_5_0:setList(var_5_0)
	arg_5_0:refreshSelectList(arg_5_1)
end

function var_0_0.setTmpBuildingUid(arg_6_0, arg_6_1)
	arg_6_0._tmpBuildingUid = arg_6_1
end

function var_0_0.getTmpBuildingUid(arg_7_0)
	return arg_7_0._tmpBuildingUid
end

function var_0_0.refreshSelectList(arg_8_0, arg_8_1)
	local var_8_0 = {}
	local var_8_1 = RoomMapBuildingModel.instance:getBuildingMOById(arg_8_1)

	if var_8_1 then
		local var_8_2 = arg_8_0:getList()

		for iter_8_0, iter_8_1 in ipairs(var_8_2) do
			local var_8_3 = iter_8_1:getId()

			if var_8_1:isCritterInSeatSlot(var_8_3) then
				var_8_0[#var_8_0 + 1] = iter_8_1
			end
		end
	end

	for iter_8_2, iter_8_3 in ipairs(arg_8_0._scrollViews) do
		iter_8_3:setSelectList(var_8_0)
	end
end

function var_0_0.setOrder(arg_9_0, arg_9_1)
	arg_9_0._order = arg_9_1
end

function var_0_0.getOrder(arg_10_0)
	return arg_10_0._order
end

var_0_0.instance = var_0_0.New()

return var_0_0
