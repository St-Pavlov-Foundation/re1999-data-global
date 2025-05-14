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

function var_0_0._onDelayInit(arg_5_0)
	arg_5_0._isRunDalayInit = true

	arg_5_0:_initPartItem()
	arg_5_0:_initInitItem()
	arg_5_0:_initCharacterItem()
	arg_5_0:_initCharacterInteractionItem()
	arg_5_0:_refreshCharacterItem()
	arg_5_0:_refreshCharacterInteractionItem()
	arg_5_0:_refreshManufactureItem()
	arg_5_0:_refreshTransportSiteItem()
	arg_5_0:_refreshCritterBuildingItem()
	arg_5_0:_refreshTradeBuildingItem()
	arg_5_0:_refreshCritterItem()
	arg_5_0:_refreshBuildingItem()
	arg_5_0:_sort()
end

function var_0_0._sort(arg_6_0)
	if not arg_6_0._isRunDalayInit then
		return
	end

	arg_6_0._uiItemList = {}

	LuaUtil.insertDict(arg_6_0._uiItemList, arg_6_0._partItemDict)
	table.insert(arg_6_0._uiItemList, arg_6_0._initItem)
	LuaUtil.insertDict(arg_6_0._uiItemList, arg_6_0._characterItemDict)
	LuaUtil.insertDict(arg_6_0._uiItemList, arg_6_0._characterInteractionItemDict)
	LuaUtil.insertDict(arg_6_0._uiItemList, arg_6_0._manufactureItemDict)
	LuaUtil.insertDict(arg_6_0._uiItemList, arg_6_0._transportSiteItemDict)
	table.insert(arg_6_0._uiItemList, arg_6_0._critterBuildingItem)
	table.insert(arg_6_0._uiItemList, arg_6_0._tradeBuildingItem)
	LuaUtil.insertDict(arg_6_0._uiItemList, arg_6_0._critterItemDict)
	LuaUtil.insertDict(arg_6_0._uiItemList, arg_6_0._buildingItemDict)

	local var_6_0 = arg_6_0._scene.camera:getCameraPosition()

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._uiItemList) do
		local var_6_1 = iter_6_1:getUI3DPos()

		iter_6_1.__distance = Vector3.Distance(var_6_0, var_6_1)
	end

	table.sort(arg_6_0._uiItemList, function(arg_7_0, arg_7_1)
		return arg_7_0.__distance > arg_7_1.__distance
	end)

	for iter_6_2, iter_6_3 in ipairs(arg_6_0._uiItemList) do
		gohelper.setAsLastSibling(iter_6_3.go)
	end
end

function var_0_0._initPartItem(arg_8_0)
	local var_8_0 = arg_8_0.viewContainer._viewSetting.otherRes[10]

	arg_8_0._partItemDict = {}

	if not RoomController.instance:isObMode() then
		return
	end

	for iter_8_0, iter_8_1 in ipairs(lua_production_part.configList) do
		local var_8_1 = iter_8_1.id

		if not arg_8_0._partItemDict[var_8_1] then
			local var_8_2 = arg_8_0:getResInst(var_8_0, arg_8_0._gopart, "partId" .. var_8_1)
			local var_8_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_2, RoomViewUIPartItem, var_8_1)

			arg_8_0._partItemDict[var_8_1] = var_8_3
		end
	end
end

function var_0_0._initInitItem(arg_9_0)
	local var_9_0 = arg_9_0.viewContainer._viewSetting.otherRes[10]

	arg_9_0._initItem = nil

	if not RoomController.instance:isObMode() then
		return
	end

	if not arg_9_0._initItem then
		local var_9_1 = arg_9_0:getResInst(var_9_0, arg_9_0._gopart, "init")

		arg_9_0._initItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_9_1, RoomViewUIInitItem)
	end
end

function var_0_0._initCharacterItem(arg_10_0)
	arg_10_0._gocharacterui = gohelper.findChild(arg_10_0.viewGO, "go_normalroot/go_ui/go_part/go_characterui")

	gohelper.setActive(arg_10_0._gocharacterui, false)

	arg_10_0._characterItemDict = {}
end

function var_0_0._initCharacterInteractionItem(arg_11_0)
	arg_11_0._gocharacterinteractionui = gohelper.findChild(arg_11_0.viewGO, "go_normalroot/go_ui/go_part/go_characterinteractionui")

	gohelper.setActive(arg_11_0._gocharacterinteractionui, false)

	arg_11_0._characterInteractionItemDict = {}
end

