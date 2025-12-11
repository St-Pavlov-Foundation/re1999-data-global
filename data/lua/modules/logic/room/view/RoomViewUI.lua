module("modules.logic.room.view.RoomViewUI", package.seeall)

local var_0_0 = class("RoomViewUI", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._cameraStateShowUIMap = {
		[RoomEnum.CameraState.Overlook] = true,
		[RoomEnum.CameraState.OverlookAll] = true
	}
	arg_4_0._showBuildingItemTypeMap = {
		[RoomBuildingEnum.BuildingType.Interact] = true
	}
	arg_4_0._gopart = gohelper.findChild(arg_4_0.viewGO, "go_normalroot/go_ui/go_part")
	arg_4_0._canvasGroup = gohelper.onceAddComponent(arg_4_0._gopart, typeof(UnityEngine.CanvasGroup))
	arg_4_0._scene = GameSceneMgr.instance:getCurScene()
	arg_4_0._manufactureItemDict = {}
end

function var_0_0.onClickBellTower(arg_5_0)
	local var_5_0 = arg_5_0._partItemDict[1]

	if not RoomController.instance:isObMode() or not var_5_0 or not var_5_0._isShow then
		return
	end

	var_5_0:_onClick()
end

function var_0_0.onClickMarket(arg_6_0)
	local var_6_0 = arg_6_0._partItemDict[2]

	if not RoomController.instance:isObMode() or not var_6_0 or not var_6_0._isShow then
		return
	end

	var_6_0:_onClick()
end

function var_0_0._onUseBuildingReply(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._onDelayInit, arg_7_0)
	TaskDispatcher.runDelay(arg_7_0._onDelayInit, arg_7_0, 0.1)
end

function var_0_0._cameraStateUpdate(arg_8_0)
	local var_8_0 = arg_8_0._scene.camera:getCameraState()
	local var_8_1 = arg_8_0._cameraStateShowUIMap[var_8_0] and 1 or 0

	arg_8_0._canvasGroup.alpha = var_8_1
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyRoomBellTower, arg_9_0.onClickBellTower, arg_9_0)
	arg_9_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyRoomMarket, arg_9_0.onClickMarket, arg_9_0)
	arg_9_0:addEventCb(RoomMapController.instance, RoomEvent.UseBuildingReply, arg_9_0._onUseBuildingReply, arg_9_0)
	arg_9_0:addEventCb(RoomMapController.instance, RoomEvent.CameraStateUpdate, arg_9_0._cameraStateUpdate, arg_9_0)
	arg_9_0:addEventCb(RoomCharacterController.instance, RoomEvent.CharacterEntityChanged, arg_9_0._refreshCharacterItem, arg_9_0)
	arg_9_0:addEventCb(RoomCharacterController.instance, RoomEvent.CharacterEntityChanged, arg_9_0._refreshCharacterInteractionItem, arg_9_0)
	arg_9_0:addEventCb(RoomMapController.instance, RoomEvent.SceneTrainChangeSpine, arg_9_0._refreshCritterItem, arg_9_0)
	arg_9_0:addEventCb(CritterController.instance, CritterEvent.TrainSelectEventOptionReply, arg_9_0._refreshCritterItem, arg_9_0)
	arg_9_0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, arg_9_0._refreshCritterItem, arg_9_0)
	arg_9_0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, arg_9_0._refreshCritterItem, arg_9_0)
	arg_9_0:addEventCb(CritterController.instance, CritterEvent.CritterInfoPushUpdate, arg_9_0._refreshCritterItem, arg_9_0)
	TaskDispatcher.runDelay(arg_9_0._onDelayInit, arg_9_0, 0.1)
	TaskDispatcher.runRepeat(arg_9_0._sort, arg_9_0, 1)
end

function var_0_0._onDelayInit(arg_10_0)
	arg_10_0._isRunDalayInit = true

	arg_10_0:_initPartItem()
	arg_10_0:_initInitItem()
	arg_10_0:_initCharacterItem()
	arg_10_0:_initCharacterInteractionItem()
	arg_10_0:_initFishingItem()
	arg_10_0:refresh()
