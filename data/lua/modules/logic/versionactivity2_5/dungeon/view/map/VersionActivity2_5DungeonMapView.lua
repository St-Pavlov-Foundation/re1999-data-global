module("modules.logic.versionactivity2_5.dungeon.view.map.VersionActivity2_5DungeonMapView", package.seeall)

slot0 = class("VersionActivity2_5DungeonMapView", BaseView)
slot1 = Vector4(0, 0, 0, 0)
slot2 = Vector4(0, 0, 600, 0)
slot3 = 0.5

function slot0.onInitView(slot0)
	slot0.animator = slot0.viewGO:GetComponent(gohelper.Type_Animator)
	slot0._simagenormalmask = gohelper.findChildSingleImage(slot0.viewGO, "#simage_normalmask")
	slot0._simagehardmask = gohelper.findChildSingleImage(slot0.viewGO, "#simage_hardmask")
	slot0._scrollcontent = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_content")
	slot0._rectmask2D = slot0._scrollcontent:GetComponent(typeof(UnityEngine.UI.RectMask2D))
	slot0._goswitchmodecontainer = gohelper.findChild(slot0.viewGO, "#go_switchmodecontainer")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._gotopright = gohelper.findChild(slot0.viewGO, "#go_topright")
	slot0._txtstorename = gohelper.findChildText(slot0.viewGO, "#go_topright/#btn_activitystore/normal/txt_shop")
	slot0._txtstorenum = gohelper.findChildText(slot0.viewGO, "#go_topright/#btn_activitystore/normal/#txt_num")
	slot0._imagestoreicon = gohelper.findChildImage(slot0.viewGO, "#go_topright/#btn_activitystore/normal/#simage_icon")
	slot0._txtStoreRemainTime = gohelper.findChildText(slot0.viewGO, "#go_topright/#btn_activitystore/#go_time/#txt_time")
	slot0._goTaskReddot = gohelper.findChild(slot0.viewGO, "#go_topright/#btn_activitytask/#go_reddot")
	slot0._goexcessive = gohelper.findChild(slot0.viewGO, "#go_excessive")
	slot0._btncloseview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closeview")
	slot0._btnactivitystore = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_topright/#btn_activitystore")
	slot0._btnactivitytask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_topright/#btn_activitytask")
	slot0._btnrestaurant = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_topright/#btn_restaurant")
	slot0._goact165Reddot = gohelper.findChild(slot0.viewGO, "#go_topright/#btn_restaurant/#go_reddot")

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
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshActivityCurrency, slot0)
	slot0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, slot0.onModeChange, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.onRefreshActivityState, slot0)
	slot0:addEventCb(Activity165Controller.instance, Activity165Event.Act165GetInfoReply, slot0.refreshRestaurantBtn, slot0)
	slot0:addEventCb(VersionActivity2_5DungeonController.instance, VersionActivity2_5DungeonEvent.OnClickElement, slot0.onClickElement, slot0)
	slot0:addEventCb(VersionActivity2_5DungeonController.instance, VersionActivity2_5DungeonEvent.OnHideInteractUI, slot0.showBtnUI, slot0)
	slot0:addEventCb(Activity165Controller.instance, Activity165Event.refreshStoryReddot, slot0._act165RedDot, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateMapElementState, slot0._OnUpdateMapElementState, slot0)
	slot0:addEventCb(GameSceneMgr.instance, SceneEventName.LoadingAnimEnd, slot0.checkLoadingAndRefresh, slot0)
	slot0._btncloseview:AddClickListener(slot0._btncloseviewOnClick, slot0)
	slot0._btnactivitystore:AddClickListener(slot0._btnactivitystoreOnClick, slot0)
	slot0._btnactivitytask:AddClickListener(slot0._btnactivitytaskOnClick, slot0)
	slot0._btnrestaurant:AddClickListener(slot0._btnrestaurantOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, slot0.onRemoveElement, slot0, LuaEventSystem.Low)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, slot0.beginShowRewardView, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, slot0.endShowRewardView, slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshActivityCurrency, slot0)
	slot0:removeEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, slot0.onModeChange, slot0)
	slot0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.onRefreshActivityState, slot0)
	slot0:removeEventCb(Activity165Controller.instance, Activity165Event.Act165GetInfoReply, slot0.refreshRestaurantBtn, slot0)
	slot0:removeEventCb(VersionActivity2_5DungeonController.instance, VersionActivity2_5DungeonEvent.OnClickElement, slot0.onClickElement, slot0)
	slot0:removeEventCb(VersionActivity2_5DungeonController.instance, VersionActivity2_5DungeonEvent.OnHideInteractUI, slot0.showBtnUI, slot0)
	slot0:removeEventCb(Activity165Controller.instance, Activity165Event.refreshStoryReddot, slot0._act165RedDot, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.OnUpdateMapElementState, slot0._OnUpdateMapElementState, slot0)
	slot0:addEventCb(GameSceneMgr.instance, SceneEventName.LoadingAnimEnd, slot0.checkLoadingAndRefresh, slot0)
	slot0._btncloseview:RemoveClickListener()
	slot0._btnactivitystore:RemoveClickListener()
	slot0._btnactivitytask:RemoveClickListener()
	slot0._btnrestaurant:RemoveClickListener()