function var_0_0._refreshCharacterItem(arg_12_0)
	if not arg_12_0._isRunDalayInit then
		return
	end

	if not RoomController.instance:isObMode() and not RoomController.instance:isVisitMode() then
		return
	end

	local var_12_0 = arg_12_0.viewContainer._viewSetting.otherRes[9]
	local var_12_1 = arg_12_0._scene.charactermgr:getRoomCharacterEntityDict()

	for iter_12_0, iter_12_1 in pairs(var_12_1) do
		if not arg_12_0._characterItemDict[iter_12_0] then
			local var_12_2 = arg_12_0:getResInst(var_12_0, arg_12_0._gopart, "heroId" .. iter_12_0)
			local var_12_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_12_2, RoomViewUICharacterItem, iter_12_0)

			arg_12_0._characterItemDict[iter_12_0] = var_12_3
		end
	end

	for iter_12_2, iter_12_3 in pairs(arg_12_0._characterItemDict) do
		if not var_12_1[iter_12_2] then
			iter_12_3:removeEventListeners()
			gohelper.destroy(iter_12_3.go)

			arg_12_0._characterItemDict[iter_12_2] = nil
		end
	end
end

function var_0_0._refreshCharacterInteractionItem(arg_13_0)
	if not arg_13_0._isRunDalayInit then
		return
	end

	if not RoomController.instance:isObMode() or not RoomEnum.IsShowUICharacterInteraction then
		return
	end

	local var_13_0 = arg_13_0.viewContainer._viewSetting.otherRes[8]
	local var_13_1 = arg_13_0._scene.charactermgr:getRoomCharacterEntityDict()

	for iter_13_0, iter_13_1 in pairs(var_13_1) do
		if not arg_13_0._characterInteractionItemDict[iter_13_0] then
			local var_13_2 = arg_13_0:getResInst(var_13_0, arg_13_0._gopart, "interaction" .. iter_13_0)
			local var_13_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_13_2, RoomViewUICharacterInteractionItem, iter_13_0)

			arg_13_0._characterInteractionItemDict[iter_13_0] = var_13_3
		end
	end

	for iter_13_2, iter_13_3 in pairs(arg_13_0._characterInteractionItemDict) do
		if not var_13_1[iter_13_2] then
			iter_13_3:removeEventListeners()
			gohelper.destroy(iter_13_3.go)

			arg_13_0._characterInteractionItemDict[iter_13_2] = nil
		end
	end
end

function var_0_0.onClickBellTower(arg_14_0)
	local var_14_0 = arg_14_0._partItemDict[1]

	if not RoomController.instance:isObMode() or not var_14_0 or not var_14_0._isShow then
		return
	end

	var_14_0:_onClick()
end

function var_0_0.onClickMarket(arg_15_0)
	local var_15_0 = arg_15_0._partItemDict[2]

	if not RoomController.instance:isObMode() or not var_15_0 or not var_15_0._isShow then
		return
	end

	var_15_0:_onClick()
end

function var_0_0._refreshManufactureItem(arg_16_0)
	if not RoomController.instance:isObMode() or not arg_16_0._isRunDalayInit then
		return
	end

	local var_16_0 = RoomMapBuildingAreaModel.instance:getBuildingType2AreaMODict()
	local var_16_1 = arg_16_0.viewContainer._viewSetting.otherRes[11]

	for iter_16_0, iter_16_1 in pairs(var_16_0) do
		if not arg_16_0._manufactureItemDict[iter_16_0] then
			local var_16_2 = arg_16_0:getResInst(var_16_1, arg_16_0._gopart, "manufacture" .. iter_16_0)
			local var_16_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_16_2, RoomViewUIManufactureItem, iter_16_0)

			arg_16_0._manufactureItemDict[iter_16_0] = var_16_3
		end
	end

	for iter_16_2, iter_16_3 in pairs(arg_16_0._manufactureItemDict) do
		if not var_16_0[iter_16_2] then
			iter_16_3:removeEventListeners()
			gohelper.destroy(iter_16_3.go)

			arg_16_0._manufactureItemDict[iter_16_2] = nil
		end
	end
end

function var_0_0._refreshTransportSiteItem(arg_17_0)
	if not RoomController.instance:isObMode() or not arg_17_0._isRunDalayInit then
		return
	end

	arg_17_0._transportSiteItemDict = arg_17_0._transportSiteItemDict or {}

	local var_17_0 = RoomViewUITransportSiteItem.prefabPath
	local var_17_1 = RoomTransportHelper.getSiteBuildingTypeList()

	for iter_17_0 = 1, #var_17_1 do
		local var_17_2 = var_17_1[iter_17_0]
		local var_17_3 = RoomMapTransportPathModel.instance:getSiteHexPointByType(var_17_2)
		local var_17_4 = arg_17_0._transportSiteItemDict[var_17_2]

		if var_17_3 then
			if not var_17_4 then
				local var_17_5 = arg_17_0:getResInst(var_17_0, arg_17_0._gopart, "site_" .. var_17_2)

				var_17_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_17_5, RoomViewUITransportSiteItem, var_17_2)
				arg_17_0._transportSiteItemDict[var_17_2] = var_17_4
			end
		elseif var_17_4 then
			var_17_4:removeEventListeners()
			gohelper.destroy(var_17_4.go)

			arg_17_0._transportSiteItemDict[var_17_2] = nil
		end
	end
