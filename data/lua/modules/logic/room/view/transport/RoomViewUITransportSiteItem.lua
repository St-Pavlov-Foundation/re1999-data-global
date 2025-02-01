module("modules.logic.room.view.transport.RoomViewUITransportSiteItem", package.seeall)

slot0 = class("RoomViewUITransportSiteItem", RoomViewUIBaseItem)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0)

	slot0._siteType = slot1
	slot0._fromType, slot0._toType = RoomTransportHelper.getSiteFromToByType(slot1)
end

function slot0._customOnInit(slot0)
	slot0._gomain = gohelper.findChild(slot0._gocontainer, "bubblebg/#go_main")
	slot0._imagebuildingicon = gohelper.findChildImage(slot0._gocontainer, "#image_buildingicon")
	slot0._txtbuildingname = gohelper.findChildText(slot0._gocontainer, "bottom/txt_buildingName")
	slot0._goreddot = gohelper.findChild(slot0._gocontainer, "bottom/#go_reddot")
	slot0._txtbuildingname.text = luaLang(RoomBuildingEnum.BuildingTypeSiteLangKey[slot0._siteType])
end

function slot0._customAddEventListeners(slot0)
	RoomMapController.instance:registerCallback(RoomEvent.TransportBuildingChanged, slot0._refreshIconUI, slot0)
	RoomMapController.instance:registerCallback(RoomEvent.TransportCritterChanged, slot0._refreshIconUI, slot0)
	slot0:refreshUI(true)
	slot0:_refreshIconUI()
end

function slot0._customRemoveEventListeners(slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.TransportBuildingChanged, slot0._refreshIconUI, slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.TransportCritterChanged, slot0._refreshIconUI, slot0)
end

function slot0._onClick(slot0, slot1, slot2)
	RoomTransportController.instance:openTransportSiteView(slot0._siteType)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function slot0._refreshIconUI(slot0)
	slot2 = nil

	if RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(slot0._fromType, slot0._toType) and RoomTransportHelper.getVehicleCfgByBuildingId(slot1.buildingId, slot1.buildingSkinId) then
		UISpriteSetMgr.instance:setCritterSprite(slot0._imagebuildingicon, slot2.uiIcon)
	end

	gohelper.setActive(slot0._gomain, slot1 ~= nil and slot1.critterUid and slot1.critterUid ~= 0)
	gohelper.setActive(slot0._imagebuildingicon, slot2 ~= nil)
end

function slot0.refreshUI(slot0, slot1)
	slot0:_refreshShow(slot1)
	slot0:_refreshPosition()
end

function slot0._refreshShow(slot0, slot1)
	if RoomBuildingController.instance:isBuildingListShow() or RoomCharacterController.instance:isCharacterListShow() then
		slot0:_setShow(false, slot1)

		return
	end

	if slot0._scene.camera:getCameraState() ~= RoomEnum.CameraState.Overlook and slot2 ~= RoomEnum.CameraState.OverlookAll then
		slot0:_setShow(false, slot1)

		return
	end

	if RoomMapController.instance:isInRoomInitBuildingViewCamera() then
		slot0:_setShow(false, slot1)

		return
	end

	slot0:_setShow(true, slot1)
end

function slot0.getUI3DPos(slot0)
	if not slot0._scene.sitemgr:getSiteEntity(slot0._siteType) then
		return Vector3.zero
	end

	if slot1:getHeadGO() then
		return slot2.transform.position
	end

	return slot1.goTrs.position
end

function slot0._customOnDestory(slot0)
end

slot0.prefabPath = "ui/viewres/room/sceneui/roomscenetransportsiteui.prefab"

return slot0
