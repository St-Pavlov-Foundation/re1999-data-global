module("modules.logic.versionactivity2_1.dungeon.view.map.VersionActivity2_1DungeonMapView", package.seeall)

local var_0_0 = class("VersionActivity2_1DungeonMapView", BaseView)
local var_0_1 = Vector4(0, 0, 0, 0)
local var_0_2 = Vector4(0, 0, 600, 0)
local var_0_3 = 0.5

function var_0_0.onInitView(arg_1_0)
	arg_1_0.animator = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_1_0._simagenormalmask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_normalmask")
	arg_1_0._simagehardmask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_hardmask")
	arg_1_0._scrollcontent = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_content")
	arg_1_0._rectmask2D = arg_1_0._scrollcontent:GetComponent(typeof(UnityEngine.UI.RectMask2D))
	arg_1_0._goswitchmodecontainer = gohelper.findChild(arg_1_0.viewGO, "#go_switchmodecontainer")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._gotopright = gohelper.findChild(arg_1_0.viewGO, "#go_topright")
	arg_1_0._txtstorename = gohelper.findChildText(arg_1_0.viewGO, "#go_topright/#btn_activitystore/normal/txt_shop")
	arg_1_0._txtstorenum = gohelper.findChildText(arg_1_0.viewGO, "#go_topright/#btn_activitystore/normal/#txt_num")
	arg_1_0._imagestoreicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_topright/#btn_activitystore/normal/#simage_icon")
	arg_1_0._txtStoreRemainTime = gohelper.findChildText(arg_1_0.viewGO, "#go_topright/#btn_activitystore/#go_time/#txt_time")
	arg_1_0._goTaskReddot = gohelper.findChild(arg_1_0.viewGO, "#go_topright/#btn_activitytask/#go_reddot")
	arg_1_0._goexcessive = gohelper.findChild(arg_1_0.viewGO, "#go_excessive")
	arg_1_0._btncloseview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closeview")
	arg_1_0._btnactivitystore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_topright/#btn_activitystore")
	arg_1_0._btnactivitytask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_topright/#btn_activitytask")
	arg_1_0._btnrestaurant = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_topright/#btn_restaurant")
	arg_1_0._goact165Reddot = gohelper.findChild(arg_1_0.viewGO, "#go_topright/#btn_restaurant/#go_reddot")

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
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0.refreshActivityCurrency, arg_2_0)
	arg_2_0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, arg_2_0.onModeChange, arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_2_0.onRefreshActivityState, arg_2_0)
	arg_2_0:addEventCb(Activity165Controller.instance, Activity165Event.Act165GetInfoReply, arg_2_0.refreshRestaurantBtn, arg_2_0)
	arg_2_0:addEventCb(VersionActivity2_1DungeonController.instance, VersionActivity2_1DungeonEvent.OnClickElement, arg_2_0.onClickElement, arg_2_0)
	arg_2_0:addEventCb(VersionActivity2_1DungeonController.instance, VersionActivity2_1DungeonEvent.OnHideInteractUI, arg_2_0.showBtnUI, arg_2_0)
	arg_2_0:addEventCb(Activity165Controller.instance, Activity165Event.refreshStoryReddot, arg_2_0._act165RedDot, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateMapElementState, arg_2_0._OnUpdateMapElementState, arg_2_0)
	arg_2_0:addEventCb(GameSceneMgr.instance, SceneEventName.LoadingAnimEnd, arg_2_0.checkLoadingAndRefresh, arg_2_0)
	arg_2_0._btncloseview:AddClickListener(arg_2_0._btncloseviewOnClick, arg_2_0)
	arg_2_0._btnactivitystore:AddClickListener(arg_2_0._btnactivitystoreOnClick, arg_2_0)
	arg_2_0._btnactivitytask:AddClickListener(arg_2_0._btnactivitytaskOnClick, arg_2_0)
	arg_2_0._btnrestaurant:AddClickListener(arg_2_0._btnrestaurantOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0._onOpenView, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, arg_3_0.onRemoveElement, arg_3_0, LuaEventSystem.Low)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, arg_3_0.beginShowRewardView, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, arg_3_0.endShowRewardView, arg_3_0)
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0.refreshActivityCurrency, arg_3_0)
	arg_3_0:removeEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, arg_3_0.onModeChange, arg_3_0)
	arg_3_0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_3_0.onRefreshActivityState, arg_3_0)
	arg_3_0:removeEventCb(Activity165Controller.instance, Activity165Event.Act165GetInfoReply, arg_3_0.refreshRestaurantBtn, arg_3_0)
	arg_3_0:removeEventCb(VersionActivity2_1DungeonController.instance, VersionActivity2_1DungeonEvent.OnClickElement, arg_3_0.onClickElement, arg_3_0)
	arg_3_0:removeEventCb(VersionActivity2_1DungeonController.instance, VersionActivity2_1DungeonEvent.OnHideInteractUI, arg_3_0.showBtnUI, arg_3_0)
	arg_3_0:removeEventCb(Activity165Controller.instance, Activity165Event.refreshStoryReddot, arg_3_0._act165RedDot, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.OnUpdateMapElementState, arg_3_0._OnUpdateMapElementState, arg_3_0)
	arg_3_0:addEventCb(GameSceneMgr.instance, SceneEventName.LoadingAnimEnd, arg_3_0.checkLoadingAndRefresh, arg_3_0)
	arg_3_0._btncloseview:RemoveClickListener()
	arg_3_0._btnactivitystore:RemoveClickListener()
	arg_3_0._btnactivitytask:RemoveClickListener()
	arg_3_0._btnrestaurant:RemoveClickListener()
