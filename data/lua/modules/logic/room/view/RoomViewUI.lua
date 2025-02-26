module("modules.logic.room.view.RoomViewUI", package.seeall)

slot0 = class("RoomViewUI", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._cameraStateShowUIMap = {
		[RoomEnum.CameraState.Overlook] = true,
		[RoomEnum.CameraState.OverlookAll] = true
	}
	slot0._showBuildingItemTypeMap = {
		[RoomBuildingEnum.BuildingType.Interact] = true
	}
	slot0._gopart = gohelper.findChild(slot0.viewGO, "go_normalroot/go_ui/go_part")
	slot0._canvasGroup = gohelper.onceAddComponent(slot0._gopart, typeof(UnityEngine.CanvasGroup))
	slot0._scene = GameSceneMgr.instance:getCurScene()
	slot0._manufactureItemDict = {}
end

function slot0._onDelayInit(slot0)
	slot0._isRunDalayInit = true

	slot0:_initPartItem()
	slot0:_initInitItem()
	slot0:_initCharacterItem()
	slot0:_initCharacterInteractionItem()
	slot0:_refreshCharacterItem()
	slot0:_refreshCharacterInteractionItem()
	slot0:_refreshManufactureItem()
	slot0:_refreshTransportSiteItem()
	slot0:_refreshCritterBuildingItem()
	slot0:_refreshTradeBuildingItem()
	slot0:_refreshCritterItem()
	slot0:_refreshBuildingItem()
	slot0:_sort()
end

function slot0._sort(slot0)
	if not slot0._isRunDalayInit then
		return
	end

	slot0._uiItemList = {}

	LuaUtil.insertDict(slot0._uiItemList, slot0._partItemDict)
	table.insert(slot0._uiItemList, slot0._initItem)
	LuaUtil.insertDict(slot0._uiItemList, slot0._characterItemDict)
	LuaUtil.insertDict(slot0._uiItemList, slot0._characterInteractionItemDict)
	LuaUtil.insertDict(slot0._uiItemList, slot0._manufactureItemDict)
	LuaUtil.insertDict(slot0._uiItemList, slot0._transportSiteItemDict)
	table.insert(slot0._uiItemList, slot0._critterBuildingItem)
	table.insert(slot0._uiItemList, slot0._tradeBuildingItem)
	LuaUtil.insertDict(slot0._uiItemList, slot0._critterItemDict)
	LuaUtil.insertDict(slot0._uiItemList, slot0._buildingItemDict)

	for slot5, slot6 in ipairs(slot0._uiItemList) do
		slot6.__distance = Vector3.Distance(slot0._scene.camera:getCameraPosition(), slot6:getUI3DPos())
	end

	table.sort(slot0._uiItemList, function (slot0, slot1)
		return slot1.__distance < slot0.__distance
	end)

	for slot5, slot6 in ipairs(slot0._uiItemList) do
		gohelper.setAsLastSibling(slot6.go)
	end
end

function slot0._initPartItem(slot0)
	slot1 = slot0.viewContainer._viewSetting.otherRes[10]
	slot0._partItemDict = {}

	if not RoomController.instance:isObMode() then
		return
	end

	for slot5, slot6 in ipairs(lua_production_part.configList) do
		if not slot0._partItemDict[slot6.id] then
			slot0._partItemDict[slot7] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot1, slot0._gopart, "partId" .. slot7), RoomViewUIPartItem, slot7)
		end
	end
end

function slot0._initInitItem(slot0)
	slot1 = slot0.viewContainer._viewSetting.otherRes[10]
	slot0._initItem = nil

	if not RoomController.instance:isObMode() then
		return
	end

	if not slot0._initItem then
		slot0._initItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot1, slot0._gopart, "init"), RoomViewUIInitItem)
	end
end

function slot0._initCharacterItem(slot0)
	slot0._gocharacterui = gohelper.findChild(slot0.viewGO, "go_normalroot/go_ui/go_part/go_characterui")

	gohelper.setActive(slot0._gocharacterui, false)

	slot0._characterItemDict = {}
end

function slot0._initCharacterInteractionItem(slot0)
	slot0._gocharacterinteractionui = gohelper.findChild(slot0.viewGO, "go_normalroot/go_ui/go_part/go_characterinteractionui")

	gohelper.setActive(slot0._gocharacterinteractionui, false)

	slot0._characterInteractionItemDict = {}
end

function slot0._refreshCharacterItem(slot0)
	if not slot0._isRunDalayInit then
		return
	end

	if not RoomController.instance:isObMode() and not RoomController.instance:isVisitMode() then
		return
	end

	for slot6, slot7 in pairs(slot0._scene.charactermgr:getRoomCharacterEntityDict()) do
		if not slot0._characterItemDict[slot6] then
			slot0._characterItemDict[slot6] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer._viewSetting.otherRes[9], slot0._gopart, "heroId" .. slot6), RoomViewUICharacterItem, slot6)
		end
	end

	for slot6, slot7 in pairs(slot0._characterItemDict) do
		if not slot2[slot6] then
			slot7:removeEventListeners()
			gohelper.destroy(slot7.go)

			slot0._characterItemDict[slot6] = nil
		end
	end
