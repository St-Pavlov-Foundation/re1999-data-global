module("modules.logic.room.model.map.RoomCritterModel", package.seeall)

local var_0_0 = class("RoomCritterModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:_clearData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:_clearData()
end

function var_0_0._clearData(arg_3_0)
	arg_3_0:clearBuildingCritterData()
end

function var_0_0.clearBuildingCritterData(arg_4_0)
	arg_4_0._buildingCritterList = {}
	arg_4_0._buildingCritterDict = {}
end

function var_0_0.initCititer(arg_5_0, arg_5_1)
	arg_5_0:clear()

	local var_5_0 = {}

	if arg_5_1 then
		for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
			local var_5_1 = RoomCritterMO.New()

			var_5_1:init(iter_5_1)
			table.insert(var_5_0, var_5_1)
		end
	end

	arg_5_0:setList(var_5_0)
end

function var_0_0.initStayBuildingCritters(arg_6_0)
	arg_6_0:clearBuildingCritterData()

	local var_6_0 = ManufactureModel.instance:getAllManufactureMOList()

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_1 = iter_6_1:getSlot2CritterDict()

		if var_6_1 then
			local var_6_2 = iter_6_1:getBuildingUid()

			for iter_6_2, iter_6_3 in pairs(var_6_1) do
				local var_6_3 = RoomCritterMO.New()

				var_6_3:initWithBuildingValue(iter_6_3, var_6_2, iter_6_2)

				arg_6_0._buildingCritterList[#arg_6_0._buildingCritterList + 1] = var_6_3
				arg_6_0._buildingCritterDict[iter_6_3] = var_6_3
			end
		end
	end

	local var_6_4 = ManufactureModel.instance:getAllCritterBuildingMOList()

	for iter_6_4, iter_6_5 in ipairs(var_6_4) do
		local var_6_5 = iter_6_5:getSeatSlot2CritterDict()
		local var_6_6 = iter_6_5:getBuildingUid()

		for iter_6_6, iter_6_7 in pairs(var_6_5) do
			local var_6_7 = RoomCritterMO.New()

			var_6_7:initWithBuildingValue(iter_6_7, var_6_6, iter_6_6)

			arg_6_0._buildingCritterList[#arg_6_0._buildingCritterList + 1] = var_6_7
			arg_6_0._buildingCritterDict[iter_6_7] = var_6_7
		end
	end
end

function var_0_0.getRoomBuildingCritterList(arg_7_0)
	return arg_7_0._buildingCritterList
end

function var_0_0.getCritterMOById(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getById(arg_8_1)

	if not var_8_0 and arg_8_0._buildingCritterDict then
		var_8_0 = arg_8_0._buildingCritterDict[arg_8_1]
	end

	if not var_8_0 and arg_8_0._tempCritterMO and arg_8_1 == arg_8_0._tempCritterMO.uid then
		return arg_8_0._tempCritterMO
	end

	return var_8_0
end

function var_0_0.getTrainCritterMOList(arg_9_0)
	return arg_9_0:getList()
end

function var_0_0.removeTrainCritterMO(arg_10_0, arg_10_1)
	arg_10_0:remove(arg_10_1)
end

function var_0_0.getAllCritterList(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = arg_11_0:getList()
	local var_11_2 = arg_11_0:getRoomBuildingCritterList()

	tabletool.addValues(var_11_0, var_11_1)
	tabletool.addValues(var_11_0, var_11_2)

	return var_11_0
end

function var_0_0.getTempCritterMO(arg_12_0)
	if not arg_12_0._tempCritterMO then
		arg_12_0._tempCritterMO = RoomCritterMO.New()
	end

	return arg_12_0._tempCritterMO
end

var_0_0.instance = var_0_0.New()

return var_0_0
