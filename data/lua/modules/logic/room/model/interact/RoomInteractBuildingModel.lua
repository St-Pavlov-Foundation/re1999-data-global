module("modules.logic.room.model.interact.RoomInteractBuildingModel", package.seeall)

local var_0_0 = class("RoomInteractBuildingModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.clear(arg_3_0)
	RoomMapBuildingAreaModel.super.clear(arg_3_0)

	arg_3_0._heroId2BuildingUidDict = {}
end

function var_0_0.init(arg_4_0)
	arg_4_0._heroId2BuildingUidDict = {}

	local var_4_0 = RoomMapBuildingModel.instance:getBuildingMOList()
	local var_4_1 = RoomCharacterModel.instance

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		local var_4_2 = iter_4_1:getInteractMO()

		if var_4_2 then
			local var_4_3 = var_4_2.id
			local var_4_4 = var_4_2:getHeroIdList()

			for iter_4_2 = #var_4_4, 1, -1 do
				local var_4_5 = var_4_4[iter_4_2]

				if var_4_1:getCharacterMOById(var_4_5) == nil then
					var_4_2:removeHeroId(var_4_5)
				elseif arg_4_0._heroId2BuildingUidDict[var_4_5] == nil then
					arg_4_0._heroId2BuildingUidDict[var_4_5] = var_4_3
				elseif arg_4_0._heroId2BuildingUidDict[var_4_5] ~= var_4_3 then
					var_4_2:removeHeroId(var_4_5)
				end
			end
		end
	end
end

function var_0_0.checkAllHero(arg_5_0)
	local var_5_0 = RoomMapBuildingModel.instance:getBuildingMOList()

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		local var_5_1 = iter_5_1:getInteractMO()

		if var_5_1 then
			var_5_1:checkHeroIdList()
		end
	end
end

function var_0_0.setSelectBuildingMO(arg_6_0, arg_6_1)
	arg_6_0._selectBuildingMO = arg_6_1
	arg_6_0._selectInteractMO = nil

	if arg_6_1 then
		arg_6_0._selectInteractMO = arg_6_1:getInteractMO()
	end
end

function var_0_0.isSelectHeroId(arg_7_0, arg_7_1)
	if arg_7_0._selectInteractMO and arg_7_0._selectInteractMO:isHasHeroId(arg_7_1) then
		return true
	end

	return false
end

function var_0_0.addInteractHeroId(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0:_getInteractMOByUid(arg_8_1)

	if var_8_0 and not var_8_0:isHeroMax() then
		local var_8_1 = arg_8_0._heroId2BuildingUidDict[arg_8_2]

		arg_8_0._heroId2BuildingUidDict[arg_8_2] = arg_8_1

		var_8_0:addHeroId(arg_8_2)

		if var_8_1 then
			arg_8_0:removeInteractHeroId(var_8_1, arg_8_2)
		end
	end
end

function var_0_0.removeInteractHeroId(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:_getInteractMOByUid(arg_9_1)

	if var_9_0 and var_9_0:isHasHeroId(arg_9_2) then
		var_9_0:removeHeroId(arg_9_2)

		if arg_9_0._heroId2BuildingUidDict[arg_9_2] == arg_9_1 then
			arg_9_0._heroId2BuildingUidDict[arg_9_2] = nil
		end
	end
end

function var_0_0._getInteractMOByUid(arg_10_0, arg_10_1)
	local var_10_0 = RoomMapBuildingModel.instance:getBuildingMOById(arg_10_1)

	if var_10_0 then
		return var_10_0:getInteractMO()
	end

	return nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
