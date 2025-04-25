module("modules.logic.room.model.map.RoomBuildingMO", package.seeall)

slot0 = pureTable("RoomBuildingMO")

function slot0.init(slot0, slot1)
	slot0:setUid(slot1.uid)

	slot0.buildingId = slot1.buildingId or slot1.defineId
	slot0.rotate = slot1.rotate or 0
	slot0.buildingState = slot1.buildingState
	slot0.use = slot1.use
	slot0.level = slot1.level or 0

	if slot0:isInMap() then
		slot0.hexPoint = HexPoint(slot1.x, slot1.y)
		slot0.resAreaDirection = slot1.resAreaDirection
	end

	slot0:refreshCfg()

	slot0._currentInteractionId = nil
end

function slot0.setUid(slot0, slot1)
	slot0.id = slot1
	slot0.uid = slot1
	slot0.buildingUid = slot1
end

function slot0.refreshCfg(slot0)
	slot0.config = RoomConfig.instance:getBuildingConfig(slot0.buildingId)

	if not slot0.config then
		logError("找不到建筑id: " .. tostring(slot0.buildingId))
	elseif slot0.config.canLevelUp and RoomConfig.instance:getLevelGroupConfig(slot0.buildingId, slot0.level) then
		slot0.config = RoomHelper.mergeCfg(slot0.config, slot1)
	end
end

function slot0.isInMap(slot0)
	return slot0.buildingState == RoomBuildingEnum.BuildingState.Map or slot0.buildingState == RoomBuildingEnum.BuildingState.Temp or slot0.buildingState == RoomBuildingEnum.BuildingState.Revert
end

function slot0.updateBuildingLevels(slot0)
end

function slot0.setCurrentInteractionId(slot0, slot1)
	slot0._currentInteractionId = slot1
end

function slot0.getCurrentInteractionId(slot0)
	return slot0._currentInteractionId
end

function slot0.getInteractMO(slot0)
	if slot0:checkSameType(RoomBuildingEnum.BuildingType.Interact) then
		if not slot0._interactMO then
			slot0._interactMO = RoomInteractBuildingMO.New()

			slot0._interactMO:init(slot0)
		end

		return slot0._interactMO
	end

	return nil
end

function slot0.getPlaceAudioId(slot0, slot1)
	if slot0.config and slot0.config.placeAudio and slot0.config.placeAudio ~= 0 then
		return slot0.config.placeAudio
	end

	if slot1 then
		return 0
	end

	return AudioEnum.Room.play_ui_home_board_lay
end

function slot0.getLevel(slot0)
	return slot0.level
end

function slot0.getIcon(slot0)
	if slot0.config then
		if slot0.config.canLevelUp and slot0.levelConfig and not string.nilorempty(slot0.levelConfig.icon) then
			return slot0.levelConfig.icon
		end

		return slot0.config.icon
	end
end

function slot0.getLevelUpIcon(slot0)
	slot1 = nil

	if slot0.config and slot0.config.canLevelUp then
		slot1 = slot0.config.levelUpIcon
	end

	return slot1
end

function slot0._getCfgParam(slot0)
end

function slot0.getCanPlaceCritterCount(slot0)
	return ManufactureConfig.instance:getBuildingCanPlaceCritterCount(slot0.buildingId, ManufactureModel.instance:getTradeLevel())
end

function slot0.getWorkingCritter(slot0, slot1)
	slot2 = nil

	if ManufactureModel.instance:getManufactureMOById(slot0.id) then
		slot2 = slot3:getWorkingCritter(slot1)
	end

	return slot2
end

function slot0.getCritterWorkSlot(slot0, slot1)
	slot2 = nil

	if ManufactureModel.instance:getManufactureMOById(slot0.id) then
		slot2 = slot3:getCritterWorkSlot(slot1)
	end

	return slot2
end

function slot0.getSeatSlotMO(slot0, slot1, slot2)
	slot3 = nil

	if ManufactureModel.instance:getCritterBuildingMOById(slot0.id) then
		slot3 = slot4:getSeatSlotMO(slot1, slot2)
	end

	return slot3
end

function slot0.getRestingCritter(slot0, slot1)
	slot2 = nil

	if slot0:getSeatSlotMO(slot1) then
		slot2 = slot3:getRestingCritter()
	end

	return slot2
end

function slot0.isSeatSlotEmpty(slot0, slot1)
	slot2 = true

	if slot0:getSeatSlotMO(slot1) then
		slot2 = slot3:isEmpty()
	end

	return slot2
end

function slot0.isCritterInSeatSlot(slot0, slot1)
	slot2 = nil

	if ManufactureModel.instance:getCritterBuildingMOById(slot0.id) then
		slot2 = slot3:isCritterInSeatSlot(slot1)
	end

	return slot2
end

function slot0.getNextEmptyCritterSeatSlot(slot0)
	slot1 = nil

	if ManufactureModel.instance:getCritterBuildingMOById(slot0.id) then
		slot1 = slot2:getNextEmptyCritterSeatSlot()
	end

	return slot1
