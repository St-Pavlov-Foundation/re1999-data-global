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

	slot0._frozenMatDict = nil
	slot0._needMatDict = nil
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
	slot0:setFrozenItemDict(slot1.frozenItems2Count)
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

	slot0:refreshAllNeedMat()
end

function slot0.setManuBuildingInfo(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	slot3 = false

	if not slot0:getManufactureMOById(slot1.buildingUid) then
		slot4 = RoomBuildingManufactureMO.New()
		slot3 = true
	end

	slot4:init(slot1)

	if slot3 then
		slot0:addAtLast(slot4)
	end

	if slot2 then
		slot0:refreshAllNeedMat()
	end
end

function slot0.setFrozenItemDict(slot0, slot1)
	slot0._frozenMatDict = {}

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			slot0._frozenMatDict[slot6.materialId] = slot6.quantity + (slot0._frozenMatDict[slot6.materialId] or 0)
		end
	end
end

function slot0._isCanFrozenItem(slot0, slot1, slot2)
	if not ManufactureConfig.instance:getManufactureItemListByItemId(slot1)[1] then
		return false
	end

	if slot0:getManufactureItemCount(slot4) < slot2 then
		return false
	end

	if slot0:getFrozenManufactureItemCount(slot4) + slot2 < 0 then
		return false
	end

	return true
end

function slot0.clientCalAllFrozenItemDict(slot0)
	slot0._frozenMatDict = {}

	for slot5, slot6 in ipairs(slot0:getAllPlacedManufactureBuilding()) do
		for slot11, slot12 in ipairs(slot6:getAllUnlockedSlotIdList()) do
			if slot6:getSlotState(slot12, true) == RoomManufactureEnum.SlotState.Wait then
				for slot20, slot21 in ipairs(ManufactureConfig.instance:getNeedMatItemList(slot6:getSlotManufactureItemId(slot12))) do
					if slot0:_isCanFrozenItem(ManufactureConfig.instance:getItemId(slot21.id), slot21.quantity) then
						-- Nothing
					else
						slot14 = {}

						break
					end
				end

				for slot20, slot21 in pairs({
					[slot22] = slot23
				}) do
					slot0._frozenMatDict[slot20] = (slot0._frozenMatDict[slot20] or 0) + slot21
				end
			end
		end
	end
end

function slot0.refreshAllNeedMat(slot0)
	slot0._needMatDict = {}

	for slot5, slot6 in ipairs(slot0:getList()) do
		for slot11, slot12 in pairs(slot6:getNeedMatDict()) do
			slot0._needMatDict[slot11] = slot12 + (slot0._needMatDict[slot11] or 0)
		end
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

function slot0.getManufactureItemCount(slot0, slot1, slot2, slot3, slot4)
	slot5 = 0
	slot6 = 0

	if ManufactureConfig.instance:getItemId(slot1) then
		slot9 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, slot8)
		slot5 = slot4 and slot9 or slot9 - slot0:getFrozenManufactureItemCount(slot1)
	end

	if slot2 then
		slot6 = slot0:getManufactureItemCountInSlotQueue(slot1, false, slot3)
	end

	return slot5, slot6
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

	if slot0._recordOneKeyType == RoomManufactureEnum.OneKeyType.Customize and not OneKeyAddPopListModel.instance:getSelectedManufactureItem() then
		slot0._recordOneKeyType = slot1
	end

	return slot0._recordOneKeyType or slot1
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

function slot0.getMaxCanProductCount(slot0, slot1)
	if not slot1 then
		return OneKeyAddPopListModel.MINI_COUNT, true
	end

	slot3 = 0
	slot4, slot5 = ManufactureConfig.instance:getManufactureItemUnitCountRange(slot1)
	slot6 = slot4 / slot5

	if RoomMapBuildingModel.instance:getBuildingListByType(ManufactureConfig.instance:getManufactureItemBelongBuildingType(slot1)) and #slot8 > 0 then
		for slot12, slot13 in ipairs(slot8) do
			if ManufactureConfig.instance:isManufactureItemBelongBuilding(slot13.buildingId, slot1) then
				slot15 = 0

				if #slot13:getEmptySlotIdList() > 0 then
					slot15 = #slot16 * slot6
				end

				slot3 = slot3 + slot15
			end
		end
	end

	return math.max(slot3, OneKeyAddPopListModel.MINI_COUNT), slot3 == 0
end

function slot0.getManufactureWrongType(slot0, slot1, slot2)
	if (RoomMapBuildingModel.instance:getBuildingMOById(slot1) and slot3:getSlotState(slot2)) ~= RoomManufactureEnum.SlotState.Stop then
		return
	end

	slot5 = nil

	for slot12, slot13 in ipairs(ManufactureConfig.instance:getNeedMatItemList(slot3:getSlotManufactureItemId(slot2))) do
		slot16, slot17 = slot0:getManufactureItemCount(slot13.id, true, true, true)

		if slot16 < slot13.quantity then
			slot5 = (slot15 > slot16 + slot17 or (not slot0:hasPathLinkedToThisBuildingType(slot14, slot3.config.buildingType) or RoomManufactureEnum.ManufactureWrongType.WaitPreMat) and RoomManufactureEnum.ManufactureWrongType.NoLinkPath) and RoomManufactureEnum.ManufactureWrongType.LackPreMat
		end

		if slot5 and slot5 ~= RoomManufactureEnum.ManufactureWrongType.WaitPreMat then
			break
		end
	end

	if not slot5 and not next(slot3:getSlot2CritterDict()) then
		slot5 = RoomManufactureEnum.ManufactureWrongType.NoCritter
	end

	return slot5
end