end

function var_0_0._initPartItem(arg_11_0)
	local var_11_0 = arg_11_0.viewContainer._viewSetting.otherRes[10]

	arg_11_0._partItemDict = {}

	if not RoomController.instance:isObMode() then
		return
	end

	for iter_11_0, iter_11_1 in ipairs(lua_production_part.configList) do
		local var_11_1 = iter_11_1.id

		if not arg_11_0._partItemDict[var_11_1] then
			local var_11_2 = arg_11_0:getResInst(var_11_0, arg_11_0._gopart, "partId" .. var_11_1)
			local var_11_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_2, RoomViewUIPartItem, var_11_1)

			arg_11_0._partItemDict[var_11_1] = var_11_3
		end
	end
end

function var_0_0._initInitItem(arg_12_0)
	local var_12_0 = arg_12_0.viewContainer._viewSetting.otherRes[10]

	arg_12_0._initItem = nil

	if not RoomController.instance:isObMode() then
		return
	end

	if not arg_12_0._initItem then
		local var_12_1 = arg_12_0:getResInst(var_12_0, arg_12_0._gopart, "init")

		arg_12_0._initItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_12_1, RoomViewUIInitItem)
	end
end

function var_0_0._initCharacterItem(arg_13_0)
	arg_13_0._gocharacterui = gohelper.findChild(arg_13_0.viewGO, "go_normalroot/go_ui/go_part/go_characterui")

	gohelper.setActive(arg_13_0._gocharacterui, false)

	arg_13_0._characterItemDict = {}
end

function var_0_0._initCharacterInteractionItem(arg_14_0)
	arg_14_0._gocharacterinteractionui = gohelper.findChild(arg_14_0.viewGO, "go_normalroot/go_ui/go_part/go_characterinteractionui")

	gohelper.setActive(arg_14_0._gocharacterinteractionui, false)

	arg_14_0._characterInteractionItemDict = {}
end

function var_0_0._initFishingItem(arg_15_0)
	if not FishingModel.instance:isInFishing() then
		if arg_15_0._fishingItem then
			arg_15_0._fishingItem:removeEventListeners()
			gohelper.destroy(arg_15_0._fishingItem.go)
		end

		return
	end

	if arg_15_0._fishingItem then
		arg_15_0._fishingItem:refreshUI()
	else
		local var_15_0 = RoomViewUIFishingItem.prefabPath
		local var_15_1 = arg_15_0:getResInst(var_15_0, arg_15_0._gopart, "fishing")

		arg_15_0._fishingItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_15_1, RoomViewUIFishingItem)
	end
end

function var_0_0.refresh(arg_16_0)
	arg_16_0:_refreshCharacterItem()
	arg_16_0:_refreshCharacterInteractionItem()
	arg_16_0:_refreshManufactureItem()
	arg_16_0:_refreshTransportSiteItem()
	arg_16_0:_refreshCritterBuildingItem()
	arg_16_0:_refreshTradeBuildingItem()
	arg_16_0:_refreshCritterItem()
	arg_16_0:_refreshBuildingItem()
	arg_16_0:_refreshFishingFriendItem()
	arg_16_0:_refreshFishingStoreItem()
	arg_16_0:_sort()
end

function var_0_0._refreshCharacterItem(arg_17_0)
	if not arg_17_0._isRunDalayInit then
		return
	end

	if not RoomController.instance:isObMode() and not RoomController.instance:isVisitMode() then
		return
	end

	local var_17_0 = arg_17_0.viewContainer._viewSetting.otherRes[9]
	local var_17_1 = arg_17_0._scene.charactermgr:getRoomCharacterEntityDict()

	for iter_17_0, iter_17_1 in pairs(var_17_1) do
		if not arg_17_0._characterItemDict[iter_17_0] then
			local var_17_2 = arg_17_0:getResInst(var_17_0, arg_17_0._gopart, "heroId" .. iter_17_0)
			local var_17_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_17_2, RoomViewUICharacterItem, iter_17_0)

			arg_17_0._characterItemDict[iter_17_0] = var_17_3
		end
	end

	for iter_17_2, iter_17_3 in pairs(arg_17_0._characterItemDict) do
		if not var_17_1[iter_17_2] then
			iter_17_3:removeEventListeners()
			gohelper.destroy(iter_17_3.go)

			arg_17_0._characterItemDict[iter_17_2] = nil
		end
	end