end

function slot0.isCanClaimProduction(slot0)
	slot1 = false

	if ManufactureModel.instance:getManufactureMOById(slot0.id) then
		slot1 = slot2:isHasCompletedProduction()
	end

	return slot1
end

function slot0.getNewerCompleteManufactureItem(slot0)
	slot1 = nil

	if ManufactureModel.instance:getManufactureMOById(slot0.id) then
		slot1 = slot2:getNewerCompleteManufactureItem()
	end

	return slot1
end

function slot0.getAllUnlockedSlotIdList(slot0)
	slot1 = {}

	if ManufactureModel.instance:getManufactureMOById(slot0.id) then
		slot1 = slot2:getAllUnlockedSlotIdList()
	end

	return slot1
end

function slot0.getManufactureState(slot0)
	slot1 = nil

	if ManufactureModel.instance:getManufactureMOById(slot0.id) then
		slot1 = slot2:getManufactureState()
	end

	return slot1
end

function slot0.getManufactureProgress(slot0)
	slot1 = 0
	slot2 = ""

	if ManufactureModel.instance:getManufactureMOById(slot0.id) then
		slot1, slot2 = slot3:getManufactureProgress()
	end

	return slot1, slot2
end

function slot0.getOccupySlotCount(slot0, slot1)
	slot2 = 0

	if ManufactureModel.instance:getManufactureMOById(slot0.id) then
		slot2 = slot3:getOccupySlotCount(slot1)
	end

	return slot2
end

function slot0.getEmptySlotIdList(slot0)
	slot1 = {}

	if ManufactureModel.instance:getManufactureMOById(slot0.id) then
		slot1 = slot2:getEmptySlotIdList()
	end

	return slot1
end

function slot0.getSlotIdInProgress(slot0)
	slot1 = nil

	if ManufactureModel.instance:getManufactureMOById(slot0.id) then
		slot1 = slot2:getSlotIdInProgress()
	end

	return slot1
end

function slot0.getCanChangeMaxPriority(slot0)
	slot1 = nil

	if ManufactureModel.instance:getManufactureMOById(slot0.id) then
		slot1 = slot2:getCanChangeMaxPriority()
	end

	return slot1
end

function slot0.getSlotMO(slot0, slot1, slot2)
	slot3 = nil

	if ManufactureModel.instance:getManufactureMOById(slot0.id) then
		slot3 = slot4:getSlotMO(slot1, slot2)
	end

	return slot3
end

function slot0.getSlotState(slot0, slot1, slot2)
	slot3 = RoomManufactureEnum.SlotState.Locked

	if slot0:getSlotMO(slot1) then
		slot3 = slot4:getSlotState(slot2)
	end

	return slot3
end

function slot0.getSlotProgress(slot0, slot1)
	slot2 = 0

	if slot0:getSlotMO(slot1) then
		slot2 = slot3:getSlotProgress()
	end

	return slot2
end

function slot0.getSlotRemainStrTime(slot0, slot1, slot2)
	slot3 = ""

	if slot0:getSlotMO(slot1) then
		slot3 = slot4:getSlotRemainStrTime(slot2)
	end

	return slot3
end

function slot0.getSlotRemainSecTime(slot0, slot1)
	slot2 = 0

	if slot0:getSlotMO(slot1) then
		slot2 = slot3:getSlotRemainSecTime()
	end

	return slot2
end

function slot0.getAccelerateEff(slot0, slot1, slot2)
	slot3 = 0

	if slot0:getSlotMO(slot1) then
		slot3 = slot4:getSlotAccelerateEff(slot2)
	end

	return slot3
end

function slot0.getSlotManufactureItemId(slot0, slot1)
	slot2 = nil

	if slot0:getSlotMO(slot1) then
		slot2 = slot3:getSlotManufactureItemId()
	end

	return slot2
end

function slot0.getSlotFinishCount(slot0, slot1)
	slot2 = 0

	if slot0:getSlotMO(slot1) then
		slot2 = slot3:getFinishCount()
	end

	return slot2
end

function slot0.getSlotPriority(slot0, slot1)
	slot2 = nil

	if slot0:getSlotMO(slot1) then
		slot2 = slot3:getSlotPriority()
	end

	return slot2
end

function slot0.checkSameType(slot0, slot1)
	if slot0.config and slot0.config.buildingType == slot1 then
		return true
	end

	return false
end

function slot0.getSlot2CritterDict(slot0)
	slot1 = {}

	if ManufactureModel.instance:getManufactureMOById(slot0.id) then
		slot1 = slot2:getSlot2CritterDict()
	end

	return slot1
end

function slot0.isBuildingArea(slot0)
	if slot0.config and RoomBuildingEnum.BuildingArea[slot0.config.buildingType] then
		return true
	end

	return false
end

function slot0.isAreaMainBuilding(slot0)
	if slot0.config and slot0.config.isAreaMainBuilding then
		return true
	end

	return false
end

return slot0