function slot0.getManufactureWrongTipItemList(slot0, slot1)
	if not RoomMapBuildingModel.instance:getBuildingMOById(slot1) then
		return {}
	end

	slot4 = {}

	for slot9, slot10 in ipairs(slot3:getAllUnlockedSlotIdList()) do
		if slot0:getManufactureWrongType(slot1, slot10) and slot11 ~= RoomManufactureEnum.ManufactureWrongType.WaitPreMat then
			if not slot4[slot3:getSlotManufactureItemId(slot10)] then
				slot4[slot12] = {}
			end

			slot13[#slot13 + 1] = slot10
		end
	end

	for slot9, slot10 in pairs(slot4) do
		slot2[#slot2 + 1] = {
			manufactureItemId = slot9,
			wrongSlotIdList = slot10
		}
	end

	return slot2
end

function slot0.getAllWrongManufactureItemList(slot0, slot1, slot2, slot3)
	if not RoomMapBuildingModel.instance:getBuildingMOById(slot1) then
		return {}, {}
	end

	slot7 = {}
	slot8 = slot6.config.buildingType

	for slot13, slot14 in ipairs(ManufactureConfig.instance:getNeedMatItemList(slot2)) do
		slot15 = true
		slot17 = slot14.quantity * slot3
		slot18 = nil

		if RoomMapBuildingModel.instance:getBuildingListByType(ManufactureConfig.instance:getManufactureItemBelongBuildingType(slot14.id)) and #slot20 > 0 then
			for slot24, slot25 in ipairs(slot20) do
				if ManufactureConfig.instance:isManufactureItemBelongBuilding(slot25.buildingId, slot16) then
					if ManufactureConfig.instance:getManufactureItemNeedLevel(slot26, slot16) and slot29 <= slot25:getLevel() then
						slot15 = false

						break
					end
				end
			end
		end

		if slot15 then
			slot18 = RoomManufactureEnum.ManufactureWrongType.PreMatNotUnlock
		else
			slot21, slot22 = slot0:getManufactureItemCount(slot16, true, true)

			if slot21 < slot17 then
				if slot17 <= slot21 + slot22 then
					if not slot0:hasPathLinkedToThisBuildingType(slot16, slot8) then
						slot18 = RoomManufactureEnum.ManufactureWrongType.NoLinkPath
					end
				else
					slot18 = RoomManufactureEnum.ManufactureWrongType.LackPreMat
				end
			end
		end

		if slot18 then
			if not slot7[slot18] then
				slot7[slot18] = {}
			end

			slot21[#slot21 + 1] = {
				manufactureItemId = slot16,
				buildingType = ManufactureConfig.instance:getManufactureItemBelongBuildingType(slot16),
				needQuantity = slot17
			}
		end
	end

	slot10 = {}

	for slot14, slot15 in pairs(slot7) do
		for slot19, slot20 in ipairs(slot15) do
			if slot14 ~= RoomManufactureEnum.ManufactureWrongType.NoLinkPath or not slot10[slot20.buildingType] then
				slot4[#slot4 + 1] = {
					manufactureItemId = slot20.manufactureItemId,
					wrongType = slot14,
					buildingType = slot20.buildingType,
					needQuantity = slot20.needQuantity
				}

				if slot14 == RoomManufactureEnum.ManufactureWrongType.NoLinkPath then
					slot10[slot20.buildingType] = true
				end
			end
		end

		slot5[#slot5 + 1] = slot14
	end

	if not next(slot6:getSlot2CritterDict()) then
		slot5[#slot5 + 1] = RoomManufactureEnum.ManufactureWrongType.NoCritter
	end

	return slot4, slot5
end

function slot0.getFrozenManufactureItemCount(slot0, slot1)
	return slot0._frozenMatDict and slot0._frozenMatDict[ManufactureConfig.instance:getItemId(slot1)] or 0
end

function slot0.getLackMatCount(slot0, slot1)
	slot2, slot3 = slot0:getManufactureItemCount(slot1, true, true, true)
	slot5 = true
	slot6, slot7 = RoomTradeModel.instance:getTracedGoodsCount(slot1)

	if math.max(0, slot6 + slot7 - (slot2 + slot3)) <= 0 then
		slot5 = false
		slot8 = math.max(0, slot0:getNeedMatCount(slot1) + slot6 - slot4)
	end

	slot9 = ManufactureConfig.instance:getItemId(slot1)

	for slot14, slot15 in ipairs(slot0:getAllPlacedManufactureBuilding()) do
		if slot15:getSlotManufactureItemId(slot15:getSlotIdInProgress()) then
			for slot22, slot23 in ipairs(ManufactureConfig.instance:getNeedMatItemList(slot17)) do
				if ManufactureConfig.instance:getItemId(slot23.id) == slot9 then
					slot8 = slot8 - slot23.quantity
				end
			end
		end
	end

	return math.max(0, slot8), slot5
end

function slot0.getNeedMatCount(slot0, slot1)
	return slot0._needMatDict and slot0._needMatDict[ManufactureConfig.instance:getItemId(slot1)] or 0
end

function slot0.getCritterBuildingMOById(slot0, slot1)
	return slot0._buildingCritterMODict[slot1]
end

function slot0.getAllCritterBuildingMOList(slot0)
	return slot0._buildingCritterMOList
end

function slot0.getCritterBuildingListInOrder(slot0)
	return RoomMapBuildingModel.instance:getBuildingListByType(RoomBuildingEnum.BuildingType.Rest, true)
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
	return RoomMapBuildingModel.instance:getBuildingListByType(RoomBuildingEnum.BuildingType.Trade, true)
end

slot0.instance = slot0.New()

return slot0
