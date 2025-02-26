module("modules.logic.room.model.manufacture.ManufactureModel", package.seeall)

slot0 = class("ManufactureModel", BaseModel)
slot1 = 1
slot2 = 0

function slot0.onInit(slot0)
	slot0:clear()
	slot0:clearData()
end

function slot0.reInit(slot0)
	slot0:clearData()
end

function slot0.clearData(slot0)
	slot0:setSelectedSlot()
	slot0:setSelectedCritterSlot()
	slot0:setSelectedCritterSeatSlot()
	slot0:setSelectedTransportPath()
	slot0:setNewRestCritter()
	slot0:setIsJump2ManufactureBuildingList()
	slot0:setTradeLevel()
	slot0:clearCritterBuildingData()
	slot0:setCameraRecord()

	slot0._isPlayManufactureUnlock = nil
	slot0._isExpandManufacture = nil
	slot0._readFormulaDict = nil
	slot0._recordOneKeyType = nil
end

function slot0.resetDataBeforeSetInfo(slot0)
	slot0:setTradeLevel()
	slot0:clearCritterBuildingData()
	slot0:clear()
end

function slot0.clearCritterBuildingData(slot0)
	slot0._buildingCritterMOList = {}
	slot0._buildingCritterMODict = {}
end

function slot0.initNewManufactureFormulaCacheData(slot0)
	if slot0._readFormulaDict then
		return
	end

	if not string.nilorempty(GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.RoomManufactureReadFormula, "")) then
		slot0._readFormulaDict = cjson.decode(slot1)
	end

	slot0._readFormulaDict = slot0._readFormulaDict or {}
end

function slot0.setManufactureInfo(slot0, slot1)
	if not slot1 then
		return
	end

	slot0:setTradeLevel(slot1.tradeLevel)
	slot0:setManuBuildingInfoList(slot1.manuBuildingInfos)
	slot0:setCritterBuildingInfoList(slot1.restBuildingInfos)
end

function slot0.setTradeLevel(slot0, slot1)
	slot0._tradeLevel = slot1
end

function slot0.setManuBuildingInfoList(slot0, slot1)
	if not slot1 then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		slot0:setManuBuildingInfo(slot6)
	end
end

function slot0.setManuBuildingInfo(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = false

	if not slot0:getManufactureMOById(slot1.buildingUid) then
		slot3 = RoomBuildingManufactureMO.New()
		slot2 = true
	end

	slot3:init(slot1)

	if slot2 then
		slot0:addAtLast(slot3)
	end
end

function slot0.setWorkCritterInfo(slot0, slot1, slot2)
	if slot0:getManufactureMOById(slot1) then
		slot3:setWorkCritterInfo(slot2)
	end
end

function slot0.setCritterBuildingInfoList(slot0, slot1)
	if not slot1 then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		slot0:setCritterBuildingInfo(slot6)
	end
end

function slot0.setCritterBuildingInfo(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = false

	if not slot0:getCritterBuildingMOById(slot1.buildingUid) then
		slot4 = RoomBuildingCritterMO.New()
		slot2 = true
	end

	slot4:init(slot1)

	if slot2 then
		table.insert(slot0._buildingCritterMOList, slot4)

		slot0._buildingCritterMODict[slot3] = slot4
	end
end

function slot0.setPlayManufactureUnlock(slot0, slot1)
	slot0._isPlayManufactureUnlock = slot1 and uv0 or uv1

	PlayerPrefsHelper.setNumber(slot0:getManufacturePlayUnlockKey(), slot0._isPlayManufactureUnlock)
end

function slot0.setExpandManufactureBtn(slot0, slot1)
	if slot0._isExpandManufacture == slot1 then
		return
	end

	slot0._isExpandManufacture = slot1

	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.RoomExpandManufacture, slot1 and uv0 or uv1)
end

function slot0.setReadNewManufactureFormula(slot0, slot1)
	slot0:initNewManufactureFormulaCacheData()

	if not slot0._readFormulaDict[slot1] then
		slot0._readFormulaDict[slot1] = {}
	end

	for slot7, slot8 in pairs(slot0:getCanProduceManufactureItemDict(slot1)) do
		slot2[tostring(slot7)] = true
	end

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.RoomManufactureReadFormula, cjson.encode(slot0._readFormulaDict) or "")
end

function slot0.setRecordOneKeyType(slot0, slot1)
	if not LuaUtil.tableContains(RoomManufactureEnum.OneKeyType, slot1) or slot0._recordOneKeyType == slot1 then
		return
	end

	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.RoomManufactureOneKeyType, slot1)

	slot0._recordOneKeyType = slot1
end

function slot0.setSelectedSlot(slot0, slot1, slot2)
	slot0._selectedSlotBuildingUid = slot1
	slot0._selectedSlotId = slot2
end

function slot0.setSelectedCritterSlot(slot0, slot1, slot2)
	slot0._selectedCritterSlotBuildingUid = slot1
	slot0._selectedCritterSlotId = slot2
end

function slot0.setSelectedCritterSeatSlot(slot0, slot1, slot2)
	slot0._selectedCritterSeatSlotBuildingUid = slot1
	slot0._selectedCritterSeatSlotId = slot2