end

function slot0._refreshCharacterInteractionItem(slot0)
	if not slot0._isRunDalayInit then
		return
	end

	if not RoomController.instance:isObMode() or not RoomEnum.IsShowUICharacterInteraction then
		return
	end

	for slot6, slot7 in pairs(slot0._scene.charactermgr:getRoomCharacterEntityDict()) do
		if not slot0._characterInteractionItemDict[slot6] then
			slot0._characterInteractionItemDict[slot6] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer._viewSetting.otherRes[8], slot0._gopart, "interaction" .. slot6), RoomViewUICharacterInteractionItem, slot6)
		end
	end

	for slot6, slot7 in pairs(slot0._characterInteractionItemDict) do
		if not slot2[slot6] then
			slot7:removeEventListeners()
			gohelper.destroy(slot7.go)

			slot0._characterInteractionItemDict[slot6] = nil
		end
	end
end

function slot0.onClickBellTower(slot0)
	slot1 = slot0._partItemDict[1]

	if not RoomController.instance:isObMode() or not slot1 or not slot1._isShow then
		return
	end

	slot1:_onClick()
end

function slot0.onClickMarket(slot0)
	slot1 = slot0._partItemDict[2]

	if not RoomController.instance:isObMode() or not slot1 or not slot1._isShow then
		return
	end

	slot1:_onClick()
end

function slot0._refreshManufactureItem(slot0)
	if not RoomController.instance:isObMode() or not slot0._isRunDalayInit then
		return
	end

	for slot6, slot7 in pairs(RoomMapBuildingAreaModel.instance:getBuildingType2AreaMODict()) do
		if not slot0._manufactureItemDict[slot6] then
			slot0._manufactureItemDict[slot6] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer._viewSetting.otherRes[11], slot0._gopart, "manufacture" .. slot6), RoomViewUIManufactureItem, slot6)
		end
	end

	for slot6, slot7 in pairs(slot0._manufactureItemDict) do
		if not slot1[slot6] then
			slot7:removeEventListeners()
			gohelper.destroy(slot7.go)

			slot0._manufactureItemDict[slot6] = nil
		end
	end
end

function slot0._refreshTransportSiteItem(slot0)
	if not RoomController.instance:isObMode() or not slot0._isRunDalayInit then
		return
	end

	slot0._transportSiteItemDict = slot0._transportSiteItemDict or {}

	for slot6 = 1, #RoomTransportHelper.getSiteBuildingTypeList() do
		slot7 = slot2[slot6]

		if RoomMapTransportPathModel.instance:getSiteHexPointByType(slot7) then
			if not slot0._transportSiteItemDict[slot7] then
				slot0._transportSiteItemDict[slot7] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(RoomViewUITransportSiteItem.prefabPath, slot0._gopart, "site_" .. slot7), RoomViewUITransportSiteItem, slot7)
			end
		elseif slot9 then
			slot9:removeEventListeners()
			gohelper.destroy(slot9.go)

			slot0._transportSiteItemDict[slot7] = nil
		end
	end
end

function slot0._refreshCritterItem(slot0, slot1, slot2)
	if not RoomController.instance:isObMode() or not slot0._isRunDalayInit then
		return
	end

	slot0._critterItemDict = slot0._critterItemDict or {}

	for slot7 = 1, #CritterModel.instance:getAllCritters() do
		slot8 = slot3[slot7]
		slot9 = slot8.id

		if slot0:_isShowCritterItem(slot8) and not slot0._critterItemDict[slot9] then
			slot0._critterItemDict[slot8.id] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(RoomViewUICritterEventItem.prefabPath, slot0._gopart, "critter_" .. slot9), RoomViewUICritterEventItem, slot9)
		end
	end

	for slot7, slot8 in pairs(slot0._critterItemDict) do
		if not slot0:_isShowCritterItem(CritterModel.instance:getCritterMOByUid(slot7)) then
			if slot8 then
				slot8:removeEventListeners()
				gohelper.destroy(slot8.go)
			end

			slot0._critterItemDict[slot7] = nil
		end
	end
end

function slot0._isShowCritterItem(slot0, slot1)
	slot2 = nil
	slot3 = false

	if slot1:isCultivating() then
		slot3 = slot1.trainInfo:isHasEventTrigger()
		slot2 = slot0._scene.crittermgr:getCritterEntity(slot1:getId(), SceneTag.RoomCharacter)
	end

	slot6 = false

	if not slot3 then
		slot6 = slot1:isNoMoodWorking()
		slot2 = slot0._scene.buildingcrittermgr:getCritterEntity(slot4, SceneTag.RoomCharacter)
	end

	return slot1 and slot2 and (slot3 or slot6)
