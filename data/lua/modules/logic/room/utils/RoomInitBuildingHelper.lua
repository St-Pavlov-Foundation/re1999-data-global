module("modules.logic.room.utils.RoomInitBuildingHelper", package.seeall)

local var_0_0 = {}

function var_0_0.canLevelUp()
	local var_1_0 = RoomConfig.instance:getMaxRoomLevel()
	local var_1_1 = RoomModel.instance:getRoomLevel()

	if var_1_0 <= var_1_1 then
		return false, RoomInitBuildingEnum.CanLevelUpErrorCode.MaxLevel
	end

	local var_1_2 = var_1_1 + 1
	local var_1_3 = RoomConfig.instance:getRoomLevelConfig(var_1_2)

	if not var_0_0.hasLevelUpItemEnough() then
		return false, RoomInitBuildingEnum.CanLevelUpErrorCode.NotEnoughItem
	end

	if var_1_3.needBlockCount > RoomMapBlockModel.instance:getConfirmBlockCount() then
		return false, RoomInitBuildingEnum.CanLevelUpErrorCode.NotEnoughBlock
	end

	return true
end

function var_0_0.hasLevelUpItemEnough()
	local var_2_0 = RoomModel.instance:getRoomLevel() + 1
	local var_2_1 = RoomConfig.instance:getRoomLevelConfig(var_2_0)
	local var_2_2 = RoomProductionHelper.getFormulaItemParamList(var_2_1.cost)
	local var_2_3, var_2_4 = ItemModel.instance:hasEnoughItems(var_2_2)

	return var_2_4
end

function var_0_0.getModelPath(arg_3_0)
	local var_3_0
	local var_3_1 = RoomSkinModel.instance:getShowSkin(arg_3_0)

	if RoomSkinModel.instance:isDefaultRoomSkin(arg_3_0, var_3_1) then
		var_3_0 = var_0_0.getDefaultSkinModelPath(arg_3_0)
	else
		var_3_0 = RoomConfig.instance:getRoomSkinModelPath(var_3_1) or var_0_0.getDefaultSkinModelPath(arg_3_0)
	end

	return var_3_0
end

function var_0_0.getDefaultSkinModelPath(arg_4_0)
	local var_4_0 = RoomConfig.instance:getProductionPartConfig(arg_4_0)

	if not var_4_0 then
		return nil
	end

	local var_4_1 = var_4_0.productionLines
	local var_4_2 = 0
	local var_4_3

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		local var_4_4 = 0

		if RoomController.instance:isVisitMode() then
			var_4_4 = RoomMapModel.instance:getOtherLineLevelDict()[iter_4_1] or 0
		elseif RoomController.instance:isDebugMode() then
			var_4_3 = iter_4_1
			var_4_2 = 1

			break
		else
			local var_4_5 = RoomProductionModel.instance:getLineMO(iter_4_1)

			var_4_4 = var_4_5 and var_4_5.level or 0
		end

		if (not var_4_3 or var_4_2 < var_4_4) and var_4_4 > 0 then
			var_4_3 = iter_4_1
			var_4_2 = var_4_4
		end
	end

	if not var_4_3 then
		return nil
	end

	local var_4_6 = RoomConfig.instance:getProductionLineConfig(var_4_3)
	local var_4_7 = RoomConfig.instance:getProductionLineLevelConfig(var_4_6.levelGroup, var_4_2)
	local var_4_8 = var_4_7 and var_4_7.modulePart

	if string.nilorempty(var_4_8) then
		return nil
	end

	return string.format("scenes/m_s07_xiaowu/prefab/jianzhu/a_rukou/%s.prefab", var_4_8)
end

function var_0_0.getPartRealCameraParam(arg_5_0)
	local var_5_0

	if arg_5_0 == 0 then
		var_5_0 = CommonConfig.instance:getConstStr(ConstEnum.RoomInitBuildingCameraParam)
	else
		var_5_0 = RoomConfig.instance:getProductionPartConfig(arg_5_0).cameraParam
	end

	if not string.nilorempty(var_5_0) then
		local var_5_1 = string.splitToNumber(var_5_0, "#")

		return {
			rotate = var_5_1[1],
			angle = var_5_1[2],
			distance = var_5_1[3],
			height = var_5_1[4]
		}
	end
end

return var_0_0