end

function slot0._btncloseviewOnClick(slot0)
	ViewMgr.instance:closeView(ViewName.VersionActivity2_5DungeonMapLevelView)
end

function slot0._btnactivitystoreOnClick(slot0)
	VersionActivity2_5DungeonController.instance:openStoreView()
end

function slot0._btnactivitytaskOnClick(slot0)
	VersionActivity2_5DungeonController.instance:openTaskView()
end

function slot0._btnrestaurantOnClick(slot0)
	Activity165Controller.instance:openActivity165EnterView()
end

function slot0._onEscBtnClick(slot0)
	if VersionActivity2_5DungeonModel.instance:checkIsShowInteractView() then
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
	slot3 = Activity165Model.instance:getActivityId()

	if VersionActivity2_5DungeonModel.instance:checkStoryCanUnlock(slot1) then
		GameFacade.showToast(ToastEnum.Act165StoryUnlock, slot2.name)
		Activity165Model.instance:onInitInfo()
	end
end

function slot0._editableInitView(slot0)
	slot0._txtstorename.text = ActivityModel.instance:getActivityInfo()[VersionActivity2_5Enum.ActivityId.DungeonStore].config.name

	NavigateMgr.instance:addEscape(slot0.viewName, slot0._onEscBtnClick, slot0)
	TaskDispatcher.runRepeat(slot0._everyMinuteCall, slot0, TimeUtil.OneMinuteSecond)
	RedDotController.instance:addRedDot(slot0._goTaskReddot, RedDotEnum.DotNode.V2a5DungeonEnter)
	slot0:_act165RedDot()
end

function slot0._everyMinuteCall(slot0)
	slot0:refreshUI()
end

function slot0.onUpdateParam(slot0)
	slot0:onOpen()
end

function slot0.onOpen(slot0)
	VersionActivity2_5DungeonController.instance:onVersionActivityDungeonMapViewOpen()
	slot0:refreshUI()
end

function slot0.checkLoadingAndRefresh(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
end

function slot0.refreshUI(slot0)
	slot0:refreshRestaurantBtn()
	slot0:refreshActivityCurrency()
	slot0:refreshMask()
	slot0:refreshStoreRemainTime()
end

function slot0.refreshActivityCurrency(slot0)
	slot0._txtstorenum.text = GameUtil.numberDisplay(CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V2a5Dungeon) and slot1.quantity or 0)
end

function slot0.onRefreshActivityState(slot0, slot1)
	if slot1 == VersionActivity2_5Enum.ActivityId.Dungeon and not (ActivityHelper.getActivityStatusAndToast(slot1) == ActivityEnum.ActivityStatus.Normal) then
		slot0:closeThis()
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	slot2 = Activity165Model.instance:getActivityId()

	if slot1 and slot1 ~= slot2 then
		return
	end

	if ActivityModel.instance:isActOnLine(slot2) then
		Activity165Model.instance:onInitInfo()
	else
		gohelper.setActive(slot0._btnrestaurant.gameObject, false)
	end