end

function var_0_0._refreshCharacterInteractionItem(arg_18_0)
	if not arg_18_0._isRunDalayInit then
		return
	end

	if not RoomController.instance:isObMode() or not RoomEnum.IsShowUICharacterInteraction then
		return
	end

	local var_18_0 = arg_18_0.viewContainer._viewSetting.otherRes[8]
	local var_18_1 = arg_18_0._scene.charactermgr:getRoomCharacterEntityDict()

	for iter_18_0, iter_18_1 in pairs(var_18_1) do
		if not arg_18_0._characterInteractionItemDict[iter_18_0] then
			local var_18_2 = arg_18_0:getResInst(var_18_0, arg_18_0._gopart, "interaction" .. iter_18_0)
			local var_18_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_18_2, RoomViewUICharacterInteractionItem, iter_18_0)

			arg_18_0._characterInteractionItemDict[iter_18_0] = var_18_3
		end
	end

	for iter_18_2, iter_18_3 in pairs(arg_18_0._characterInteractionItemDict) do
		if not var_18_1[iter_18_2] then
			iter_18_3:removeEventListeners()
			gohelper.destroy(iter_18_3.go)

			arg_18_0._characterInteractionItemDict[iter_18_2] = nil
		end
	end
end

function var_0_0._refreshManufactureItem(arg_19_0)
	if not RoomController.instance:isObMode() or not arg_19_0._isRunDalayInit then
		return
	end

	local var_19_0 = RoomMapBuildingAreaModel.instance:getBuildingType2AreaMODict()
	local var_19_1 = arg_19_0.viewContainer._viewSetting.otherRes[11]

	for iter_19_0, iter_19_1 in pairs(var_19_0) do
		if not arg_19_0._manufactureItemDict[iter_19_0] then
			local var_19_2 = arg_19_0:getResInst(var_19_1, arg_19_0._gopart, "manufacture" .. iter_19_0)
			local var_19_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_19_2, RoomViewUIManufactureItem, iter_19_0)

			arg_19_0._manufactureItemDict[iter_19_0] = var_19_3
		end
	end

	for iter_19_2, iter_19_3 in pairs(arg_19_0._manufactureItemDict) do
		if not var_19_0[iter_19_2] then
			iter_19_3:removeEventListeners()
			gohelper.destroy(iter_19_3.go)

			arg_19_0._manufactureItemDict[iter_19_2] = nil
		end
	end
end

function var_0_0._refreshTransportSiteItem(arg_20_0)
	if not RoomController.instance:isObMode() or not arg_20_0._isRunDalayInit then
		return
	end

	arg_20_0._transportSiteItemDict = arg_20_0._transportSiteItemDict or {}

	local var_20_0 = RoomViewUITransportSiteItem.prefabPath
	local var_20_1 = RoomTransportHelper.getSiteBuildingTypeList()

	for iter_20_0 = 1, #var_20_1 do
		local var_20_2 = var_20_1[iter_20_0]
		local var_20_3 = RoomMapTransportPathModel.instance:getSiteHexPointByType(var_20_2)
		local var_20_4 = arg_20_0._transportSiteItemDict[var_20_2]

		if var_20_3 then
			if not var_20_4 then
				local var_20_5 = arg_20_0:getResInst(var_20_0, arg_20_0._gopart, "site_" .. var_20_2)

				var_20_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_20_5, RoomViewUITransportSiteItem, var_20_2)
				arg_20_0._transportSiteItemDict[var_20_2] = var_20_4
			end
		elseif var_20_4 then
			var_20_4:removeEventListeners()
			gohelper.destroy(var_20_4.go)

			arg_20_0._transportSiteItemDict[var_20_2] = nil
		end
	end