end

function slot0._refreshCritterBuildingItem(slot0)
	if not RoomController.instance:isObMode() or not slot0._isRunDalayInit then
		return
	end

	slot1 = nil

	if ManufactureModel.instance:getCritterBuildingListInOrder() then
		slot1 = slot2[1].buildingUid
	end

	if slot0._scene.buildingmgr:getBuildingEntity(slot1, SceneTag.RoomBuilding) then
		if not slot0._critterBuildingItem then
			slot0._critterBuildingItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer._viewSetting.otherRes[12], slot0._gopart, "critterBuilding"), RoomViewUICritterBuildingItem)
		end
	elseif slot0._critterBuildingItem then
		slot0._critterBuildingItem:removeEventListeners()
		gohelper.destroy(slot0._critterBuildingItem.go)

		slot0._critterBuildingItem = nil
	end
end

function slot0._refreshTradeBuildingItem(slot0)
	if not RoomController.instance:isObMode() or not slot0._isRunDalayInit then
		return
	end

	slot1 = nil

	if ManufactureModel.instance:getTradeBuildingListInOrder() then
		slot1 = slot2[1].buildingUid
	end

	if slot0._scene.buildingmgr:getBuildingEntity(slot1, SceneTag.RoomBuilding) then
		if not slot0._tradeBuildingItem then
			slot0._tradeBuildingItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer._viewSetting.otherRes[12], slot0._gopart, "tradeBuilding"), RoomViewUITradeBuildingItem)
		end
	elseif slot0._tradeBuildingItem then
		slot0._tradeBuildingItem:removeEventListeners()
		gohelper.destroy(slot0._tradeBuildingItem.go)

		slot0._tradeBuildingItem = nil
	end
end

function slot0._refreshBuildingItem(slot0)
	if not RoomController.instance:isObMode() or not slot0._isRunDalayInit then
		return
	end

	slot0._buildingItemDict = slot0._buildingItemDict or {}

	for slot5 = 1, #RoomMapBuildingModel.instance:getBuildingMOList() do
		slot6 = slot1[slot5]
		slot7 = slot6.id

		if slot6.config and slot6.config.buildingType and slot0._showBuildingItemTypeMap[slot8] and not slot0._buildingItemDict[slot7] then
			slot0._buildingItemDict[slot7] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer._viewSetting.otherRes[12], slot0._gopart, "building_" .. slot7), RoomViewUIBuildingItem, slot7)
		end
	end

	for slot5, slot6 in pairs(slot0._buildingItemDict) do
		if not RoomMapBuildingModel.instance:getBuildingMOById(slot5) then
			if slot6 then
				slot6:removeEventListeners()
				gohelper.destroy(slot6.go)
			end

			slot0._buildingItemDict[slot5] = nil
		end
	end
end

function slot0._onUseBuildingReply(slot0)
	TaskDispatcher.cancelTask(slot0._onDelayInit, slot0)
	TaskDispatcher.runDelay(slot0._onDelayInit, slot0, 0.1)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(RoomCharacterController.instance, RoomEvent.CharacterEntityChanged, slot0._refreshCharacterItem, slot0)
	slot0:addEventCb(RoomCharacterController.instance, RoomEvent.CharacterEntityChanged, slot0._refreshCharacterInteractionItem, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyRoomBellTower, slot0.onClickBellTower, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyRoomMarket, slot0.onClickMarket, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.UseBuildingReply, slot0._onUseBuildingReply, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.CameraStateUpdate, slot0._cameraStateUpdate, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.SceneTrainChangeSpine, slot0._refreshCritterItem, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.TrainSelectEventOptionReply, slot0._refreshCritterItem, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, slot0._refreshCritterItem, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, slot0._refreshCritterItem, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterInfoPushUpdate, slot0._refreshCritterItem, slot0)
	TaskDispatcher.runDelay(slot0._onDelayInit, slot0, 0.1)
	TaskDispatcher.runRepeat(slot0._sort, slot0, 1)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._sort, slot0)
	TaskDispatcher.cancelTask(slot0._onDelayInit, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyRoomBellTower, slot0.onClickBellTower, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyRoomMarket, slot0.onClickMarket, slot0)
	slot0:removeEventCb(RoomMapController.instance, RoomEvent.UseBuildingReply, slot0._onUseBuildingReply, slot0)
end

function slot0._cameraStateUpdate(slot0)
	slot0._canvasGroup.alpha = slot0._cameraStateShowUIMap[slot0._scene.camera:getCameraState()] and 1 or 0
end

function slot0.onDestroyView(slot0)
end

return slot0
