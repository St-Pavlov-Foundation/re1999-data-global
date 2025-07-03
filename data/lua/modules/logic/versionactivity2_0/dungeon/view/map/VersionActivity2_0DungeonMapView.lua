module("modules.logic.versionactivity2_0.dungeon.view.map.VersionActivity2_0DungeonMapView", package.seeall)

local var_0_0 = class("VersionActivity2_0DungeonMapView", BaseView)
local var_0_1 = Vector4(0, 0, 0, 0)
local var_0_2 = Vector4(0, 0, 600, 0)
local var_0_3 = 0.5

function var_0_0.onInitView(arg_1_0)
	arg_1_0.animator = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_1_0._simagenormalmask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_normalmask")
	arg_1_0._simagehardmask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_hardmask")
	arg_1_0._simagerestaurant = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_restaurantmask")
	arg_1_0._scrollcontent = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_content")
	arg_1_0._rectmask2D = arg_1_0._scrollcontent:GetComponent(typeof(UnityEngine.UI.RectMask2D))
	arg_1_0._goswitchmodecontainer = gohelper.findChild(arg_1_0.viewGO, "#go_switchmodecontainer")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._gotopright = gohelper.findChild(arg_1_0.viewGO, "#go_topright")
	arg_1_0._txtstorenum = gohelper.findChildText(arg_1_0.viewGO, "#go_topright/#btn_activitystore/normal/#txt_num")
	arg_1_0._txtStoreRemainTime = gohelper.findChildText(arg_1_0.viewGO, "#go_topright/#btn_activitystore/#go_time/#txt_time")
	arg_1_0._goTaskReddot = gohelper.findChild(arg_1_0.viewGO, "#go_topright/#btn_activitytask/#go_reddot")
	arg_1_0._goGraffitiReddot = gohelper.findChild(arg_1_0.viewGO, "#go_topright/#btn_graffiti/#go_reddot")
	arg_1_0._goRestaurantReddot = gohelper.findChild(arg_1_0.viewGO, "#go_topright/#btn_restaurant/#go_reddot")
	arg_1_0._goexcessive = gohelper.findChild(arg_1_0.viewGO, "#go_excessive")
	arg_1_0._btncloseview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closeview")
	arg_1_0._btnactivitystore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_topright/#btn_activitystore")
	arg_1_0._btnactivitytask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_topright/#btn_activitytask")
	arg_1_0._btnrestaurant = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_topright/#btn_restaurant")
	arg_1_0._btngraffiti = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_topright/#btn_graffiti")
	arg_1_0._goExcessiveEffect = gohelper.findChild(arg_1_0.viewGO, "excessive")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0._onOpenView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, arg_2_0.onRemoveElement, arg_2_0, LuaEventSystem.Low)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, arg_2_0.beginShowRewardView, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, arg_2_0.endShowRewardView, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateMapElementState, arg_2_0.checkHasUnDoElement, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0.refreshActivityCurrency, arg_2_0)
	arg_2_0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, arg_2_0.onModeChange, arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_2_0.onRefreshActivityState, arg_2_0)
	arg_2_0:addEventCb(VersionActivity2_0DungeonController.instance, VersionActivity2_0DungeonEvent.OnClickElement, arg_2_0.onClickElement, arg_2_0)
	arg_2_0:addEventCb(VersionActivity2_0DungeonController.instance, VersionActivity2_0DungeonEvent.OnHideInteractUI, arg_2_0.showBtnUI, arg_2_0)
	arg_2_0:addEventCb(Activity161Controller.instance, Activity161Event.CloseGraffitiEnterView, arg_2_0.closeGraffitiEnterView, arg_2_0)
	arg_2_0:addEventCb(Activity161Controller.instance, Activity161Event.PlayExcessiveEffect, arg_2_0.showExcessiveEffect, arg_2_0)
	arg_2_0._btncloseview:AddClickListener(arg_2_0._btncloseviewOnClick, arg_2_0)
	arg_2_0._btnactivitystore:AddClickListener(arg_2_0._btnactivitystoreOnClick, arg_2_0)
	arg_2_0._btnactivitytask:AddClickListener(arg_2_0._btnactivitytaskOnClick, arg_2_0)
	arg_2_0._btngraffiti:AddClickListener(arg_2_0._btngraffitiOnClick, arg_2_0)
	arg_2_0._btnrestaurant:AddClickListener(arg_2_0._btnrestaurantOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0._onOpenView, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, arg_3_0.onRemoveElement, arg_3_0, LuaEventSystem.Low)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, arg_3_0.beginShowRewardView, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, arg_3_0.endShowRewardView, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.OnUpdateMapElementState, arg_3_0.checkHasUnDoElement, arg_3_0)
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0.refreshActivityCurrency, arg_3_0)
	arg_3_0:removeEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, arg_3_0.onModeChange, arg_3_0)
	arg_3_0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_3_0.onRefreshActivityState, arg_3_0)
	arg_3_0:removeEventCb(VersionActivity2_0DungeonController.instance, VersionActivity2_0DungeonEvent.OnClickElement, arg_3_0.onClickElement, arg_3_0)
	arg_3_0:removeEventCb(VersionActivity2_0DungeonController.instance, VersionActivity2_0DungeonEvent.OnHideInteractUI, arg_3_0.showBtnUI, arg_3_0)
	arg_3_0:removeEventCb(Activity161Controller.instance, Activity161Event.CloseGraffitiEnterView, arg_3_0.closeGraffitiEnterView, arg_3_0)
	arg_3_0:removeEventCb(Activity161Controller.instance, Activity161Event.PlayExcessiveEffect, arg_3_0.showExcessiveEffect, arg_3_0)
	arg_3_0._btncloseview:RemoveClickListener()
	arg_3_0._btnactivitystore:RemoveClickListener()
	arg_3_0._btnactivitytask:RemoveClickListener()
	arg_3_0._btngraffiti:RemoveClickListener()
	arg_3_0._btnrestaurant:RemoveClickListener()