end

function var_0_0._refreshCritterBuildingItem(arg_21_0)
	if not RoomController.instance:isObMode() or not arg_21_0._isRunDalayInit then
		return
	end

	local var_21_0
	local var_21_1 = ManufactureModel.instance:getCritterBuildingListInOrder()

	if var_21_1 then
		var_21_0 = var_21_1[1].buildingUid
	end

	if arg_21_0._scene.buildingmgr:getBuildingEntity(var_21_0, SceneTag.RoomBuilding) then
		if not arg_21_0._critterBuildingItem then
			local var_21_2 = arg_21_0.viewContainer._viewSetting.otherRes[12]
			local var_21_3 = arg_21_0:getResInst(var_21_2, arg_21_0._gopart, "critterBuilding")

			arg_21_0._critterBuildingItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_21_3, RoomViewUICritterBuildingItem)
		end
	elseif arg_21_0._critterBuildingItem then
		arg_21_0._critterBuildingItem:removeEventListeners()
		gohelper.destroy(arg_21_0._critterBuildingItem.go)

		arg_21_0._critterBuildingItem = nil
	end
end

function var_0_0._refreshTradeBuildingItem(arg_22_0)
	if not RoomController.instance:isObMode() or not arg_22_0._isRunDalayInit then
		return
	end

	local var_22_0
	local var_22_1 = ManufactureModel.instance:getTradeBuildingListInOrder()

	if var_22_1 then
		var_22_0 = var_22_1[1].buildingUid
	end

	if arg_22_0._scene.buildingmgr:getBuildingEntity(var_22_0, SceneTag.RoomBuilding) then
		if not arg_22_0._tradeBuildingItem then
			local var_22_2 = arg_22_0.viewContainer._viewSetting.otherRes[12]
			local var_22_3 = arg_22_0:getResInst(var_22_2, arg_22_0._gopart, "tradeBuilding")

			arg_22_0._tradeBuildingItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_22_3, RoomViewUITradeBuildingItem)
		end
	elseif arg_22_0._tradeBuildingItem then
		arg_22_0._tradeBuildingItem:removeEventListeners()
		gohelper.destroy(arg_22_0._tradeBuildingItem.go)

		arg_22_0._tradeBuildingItem = nil
	end
end

function var_0_0._refreshCritterItem(arg_23_0, arg_23_1, arg_23_2)
	if not RoomController.instance:isObMode() or not arg_23_0._isRunDalayInit then
		return
	end

	arg_23_0._critterItemDict = arg_23_0._critterItemDict or {}

	local var_23_0 = CritterModel.instance:getAllCritters()

	for iter_23_0 = 1, #var_23_0 do
		local var_23_1 = var_23_0[iter_23_0]
		local var_23_2 = var_23_1.id

		if arg_23_0:_isShowCritterItem(var_23_1) and not arg_23_0._critterItemDict[var_23_2] then
			local var_23_3 = arg_23_0:getResInst(RoomViewUICritterEventItem.prefabPath, arg_23_0._gopart, "critter_" .. var_23_2)

			arg_23_0._critterItemDict[var_23_1.id] = MonoHelper.addNoUpdateLuaComOnceToGo(var_23_3, RoomViewUICritterEventItem, var_23_2)
		end
	end

	for iter_23_1, iter_23_2 in pairs(arg_23_0._critterItemDict) do
		local var_23_4 = CritterModel.instance:getCritterMOByUid(iter_23_1)

		if not arg_23_0:_isShowCritterItem(var_23_4) then
			if iter_23_2 then
				iter_23_2:removeEventListeners()
				gohelper.destroy(iter_23_2.go)
			end

			arg_23_0._critterItemDict[iter_23_1] = nil
		end
	end