end

function slot0._onOpenView(slot0, slot1)
	if slot1 ~= ViewName.VersionActivity2_5DungeonMapLevelView then
		return
	end

	slot0._rectmask2D.padding = uv0

	gohelper.setActive(slot0._btncloseview, true)
	slot0:hideBtnUI()
end

function slot0.hideBtnUI(slot0)
	slot0.animator:Play("close", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity2_5DungeonEnum.BlockKey.MapViewPlayCloseAnim)
	TaskDispatcher.runDelay(slot0.playCloseAnimaDone, slot0, uv0)
end

function slot0.playCloseAnimaDone(slot0)
	gohelper.setActive(slot0._gotopright, false)
	gohelper.setActive(slot0._goswitchmodecontainer, false)
	UIBlockMgr.instance:endBlock(VersionActivity2_5DungeonEnum.BlockKey.MapViewPlayCloseAnim)
end

function slot0._onCloseView(slot0, slot1)
	if slot1 ~= ViewName.VersionActivity2_5DungeonMapLevelView then
		return
	end

	slot0._rectmask2D.padding = uv0

	gohelper.setActive(slot0._btncloseview, false)
	slot0:showBtnUI()
end

function slot0.showBtnUI(slot0)
	slot0:setNavBtnIsShow(true)
	gohelper.setActive(slot0._gotopright, true)
	gohelper.setActive(slot0._goswitchmodecontainer, true)
	slot0:refreshRestaurantBtn()
	slot0.animator:Play("open", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity2_5DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	TaskDispatcher.runDelay(slot0.playOpenAnimaDone, slot0, uv0)
end

function slot0.refreshRestaurantBtn(slot0)
	gohelper.setActive(slot0._btnrestaurant.gameObject, VersionActivity2_5DungeonModel.instance:isUnlockAct165Btn())
end

function slot0.playOpenAnimaDone(slot0)
	UIBlockMgr.instance:endBlock(VersionActivity2_5DungeonEnum.BlockKey.MapViewPlayOpenAnim)
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
	slot1 = slot0.activityDungeonMo:isHardMode()

	gohelper.setActive(slot0._simagenormalmask.gameObject, not slot1)
	gohelper.setActive(slot0._simagehardmask.gameObject, slot1)
end

function slot0.refreshStoreRemainTime(slot0)
	if TimeUtil.OneDaySecond < ActivityModel.instance:getActMO(VersionActivity2_5Enum.ActivityId.DungeonStore):getRealEndTimeStamp() - ServerTime.now() then
		slot0._txtStoreRemainTime.text = Mathf.Floor(slot4 / TimeUtil.OneDaySecond) .. "d"

		return
	end

	if TimeUtil.OneHourSecond < slot4 then
		slot0._txtStoreRemainTime.text = Mathf.Floor(slot4 / TimeUtil.OneHourSecond) .. "h"

		return
	end

	slot0._txtStoreRemainTime.text = "1h"
end

function slot0._act165RedDot(slot0)
	gohelper.setActive(slot0._goact165Reddot.gameObject, Activity165Model.instance:isShowAct165Reddot())
end

function slot0._OnUpdateMapElementState(slot0, slot1)
	if Activity165Model.instance:getAllElements() then
		for slot6, slot7 in pairs(slot2) do
			if DungeonConfig.instance:getChapterMapElement(slot7) and slot8.mapId == slot1 then
				Activity165Model.instance:onInitInfo()

				return
			end
		end
	end
end

function slot0.onClose(slot0)
	slot0._showRewardView = false

	TaskDispatcher.cancelTask(slot0._everyMinuteCall, slot0)
	UIBlockMgr.instance:endBlock(VersionActivity2_5DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	UIBlockMgr.instance:endBlock(VersionActivity2_5DungeonEnum.BlockKey.MapViewPlayCloseAnim)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function slot0.onDestroyView(slot0)
end

return slot0