end

function var_0_0._refreshCritterItem(arg_18_0, arg_18_1, arg_18_2)
	if not RoomController.instance:isObMode() or not arg_18_0._isRunDalayInit then
		return
	end

	arg_18_0._critterItemDict = arg_18_0._critterItemDict or {}

	local var_18_0 = CritterModel.instance:getAllCritters()

	for iter_18_0 = 1, #var_18_0 do
		local var_18_1 = var_18_0[iter_18_0]
		local var_18_2 = var_18_1.id

		if arg_18_0:_isShowCritterItem(var_18_1) and not arg_18_0._critterItemDict[var_18_2] then
			local var_18_3 = arg_18_0:getResInst(RoomViewUICritterEventItem.prefabPath, arg_18_0._gopart, "critter_" .. var_18_2)

			arg_18_0._critterItemDict[var_18_1.id] = MonoHelper.addNoUpdateLuaComOnceToGo(var_18_3, RoomViewUICritterEventItem, var_18_2)
		end
	end

	for iter_18_1, iter_18_2 in pairs(arg_18_0._critterItemDict) do
		local var_18_4 = CritterModel.instance:getCritterMOByUid(iter_18_1)

		if not arg_18_0:_isShowCritterItem(var_18_4) then
			if iter_18_2 then
				iter_18_2:removeEventListeners()
				gohelper.destroy(iter_18_2.go)
			end

			arg_18_0._critterItemDict[iter_18_1] = nil
		end
	end
end

function var_0_0._isShowCritterItem(arg_19_0, arg_19_1)
	local var_19_0
	local var_19_1 = false
	local var_19_2 = arg_19_1:getId()

	if arg_19_1:isCultivating() then
		var_19_1 = arg_19_1.trainInfo:isHasEventTrigger()
		var_19_0 = arg_19_0._scene.crittermgr:getCritterEntity(var_19_2, SceneTag.RoomCharacter)
	end

	local var_19_3 = false

	if not var_19_1 then
		var_19_3 = arg_19_1:isNoMoodWorking()
		var_19_0 = arg_19_0._scene.buildingcrittermgr:getCritterEntity(var_19_2, SceneTag.RoomCharacter)
	end

	return arg_19_1 and var_19_0 and (var_19_1 or var_19_3)
end

function var_0_0._refreshCritterBuildingItem(arg_20_0)
	if not RoomController.instance:isObMode() or not arg_20_0._isRunDalayInit then
		return
	end

	local var_20_0
	local var_20_1 = ManufactureModel.instance:getCritterBuildingListInOrder()

	if var_20_1 then
		var_20_0 = var_20_1[1].buildingUid
	end

	if arg_20_0._scene.buildingmgr:getBuildingEntity(var_20_0, SceneTag.RoomBuilding) then
		if not arg_20_0._critterBuildingItem then
			local var_20_2 = arg_20_0.viewContainer._viewSetting.otherRes[12]
			local var_20_3 = arg_20_0:getResInst(var_20_2, arg_20_0._gopart, "critterBuilding")

			arg_20_0._critterBuildingItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_20_3, RoomViewUICritterBuildingItem)
		end
	elseif arg_20_0._critterBuildingItem then
		arg_20_0._critterBuildingItem:removeEventListeners()
		gohelper.destroy(arg_20_0._critterBuildingItem.go)

		arg_20_0._critterBuildingItem = nil
	end
end

function var_0_0._refreshTradeBuildingItem(arg_21_0)
	if not RoomController.instance:isObMode() or not arg_21_0._isRunDalayInit then
		return
	end

	local var_21_0
	local var_21_1 = ManufactureModel.instance:getTradeBuildingListInOrder()

	if var_21_1 then
		var_21_0 = var_21_1[1].buildingUid
	end

	if arg_21_0._scene.buildingmgr:getBuildingEntity(var_21_0, SceneTag.RoomBuilding) then
		if not arg_21_0._tradeBuildingItem then
			local var_21_2 = arg_21_0.viewContainer._viewSetting.otherRes[12]
			local var_21_3 = arg_21_0:getResInst(var_21_2, arg_21_0._gopart, "tradeBuilding")

			arg_21_0._tradeBuildingItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_21_3, RoomViewUITradeBuildingItem)
		end
	elseif arg_21_0._tradeBuildingItem then
		arg_21_0._tradeBuildingItem:removeEventListeners()
		gohelper.destroy(arg_21_0._tradeBuildingItem.go)

		arg_21_0._tradeBuildingItem = nil
	end