end

function var_0_0._btncloseviewOnClick(arg_4_0)
	ViewMgr.instance:closeView(ViewName.VersionActivity2_0DungeonMapLevelView)
end

function var_0_0._btnactivitystoreOnClick(arg_5_0)
	ReactivityController.instance:openReactivityStoreView(VersionActivity2_7Enum.ActivityId.Reactivity)
end

function var_0_0._btnactivitytaskOnClick(arg_6_0)
	ReactivityController.instance:openReactivityTaskView(VersionActivity2_7Enum.ActivityId.Reactivity)
end

function var_0_0._btngraffitiOnClick(arg_7_0)
	local var_7_0 = {
		actId = Activity161Model.instance:getActId()
	}

	Activity161Controller.instance:openGraffitiView(var_7_0)
end

function var_0_0._btnrestaurantOnClick(arg_8_0)
	arg_8_0.activityDungeonMo:changeEpisode(VersionActivity2_0DungeonEnum.restaurantChapterMap)
	VersionActivity2_0DungeonController.instance:dispatchEvent(VersionActivity2_0DungeonEvent.FocusElement, VersionActivity2_0DungeonEnum.restaurantElement)
	TaskDispatcher.runDelay(arg_8_0.showExcessiveEffect, arg_8_0, 0.2)
	TaskDispatcher.runDelay(arg_8_0.enterRestaurant, arg_8_0, 0.7)
	VersionActivity2_0DungeonModel.instance:setOpeningGraffitiEntrance(true)
	arg_8_0.viewContainer.mapSceneElements:setMouseElementDown(nil)
end

function var_0_0.enterRestaurant(arg_9_0)
	arg_9_0.isEnterRestaurant = true

	VersionActivity2_0DungeonModel.instance:setOpenGraffitiEntrance(true)
	gohelper.setActive(arg_9_0._goswitchmodecontainer, false)
	gohelper.setActive(arg_9_0._btnrestaurant.gameObject, false)
	arg_9_0.viewContainer.mapEpisodeView:hideUI()

	local var_9_0 = lua_chapter_map.configDict[Activity161Enum.graffitiMapId]

	Activity161Controller.instance:openGraffitiEnterView()

	arg_9_0.viewContainer.mapScene.tempInitPosX = nil

	arg_9_0.viewContainer.mapScene:refreshMap(false, var_9_0)
	gohelper.setActive(arg_9_0._simagenormalmask.gameObject, false)
	gohelper.setActive(arg_9_0._simagehardmask.gameObject, false)
	gohelper.setActive(arg_9_0._simagerestaurant, true)
end

function var_0_0.showExcessiveEffect(arg_10_0)
	gohelper.setActive(arg_10_0._goExcessiveEffect, false)
	gohelper.setActive(arg_10_0._goExcessiveEffect, true)
end

function var_0_0._onEscBtnClick(arg_11_0)
	if VersionActivity2_0DungeonModel.instance:getOpenGraffitiEntranceState() then
		ViewMgr.instance:closeView(ViewName.VersionActivity2_0DungeonMapGraffitiEnterView)

		return
	end

	if VersionActivity2_0DungeonModel.instance:checkIsShowInteractView() then
		arg_11_0.viewContainer.interactView:hide()
	else
		arg_11_0:closeThis()
	end
