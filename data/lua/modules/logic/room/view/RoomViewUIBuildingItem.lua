module("modules.logic.room.view.RoomViewUIBuildingItem", package.seeall)

local var_0_0 = class("RoomViewUIBuildingItem", RoomViewUIBaseItem)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._buildingUid = arg_1_1
end

function var_0_0._customOnInit(arg_2_0)
	arg_2_0._gomain = gohelper.findChild(arg_2_0._gocontainer, "bubblebg/#go_main")
	arg_2_0._imagebuildingicon = gohelper.findChildImage(arg_2_0._gocontainer, "#image_buildingicon")
	arg_2_0._txtnamecn = gohelper.findChildText(arg_2_0._gocontainer, "bottom/txt_buildingName")
	arg_2_0._goreddot = gohelper.findChild(arg_2_0._gocontainer, "bottom/#go_reddot")

	local var_2_0 = RoomMapBuildingModel.instance:getBuildingMOById(arg_2_0._buildingUid)

	if var_2_0 then
		local var_2_1 = var_2_0.config
		local var_2_2 = var_2_1.buildingType

		arg_2_0._txtnamecn.text = var_2_1.name

		UISpriteSetMgr.instance:setCritterSprite(arg_2_0._imagebuildingicon, RoomBuildingEnum.BuildingMapUiIcon[var_2_1.buildingType])
	end
end

function var_0_0._customAddEventListeners(arg_3_0)
	arg_3_0:refreshUI(true)
end

function var_0_0._customRemoveEventListeners(arg_4_0)
	return
end

function var_0_0._onClick(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = RoomMapBuildingModel.instance:getBuildingMOById(arg_5_0._buildingUid)

	if var_5_0 then
		RoomMap3DClickController.instance:onBuildingEntityClick(var_5_0)
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	end
end

function var_0_0.refreshUI(arg_6_0, arg_6_1)
	arg_6_0:_refreshShow(arg_6_1)
	arg_6_0:_refreshPosition()
end

function var_0_0._refreshShow(arg_7_0, arg_7_1)
	if RoomBuildingController.instance:isBuildingListShow() or RoomCharacterController.instance:isCharacterListShow() then
		arg_7_0:_setShow(false, arg_7_1)

		return
	end

	local var_7_0 = arg_7_0._scene.camera:getCameraState()

	if var_7_0 ~= RoomEnum.CameraState.Overlook and var_7_0 ~= RoomEnum.CameraState.OverlookAll then
		arg_7_0:_setShow(false, arg_7_1)

		return
	end

	if RoomMapController.instance:isInRoomInitBuildingViewCamera() then
		arg_7_0:_setShow(false, arg_7_1)

		return
	end

	arg_7_0:_setShow(true, arg_7_1)
end

function var_0_0.getUI3DPos(arg_8_0)
	local var_8_0 = arg_8_0._scene.buildingmgr:getBuildingEntity(arg_8_0._buildingUid, SceneTag.RoomBuilding)

	if not var_8_0 then
		arg_8_0:_setShow(false, true)

		return Vector3.zero
	end

	local var_8_1 = var_8_0:getHeadGO()

	if var_8_1 then
		return var_8_1.transform.position
	end

	return var_8_0.goTrs.position
end

function var_0_0._customOnDestory(arg_9_0)
	return
end

return var_0_0
