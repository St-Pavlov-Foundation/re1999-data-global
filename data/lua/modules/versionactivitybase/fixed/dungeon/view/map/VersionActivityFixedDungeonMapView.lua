module("modules.versionactivitybase.fixed.dungeon.view.map.VersionActivityFixedDungeonMapView", package.seeall)

local var_0_0 = class("VersionActivityFixedDungeonMapView", BaseView)
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
	arg_2_0:addEventCb(VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnClickElement, arg_2_0.onClickElement, arg_2_0)
	arg_2_0:addEventCb(VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnHideInteractUI, arg_2_0.showBtnUI, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateMapElementState, arg_2_0._OnUpdateMapElementState, arg_2_0)
	arg_2_0:addEventCb(GameSceneMgr.instance, SceneEventName.LoadingAnimEnd, arg_2_0.checkLoadingAndRefresh, arg_2_0)
	arg_2_0._btncloseview:AddClickListener(arg_2_0._btncloseviewOnClick, arg_2_0)
	arg_2_0._btnactivitystore:AddClickListener(arg_2_0._btnactivitystoreOnClick, arg_2_0)
	arg_2_0._btnactivitytask:AddClickListener(arg_2_0._btnactivitytaskOnClick, arg_2_0)
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
	arg_3_0:removeEventCb(VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnClickElement, arg_3_0.onClickElement, arg_3_0)
	arg_3_0:removeEventCb(VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnHideInteractUI, arg_3_0.showBtnUI, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.OnUpdateMapElementState, arg_3_0._OnUpdateMapElementState, arg_3_0)
	arg_3_0:addEventCb(GameSceneMgr.instance, SceneEventName.LoadingAnimEnd, arg_3_0.checkLoadingAndRefresh, arg_3_0)
	arg_3_0._btncloseview:RemoveClickListener()
	arg_3_0._btnactivitystore:RemoveClickListener()
	arg_3_0._btnactivitytask:RemoveClickListener()
end

function var_0_0._btncloseviewOnClick(arg_4_0)
	ViewMgr.instance:closeView(VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName(arg_4_0._bigVersion, arg_4_0._smallVersion))
end

function var_0_0._btnactivitystoreOnClick(arg_5_0)
	VersionActivityFixedHelper.getVersionActivityDungeonController(arg_5_0._bigVersion, arg_5_0._smallVersion).instance:openStoreView()
end

function var_0_0._btnactivitytaskOnClick(arg_6_0)
	VersionActivityFixedHelper.getVersionActivityDungeonController(arg_6_0._bigVersion, arg_6_0._smallVersion).instance:openTaskView()
end

function var_0_0._onEscBtnClick(arg_7_0)
	if VersionActivityFixedDungeonModel.instance:checkIsShowInteractView() then
		arg_7_0.viewContainer.interactView:hide()
	else
		arg_7_0:closeThis()
	end
end

function var_0_0.beginShowRewardView(arg_8_0)
	arg_8_0._showRewardView = true
end

function var_0_0.endShowRewardView(arg_9_0)
	arg_9_0._showRewardView = false
end

function var_0_0.onRemoveElement(arg_10_0, arg_10_1)
	return
end

function var_0_0._editableInitView(arg_11_0)
	local var_11_0 = ActivityModel.instance:getActivityInfo()[VersionActivityFixedHelper.getVersionActivityEnum().ActivityId.DungeonStore]

	arg_11_0._txtstorename.text = var_11_0.config.name

	NavigateMgr.instance:addEscape(arg_11_0.viewName, arg_11_0._onEscBtnClick, arg_11_0)
	TaskDispatcher.runRepeat(arg_11_0._everyMinuteCall, arg_11_0, TimeUtil.OneMinuteSecond)

	arg_11_0._bigVersion, arg_11_0._smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()

	local var_11_1 = VersionActivityFixedHelper.getVersionActivityDungeonTaskReddotId(arg_11_0._bigVersion, arg_11_0._smallVersion)

	RedDotController.instance:addRedDot(arg_11_0._goTaskReddot, var_11_1)
end

function var_0_0._everyMinuteCall(arg_12_0)
	arg_12_0:refreshUI()
end

function var_0_0.onUpdateParam(arg_13_0)
	arg_13_0:onOpen()
end

function var_0_0.onOpen(arg_14_0)
	VersionActivityFixedHelper.getVersionActivityDungeonController(arg_14_0._bigVersion, arg_14_0._smallVersion).instance:onVersionActivityDungeonMapViewOpen()
	arg_14_0:refreshUI()
end

