module("modules.logic.room.view.RoomViewUIInitItem", package.seeall)

local var_0_0 = class("RoomViewUIInitItem", RoomViewUIBaseItem)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)
end

function var_0_0._customOnInit(arg_2_0)
	arg_2_0._txtbuildingname = gohelper.findChildText(arg_2_0._gocontainer, "bottom/txt_buildingName")
	arg_2_0._goskinreddot = gohelper.findChild(arg_2_0._gocontainer, "bottom/#go_reddot")
	arg_2_0._gobubbleContent = gohelper.findChild(arg_2_0._gocontainer, "#go_bubbleContent")
	arg_2_0._goawarn = gohelper.findChild(arg_2_0._gocontainer, "state/#go_warn")
	arg_2_0._gostop = gohelper.findChild(arg_2_0._gocontainer, "state/#go_stop")
	arg_2_0._goadd = gohelper.findChild(arg_2_0._gocontainer, "state/#go_add")
	arg_2_0._txtcount = gohelper.findChildText(arg_2_0._gocontainer, "count/txt_count")
	arg_2_0._gotxtcount = gohelper.findChild(arg_2_0._gocontainer, "count")
	arg_2_0._txtper = gohelper.findChildText(arg_2_0._gocontainer, "count/txt_count/txt")
	arg_2_0._simagegathericon = gohelper.findChildSingleImage(arg_2_0._gocontainer, "simage_gathericon")
	arg_2_0._simagebuildingicon = gohelper.findChildSingleImage(arg_2_0._gocontainer, "simage_buildingicon")
	arg_2_0._goqipaobg = gohelper.findChild(arg_2_0._gocontainer, "qipao")
	arg_2_0._goroomgifticon = gohelper.findChild(arg_2_0._gocontainer, "simage_actroomicon")
	arg_2_0._goreddot = gohelper.findChild(arg_2_0._gocontainer, "count/txt_count/go_reddot")
	arg_2_0._goupgrade = gohelper.findChild(arg_2_0._gocontainer, "#go_upgrade")
	arg_2_0._gobg = gohelper.findChild(arg_2_0._gocontainer, "count/bg")
	arg_2_0._gobg1 = gohelper.findChild(arg_2_0._gocontainer, "count/bg1")
	arg_2_0._customReddotGO = gohelper.findChild(arg_2_0._gocontainer, "count/txt_count/go_reddot/type1")
	arg_2_0._bgGO = gohelper.findChild(arg_2_0._gocontainer, "count/bg")

	gohelper.setActive(arg_2_0._customReddotGO, false)
	gohelper.setActive(arg_2_0._bgGO, false)

	arg_2_0._gobubbleitem = gohelper.findChild(arg_2_0._gocontainer, "bubbleContent/#go_bubbleitem")

	gohelper.setActive(arg_2_0._gobubbleitem, false)

	local var_2_0 = RoomInitBuildingEnum.InitBuildingSkinReddot[RoomInitBuildingEnum.InitBuildingId.Hall]

	if var_2_0 then
		RedDotController.instance:addRedDot(arg_2_0._goskinreddot, var_2_0)
	end
end

function var_0_0._customAddEventListeners(arg_3_0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, arg_3_0._refreshRelateDot, arg_3_0)
	RoomMapController.instance:registerCallback(RoomEvent.UpdateRoomLevel, arg_3_0._refreshUpgradeUI, arg_3_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_3_0._onDailyRefresh, arg_3_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, arg_3_0._checkActivityInfo, arg_3_0)
	RoomGiftController.instance:registerCallback(RoomGiftEvent.UpdateActInfo, arg_3_0._refreshBubble, arg_3_0)
	RoomGiftController.instance:registerCallback(RoomGiftEvent.GetBonus, arg_3_0._refreshBubble, arg_3_0)
	arg_3_0:refreshUI()
	arg_3_0:_refreshShow(true)
end

function var_0_0._customRemoveEventListeners(arg_4_0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, arg_4_0._refreshRelateDot, arg_4_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.UpdateRoomLevel, arg_4_0._refreshUpgradeUI, arg_4_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_4_0._onDailyRefresh, arg_4_0)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshActivityState, arg_4_0._checkActivityInfo, arg_4_0)
	RoomGiftController.instance:unregisterCallback(RoomGiftEvent.UpdateActInfo, arg_4_0._refreshBubble, arg_4_0)
	RoomGiftController.instance:unregisterCallback(RoomGiftEvent.GetBonus, arg_4_0._refreshBubble, arg_4_0)