end

function var_0_0._btncloseviewOnClick(arg_4_0)
	ViewMgr.instance:closeView(ViewName.VersionActivity2_1DungeonMapLevelView)
end

function var_0_0._btnactivitystoreOnClick(arg_5_0)
	VersionActivity2_1DungeonController.instance:openStoreView()
end

function var_0_0._btnactivitytaskOnClick(arg_6_0)
	VersionActivity2_1DungeonController.instance:openTaskView()
end

function var_0_0._btnrestaurantOnClick(arg_7_0)
	Activity165Controller.instance:openActivity165EnterView()
end

function var_0_0._onEscBtnClick(arg_8_0)
	if VersionActivity2_1DungeonModel.instance:checkIsShowInteractView() then
		arg_8_0.viewContainer.interactView:hide()
	else
		arg_8_0:closeThis()
	end
end

function var_0_0.beginShowRewardView(arg_9_0)
	arg_9_0._showRewardView = true
end

function var_0_0.endShowRewardView(arg_10_0)
	arg_10_0._showRewardView = false
end

function var_0_0.onRemoveElement(arg_11_0, arg_11_1)
	local var_11_0 = VersionActivity2_1DungeonModel.instance:checkStoryCanUnlock(arg_11_1)
	local var_11_1 = Activity165Model.instance:getActivityId()

	if var_11_0 then
		GameFacade.showToast(ToastEnum.Act165StoryUnlock, var_11_0.name)
		Activity165Model.instance:onInitInfo()
	end
end

function var_0_0._editableInitView(arg_12_0)
	local var_12_0 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.V2a1Dungeon)

	if var_12_0 then
		local var_12_1 = string.format("%s_1", var_12_0 and var_12_0.icon)

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_12_0._imagestoreicon, var_12_1)
	end

	local var_12_2 = ActivityModel.instance:getActivityInfo()[VersionActivity2_1Enum.ActivityId.DungeonStore]

	arg_12_0._txtstorename.text = var_12_2.config.name

	NavigateMgr.instance:addEscape(arg_12_0.viewName, arg_12_0._onEscBtnClick, arg_12_0)
	TaskDispatcher.runRepeat(arg_12_0._everyMinuteCall, arg_12_0, TimeUtil.OneMinuteSecond)
	RedDotController.instance:addRedDot(arg_12_0._goTaskReddot, RedDotEnum.DotNode.V2a1DungeonTask)
	arg_12_0:_act165RedDot()
end

function var_0_0._everyMinuteCall(arg_13_0)
	arg_13_0:refreshUI()
end

function var_0_0.onUpdateParam(arg_14_0)
	arg_14_0:onOpen()
end

function var_0_0.onOpen(arg_15_0)
	VersionActivity2_1DungeonController.instance:onVersionActivityDungeonMapViewOpen()
	arg_15_0:refreshUI()
end

function var_0_0.checkLoadingAndRefresh(arg_16_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
end

function var_0_0.refreshUI(arg_17_0)
	arg_17_0:refreshRestaurantBtn()
	arg_17_0:refreshActivityCurrency()
	arg_17_0:refreshMask()
	arg_17_0:refreshStoreRemainTime()
end

function var_0_0.refreshActivityCurrency(arg_18_0)
	local var_18_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V2a1Dungeon)
	local var_18_1 = var_18_0 and var_18_0.quantity or 0

	arg_18_0._txtstorenum.text = GameUtil.numberDisplay(var_18_1)
end

function var_0_0.onRefreshActivityState(arg_19_0, arg_19_1)
	if arg_19_1 == VersionActivity2_1Enum.ActivityId.Dungeon and not (ActivityHelper.getActivityStatusAndToast(arg_19_1) == ActivityEnum.ActivityStatus.Normal) then
		arg_19_0:closeThis()
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	local var_19_0 = Activity165Model.instance:getActivityId()

	if arg_19_1 and arg_19_1 ~= var_19_0 then
		return
	end

	if ActivityModel.instance:isActOnLine(var_19_0) then
		Activity165Model.instance:onInitInfo()
	else
		gohelper.setActive(arg_19_0._btnrestaurant.gameObject, false)
	end
end

