module("modules.logic.versionactivity2_0.dungeon.view.map.VersionActivity2_0DungeonMapView", package.seeall)

slot0 = class("VersionActivity2_0DungeonMapView", BaseView)
slot1 = Vector4(0, 0, 0, 0)
slot2 = Vector4(0, 0, 600, 0)
slot3 = 0.5

function slot0.onInitView(slot0)
	slot0.animator = slot0.viewGO:GetComponent(gohelper.Type_Animator)
	slot0._simagenormalmask = gohelper.findChildSingleImage(slot0.viewGO, "#simage_normalmask")
	slot0._simagehardmask = gohelper.findChildSingleImage(slot0.viewGO, "#simage_hardmask")
	slot0._simagerestaurant = gohelper.findChildSingleImage(slot0.viewGO, "#simage_restaurantmask")
	slot0._scrollcontent = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_content")
	slot0._rectmask2D = slot0._scrollcontent:GetComponent(typeof(UnityEngine.UI.RectMask2D))
	slot0._goswitchmodecontainer = gohelper.findChild(slot0.viewGO, "#go_switchmodecontainer")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._gotopright = gohelper.findChild(slot0.viewGO, "#go_topright")
	slot0._txtstorenum = gohelper.findChildText(slot0.viewGO, "#go_topright/#btn_activitystore/normal/#txt_num")
	slot0._txtStoreRemainTime = gohelper.findChildText(slot0.viewGO, "#go_topright/#btn_activitystore/#go_time/#txt_time")
	slot0._goTaskReddot = gohelper.findChild(slot0.viewGO, "#go_topright/#btn_activitytask/#go_reddot")
	slot0._goGraffitiReddot = gohelper.findChild(slot0.viewGO, "#go_topright/#btn_graffiti/#go_reddot")
	slot0._goRestaurantReddot = gohelper.findChild(slot0.viewGO, "#go_topright/#btn_restaurant/#go_reddot")
	slot0._goexcessive = gohelper.findChild(slot0.viewGO, "#go_excessive")
	slot0._btncloseview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closeview")
	slot0._btnactivitystore = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_topright/#btn_activitystore")
	slot0._btnactivitytask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_topright/#btn_activitytask")
	slot0._btnrestaurant = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_topright/#btn_restaurant")
	slot0._btngraffiti = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_topright/#btn_graffiti")
	slot0._goExcessiveEffect = gohelper.findChild(slot0.viewGO, "excessive")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, slot0.onRemoveElement, slot0, LuaEventSystem.Low)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, slot0.beginShowRewardView, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, slot0.endShowRewardView, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateMapElementState, slot0.checkHasUnDoElement, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshActivityCurrency, slot0)
	slot0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, slot0.onModeChange, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.onRefreshActivityState, slot0)
	slot0:addEventCb(VersionActivity2_0DungeonController.instance, VersionActivity2_0DungeonEvent.OnClickElement, slot0.onClickElement, slot0)
	slot0:addEventCb(VersionActivity2_0DungeonController.instance, VersionActivity2_0DungeonEvent.OnHideInteractUI, slot0.showBtnUI, slot0)
	slot0:addEventCb(Activity161Controller.instance, Activity161Event.CloseGraffitiEnterView, slot0.closeGraffitiEnterView, slot0)
	slot0:addEventCb(Activity161Controller.instance, Activity161Event.PlayExcessiveEffect, slot0.showExcessiveEffect, slot0)
	slot0._btncloseview:AddClickListener(slot0._btncloseviewOnClick, slot0)
	slot0._btnactivitystore:AddClickListener(slot0._btnactivitystoreOnClick, slot0)
	slot0._btnactivitytask:AddClickListener(slot0._btnactivitytaskOnClick, slot0)
	slot0._btngraffiti:AddClickListener(slot0._btngraffitiOnClick, slot0)
	slot0._btnrestaurant:AddClickListener(slot0._btnrestaurantOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, slot0.onRemoveElement, slot0, LuaEventSystem.Low)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, slot0.beginShowRewardView, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, slot0.endShowRewardView, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.OnUpdateMapElementState, slot0.checkHasUnDoElement, slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshActivityCurrency, slot0)
	slot0:removeEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, slot0.onModeChange, slot0)
	slot0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.onRefreshActivityState, slot0)
	slot0:removeEventCb(VersionActivity2_0DungeonController.instance, VersionActivity2_0DungeonEvent.OnClickElement, slot0.onClickElement, slot0)
	slot0:removeEventCb(VersionActivity2_0DungeonController.instance, VersionActivity2_0DungeonEvent.OnHideInteractUI, slot0.showBtnUI, slot0)
	slot0:removeEventCb(Activity161Controller.instance, Activity161Event.CloseGraffitiEnterView, slot0.closeGraffitiEnterView, slot0)
	slot0:removeEventCb(Activity161Controller.instance, Activity161Event.PlayExcessiveEffect, slot0.showExcessiveEffect, slot0)
	slot0._btncloseview:RemoveClickListener()
	slot0._btnactivitystore:RemoveClickListener()
	slot0._btnactivitytask:RemoveClickListener()
	slot0._btngraffiti:RemoveClickListener()
	slot0._btnrestaurant:RemoveClickListener()