end

function var_0_0._refreshRelateDot(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_1) do
		if iter_5_0 == RedDotEnum.DotNode.RoomInitBuildingLevel then
			arg_5_0:_refreshUpgradeUI()

			break
		end
	end
end

function var_0_0._onDailyRefresh(arg_6_0)
	RoomGiftController.instance:getAct159Info()
end

function var_0_0._checkActivityInfo(arg_7_0, arg_7_1)
	local var_7_0 = true

	if arg_7_1 and arg_7_1 ~= 0 then
		var_7_0 = arg_7_1 == RoomGiftModel.instance:getActId()
	end

	if var_7_0 then
		RoomGiftController.instance:getAct159Info()
	end
end

function var_0_0.refreshUI(arg_8_0)
	gohelper.setActive(arg_8_0._goawarn, false)
	gohelper.setActive(arg_8_0._gostop, false)
	gohelper.setActive(arg_8_0._gobg, false)
	gohelper.setActive(arg_8_0._gobg1, false)
	gohelper.setActive(arg_8_0._simagegathericon.gameObject, false)

	arg_8_0._txtcount.text = ""
	arg_8_0._txtper.text = ""

	arg_8_0._simagebuildingicon:LoadImage(ResUrl.getRoomImage("productline/icon_1"))

	arg_8_0._txtbuildingname.text = luaLang("room_initbuilding_title")

	arg_8_0:_refreshPosition()
	arg_8_0:_refreshUpgradeUI()
	arg_8_0:_refreshBubble()
end

function var_0_0._refreshUpgradeUI(arg_9_0)
	local var_9_0, var_9_1 = RoomInitBuildingHelper.canLevelUp()

	gohelper.setActive(arg_9_0._goupgrade, var_9_0)
end

function var_0_0._refreshShow(arg_10_0, arg_10_1)
	if RoomBuildingController.instance:isBuildingListShow() or RoomCharacterController.instance:isCharacterListShow() then
		arg_10_0:_setShow(false, arg_10_1)

		return
	end

	local var_10_0 = arg_10_0._scene.camera:getCameraState()

	if var_10_0 ~= RoomEnum.CameraState.Overlook and var_10_0 ~= RoomEnum.CameraState.OverlookAll then
		arg_10_0:_setShow(false, arg_10_1)

		return
	end

	if RoomMapController.instance:isInRoomInitBuildingViewCamera() then
		arg_10_0:_setShow(false, arg_10_1)

		return
	end

	arg_10_0:_setShow(true, arg_10_1)
end

function var_0_0.getUI3DPos(arg_11_0)
	local var_11_0 = arg_11_0._scene.buildingmgr:getInitBuildingGO()
	local var_11_1 = 0
	local var_11_2 = 0

	if not gohelper.isNil(var_11_0) then
		local var_11_3 = RoomBuildingHelper.getCenterPosition(var_11_0)

		var_11_1 = var_11_3.x

		local var_11_4 = var_11_3.z
	end

	local var_11_5 = Vector3(var_11_1, 0.5, var_11_1)

	return (RoomBendingHelper.worldToBendingSimple(var_11_5))
end

function var_0_0._onGuideTouchUIPart(arg_12_0, arg_12_1)
	if tonumber(arg_12_1) == arg_12_0._partId then
		arg_12_0:_onClick()
	end
end

function var_0_0._refreshBubble(arg_13_0)
	local var_13_0 = RoomGiftModel.instance:isCanGetBonus()

	gohelper.setActive(arg_13_0._goroomgifticon, var_13_0)
	gohelper.setActive(arg_13_0._simagebuildingicon.gameObject, not var_13_0)
	gohelper.setActive(arg_13_0._goqipaobg, not var_13_0)
end

function var_0_0._onClick(arg_14_0, arg_14_1, arg_14_2)
	if RoomGiftModel.instance:isCanGetBonus() then
		RoomGiftController.instance:getAct159Bonus()
	else
		RoomMapController.instance:openRoomInitBuildingView(0.2)
	end

	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_yield_click)
end

function var_0_0._customOnDestory(arg_15_0)
	if arg_15_0._simagegathericon then
		arg_15_0._simagegathericon:UnLoadImage()

		arg_15_0._simagegathericon = nil
	end

	if arg_15_0._simagebuildingicon then
		arg_15_0._simagebuildingicon:UnLoadImage()

		arg_15_0._simagebuildingicon = nil
	end
end

return var_0_0