function var_0_0._onOpenView(arg_20_0, arg_20_1)
	if arg_20_1 ~= ViewName.VersionActivity2_1DungeonMapLevelView then
		return
	end

	arg_20_0._rectmask2D.padding = var_0_2

	gohelper.setActive(arg_20_0._btncloseview, true)
	arg_20_0:hideBtnUI()
end

function var_0_0.hideBtnUI(arg_21_0)
	arg_21_0.animator:Play("close", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity2_1DungeonEnum.BlockKey.MapViewPlayCloseAnim)
	TaskDispatcher.runDelay(arg_21_0.playCloseAnimaDone, arg_21_0, var_0_3)
end

function var_0_0.playCloseAnimaDone(arg_22_0)
	gohelper.setActive(arg_22_0._gotopright, false)
	gohelper.setActive(arg_22_0._goswitchmodecontainer, false)
	UIBlockMgr.instance:endBlock(VersionActivity2_1DungeonEnum.BlockKey.MapViewPlayCloseAnim)
end

function var_0_0._onCloseView(arg_23_0, arg_23_1)
	if arg_23_1 ~= ViewName.VersionActivity2_1DungeonMapLevelView then
		return
	end

	arg_23_0._rectmask2D.padding = var_0_1

	gohelper.setActive(arg_23_0._btncloseview, false)
	arg_23_0:showBtnUI()
end

function var_0_0.showBtnUI(arg_24_0)
	arg_24_0:setNavBtnIsShow(true)
	gohelper.setActive(arg_24_0._gotopright, true)
	gohelper.setActive(arg_24_0._goswitchmodecontainer, true)
	arg_24_0:refreshRestaurantBtn()
	arg_24_0.animator:Play("open", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity2_1DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	TaskDispatcher.runDelay(arg_24_0.playOpenAnimaDone, arg_24_0, var_0_3)
end

function var_0_0.refreshRestaurantBtn(arg_25_0)
	local var_25_0 = VersionActivity2_1DungeonModel.instance:isUnlockAct165Btn()

	gohelper.setActive(arg_25_0._btnrestaurant.gameObject, var_25_0)
end

function var_0_0.playOpenAnimaDone(arg_26_0)
	UIBlockMgr.instance:endBlock(VersionActivity2_1DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.setNavBtnIsShow(arg_27_0, arg_27_1)
	gohelper.setActive(arg_27_0._gotopleft, arg_27_1)
end

function var_0_0.onClickElement(arg_28_0)
	arg_28_0:hideBtnUI()
	arg_28_0:setNavBtnIsShow(false)
end

function var_0_0.onModeChange(arg_29_0)
	arg_29_0:refreshMask()
end

function var_0_0.refreshMask(arg_30_0)
	local var_30_0 = arg_30_0.activityDungeonMo:isHardMode()

	gohelper.setActive(arg_30_0._simagenormalmask.gameObject, not var_30_0)
	gohelper.setActive(arg_30_0._simagehardmask.gameObject, var_30_0)
end

function var_0_0.refreshStoreRemainTime(arg_31_0)
	local var_31_0 = VersionActivity2_1Enum.ActivityId.DungeonStore
	local var_31_1 = ActivityModel.instance:getActMO(var_31_0):getRealEndTimeStamp() - ServerTime.now()

	if var_31_1 > TimeUtil.OneDaySecond then
		local var_31_2 = Mathf.Floor(var_31_1 / TimeUtil.OneDaySecond) .. "d"

		arg_31_0._txtStoreRemainTime.text = var_31_2

		return
	end

	if var_31_1 > TimeUtil.OneHourSecond then
		local var_31_3 = Mathf.Floor(var_31_1 / TimeUtil.OneHourSecond) .. "h"

		arg_31_0._txtStoreRemainTime.text = var_31_3

		return
	end

	arg_31_0._txtStoreRemainTime.text = "1h"
end

function var_0_0._act165RedDot(arg_32_0)
	local var_32_0 = Activity165Model.instance:isShowAct165Reddot()

	gohelper.setActive(arg_32_0._goact165Reddot.gameObject, var_32_0)
end

function var_0_0._OnUpdateMapElementState(arg_33_0, arg_33_1)
	local var_33_0 = Activity165Model.instance:getAllElements()

	if var_33_0 then
		for iter_33_0, iter_33_1 in pairs(var_33_0) do
			local var_33_1 = DungeonConfig.instance:getChapterMapElement(iter_33_1)

			if var_33_1 and var_33_1.mapId == arg_33_1 then
				Activity165Model.instance:onInitInfo()

				return
			end
		end
	end
end

function var_0_0.onClose(arg_34_0)
	arg_34_0._showRewardView = false

	TaskDispatcher.cancelTask(arg_34_0._everyMinuteCall, arg_34_0)
	UIBlockMgr.instance:endBlock(VersionActivity2_1DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	UIBlockMgr.instance:endBlock(VersionActivity2_1DungeonEnum.BlockKey.MapViewPlayCloseAnim)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.onDestroyView(arg_35_0)
	return
end

return var_0_0