end

function var_0_0._refreshBuildingItem(arg_22_0)
	if not RoomController.instance:isObMode() or not arg_22_0._isRunDalayInit then
		return
	end

	arg_22_0._buildingItemDict = arg_22_0._buildingItemDict or {}

	local var_22_0 = RoomMapBuildingModel.instance:getBuildingMOList()

	for iter_22_0 = 1, #var_22_0 do
		local var_22_1 = var_22_0[iter_22_0]
		local var_22_2 = var_22_1.id
		local var_22_3 = var_22_1.config and var_22_1.config.buildingType

		if var_22_3 and arg_22_0._showBuildingItemTypeMap[var_22_3] and not arg_22_0._buildingItemDict[var_22_2] then
			local var_22_4 = arg_22_0.viewContainer._viewSetting.otherRes[12]
			local var_22_5 = arg_22_0:getResInst(var_22_4, arg_22_0._gopart, "building_" .. var_22_2)

			arg_22_0._buildingItemDict[var_22_2] = MonoHelper.addNoUpdateLuaComOnceToGo(var_22_5, RoomViewUIBuildingItem, var_22_2)
		end
	end

	for iter_22_1, iter_22_2 in pairs(arg_22_0._buildingItemDict) do
		if not RoomMapBuildingModel.instance:getBuildingMOById(iter_22_1) then
			if iter_22_2 then
				iter_22_2:removeEventListeners()
				gohelper.destroy(iter_22_2.go)
			end

			arg_22_0._buildingItemDict[iter_22_1] = nil
		end
	end
end

function var_0_0._onUseBuildingReply(arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._onDelayInit, arg_23_0)
	TaskDispatcher.runDelay(arg_23_0._onDelayInit, arg_23_0, 0.1)
end

function var_0_0.onOpen(arg_24_0)
	arg_24_0:addEventCb(RoomCharacterController.instance, RoomEvent.CharacterEntityChanged, arg_24_0._refreshCharacterItem, arg_24_0)
	arg_24_0:addEventCb(RoomCharacterController.instance, RoomEvent.CharacterEntityChanged, arg_24_0._refreshCharacterInteractionItem, arg_24_0)
	arg_24_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyRoomBellTower, arg_24_0.onClickBellTower, arg_24_0)
	arg_24_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyRoomMarket, arg_24_0.onClickMarket, arg_24_0)
	arg_24_0:addEventCb(RoomMapController.instance, RoomEvent.UseBuildingReply, arg_24_0._onUseBuildingReply, arg_24_0)
	arg_24_0:addEventCb(RoomMapController.instance, RoomEvent.CameraStateUpdate, arg_24_0._cameraStateUpdate, arg_24_0)
	arg_24_0:addEventCb(RoomMapController.instance, RoomEvent.SceneTrainChangeSpine, arg_24_0._refreshCritterItem, arg_24_0)
	arg_24_0:addEventCb(CritterController.instance, CritterEvent.TrainSelectEventOptionReply, arg_24_0._refreshCritterItem, arg_24_0)
	arg_24_0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, arg_24_0._refreshCritterItem, arg_24_0)
	arg_24_0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, arg_24_0._refreshCritterItem, arg_24_0)
	arg_24_0:addEventCb(CritterController.instance, CritterEvent.CritterInfoPushUpdate, arg_24_0._refreshCritterItem, arg_24_0)
	TaskDispatcher.runDelay(arg_24_0._onDelayInit, arg_24_0, 0.1)
	TaskDispatcher.runRepeat(arg_24_0._sort, arg_24_0, 1)
end

function var_0_0.onClose(arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0._sort, arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0._onDelayInit, arg_25_0)
	arg_25_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyRoomBellTower, arg_25_0.onClickBellTower, arg_25_0)
	arg_25_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyRoomMarket, arg_25_0.onClickMarket, arg_25_0)
	arg_25_0:removeEventCb(RoomMapController.instance, RoomEvent.UseBuildingReply, arg_25_0._onUseBuildingReply, arg_25_0)
end

function var_0_0._cameraStateUpdate(arg_26_0)
	local var_26_0 = arg_26_0._scene.camera:getCameraState()
	local var_26_1 = arg_26_0._cameraStateShowUIMap[var_26_0] and 1 or 0

	arg_26_0._canvasGroup.alpha = var_26_1
end

function var_0_0.onDestroyView(arg_27_0)
	return
end

return var_0_0