end

function var_0_0.beginShowRewardView(arg_12_0)
	arg_12_0._showRewardView = true
end

function var_0_0.endShowRewardView(arg_13_0)
	arg_13_0._showRewardView = false
end

function var_0_0.onRemoveElement(arg_14_0, arg_14_1)
	local var_14_0 = Activity161Model.instance:getActId()
	local var_14_1, var_14_2 = Activity161Config.instance:checkIsGraffitiMainElement(var_14_0, arg_14_1)

	if var_14_1 then
		GameFacade.showToast(ToastEnum.GraffitiElementFinish, var_14_2.finishTitle)
	end
end

function var_0_0.checkHasUnDoElement(arg_15_0)
	Activity161Controller.instance:checkHasUnDoElement()
end

function var_0_0._editableInitView(arg_16_0)
	Activity161Controller.instance:checkHasUnDoElement()
	NavigateMgr.instance:addEscape(arg_16_0.viewName, arg_16_0._onEscBtnClick, arg_16_0)
	TaskDispatcher.runRepeat(arg_16_0._everyMinuteCall, arg_16_0, TimeUtil.OneMinuteSecond)
	RedDotController.instance:addRedDot(arg_16_0._goTaskReddot, RedDotEnum.DotNode.V2a0DungeonTask)

	local var_16_0 = Activity161Model.instance:getActId()

	RedDotController.instance:addMultiRedDot(arg_16_0._goGraffitiReddot, {
		{
			id = RedDotEnum.DotNode.V2a0GraffitiReward,
			uid = var_16_0
		},
		{
			id = RedDotEnum.DotNode.V2a0GraffitiUnlock,
			uid = var_16_0
		}
	})
	RedDotController.instance:addRedDot(arg_16_0._goRestaurantReddot, RedDotEnum.DotNode.V2a0DungeonRestaurant)

	arg_16_0.isEnterRestaurant = false
end

function var_0_0._everyMinuteCall(arg_17_0)
	arg_17_0:refreshUI()
end

function var_0_0.onUpdateParam(arg_18_0)
	arg_18_0:onOpen()
end

function var_0_0.onOpen(arg_19_0)
	VersionActivity2_0DungeonController.instance:onVersionActivityDungeonMapViewOpen()
	arg_19_0:refreshUI()
end

function var_0_0.refreshUI(arg_20_0)
	arg_20_0:refreshBtnVisible()
	arg_20_0:refreshActivityCurrency()
	arg_20_0:refreshMask()
	arg_20_0:refreshStoreRemainTime()
end

function var_0_0.refreshBtnVisible(arg_21_0)
	arg_21_0.isEntranceUnlock = VersionActivity2_0DungeonModel.instance:getGraffitiEntranceUnlockState()

	gohelper.setActive(arg_21_0._btngraffiti.gameObject, false)
	gohelper.setActive(arg_21_0._btnrestaurant.gameObject, arg_21_0.isEntranceUnlock and not arg_21_0.isEnterRestaurant)

	if arg_21_0._showRewardView then
		return
	end
end

function var_0_0.refreshActivityCurrency(arg_22_0)
	local var_22_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V2a0Dungeon)
	local var_22_1 = var_22_0 and var_22_0.quantity or 0

	arg_22_0._txtstorenum.text = GameUtil.numberDisplay(var_22_1)
end

function var_0_0.onRefreshActivityState(arg_23_0, arg_23_1)
	local var_23_0 = Activity161Model.instance:getActId()

	if arg_23_1 and arg_23_1 ~= var_23_0 then
		return
	end

	if ActivityModel.instance:isActOnLine(var_23_0) then
		Activity161Controller.instance:initAct161Info(false, true, arg_23_0.refreshBtnVisible, arg_23_0)
	else
		gohelper.setActive(arg_23_0._btngraffiti.gameObject, false)
		gohelper.setActive(arg_23_0._btnrestaurant.gameObject, false)
	end
end

function var_0_0._onOpenView(arg_24_0, arg_24_1)
	if arg_24_1 ~= ViewName.VersionActivity2_0DungeonMapLevelView then
		return
	end

	arg_24_0._rectmask2D.padding = var_0_2

	gohelper.setActive(arg_24_0._btncloseview, true)
	arg_24_0:hideBtnUI()
end

function var_0_0.hideBtnUI(arg_25_0)
	arg_25_0.animator:Play("close", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity2_0DungeonEnum.BlockKey.MapViewPlayCloseAnim)
	TaskDispatcher.runDelay(arg_25_0.playCloseAnimaDone, arg_25_0, var_0_3)
end