end

function var_0_0._isShowCritterItem(arg_24_0, arg_24_1)
	local var_24_0
	local var_24_1 = false
	local var_24_2 = arg_24_1:getId()

	if arg_24_1:isCultivating() then
		var_24_1 = arg_24_1.trainInfo:isHasEventTrigger()
		var_24_0 = arg_24_0._scene.crittermgr:getCritterEntity(var_24_2, SceneTag.RoomCharacter)
	end

	local var_24_3 = false

	if not var_24_1 then
		var_24_3 = arg_24_1:isNoMoodWorking()
		var_24_0 = arg_24_0._scene.buildingcrittermgr:getCritterEntity(var_24_2, SceneTag.RoomCharacter)
	end

	return arg_24_1 and var_24_0 and (var_24_1 or var_24_3)
end

function var_0_0._refreshBuildingItem(arg_25_0)
	if not RoomController.instance:isObMode() or not arg_25_0._isRunDalayInit then
		return
	end

	arg_25_0._buildingItemDict = arg_25_0._buildingItemDict or {}

	local var_25_0 = RoomMapBuildingModel.instance:getBuildingMOList()

	for iter_25_0 = 1, #var_25_0 do
		local var_25_1 = var_25_0[iter_25_0]
		local var_25_2 = var_25_1.id
		local var_25_3 = var_25_1.config and var_25_1.config.buildingType

		if var_25_3 and arg_25_0._showBuildingItemTypeMap[var_25_3] and not arg_25_0._buildingItemDict[var_25_2] then
			local var_25_4 = arg_25_0.viewContainer._viewSetting.otherRes[12]
			local var_25_5 = arg_25_0:getResInst(var_25_4, arg_25_0._gopart, "building_" .. var_25_2)

			arg_25_0._buildingItemDict[var_25_2] = MonoHelper.addNoUpdateLuaComOnceToGo(var_25_5, RoomViewUIBuildingItem, var_25_2)
		end
	end

	for iter_25_1, iter_25_2 in pairs(arg_25_0._buildingItemDict) do
		if not RoomMapBuildingModel.instance:getBuildingMOById(iter_25_1) then
			if iter_25_2 then
				iter_25_2:removeEventListeners()
				gohelper.destroy(iter_25_2.go)
			end

			arg_25_0._buildingItemDict[iter_25_1] = nil
		end
	end
end

function var_0_0._refreshFishingFriendItem(arg_26_0)
	if not FishingModel.instance:isInFishing() or not arg_26_0._isRunDalayInit then
		return
	end

	local var_26_0 = {}

	arg_26_0._fishingFriendItemDict = arg_26_0._fishingFriendItemDict or {}

	local var_26_1 = RoomMapBuildingModel.instance:getBuildingListByType(RoomBuildingEnum.BuildingType.Fishing)
	local var_26_2 = PlayerModel.instance:getMyUserId()

	if var_26_1 then
		for iter_26_0, iter_26_1 in ipairs(var_26_1) do
			local var_26_3 = arg_26_0._scene.buildingmgr:getBuildingEntity(iter_26_1.buildingUid, SceneTag.RoomBuilding)
			local var_26_4 = iter_26_1:getBelongUserId()

			if var_26_3 and var_26_4 and var_26_4 ~= var_26_2 then
				local var_26_5 = arg_26_0:getResInst(RoomViewUIFishingFriendItem.prefabPath, arg_26_0._gopart, "fishingFriend_" .. var_26_4)

				arg_26_0._fishingFriendItemDict[var_26_4] = MonoHelper.addNoUpdateLuaComOnceToGo(var_26_5, RoomViewUIFishingFriendItem, var_26_4)
				var_26_0[var_26_4] = true
			end
		end
	end

	for iter_26_2, iter_26_3 in pairs(arg_26_0._fishingFriendItemDict) do
		if not var_26_0[iter_26_2] then
			if iter_26_3 then
				iter_26_3:removeEventListeners()
				gohelper.destroy(iter_26_3.go)
			end

			arg_26_0._fishingFriendItemDict[iter_26_2] = nil
		end
	end
