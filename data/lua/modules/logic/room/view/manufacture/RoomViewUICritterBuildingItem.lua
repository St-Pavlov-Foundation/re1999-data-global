module("modules.logic.room.view.manufacture.RoomViewUICritterBuildingItem", package.seeall)

local var_0_0 = class("RoomViewUICritterBuildingItem", RoomViewUIBaseItem)

function var_0_0._customOnInit(arg_1_0)
	arg_1_0._gomain = gohelper.findChild(arg_1_0._gocontainer, "bubblebg/#go_main")
	arg_1_0._imagebuildingicon = gohelper.findChildImage(arg_1_0._gocontainer, "#image_buildingicon")
	arg_1_0._txtnamecn = gohelper.findChildText(arg_1_0._gocontainer, "bottom/txt_buildingName")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0._gocontainer, "bottom/#go_reddot")
	arg_1_0._txtnamecn.text = luaLang("critter_restroom_name")

	UISpriteSetMgr.instance:setCritterSprite(arg_1_0._imagebuildingicon, "critter_buildingicon_1")
	gohelper.setActive(arg_1_0._gomain, true)
end

function var_0_0._customAddEventListeners(arg_2_0)
	arg_2_0:refreshUI(true)
end

function var_0_0._customRemoveEventListeners(arg_3_0)
	return
end

function var_0_0._onClick(arg_4_0, arg_4_1, arg_4_2)
	ManufactureController.instance:openCritterBuildingView()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function var_0_0.refreshUI(arg_5_0, arg_5_1)
	arg_5_0:_refreshShow(arg_5_1)
	arg_5_0:_refreshPosition()
end

function var_0_0._refreshShow(arg_6_0, arg_6_1)
	if RoomBuildingController.instance:isBuildingListShow() or RoomCharacterController.instance:isCharacterListShow() then
		arg_6_0:_setShow(false, arg_6_1)

		return
	end

	local var_6_0 = arg_6_0._scene.camera:getCameraState()

	if var_6_0 ~= RoomEnum.CameraState.Overlook and var_6_0 ~= RoomEnum.CameraState.OverlookAll then
		arg_6_0:_setShow(false, arg_6_1)

		return
	end

	if RoomMapController.instance:isInRoomInitBuildingViewCamera() then
		arg_6_0:_setShow(false, arg_6_1)

		return
	end

	arg_6_0:_setShow(true, arg_6_1)
end

function var_0_0.getUI3DPos(arg_7_0)
	local var_7_0
	local var_7_1 = ManufactureModel.instance:getCritterBuildingListInOrder()

	if var_7_1 then
		var_7_0 = var_7_1[1].buildingUid
	end

	local var_7_2 = arg_7_0._scene.buildingmgr:getBuildingEntity(var_7_0, SceneTag.RoomBuilding)

	if not var_7_2 then
		arg_7_0:_setShow(false, true)

		return Vector3.zero
	end

	local var_7_3 = var_7_2:getHeadGO()
	local var_7_4 = var_7_2.containerGO
	local var_7_5 = var_7_3 and var_7_3.transform.position or var_7_4.transform.position
	local var_7_6 = Vector3(var_7_5.x, var_7_5.y, var_7_5.z)

	return (RoomBendingHelper.worldToBendingSimple(var_7_6))
end

function var_0_0._customOnDestory(arg_8_0)
	return
end

return var_0_0