function var_0_0.checkLoadingAndRefresh(arg_15_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
end

function var_0_0.refreshUI(arg_16_0)
	arg_16_0:refreshActivityCurrency()
	arg_16_0:refreshMask()
	arg_16_0:refreshStoreRemainTime()
end

function var_0_0.refreshActivityCurrency(arg_17_0)
	local var_17_0 = VersionActivityFixedHelper.getVersionActivityCurrencyType(arg_17_0._bigVersion, arg_17_0._smallVersion)
	local var_17_1 = CurrencyModel.instance:getCurrency(var_17_0)
	local var_17_2 = var_17_1 and var_17_1.quantity or 0

	arg_17_0._txtstorenum.text = GameUtil.numberDisplay(var_17_2)
end

function var_0_0.onRefreshActivityState(arg_18_0, arg_18_1)
	return
end

function var_0_0._onOpenView(arg_19_0, arg_19_1)
	if arg_19_1 ~= VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName(arg_19_0._bigVersion, arg_19_0._smallVersion) then
		return
	end

	arg_19_0._rectmask2D.padding = var_0_2

	gohelper.setActive(arg_19_0._btncloseview, true)
	arg_19_0:hideBtnUI()
end

function var_0_0.hideBtnUI(arg_20_0)
	arg_20_0.animator:Play("close", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivityFixedHelper.getVersionActivityDungeonEnum(arg_20_0._bigVersion, arg_20_0._smallVersion).BlockKey.MapViewPlayCloseAnim)
	TaskDispatcher.runDelay(arg_20_0.playCloseAnimaDone, arg_20_0, var_0_3)
end

function var_0_0.playCloseAnimaDone(arg_21_0)
	gohelper.setActive(arg_21_0._gotopright, false)
	gohelper.setActive(arg_21_0._goswitchmodecontainer, false)
	UIBlockMgr.instance:endBlock(VersionActivityFixedHelper.getVersionActivityDungeonEnum(arg_21_0._bigVersion, arg_21_0._smallVersion).BlockKey.MapViewPlayCloseAnim)
end

function var_0_0._onCloseView(arg_22_0, arg_22_1)
	if arg_22_1 ~= VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName(arg_22_0._bigVersion, arg_22_0._smallVersion) then
		return
	end

	arg_22_0._rectmask2D.padding = var_0_1

	gohelper.setActive(arg_22_0._btncloseview, false)
	arg_22_0:showBtnUI()
end

function var_0_0.showBtnUI(arg_23_0)
	arg_23_0:setNavBtnIsShow(true)
	gohelper.setActive(arg_23_0._gotopright, true)
	gohelper.setActive(arg_23_0._goswitchmodecontainer, true)
	arg_23_0.animator:Play("open", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivityFixedHelper.getVersionActivityDungeonEnum(arg_23_0._bigVersion, arg_23_0._smallVersion).BlockKey.MapViewPlayOpenAnim)
	TaskDispatcher.runDelay(arg_23_0.playOpenAnimaDone, arg_23_0, var_0_3)
end

function var_0_0.playOpenAnimaDone(arg_24_0)
	UIBlockMgr.instance:endBlock(VersionActivityFixedHelper.getVersionActivityDungeonEnum(arg_24_0._bigVersion, arg_24_0._smallVersion).BlockKey.MapViewPlayOpenAnim)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.setNavBtnIsShow(arg_25_0, arg_25_1)
	gohelper.setActive(arg_25_0._gotopleft, arg_25_1)
end

function var_0_0.onClickElement(arg_26_0)
	arg_26_0:hideBtnUI()
	arg_26_0:setNavBtnIsShow(false)
end

function var_0_0.onModeChange(arg_27_0)
	arg_27_0:refreshMask()
end

function var_0_0.refreshMask(arg_28_0)
	local var_28_0 = arg_28_0.activityDungeonMo:isHardMode()

	gohelper.setActive(arg_28_0._simagenormalmask.gameObject, not var_28_0)
	gohelper.setActive(arg_28_0._simagehardmask.gameObject, var_28_0)
end

function var_0_0.refreshStoreRemainTime(arg_29_0)
	local var_29_0 = VersionActivityFixedHelper.getVersionActivityEnum(arg_29_0._bigVersion, arg_29_0._smallVersion).ActivityId.DungeonStore
	local var_29_1 = ActivityModel.instance:getActMO(var_29_0):getRealEndTimeStamp() - ServerTime.now()

	if var_29_1 > TimeUtil.OneDaySecond then
		local var_29_2 = Mathf.Floor(var_29_1 / TimeUtil.OneDaySecond) .. "d"

		arg_29_0._txtStoreRemainTime.text = var_29_2

		return
	end

	if var_29_1 > TimeUtil.OneHourSecond then
		local var_29_3 = Mathf.Floor(var_29_1 / TimeUtil.OneHourSecond) .. "h"

		arg_29_0._txtStoreRemainTime.text = var_29_3

		return
	end

	arg_29_0._txtStoreRemainTime.text = "1h"
end

function var_0_0._OnUpdateMapElementState(arg_30_0, arg_30_1)
	return
end

function var_0_0.onClose(arg_31_0)
	arg_31_0._showRewardView = false

	TaskDispatcher.cancelTask(arg_31_0._everyMinuteCall, arg_31_0)
	UIBlockMgr.instance:endBlock(VersionActivityFixedHelper.getVersionActivityDungeonEnum(arg_31_0._bigVersion, arg_31_0._smallVersion).BlockKey.MapViewPlayOpenAnim)
	UIBlockMgr.instance:endBlock(VersionActivityFixedHelper.getVersionActivityDungeonEnum(arg_31_0._bigVersion, arg_31_0._smallVersion).BlockKey.MapViewPlayCloseAnim)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.onDestroyView(arg_32_0)
	return
end

return var_0_0
