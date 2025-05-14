module("modules.logic.room.view.critter.RoomViewUICritterEventItem", package.seeall)

local var_0_0 = class("RoomViewUICritterEventItem", RoomViewUIBaseItem)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._showCameraStateDict = {
		[RoomEnum.CameraState.OverlookAll] = true
	}
	arg_1_0.critterUid = arg_1_1
	arg_1_0.critterMO = CritterModel.instance:getCritterMOByUid(arg_1_0.critterUid)
	arg_1_0.eventType = CritterHelper.getEventTypeByCritterMO(arg_1_0.critterMO)

	if not arg_1_0.eventType then
		arg_1_0.eventType = CritterEnum.CritterItemEventType.SurpriseCollect
	end
end

function var_0_0._customOnInit(arg_2_0)
	arg_2_0._gobg = gohelper.findChildImage(arg_2_0._gocontainer, "bg")
	arg_2_0._gocrittericon = gohelper.findChild(arg_2_0._gocontainer, "#go_crittericon")
	arg_2_0._goEventBubble = gohelper.findChild(arg_2_0._gocontainer, "#image_bubble")
	arg_2_0._imageEventBubble = gohelper.findChildImage(arg_2_0._gocontainer, "#image_bubble")
	arg_2_0._goPropBubble = gohelper.findChild(arg_2_0._gocontainer, "bubblebg")
	arg_2_0._simageProp = gohelper.findChildSingleImage(arg_2_0._gocontainer, "#image_bubble")
end

function var_0_0._customAddEventListeners(arg_3_0)
	RoomCharacterController.instance:registerCallback(RoomEvent.CharacterPositionChanged, arg_3_0._characterPositionChanged, arg_3_0)
	arg_3_0:setIconUI()
	arg_3_0:refreshUI(true)
end

function var_0_0._customRemoveEventListeners(arg_4_0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.CharacterPositionChanged, arg_4_0._characterPositionChanged, arg_4_0)
end

function var_0_0._characterPositionChanged(arg_5_0, arg_5_1)
	if arg_5_0.critterMO and arg_5_0.critterMO.trainInfo.heroId ~= arg_5_1 then
		return
	end

	arg_5_0:_refreshPosition()
end

function var_0_0._onClick(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0.eventType == CritterEnum.CritterItemEventType.HasTrainEvent then
		arg_6_0:_clickTrainEvent()
	end

	if arg_6_0.eventType == CritterEnum.CritterItemEventType.NoMoodWork then
		arg_6_0:_clickNoMoodWorking()
	end
end

function var_0_0._clickNoMoodWorking(arg_7_0)
	local var_7_0 = ManufactureModel.instance:getCritterWorkingBuilding(arg_7_0.critterUid)

	RoomMap3DClickController.instance:onBuildingEntityClick(RoomMapBuildingModel.instance:getBuildingMOById(var_7_0))
end

function var_0_0._clickTrainEvent(arg_8_0)
	if ViewMgr.instance:isOpen(ViewName.RoomCritterBuildingView) then
		RoomCritterController.instance:openTrainEventView(arg_8_0.critterUid)
	else
		ManufactureController.instance:openCritterBuildingView(nil, RoomCritterBuildingViewContainer.SubViewTabId.Training, arg_8_0.critterUid)
	end
end

local var_0_1 = {
	[CritterEnum.CritterItemEventType.HasTrainEvent] = "critter_mapbubble1",
	[CritterEnum.CritterItemEventType.TrainEventComplete] = "critter_mapbubble2",
	[CritterEnum.CritterItemEventType.NoMoodWork] = "critter_mapbubble3"
}

function var_0_0.setIconUI(arg_9_0)
	if not arg_9_0.critterIcon then
		arg_9_0.critterIcon = IconMgr.instance:getCommonCritterIcon(arg_9_0._gocrittericon)
	end

	arg_9_0.critterIcon:onUpdateMO(arg_9_0.critterMO)

	local var_9_0 = arg_9_0.eventType == CritterEnum.CritterItemEventType.SurpriseCollect

	if var_9_0 then
		-- block empty
	else
		local var_9_1 = var_0_1[arg_9_0.eventType]

		UISpriteSetMgr.instance:setCritterSprite(arg_9_0._imageEventBubble, var_9_1)
	end

	gohelper.setActive(arg_9_0._goPropBubble, var_9_0)
	gohelper.setActive(arg_9_0._goEventBubble, not var_9_0)
end

function var_0_0.refreshUI(arg_10_0, arg_10_1)
	arg_10_0:_refreshShow(arg_10_1)
	arg_10_0:_refreshPosition()
end

function var_0_0._refreshShow(arg_11_0, arg_11_1)
	if RoomBuildingController.instance:isBuildingListShow() or RoomCharacterController.instance:isCharacterListShow() then
		arg_11_0:_setShow(false, arg_11_1)

		return
	end

	if RoomMapController.instance:isInRoomInitBuildingViewCamera() or not arg_11_0._showCameraStateDict[arg_11_0._scene.camera:getCameraState()] then
		arg_11_0:_setShow(false, arg_11_1)

		return
	end

	arg_11_0:_setShow(true, arg_11_1)
end

function var_0_0.getUI3DPos(arg_12_0)
	local var_12_0 = arg_12_0:getEventCritterEntity()

	if not var_12_0 then
		return Vector3.zero
	end

	local var_12_1 = var_12_0.critterspine:getMountheadGOTrs() or var_12_0.goTrs

	if not var_12_1 then
		return Vector3.zero
	end

	local var_12_2, var_12_3, var_12_4 = transformhelper.getPos(var_12_1)

	return Vector3(var_12_2, var_12_3, var_12_4)
end

function var_0_0.getEventCritterEntity(arg_13_0)
	local var_13_0

	if arg_13_0.critterMO:isCultivating() then
		var_13_0 = arg_13_0._scene.crittermgr:getCritterEntity(arg_13_0.critterUid, SceneTag.RoomCharacter)
	else
		var_13_0 = arg_13_0._scene.buildingcrittermgr:getCritterEntity(arg_13_0.critterUid, SceneTag.RoomCharacter)
	end

	return var_13_0
end

function var_0_0._customOnDestory(arg_14_0)
	arg_14_0._simageProp:UnLoadImage()
end

var_0_0.prefabPath = "ui/viewres/room/sceneui/roomscenecritterheadui.prefab"

return var_0_0
