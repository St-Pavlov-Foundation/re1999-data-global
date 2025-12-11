module("modules.logic.versionactivity2_4.dungeon.view.map.VersionActivity2_4DungeonMapView", package.seeall)

local var_0_0 = class("VersionActivity2_4DungeonMapView", BaseView)
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
	arg_1_0._btnwuerlixi = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_wuerlixi")
	arg_1_0._gowuerlixireddot = gohelper.findChild(arg_1_0.viewGO, "#btn_wuerlixi/image_Icon/#go_reddot")
	arg_1_0._btnwuerlixiAnimator = arg_1_0._btnwuerlixi.gameObject:GetComponent(gohelper.Type_Animator)

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
	arg_2_0:addEventCb(VersionActivity2_4DungeonController.instance, VersionActivity2_4DungeonEvent.OnClickElement, arg_2_0.onClickElement, arg_2_0)
	arg_2_0:addEventCb(VersionActivity2_4DungeonController.instance, VersionActivity2_4DungeonEvent.OnHideInteractUI, arg_2_0.showBtnUI, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateMapElementState, arg_2_0._OnUpdateMapElementState, arg_2_0)
	arg_2_0:addEventCb(GameSceneMgr.instance, SceneEventName.LoadingAnimEnd, arg_2_0.checkLoadingAndRefresh, arg_2_0)
	arg_2_0._btncloseview:AddClickListener(arg_2_0._btncloseviewOnClick, arg_2_0)
	arg_2_0._btnactivitystore:AddClickListener(arg_2_0._btnactivitystoreOnClick, arg_2_0)
	arg_2_0._btnactivitytask:AddClickListener(arg_2_0._btnactivitytaskOnClick, arg_2_0)
	arg_2_0._btnwuerlixi:AddClickListener(arg_2_0._btnwuerlixiOnClick, arg_2_0)
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
	arg_3_0:removeEventCb(VersionActivity2_4DungeonController.instance, VersionActivity2_4DungeonEvent.OnClickElement, arg_3_0.onClickElement, arg_3_0)
	arg_3_0:removeEventCb(VersionActivity2_4DungeonController.instance, VersionActivity2_4DungeonEvent.OnHideInteractUI, arg_3_0.showBtnUI, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.OnUpdateMapElementState, arg_3_0._OnUpdateMapElementState, arg_3_0)
	arg_3_0:addEventCb(GameSceneMgr.instance, SceneEventName.LoadingAnimEnd, arg_3_0.checkLoadingAndRefresh, arg_3_0)
	arg_3_0._btncloseview:RemoveClickListener()
	arg_3_0._btnactivitystore:RemoveClickListener()
	arg_3_0._btnactivitytask:RemoveClickListener()
	arg_3_0._btnwuerlixi:RemoveClickListener()
end

function var_0_0._btncloseviewOnClick(arg_4_0)
	ViewMgr.instance:closeView(ViewName.VersionActivity2_4DungeonMapLevelView)
end

function var_0_0._btnactivitystoreOnClick(arg_5_0)
	ReactivityController.instance:openReactivityStoreView(VersionActivity3_1Enum.ActivityId.Reactivity)
end

function var_0_0._btnactivitytaskOnClick(arg_6_0)
	ReactivityController.instance:openReactivityTaskView(VersionActivity3_1Enum.ActivityId.Reactivity)
end

function var_0_0._btnwuerlixiOnClick(arg_7_0)
	WuErLiXiController.instance:enterLevelView()
end

function var_0_0._onEscBtnClick(arg_8_0)
	if VersionActivity2_4DungeonModel.instance:checkIsShowInteractView() then
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
	return
end

function var_0_0._editableInitView(arg_12_0)
	local var_12_0 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.V2a4Dungeon)

	if var_12_0 then
		local var_12_1 = string.format("%s_1", var_12_0 and var_12_0.icon)

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_12_0._imagestoreicon, var_12_1)
	end

	local var_12_2 = ActivityModel.instance:getActivityInfo()[VersionActivity3_1Enum.ActivityId.ReactivityStore]

	arg_12_0._txtstorename.text = var_12_2.config.name

	NavigateMgr.instance:addEscape(arg_12_0.viewName, arg_12_0._onEscBtnClick, arg_12_0)
	TaskDispatcher.runRepeat(arg_12_0._everyMinuteCall, arg_12_0, TimeUtil.OneMinuteSecond)
	RedDotController.instance:addRedDot(arg_12_0._goTaskReddot, RedDotEnum.DotNode.V2a4DungeonTask)
	RedDotController.instance:addRedDot(arg_12_0._gowuerlixireddot, RedDotEnum.DotNode.V2a4WuErLiXiTask)
end

function var_0_0._everyMinuteCall(arg_13_0)
	arg_13_0:refreshUI()
end

function var_0_0.onUpdateParam(arg_14_0)
	arg_14_0:onOpen()
end