end

function slot0.setSelectedTransportPath(slot0, slot1)
	slot0._selectedTransportPathId = slot1
end

function slot0.setNewRestCritter(slot0, slot1)
	slot0._newRestCritter = slot1
end

function slot0.setIsJump2ManufactureBuildingList(slot0, slot1)
	slot0._isJumpManuBuildingList = slot1
end

function slot0.setCameraRecord(slot0, slot1, slot2)
	slot0._recordCameraState = slot1
	slot0._recordCameraParam = slot2
end

function slot0.getTradeLevel(slot0)
	return slot0._tradeLevel or 0
end

function slot0.getCritterWorkingBuilding(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = nil

	for slot7, slot8 in ipairs(slot0:getList()) do
		if slot8:getCritterWorkSlot(slot1) then
			slot2 = slot8.uid

			break
		end
	end

	return slot2
end

function slot0.getCritterRestingBuilding(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = nil

	for slot7, slot8 in ipairs(uv0.instance:getAllCritterBuildingMOList()) do
		if slot8:isCritterInSeatSlot(slot1) then
			slot2 = slot8.uid

			break
		end
	end

	return slot2
end

function slot0.getManufactureItemCount(slot0, slot1, slot2, slot3)
	slot4 = 0
	slot5 = 0

	if ManufactureConfig.instance:getItemId(slot1) then
		slot4 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, slot7)
	end

	if slot2 then
		slot5 = slot0:getManufactureItemCountInSlotQueue(slot1, false, slot3)
	end

	return slot4, slot5
end

function slot0.getManufactureItemCountInSlotQueue(slot0, slot1, slot2, slot3)
	for slot9, slot10 in ipairs(slot0:getList()) do
		slot4 = 0 + slot10:getManufactureItemFinishCount(slot1, slot2, slot3)
	end

	return slot4
end

function slot0.isManufactureUnlock(slot0, slot1)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.RoomManufacture) and GuideModel.instance:isGuideFinish(CritterEnum.OppenFuncGuide.RoomManufacture) then
		slot2 = true
	end

	if not slot2 and slot1 then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.RoomManufacture))
	end

	return slot2
end

function slot0.getManufacturePlayUnlockKey(slot0)
	return string.format("%s_%s", PlayerPrefsKey.RoomManufactureEntrancePlayUnlockAnim, PlayerModel.instance:getPlayinfo().userId)
end

function slot0.getPlayManufactureUnlock(slot0)
	if slot0._isPlayManufactureUnlock == nil then
		slot0._isPlayManufactureUnlock = PlayerPrefsHelper.getNumber(slot0:getManufacturePlayUnlockKey(), uv0)
	end

	return slot0._isPlayManufactureUnlock == uv1
end

function slot0.getExpandManufactureBtn(slot0)
	if not slot0._isExpandManufacture then
		slot0._isExpandManufacture = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.RoomExpandManufacture, uv0) == uv1
	end

	return slot0._isExpandManufacture
end

function slot0.getRecordOneKeyType(slot0)
	if not slot0._recordOneKeyType then
		slot0._recordOneKeyType = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.RoomManufactureOneKeyType, RoomManufactureEnum.OneKeyType.ShortTime)
	end

	return slot0._recordOneKeyType or RoomManufactureEnum.OneKeyType.ShortTime
end

function slot0.getManufactureMOById(slot0, slot1)
	return slot0:getById(slot1)
end

function slot0.getAllManufactureMOList(slot0)
	return slot0:getList()
end

function slot3(slot0, slot1)
	if slot0.config.buildingType ~= slot1.config.buildingType then
		return slot2 < slot3
	end

	if slot0.buildingId ~= slot1.buildingId then
		return slot4 < slot5
	end

	return slot0.uid < slot1.uid
end

function slot0.getAllPlacedManufactureBuilding(slot0)
	slot1 = {}

	tabletool.addValues(slot1, RoomMapBuildingModel.instance:getBuildingListByType(RoomBuildingEnum.BuildingType.Collect))
	tabletool.addValues(slot1, RoomMapBuildingModel.instance:getBuildingListByType(RoomBuildingEnum.BuildingType.Process))
	tabletool.addValues(slot1, RoomMapBuildingModel.instance:getBuildingListByType(RoomBuildingEnum.BuildingType.Manufacture))
	table.sort(slot1, uv0)

	return slot1
end

