module("modules.logic.room.utils.RoomInitBuildingHelper", package.seeall)

return {
	canLevelUp = function ()
		if RoomConfig.instance:getMaxRoomLevel() <= RoomModel.instance:getRoomLevel() then
			return false, RoomInitBuildingEnum.CanLevelUpErrorCode.MaxLevel
		end

		slot3 = RoomConfig.instance:getRoomLevelConfig(slot1 + 1)

		if not uv0.hasLevelUpItemEnough() then
			return false, RoomInitBuildingEnum.CanLevelUpErrorCode.NotEnoughItem
		end

		if RoomMapBlockModel.instance:getConfirmBlockCount() < slot3.needBlockCount then
			return false, RoomInitBuildingEnum.CanLevelUpErrorCode.NotEnoughBlock
		end

		return true
	end,
	hasLevelUpItemEnough = function ()
		slot4, slot5 = ItemModel.instance:hasEnoughItems(RoomProductionHelper.getFormulaItemParamList(RoomConfig.instance:getRoomLevelConfig(RoomModel.instance:getRoomLevel() + 1).cost))

		return slot5
	end,
	getModelPath = function (slot0)
		slot1 = nil

		return (not RoomSkinModel.instance:isDefaultRoomSkin(slot0, RoomSkinModel.instance:getShowSkin(slot0)) or uv0.getDefaultSkinModelPath(slot0)) and (RoomConfig.instance:getRoomSkinModelPath(slot2) or uv0.getDefaultSkinModelPath(slot0))
	end,
	getDefaultSkinModelPath = function (slot0)
		if not RoomConfig.instance:getProductionPartConfig(slot0) then
			return nil
		end

		slot3 = 0
		slot4 = nil

		for slot8, slot9 in ipairs(slot1.productionLines) do
			slot10 = 0

			if RoomController.instance:isVisitMode() then
				slot10 = RoomMapModel.instance:getOtherLineLevelDict()[slot9] or 0
			elseif RoomController.instance:isDebugMode() then
				slot4 = slot9
				slot3 = 1

				break
			else
				slot10 = RoomProductionModel.instance:getLineMO(slot9) and slot11.level or 0
			end

			if (not slot4 or slot3 < slot10) and slot10 > 0 then
				slot4 = slot9
				slot3 = slot10
			end
		end

		if not slot4 then
			return nil
		end

		if string.nilorempty(RoomConfig.instance:getProductionLineLevelConfig(RoomConfig.instance:getProductionLineConfig(slot4).levelGroup, slot3) and slot6.modulePart) then
			return nil
		end

		return string.format("scenes/m_s07_xiaowu/prefab/jianzhu/a_rukou/%s.prefab", slot7)
	end,
	getPartRealCameraParam = function (slot0)
		slot1 = nil

		if not string.nilorempty((slot0 ~= 0 or CommonConfig.instance:getConstStr(ConstEnum.RoomInitBuildingCameraParam)) and RoomConfig.instance:getProductionPartConfig(slot0).cameraParam) then
			slot2 = string.splitToNumber(slot1, "#")

			return {
				rotate = slot2[1],
				angle = slot2[2],
				distance = slot2[3],
				height = slot2[4]
			}
		end
	end
}