function var_0_0.onOpen(arg_15_0)
	VersionActivity2_4DungeonController.instance:onVersionActivityDungeonMapViewOpen()
	arg_15_0:refreshUI()
end

function var_0_0.checkLoadingAndRefresh(arg_16_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
end

function var_0_0.refreshUI(arg_17_0)
	arg_17_0:refreshActivityCurrency()
	arg_17_0:refreshMask()
	arg_17_0:refreshStoreRemainTime()
	arg_17_0:refreshBtnState()
end

function var_0_0.refreshBtnState(arg_18_0)
	local var_18_0 = ActivityHelper.getActivityStatus(VersionActivity2_4Enum.ActivityId.WuErLiXi, true)

	gohelper.setActive(arg_18_0._btnwuerlixi.gameObject, var_18_0 == ActivityEnum.ActivityStatus.Normal)

	arg_18_0._wuerlixiunlock = var_18_0 == ActivityEnum.ActivityStatus.Normal
end

function var_0_0.refreshActivityCurrency(arg_19_0)
	local var_19_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V2a4Dungeon)
	local var_19_1 = var_19_0 and var_19_0.quantity or 0

	arg_19_0._txtstorenum.text = GameUtil.numberDisplay(var_19_1)
end

function var_0_0.onRefreshActivityState(arg_20_0, arg_20_1)
	if arg_20_1 == VersionActivity2_4Enum.ActivityId.Dungeon and not (ActivityHelper.getActivityStatusAndToast(arg_20_1) == ActivityEnum.ActivityStatus.Normal) then
		arg_20_0:closeThis()
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	if arg_20_1 == VersionActivity2_4Enum.ActivityId.WuErLiXi then
		arg_20_0:refreshBtnState()

		if ActivityHelper.getActivityStatusAndToast(arg_20_1) == ActivityEnum.ActivityStatus.Normal and not arg_20_0._wuerlixiunlock then
			arg_20_0._btnwuerlixiAnimator:Play("show", 0, 0)

			arg_20_0._wuerlixiunlock = true

			return
		end
	end
end

function var_0_0._onOpenView(arg_21_0, arg_21_1)
	if arg_21_1 ~= ViewName.VersionActivity2_4DungeonMapLevelView then
		return
	end

	arg_21_0._rectmask2D.padding = var_0_2

	gohelper.setActive(arg_21_0._btncloseview, true)
	arg_21_0:hideBtnUI()
end

function var_0_0.hideBtnUI(arg_22_0)
	arg_22_0.animator:Play(UIAnimationName.Close, 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity2_4DungeonEnum.BlockKey.MapViewPlayCloseAnim)
	TaskDispatcher.runDelay(arg_22_0.playCloseAnimaDone, arg_22_0, var_0_3)
	arg_22_0._btnwuerlixiAnimator:Play(UIAnimationName.Close, 0, 0)
end

function var_0_0.playCloseAnimaDone(arg_23_0)
	gohelper.setActive(arg_23_0._gotopright, false)
	gohelper.setActive(arg_23_0._goswitchmodecontainer, false)
	UIBlockMgr.instance:endBlock(VersionActivity2_4DungeonEnum.BlockKey.MapViewPlayCloseAnim)
end

function var_0_0._onCloseView(arg_24_0, arg_24_1)
	if arg_24_1 ~= ViewName.VersionActivity2_4DungeonMapLevelView then
		return
	end

	arg_24_0._rectmask2D.padding = var_0_1

	gohelper.setActive(arg_24_0._btncloseview, false)
	arg_24_0:showBtnUI()
end

function var_0_0.showBtnUI(arg_25_0)
	arg_25_0:setNavBtnIsShow(true)
	gohelper.setActive(arg_25_0._gotopright, true)
	gohelper.setActive(arg_25_0._goswitchmodecontainer, true)
	arg_25_0.animator:Play(UIAnimationName.Open, 0, 0)
	arg_25_0._btnwuerlixiAnimator:Play(UIAnimationName.Open, 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity2_4DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	TaskDispatcher.runDelay(arg_25_0.playOpenAnimaDone, arg_25_0, var_0_3)
end

function var_0_0.playOpenAnimaDone(arg_26_0)
	UIBlockMgr.instance:endBlock(VersionActivity2_4DungeonEnum.BlockKey.MapViewPlayOpenAnim)
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
	local var_31_0 = VersionActivity3_1Enum.ActivityId.ReactivityStore
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

function var_0_0._OnUpdateMapElementState(arg_32_0, arg_32_1)
	return
end

function var_0_0.onClose(arg_33_0)
	arg_33_0._showRewardView = false

	TaskDispatcher.cancelTask(arg_33_0._everyMinuteCall, arg_33_0)
	UIBlockMgr.instance:endBlock(VersionActivity2_4DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	UIBlockMgr.instance:endBlock(VersionActivity2_4DungeonEnum.BlockKey.MapViewPlayCloseAnim)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.onDestroyView(arg_34_0)
	return
end

return var_0_0
