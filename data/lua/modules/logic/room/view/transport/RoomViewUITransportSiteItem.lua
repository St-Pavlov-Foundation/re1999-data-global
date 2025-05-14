module("modules.logic.room.view.transport.RoomViewUITransportSiteItem", package.seeall)

local var_0_0 = class("RoomViewUITransportSiteItem", RoomViewUIBaseItem)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._siteType = arg_1_1
	arg_1_0._fromType, arg_1_0._toType = RoomTransportHelper.getSiteFromToByType(arg_1_1)
end

function var_0_0._customOnInit(arg_2_0)
	arg_2_0._gomain = gohelper.findChild(arg_2_0._gocontainer, "bubblebg/#go_main")
	arg_2_0._imagebuildingicon = gohelper.findChildImage(arg_2_0._gocontainer, "#image_buildingicon")
	arg_2_0._txtbuildingname = gohelper.findChildText(arg_2_0._gocontainer, "bottom/txt_buildingName")
	arg_2_0._goreddot = gohelper.findChild(arg_2_0._gocontainer, "bottom/#go_reddot")
	arg_2_0._txtbuildingname.text = luaLang(RoomBuildingEnum.BuildingTypeSiteLangKey[arg_2_0._siteType])
end

function var_0_0._customAddEventListeners(arg_3_0)
	RoomMapController.instance:registerCallback(RoomEvent.TransportBuildingChanged, arg_3_0._refreshIconUI, arg_3_0)
	RoomMapController.instance:registerCallback(RoomEvent.TransportCritterChanged, arg_3_0._refreshIconUI, arg_3_0)
	arg_3_0:refreshUI(true)
	arg_3_0:_refreshIconUI()
end

function var_0_0._customRemoveEventListeners(arg_4_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.TransportBuildingChanged, arg_4_0._refreshIconUI, arg_4_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.TransportCritterChanged, arg_4_0._refreshIconUI, arg_4_0)
end

function var_0_0._onClick(arg_5_0, arg_5_1, arg_5_2)
	RoomTransportController.instance:openTransportSiteView(arg_5_0._siteType)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function var_0_0._refreshIconUI(arg_6_0)
	local var_6_0 = RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(arg_6_0._fromType, arg_6_0._toType)
	local var_6_1

	if var_6_0 then
		var_6_1 = RoomTransportHelper.getVehicleCfgByBuildingId(var_6_0.buildingId, var_6_0.buildingSkinId)

		if var_6_1 then
			UISpriteSetMgr.instance:setCritterSprite(arg_6_0._imagebuildingicon, var_6_1.uiIcon)
		end
	end

	gohelper.setActive(arg_6_0._gomain, var_6_0 ~= nil and var_6_0.critterUid and var_6_0.critterUid ~= 0)
	gohelper.setActive(arg_6_0._imagebuildingicon, var_6_1 ~= nil)
end

function var_0_0.refreshUI(arg_7_0, arg_7_1)
	arg_7_0:_refreshShow(arg_7_1)
	arg_7_0:_refreshPosition()
end

function var_0_0._refreshShow(arg_8_0, arg_8_1)
	if RoomBuildingController.instance:isBuildingListShow() or RoomCharacterController.instance:isCharacterListShow() then
		arg_8_0:_setShow(false, arg_8_1)

		return
	end

	local var_8_0 = arg_8_0._scene.camera:getCameraState()

	if var_8_0 ~= RoomEnum.CameraState.Overlook and var_8_0 ~= RoomEnum.CameraState.OverlookAll then
		arg_8_0:_setShow(false, arg_8_1)

		return
	end

	if RoomMapController.instance:isInRoomInitBuildingViewCamera() then
		arg_8_0:_setShow(false, arg_8_1)

		return
	end

	arg_8_0:_setShow(true, arg_8_1)
end

function var_0_0.getUI3DPos(arg_9_0)
	local var_9_0 = arg_9_0._scene.sitemgr:getSiteEntity(arg_9_0._siteType)

	if not var_9_0 then
		return Vector3.zero
	end

	local var_9_1 = var_9_0:getHeadGO()

	if var_9_1 then
		return var_9_1.transform.position
	end

	return var_9_0.goTrs.position
end

function var_0_0._customOnDestory(arg_10_0)
	return
end

var_0_0.prefabPath = "ui/viewres/room/sceneui/roomscenetransportsiteui.prefab"

return var_0_0