function var_0_0.playCloseAnimaDone(arg_26_0)
	if not VersionActivity2_0DungeonModel.instance:getOpenGraffitiEntranceState() then
		arg_26_0:setNavBtnIsShow(false)
	end

	gohelper.setActive(arg_26_0._gotopright, false)
	gohelper.setActive(arg_26_0._goswitchmodecontainer, false)
	UIBlockMgr.instance:endBlock(VersionActivity2_0DungeonEnum.BlockKey.MapViewPlayCloseAnim)
end

function var_0_0._onCloseView(arg_27_0, arg_27_1)
	if arg_27_1 ~= ViewName.VersionActivity2_0DungeonMapLevelView then
		return
	end

	arg_27_0._rectmask2D.padding = var_0_1

	gohelper.setActive(arg_27_0._btncloseview, false)
	arg_27_0:showBtnUI()
end

function var_0_0.showBtnUI(arg_28_0)
	arg_28_0:setNavBtnIsShow(true)
	gohelper.setActive(arg_28_0._gotopright, true)
	gohelper.setActive(arg_28_0._btnrestaurant.gameObject, arg_28_0.isEntranceUnlock and not arg_28_0.isEnterRestaurant)
	gohelper.setActive(arg_28_0._goswitchmodecontainer, true)
	arg_28_0.animator:Play("open", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity2_0DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	TaskDispatcher.runDelay(arg_28_0.playOpenAnimaDone, arg_28_0, var_0_3)
end

function var_0_0.showRestaurantPartBtnUI(arg_29_0)
	arg_29_0:setNavBtnIsShow(true)
	gohelper.setActive(arg_29_0._gotopright, true)
	arg_29_0.animator:Play("open", 0, 0)
end

function var_0_0.playOpenAnimaDone(arg_30_0)
	UIBlockMgr.instance:endBlock(VersionActivity2_0DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.setNavBtnIsShow(arg_31_0, arg_31_1)
	gohelper.setActive(arg_31_0._gotopleft, arg_31_1)
end

function var_0_0.onClickElement(arg_32_0)
	arg_32_0:hideBtnUI()
	arg_32_0:setNavBtnIsShow(false)
end

function var_0_0.onModeChange(arg_33_0)
	arg_33_0:refreshMask()
end

function var_0_0.refreshMask(arg_34_0)
	local var_34_0 = arg_34_0.activityDungeonMo:isHardMode()

	gohelper.setActive(arg_34_0._simagenormalmask.gameObject, not var_34_0 and not arg_34_0.isEnterRestaurant)
	gohelper.setActive(arg_34_0._simagehardmask.gameObject, var_34_0 and not arg_34_0.isEnterRestaurant)
	gohelper.setActive(arg_34_0._simagerestaurant, arg_34_0.isEnterRestaurant)
end

function var_0_0.refreshStoreRemainTime(arg_35_0)
	local var_35_0 = VersionActivity2_7Enum.ActivityId.ReactivityStore
	local var_35_1 = ActivityModel.instance:getActMO(var_35_0):getRealEndTimeStamp() - ServerTime.now()

	if var_35_1 > TimeUtil.OneDaySecond then
		local var_35_2 = Mathf.Floor(var_35_1 / TimeUtil.OneDaySecond) .. "d"

		arg_35_0._txtStoreRemainTime.text = var_35_2

		return
	end

	if var_35_1 > TimeUtil.OneHourSecond then
		local var_35_3 = Mathf.Floor(var_35_1 / TimeUtil.OneHourSecond) .. "h"

		arg_35_0._txtStoreRemainTime.text = var_35_3

		return
	end

	arg_35_0._txtStoreRemainTime.text = "1h"
end

function var_0_0.closeGraffitiEnterView(arg_36_0)
	arg_36_0.isEnterRestaurant = false

	arg_36_0:showBtnUI()
	arg_36_0:refreshMask()
end

function var_0_0.onClose(arg_37_0)
	arg_37_0._showRewardView = false

	TaskDispatcher.cancelTask(arg_37_0._everyMinuteCall, arg_37_0)
	TaskDispatcher.cancelTask(arg_37_0.enterRestaurant, arg_37_0)
	TaskDispatcher.cancelTask(arg_37_0.showExcessiveEffect, arg_37_0)
	UIBlockMgr.instance:endBlock(VersionActivity2_0DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	UIBlockMgr.instance:endBlock(VersionActivity2_0DungeonEnum.BlockKey.MapViewPlayCloseAnim)
	UIBlockMgr.instance:endBlock(VersionActivity2_0DungeonEnum.BlockKey.OpenGraffitiEnterView)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.onDestroyView(arg_38_0)
	return
end

return var_0_0
