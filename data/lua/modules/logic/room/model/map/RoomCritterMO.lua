module("modules.logic.room.model.map.RoomCritterMO", package.seeall)

local var_0_0 = pureTable("RoomCritterMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.uid
	arg_1_0.uid = arg_1_1.uid
	arg_1_0.critterId = arg_1_1.critterId or arg_1_1.defineId
	arg_1_0.skinId = arg_1_1.skinId
	arg_1_0.currentPosition = arg_1_1.currentPosition
	arg_1_0.heroId = arg_1_1.heroId or nil
	arg_1_0.characterId = arg_1_1.characterId or nil
end

function var_0_0.initWithBuildingValue(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.id = arg_2_1
	arg_2_0.uid = arg_2_1

	local var_2_0 = CritterModel.instance:getCritterMOByUid(arg_2_0.id)

	arg_2_0.critterId = var_2_0 and var_2_0.defineId
	arg_2_0.skinId = var_2_0 and var_2_0:getSkinId()
	arg_2_0.stayBuildingUid = arg_2_2
	arg_2_0.stayBuildingSlotId = arg_2_3
end

function var_0_0.setIsRestCritter(arg_3_0, arg_3_1)
	arg_3_0._isRestCritter = arg_3_1
end

function var_0_0.getId(arg_4_0)
	return arg_4_0.id
end

function var_0_0.getSkinId(arg_5_0)
	local var_5_0 = arg_5_0.skinId

	if not var_5_0 then
		local var_5_1 = arg_5_0:getId()

		var_5_0 = CritterModel.instance:getCritterSkinId(var_5_1)
	end

	return var_5_0
end

function var_0_0.getCurrentPosition(arg_6_0)
	return arg_6_0.currentPosition
end

function var_0_0.getStayBuilding(arg_7_0)
	return arg_7_0.stayBuildingUid, arg_7_0.stayBuildingSlotId
end

function var_0_0.isRestingCritter(arg_8_0)
	local var_8_0 = false
	local var_8_1
	local var_8_2

	if arg_8_0._isRestCritter then
		var_8_2 = true
	else
		local var_8_3 = RoomMapBuildingModel.instance:getBuildingMOById(arg_8_0.stayBuildingUid)

		var_8_1 = var_8_3 and var_8_3:isCritterInSeatSlot(arg_8_0.uid)
		var_8_2 = var_8_1 and true or false
	end

	return var_8_2, var_8_1
end

function var_0_0.getSpecialRate(arg_9_0)
	return CritterConfig.instance:getCritterSpecialRate(arg_9_0.critterId) / 1000
end

return var_0_0