end

function slot0._btncloseviewOnClick(slot0)
	ViewMgr.instance:closeView(ViewName.VersionActivity2_0DungeonMapLevelView)
end

function slot0._btnactivitystoreOnClick(slot0)
	VersionActivity2_0DungeonController.instance:openStoreView()
end

function slot0._btnactivitytaskOnClick(slot0)
	VersionActivity2_0DungeonController.instance:openTaskView()
end

function slot0._btngraffitiOnClick(slot0)
	Activity161Controller.instance:openGraffitiView({
		actId = Activity161Model.instance:getActId()
	})
end

function slot0._btnrestaurantOnClick(slot0)
	slot0.activityDungeonMo:changeEpisode(VersionActivity2_0DungeonEnum.restaurantChapterMap)
	VersionActivity2_0DungeonController.instance:dispatchEvent(VersionActivity2_0DungeonEvent.FocusElement, VersionActivity2_0DungeonEnum.restaurantElement)
	TaskDispatcher.runDelay(slot0.showExcessiveEffect, slot0, 0.2)
	TaskDispatcher.runDelay(slot0.enterRestaurant, slot0, 0.7)
	VersionActivity2_0DungeonModel.instance:setOpeningGraffitiEntrance(true)
	slot0.viewContainer.mapSceneElements:setMouseElementDown(nil)
end

function slot0.enterRestaurant(slot0)
	slot0.isEnterRestaurant = true

	VersionActivity2_0DungeonModel.instance:setOpenGraffitiEntrance(true)
	gohelper.setActive(slot0._goswitchmodecontainer, false)
	gohelper.setActive(slot0._btnrestaurant.gameObject, false)
	slot0.viewContainer.mapEpisodeView:hideUI()
	Activity161Controller.instance:openGraffitiEnterView()

	slot0.viewContainer.mapScene.tempInitPosX = nil

	slot0.viewContainer.mapScene:refreshMap(false, lua_chapter_map.configDict[Activity161Enum.graffitiMapId])
	gohelper.setActive(slot0._simagenormalmask.gameObject, false)
	gohelper.setActive(slot0._simagehardmask.gameObject, false)
	gohelper.setActive(slot0._simagerestaurant, true)
end

function slot0.showExcessiveEffect(slot0)
	gohelper.setActive(slot0._goExcessiveEffect, false)
	gohelper.setActive(slot0._goExcessiveEffect, true)
end

function slot0._onEscBtnClick(slot0)
	if VersionActivity2_0DungeonModel.instance:getOpenGraffitiEntranceState() then
		ViewMgr.instance:closeView(ViewName.VersionActivity2_0DungeonMapGraffitiEnterView)

		return
	end

	if VersionActivity2_0DungeonModel.instance:checkIsShowInteractView() then
		slot0.viewContainer.interactView:hide()
	else
		slot0:closeThis()
	end