end

function var_0_0._refreshFishingStoreItem(arg_27_0)
	if not RoomController.instance:isFishingMode() or not arg_27_0._isRunDalayInit then
		return
	end

	local var_27_0 = RoomMapBuildingModel.instance:getBuildingListByType(RoomBuildingEnum.BuildingType.FishingStore)
	local var_27_1 = var_27_0 and var_27_0[1].buildingUid

	if arg_27_0._scene.buildingmgr:getBuildingEntity(var_27_1, SceneTag.RoomBuilding) then
		if not arg_27_0._fishingStoreItem then
			local var_27_2 = arg_27_0.viewContainer._viewSetting.otherRes[12]
			local var_27_3 = arg_27_0:getResInst(var_27_2, arg_27_0._gopart, "fishingStore")

			arg_27_0._fishingStoreItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_27_3, RoomViewUIFishingStoreItem)
		end
	elseif arg_27_0._fishingStoreItem then
		arg_27_0._fishingStoreItem:removeEventListeners()
		gohelper.destroy(arg_27_0._fishingStoreItem.go)

		arg_27_0._fishingStoreItem = nil
	end
end

function var_0_0._sort(arg_28_0)
	if not arg_28_0._isRunDalayInit then
		return
	end

	arg_28_0._uiItemList = {}

	LuaUtil.insertDict(arg_28_0._uiItemList, arg_28_0._partItemDict)
	table.insert(arg_28_0._uiItemList, arg_28_0._initItem)
	LuaUtil.insertDict(arg_28_0._uiItemList, arg_28_0._characterItemDict)
	LuaUtil.insertDict(arg_28_0._uiItemList, arg_28_0._characterInteractionItemDict)
	LuaUtil.insertDict(arg_28_0._uiItemList, arg_28_0._manufactureItemDict)
	LuaUtil.insertDict(arg_28_0._uiItemList, arg_28_0._transportSiteItemDict)
	table.insert(arg_28_0._uiItemList, arg_28_0._critterBuildingItem)
	table.insert(arg_28_0._uiItemList, arg_28_0._tradeBuildingItem)
	LuaUtil.insertDict(arg_28_0._uiItemList, arg_28_0._critterItemDict)
	LuaUtil.insertDict(arg_28_0._uiItemList, arg_28_0._buildingItemDict)
	table.insert(arg_28_0._uiItemList, arg_28_0._fishingItem)
	LuaUtil.insertDict(arg_28_0._uiItemList, arg_28_0._fishingFriendItemDict)
	table.insert(arg_28_0._uiItemList, arg_28_0._fishingStoreItem)

	local var_28_0 = arg_28_0._scene.camera:getCameraPosition()

	for iter_28_0, iter_28_1 in ipairs(arg_28_0._uiItemList) do
		local var_28_1 = iter_28_1:getUI3DPos()

		iter_28_1.__distance = Vector3.Distance(var_28_0, var_28_1)
	end

	table.sort(arg_28_0._uiItemList, function(arg_29_0, arg_29_1)
		return arg_29_0.__distance > arg_29_1.__distance
	end)

	for iter_28_2, iter_28_3 in ipairs(arg_28_0._uiItemList) do
		gohelper.setAsLastSibling(iter_28_3.go)
	end
end

function var_0_0.onClose(arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._sort, arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._onDelayInit, arg_30_0)
	arg_30_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyRoomBellTower, arg_30_0.onClickBellTower, arg_30_0)
	arg_30_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyRoomMarket, arg_30_0.onClickMarket, arg_30_0)
	arg_30_0:removeEventCb(RoomMapController.instance, RoomEvent.UseBuildingReply, arg_30_0._onUseBuildingReply, arg_30_0)
end

function var_0_0.onDestroyView(arg_31_0)
	return
end

return var_0_0
