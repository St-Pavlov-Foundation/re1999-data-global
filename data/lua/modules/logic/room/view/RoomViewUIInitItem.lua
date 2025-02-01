module("modules.logic.room.view.RoomViewUIInitItem", package.seeall)

slot0 = class("RoomViewUIInitItem", RoomViewUIBaseItem)

function slot0.ctor(slot0)
	uv0.super.ctor(slot0)
end

function slot0._customOnInit(slot0)
	slot0._txtbuildingname = gohelper.findChildText(slot0._gocontainer, "bottom/txt_buildingName")
	slot0._goskinreddot = gohelper.findChild(slot0._gocontainer, "bottom/#go_reddot")
	slot0._gobubbleContent = gohelper.findChild(slot0._gocontainer, "#go_bubbleContent")
	slot0._goawarn = gohelper.findChild(slot0._gocontainer, "state/#go_warn")
	slot0._gostop = gohelper.findChild(slot0._gocontainer, "state/#go_stop")
	slot0._goadd = gohelper.findChild(slot0._gocontainer, "state/#go_add")
	slot0._txtcount = gohelper.findChildText(slot0._gocontainer, "count/txt_count")
	slot0._gotxtcount = gohelper.findChild(slot0._gocontainer, "count")
	slot0._txtper = gohelper.findChildText(slot0._gocontainer, "count/txt_count/txt")
	slot0._simagegathericon = gohelper.findChildSingleImage(slot0._gocontainer, "simage_gathericon")
	slot0._simagebuildingicon = gohelper.findChildSingleImage(slot0._gocontainer, "simage_buildingicon")
	slot0._goqipaobg = gohelper.findChild(slot0._gocontainer, "qipao")
	slot0._goroomgifticon = gohelper.findChild(slot0._gocontainer, "simage_actroomicon")
	slot0._goreddot = gohelper.findChild(slot0._gocontainer, "count/txt_count/go_reddot")
	slot0._goupgrade = gohelper.findChild(slot0._gocontainer, "#go_upgrade")
	slot0._gobg = gohelper.findChild(slot0._gocontainer, "count/bg")
	slot0._gobg1 = gohelper.findChild(slot0._gocontainer, "count/bg1")
	slot0._customReddotGO = gohelper.findChild(slot0._gocontainer, "count/txt_count/go_reddot/type1")
	slot0._bgGO = gohelper.findChild(slot0._gocontainer, "count/bg")

	gohelper.setActive(slot0._customReddotGO, false)
	gohelper.setActive(slot0._bgGO, false)

	slot0._gobubbleitem = gohelper.findChild(slot0._gocontainer, "bubbleContent/#go_bubbleitem")

	gohelper.setActive(slot0._gobubbleitem, false)

	if RoomInitBuildingEnum.InitBuildingSkinReddot[RoomInitBuildingEnum.InitBuildingId.Hall] then
		RedDotController.instance:addRedDot(slot0._goskinreddot, slot1)
	end
end

function slot0._customAddEventListeners(slot0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, slot0._refreshRelateDot, slot0)
	RoomMapController.instance:registerCallback(RoomEvent.UpdateRoomLevel, slot0._refreshUpgradeUI, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, slot0._checkActivityInfo, slot0)
	RoomGiftController.instance:registerCallback(RoomGiftEvent.UpdateActInfo, slot0._refreshBubble, slot0)
	RoomGiftController.instance:registerCallback(RoomGiftEvent.GetBonus, slot0._refreshBubble, slot0)
	slot0:refreshUI()
	slot0:_refreshShow(true)
end

function slot0._customRemoveEventListeners(slot0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, slot0._refreshRelateDot, slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.UpdateRoomLevel, slot0._refreshUpgradeUI, slot0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshActivityState, slot0._checkActivityInfo, slot0)
	RoomGiftController.instance:unregisterCallback(RoomGiftEvent.UpdateActInfo, slot0._refreshBubble, slot0)
	RoomGiftController.instance:unregisterCallback(RoomGiftEvent.GetBonus, slot0._refreshBubble, slot0)
end

function slot0._refreshRelateDot(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		if slot5 == RedDotEnum.DotNode.RoomInitBuildingLevel then
			slot0:_refreshUpgradeUI()

			break
		end
	end
end

function slot0._onDailyRefresh(slot0)
	RoomGiftController.instance:getAct159Info()
end

function slot0._checkActivityInfo(slot0, slot1)
	slot2 = true

	if slot1 and slot1 ~= 0 then
		slot2 = slot1 == RoomGiftModel.instance:getActId()
	end

	if slot2 then
		RoomGiftController.instance:getAct159Info()
	end
end

function slot0.refreshUI(slot0)
	gohelper.setActive(slot0._goawarn, false)
	gohelper.setActive(slot0._gostop, false)
	gohelper.setActive(slot0._gobg, false)
	gohelper.setActive(slot0._gobg1, false)
	gohelper.setActive(slot0._simagegathericon.gameObject, false)

	slot0._txtcount.text = ""
	slot0._txtper.text = ""

	slot0._simagebuildingicon:LoadImage(ResUrl.getRoomImage("productline/icon_1"))

	slot0._txtbuildingname.text = luaLang("room_initbuilding_title")

	slot0:_refreshPosition()
	slot0:_refreshUpgradeUI()
	slot0:_refreshBubble()
end

function slot0._refreshUpgradeUI(slot0)
	slot1, slot2 = RoomInitBuildingHelper.canLevelUp()

	gohelper.setActive(slot0._goupgrade, slot1)
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
	slot2 = 0
	slot3 = 0

	if not gohelper.isNil(slot0._scene.buildingmgr:getInitBuildingGO()) then
		slot4 = RoomBuildingHelper.getCenterPosition(slot1)
		slot2 = slot4.x
		slot3 = slot4.z
	end

	return RoomBendingHelper.worldToBendingSimple(Vector3(slot2, 0.5, slot2))
end

function slot0._onGuideTouchUIPart(slot0, slot1)
	if tonumber(slot1) == slot0._partId then
		slot0:_onClick()
	end
end

function slot0._refreshBubble(slot0)
	slot1 = RoomGiftModel.instance:isCanGetBonus()

	gohelper.setActive(slot0._goroomgifticon, slot1)
	gohelper.setActive(slot0._simagebuildingicon.gameObject, not slot1)
	gohelper.setActive(slot0._goqipaobg, not slot1)
end

function slot0._onClick(slot0, slot1, slot2)
	if RoomGiftModel.instance:isCanGetBonus() then
		RoomGiftController.instance:getAct159Bonus()
	else
		RoomMapController.instance:openRoomInitBuildingView(0.2)
	end

	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_yield_click)
end

function slot0._customOnDestory(slot0)
	if slot0._simagegathericon then
		slot0._simagegathericon:UnLoadImage()

		slot0._simagegathericon = nil
	end

	if slot0._simagebuildingicon then
		slot0._simagebuildingicon:UnLoadImage()

		slot0._simagebuildingicon = nil
	end
end

return slot0