end

function slot0.beginShowRewardView(slot0)
	slot0._showRewardView = true
end

function slot0.endShowRewardView(slot0)
	slot0._showRewardView = false
end

function slot0.onRemoveElement(slot0, slot1)
	slot3, slot4 = Activity161Config.instance:checkIsGraffitiMainElement(Activity161Model.instance:getActId(), slot1)

	if slot3 then
		GameFacade.showToast(ToastEnum.GraffitiElementFinish, slot4.finishTitle)
	end
end

function slot0.checkHasUnDoElement(slot0)
	Activity161Controller.instance:checkHasUnDoElement()
end

function slot0._editableInitView(slot0)
	Activity161Controller.instance:checkHasUnDoElement()
	NavigateMgr.instance:addEscape(slot0.viewName, slot0._onEscBtnClick, slot0)
	TaskDispatcher.runRepeat(slot0._everyMinuteCall, slot0, TimeUtil.OneMinuteSecond)
	RedDotController.instance:addRedDot(slot0._goTaskReddot, RedDotEnum.DotNode.V2a0DungeonTask)

	slot1 = Activity161Model.instance:getActId()

	RedDotController.instance:addMultiRedDot(slot0._goGraffitiReddot, {
		{
			id = RedDotEnum.DotNode.V2a0GraffitiReward,
			uid = slot1
		},
		{
			id = RedDotEnum.DotNode.V2a0GraffitiUnlock,
			uid = slot1
		}
	})
	RedDotController.instance:addRedDot(slot0._goRestaurantReddot, RedDotEnum.DotNode.V2a0DungeonRestaurant)

	slot0.isEnterRestaurant = false
end

function slot0._everyMinuteCall(slot0)
	slot0:refreshUI()
end

function slot0.onUpdateParam(slot0)
	slot0:onOpen()
end

function slot0.onOpen(slot0)
	VersionActivity2_0DungeonController.instance:onVersionActivityDungeonMapViewOpen()
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0:refreshBtnVisible()
	slot0:refreshActivityCurrency()
	slot0:refreshMask()
	slot0:refreshStoreRemainTime()
end

function slot0.refreshBtnVisible(slot0)
	slot0.isEntranceUnlock = VersionActivity2_0DungeonModel.instance:getGraffitiEntranceUnlockState()

	gohelper.setActive(slot0._btngraffiti.gameObject, false)
	gohelper.setActive(slot0._btnrestaurant.gameObject, slot0.isEntranceUnlock and not slot0.isEnterRestaurant)

	if slot0._showRewardView then
		return
	end
end

function slot0.refreshActivityCurrency(slot0)
	slot0._txtstorenum.text = GameUtil.numberDisplay(CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V2a0Dungeon) and slot1.quantity or 0)
end

function slot0.onRefreshActivityState(slot0, slot1)
	slot2 = Activity161Model.instance:getActId()

	if slot1 and slot1 ~= slot2 then
		return
	end

	if ActivityModel.instance:isActOnLine(slot2) then
		Activity161Controller.instance:initAct161Info(false, true, slot0.refreshBtnVisible, slot0)
	else
		gohelper.setActive(slot0._btngraffiti.gameObject, false)
		gohelper.setActive(slot0._btnrestaurant.gameObject, false)
	end
end

function slot0._onOpenView(slot0, slot1)
	if slot1 ~= ViewName.VersionActivity2_0DungeonMapLevelView then
		return
	end

	slot0._rectmask2D.padding = uv0

	gohelper.setActive(slot0._btncloseview, true)
	slot0:hideBtnUI()
end

function slot0.hideBtnUI(slot0)
	slot0.animator:Play("close", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity2_0DungeonEnum.BlockKey.MapViewPlayCloseAnim)
	TaskDispatcher.runDelay(slot0.playCloseAnimaDone, slot0, uv0)
end