function slot0.getAllBuildingCanClaimProducts(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(slot0:getAllPlacedManufactureBuilding()) do
		if slot7:isCanClaimProduction() then
			slot1[#slot1 + 1] = slot7
		end
	end

	return slot1
end

function slot0.isMaxLevel(slot0, slot1)
	slot2 = true

	if RoomMapBuildingModel.instance:getBuildingMOById(slot1) then
		slot2 = ManufactureConfig.instance:getBuildingMaxLevel(slot3.buildingId) <= slot3.level
	end

	return slot2
end

function slot0.getManufactureLevelUpParam(slot0, slot1)
	slot2 = {
		buildingUid = slot1,
		extraCheckFunc = ManufactureController.checkTradeLevelCondition,
		extraCheckFuncObj = ManufactureController.instance
	}

	if not ManufactureConfig.instance:getBuildingUpgradeGroup(RoomMapBuildingModel.instance:getBuildingMOById(slot1).buildingId) or slot5 == 0 then
		return slot2
	end

	slot6 = slot3.level
	slot7 = slot6 + 1
	slot2.levelUpInfoList = {}

	table.insert(slot2.levelUpInfoList, {
		desc = luaLang("room_building_level_up_tip"),
		currentDesc = formatLuaLang("v1a5_aizila_level", slot6),
		nextDesc = formatLuaLang("v1a5_aizila_level", slot7)
	})

	if ManufactureConfig.instance:getBuildingSlotCount(slot4, slot6) ~= ManufactureConfig.instance:getBuildingSlotCount(slot4, slot7) then
		table.insert(slot2.levelUpInfoList, {
			desc = luaLang("room_manufacture_building_add_slot"),
			currentDesc = slot9,
			nextDesc = slot10
		})
	end

	slot11 = {}
	slot12 = {}

	for slot17, slot18 in ipairs(ManufactureConfig.instance:getNewManufactureItemList(slot5, slot7)) do
		if not slot12[ManufactureConfig.instance:getItemId(slot18)] then
			slot11[#slot11 + 1] = {
				type = MaterialEnum.MaterialType.Item,
				id = slot19
			}
			slot12[slot19] = true
		end
	end

	table.insert(slot2.levelUpInfoList, {
		desc = luaLang("room_new_manufacture_item"),
		newItemInfoList = slot11
	})

	return slot2
end

function slot0.isAreaHasManufactureRunning(slot0, slot1)
	slot2 = false

	if RoomMapBuildingAreaModel.instance:getAreaMOByBType(slot1) and slot3:getBuildingMOList(true) then
		for slot8, slot9 in ipairs(slot4) do
			if slot9:getManufactureState() == RoomManufactureEnum.ManufactureState.Running then
				slot2 = true

				break
			end
		end
	end

	return slot2
end

function slot0.getCanProduceManufactureItemDict(slot0, slot1)
	slot2 = {}

	if RoomMapBuildingModel.instance:getBuildingMOById(slot1) then
		for slot10, slot11 in ipairs(ManufactureConfig.instance:getAllManufactureItems(slot3.buildingId)) do
			if ManufactureConfig.instance:getManufactureItemNeedLevel(slot4, slot11) <= slot3:getLevel() then
				slot2[slot11] = true
			end
		end
	end

	return slot2
end

function slot0.hasNewManufactureFormula(slot0, slot1)
	slot2 = false

	slot0:initNewManufactureFormulaCacheData()

	slot3 = slot0._readFormulaDict[slot1]

	for slot8, slot9 in pairs(slot0:getCanProduceManufactureItemDict(slot1)) do
		if not slot3 or not slot3[tostring(slot8)] then
			slot2 = true

			break
		end
	end

	return slot2
end

function slot0.hasPathLinkedToThisBuildingType(slot0, slot1, slot2)
	slot3 = false

	if ManufactureConfig.instance:getManufactureItemBelongBuildingType(slot1) and slot2 and RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(slot4, slot2) then
		slot3 = slot5:isLinkFinish() and slot5:hasCritterWorking()
	end

	return slot3
end

function slot0.getCritterBuildingMOById(slot0, slot1)
	return slot0._buildingCritterMODict[slot1]
end

function slot0.getAllCritterBuildingMOList(slot0)
	return slot0._buildingCritterMOList
end

function slot0.getCritterBuildingListInOrder(slot0)
	if RoomMapBuildingModel.instance:getBuildingListByType(RoomBuildingEnum.BuildingType.Rest) then
		table.sort(slot1, RoomHelper.sortBuildingById)
	end

	return slot1
end

function slot0.getSelectedSlot(slot0)
	return slot0._selectedSlotBuildingUid, slot0._selectedSlotId
end

function slot0.getSelectedCritterSlot(slot0)
	return slot0._selectedCritterSlotBuildingUid, slot0._selectedCritterSlotId
end

function slot0.getSelectedCritterSeatSlot(slot0)
	return slot0._selectedCritterSeatSlotBuildingUid, slot0._selectedCritterSeatSlotId
end

function slot0.getSelectedTransportPath(slot0)
	return slot0._selectedTransportPathId
end

function slot0.getNewRestCritter(slot0)
	return slot0._newRestCritter
end

function slot0.getIsJump2ManufactureBuildingList(slot0)
	return slot0._isJumpManuBuildingList
end

function slot0.getCameraRecord(slot0)
	return slot0._recordCameraState, slot0._recordCameraParam
end

function slot0.getTradeBuildingListInOrder(slot0)
	if RoomMapBuildingModel.instance:getBuildingListByType(RoomBuildingEnum.BuildingType.Trade) then
		table.sort(slot1, RoomHelper.sortBuildingById)
	end

	return slot1
end

slot0.instance = slot0.New()

return slot0