function slot0.playCloseAnimaDone(slot0)
	if not VersionActivity2_0DungeonModel.instance:getOpenGraffitiEntranceState() then
		slot0:setNavBtnIsShow(false)
	end

	gohelper.setActive(slot0._gotopright, false)
	gohelper.setActive(slot0._goswitchmodecontainer, false)
	UIBlockMgr.instance:endBlock(VersionActivity2_0DungeonEnum.BlockKey.MapViewPlayCloseAnim)
end

function slot0._onCloseView(slot0, slot1)
	if slot1 ~= ViewName.VersionActivity2_0DungeonMapLevelView then
		return
	end

	slot0._rectmask2D.padding = uv0

	gohelper.setActive(slot0._btncloseview, false)
	slot0:showBtnUI()
end

function slot0.showBtnUI(slot0)
	slot0:setNavBtnIsShow(true)
	gohelper.setActive(slot0._gotopright, true)
	gohelper.setActive(slot0._btnrestaurant.gameObject, slot0.isEntranceUnlock and not slot0.isEnterRestaurant)
	gohelper.setActive(slot0._goswitchmodecontainer, true)
	slot0.animator:Play("open", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity2_0DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	TaskDispatcher.runDelay(slot0.playOpenAnimaDone, slot0, uv0)
end

function slot0.showRestaurantPartBtnUI(slot0)
	slot0:setNavBtnIsShow(true)
	gohelper.setActive(slot0._gotopright, true)
	slot0.animator:Play("open", 0, 0)
end

function slot0.playOpenAnimaDone(slot0)
	UIBlockMgr.instance:endBlock(VersionActivity2_0DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function slot0.setNavBtnIsShow(slot0, slot1)
	gohelper.setActive(slot0._gotopleft, slot1)
end

function slot0.onClickElement(slot0)
	slot0:hideBtnUI()
	slot0:setNavBtnIsShow(false)
end

function slot0.onModeChange(slot0)
	slot0:refreshMask()
end

function slot0.refreshMask(slot0)
	gohelper.setActive(slot0._simagenormalmask.gameObject, not slot0.activityDungeonMo:isHardMode() and not slot0.isEnterRestaurant)
	gohelper.setActive(slot0._simagehardmask.gameObject, slot1 and not slot0.isEnterRestaurant)
	gohelper.setActive(slot0._simagerestaurant, slot0.isEnterRestaurant)
end

function slot0.refreshStoreRemainTime(slot0)
	if TimeUtil.OneDaySecond < ActivityModel.instance:getActMO(VersionActivity2_0Enum.ActivityId.DungeonStore):getRealEndTimeStamp() - ServerTime.now() then
		slot0._txtStoreRemainTime.text = Mathf.Floor(slot4 / TimeUtil.OneDaySecond) .. "d"

		return
	end

	if TimeUtil.OneHourSecond < slot4 then
		slot0._txtStoreRemainTime.text = Mathf.Floor(slot4 / TimeUtil.OneHourSecond) .. "h"

		return
	end

	slot0._txtStoreRemainTime.text = "1h"
end

function slot0.closeGraffitiEnterView(slot0)
	slot0.isEnterRestaurant = false

	slot0:showBtnUI()
	slot0:refreshMask()
end

function slot0.onClose(slot0)
	slot0._showRewardView = false

	TaskDispatcher.cancelTask(slot0._everyMinuteCall, slot0)
	TaskDispatcher.cancelTask(slot0.enterRestaurant, slot0)
	TaskDispatcher.cancelTask(slot0.showExcessiveEffect, slot0)
	UIBlockMgr.instance:endBlock(VersionActivity2_0DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	UIBlockMgr.instance:endBlock(VersionActivity2_0DungeonEnum.BlockKey.MapViewPlayCloseAnim)
	UIBlockMgr.instance:endBlock(VersionActivity2_0DungeonEnum.BlockKey.OpenGraffitiEnterView)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function slot0.onDestroyView(slot0)
end

return slot0
