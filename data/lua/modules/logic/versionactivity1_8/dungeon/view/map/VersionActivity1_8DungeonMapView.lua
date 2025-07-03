module("modules.logic.versionactivity1_8.dungeon.view.map.VersionActivity1_8DungeonMapView", package.seeall)

local var_0_0 = class("VersionActivity1_8DungeonMapView", BaseView)
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
	arg_1_0._txtstorenum = gohelper.findChildText(arg_1_0.viewGO, "#go_topright/#btn_activitystore/normal/#txt_num")
	arg_1_0._imagestoreicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_topright/#btn_activitystore/normal/#simage_icon")
	arg_1_0._txtStoreRemainTime = gohelper.findChildText(arg_1_0.viewGO, "#go_topright/#btn_activitystore/#go_time/#txt_time")
	arg_1_0._goTaskReddot = gohelper.findChild(arg_1_0.viewGO, "#go_topright/#btn_activitytask/#go_reddot")
	arg_1_0._goFactoryReddot = gohelper.findChild(arg_1_0.viewGO, "#go_topright/#btn_wish/#go_reddot")
	arg_1_0._goexcessive = gohelper.findChild(arg_1_0.viewGO, "#go_excessive")
	arg_1_0._btncloseview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closeview")
	arg_1_0._btnactivitystore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_topright/#btn_activitystore")
	arg_1_0._btnactivitytask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_topright/#btn_activitytask")
	arg_1_0._btnReturnToWork = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_topright/#btn_wish")

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
	arg_2_0:addEventCb(Activity157Controller.instance, Activity157Event.Act157RefreshEntrance, arg_2_0.refreshBtnVisible, arg_2_0)
	arg_2_0:addEventCb(Activity157Controller.instance, Activity157Event.Act157PlayMissionUnlockAnim, arg_2_0.refreshReddot, arg_2_0)
	arg_2_0:addEventCb(Activity157Controller.instance, Activity157Event.Act157UpdateInfo, arg_2_0.refreshReddot, arg_2_0)
	arg_2_0:addEventCb(Activity157Controller.instance, Activity157Event.Act157RepairComponent, arg_2_0.refreshReddot, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnClickElement, arg_2_0.onClickElement, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnHideInteractUI, arg_2_0.showBtnUI, arg_2_0)
	arg_2_0._btncloseview:AddClickListener(arg_2_0._btncloseviewOnClick, arg_2_0)
	arg_2_0._btnactivitystore:AddClickListener(arg_2_0._btnactivitystoreOnClick, arg_2_0)
	arg_2_0._btnactivitytask:AddClickListener(arg_2_0._btnactivitytaskOnClick, arg_2_0)
	arg_2_0._btnReturnToWork:AddClickListener(arg_2_0._btnReturnToWorkOnClick, arg_2_0)
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
	arg_3_0:removeEventCb(Activity157Controller.instance, Activity157Event.Act157RefreshEntrance, arg_3_0.refreshBtnVisible, arg_3_0)
	arg_3_0:removeEventCb(Activity157Controller.instance, Activity157Event.Act157PlayMissionUnlockAnim, arg_3_0.refreshReddot, arg_3_0)
	arg_3_0:removeEventCb(Activity157Controller.instance, Activity157Event.Act157UpdateInfo, arg_3_0.refreshReddot, arg_3_0)
	arg_3_0:removeEventCb(Activity157Controller.instance, Activity157Event.Act157RepairComponent, arg_3_0.refreshReddot, arg_3_0)
	arg_3_0:removeEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnClickElement, arg_3_0.onClickElement, arg_3_0)
	arg_3_0:removeEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnHideInteractUI, arg_3_0.showBtnUI, arg_3_0)
	arg_3_0._btncloseview:RemoveClickListener()
	arg_3_0._btnactivitystore:RemoveClickListener()
	arg_3_0._btnactivitytask:RemoveClickListener()
	arg_3_0._btnReturnToWork:RemoveClickListener()
end

function var_0_0._onOpenView(arg_4_0, arg_4_1)
	if arg_4_1 ~= ViewName.VersionActivity1_8DungeonMapLevelView then
		return
	end

	arg_4_0._rectmask2D.padding = var_0_2

	gohelper.setActive(arg_4_0._btncloseview, true)
	arg_4_0:hideBtnUI()
end

function var_0_0.hideBtnUI(arg_5_0)
	arg_5_0.animator:Play("close", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity1_8DungeonEnum.BlockKey.MapViewPlayCloseAnim)
	TaskDispatcher.runDelay(arg_5_0.playCloseAnimaDone, arg_5_0, var_0_3)
end

function var_0_0.playCloseAnimaDone(arg_6_0)
	arg_6_0:setNavBtnIsShow(false)
	gohelper.setActive(arg_6_0._gotopright, false)
	gohelper.setActive(arg_6_0._goswitchmodecontainer, false)
	UIBlockMgr.instance:endBlock(VersionActivity1_8DungeonEnum.BlockKey.MapViewPlayCloseAnim)
end

function var_0_0._onCloseView(arg_7_0, arg_7_1)
	if arg_7_1 ~= ViewName.VersionActivity1_8DungeonMapLevelView then
		return
	end

	arg_7_0._rectmask2D.padding = var_0_1

	gohelper.setActive(arg_7_0._btncloseview, false)
	arg_7_0:showBtnUI()
end

function var_0_0.showBtnUI(arg_8_0)
	arg_8_0:setNavBtnIsShow(true)
	gohelper.setActive(arg_8_0._gotopright, false)
	gohelper.setActive(arg_8_0._goswitchmodecontainer, true)
	arg_8_0.animator:Play("open", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity1_8DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	TaskDispatcher.runDelay(arg_8_0.playOpenAnimaDone, arg_8_0, var_0_3)
end

function var_0_0.playOpenAnimaDone(arg_9_0)
	UIBlockMgr.instance:endBlock(VersionActivity1_8DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.onRemoveElement(arg_10_0, arg_10_1)
	local var_10_0 = Activity157Model.instance:getActId()

	if not ActivityModel.instance:isActOnLine(var_10_0) then
		return
	end

	local var_10_1 = Activity157Config.instance:getAct157Const(var_10_0, Activity157Enum.ConstId.UnlockEntranceElement)

	if arg_10_1 and arg_10_1 == tonumber(var_10_1) then
		Activity157Controller.instance:getAct157ActInfo()
	end
end

function var_0_0.beginShowRewardView(arg_11_0)
	arg_11_0._showRewardView = true
end

function var_0_0.onModeChange(arg_12_0)
	arg_12_0:refreshMask()
end

function var_0_0.onRefreshActivityState(arg_13_0, arg_13_1)
	local var_13_0 = Activity157Model.instance:getActId()

	if arg_13_1 and arg_13_1 ~= var_13_0 then
		return
	end

	if ActivityModel.instance:isActOnLine(var_13_0) then
		Activity157Controller.instance:getAct157ActInfo(false, true, arg_13_0.refreshBtnVisible, arg_13_0)
	else
		gohelper.setActive(arg_13_0._btnReturnToWork.gameObject, false)
	end
end

function var_0_0.refreshReddot(arg_14_0)
	arg_14_0:refreshFactoryReddot(arg_14_0._factoryReddot)
end

function var_0_0.onClickElement(arg_15_0)
	arg_15_0:hideBtnUI()
	arg_15_0:setNavBtnIsShow(false)
end

function var_0_0._btncloseviewOnClick(arg_16_0)
	ViewMgr.instance:closeView(ViewName.VersionActivity1_8DungeonMapLevelView)
end

function var_0_0._btnactivitystoreOnClick(arg_17_0)
	ReactivityController.instance:openReactivityStoreView(VersionActivity2_4Enum.ActivityId.Reactivity)
end

function var_0_0._btnactivitytaskOnClick(arg_18_0)
	ReactivityController.instance:openReactivityTaskView(VersionActivity2_4Enum.ActivityId.Reactivity)
end

function var_0_0._btnReturnToWorkOnClick(arg_19_0)
	Activity157Controller.instance:openFactoryMapView()
end

function var_0_0._onEscBtnClick(arg_20_0)
	if VersionActivity1_8DungeonModel.instance:checkIsShowInteractView() then
		arg_20_0.viewContainer.interactView:hide()
	else
		arg_20_0:closeThis()
	end
end

function var_0_0._editableInitView(arg_21_0)
	local var_21_0 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.V1a8Dungeon)

	if var_21_0 then
		local var_21_1 = string.format("%s_1", var_21_0 and var_21_0.icon)

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_21_0._imagestoreicon, var_21_1)
	end

	NavigateMgr.instance:addEscape(arg_21_0.viewName, arg_21_0._onEscBtnClick, arg_21_0)
	TaskDispatcher.runRepeat(arg_21_0._everyMinuteCall, arg_21_0, TimeUtil.OneMinuteSecond)
	RedDotController.instance:addRedDot(arg_21_0._goTaskReddot, RedDotEnum.DotNode.V1a8DungeonTask)

	arg_21_0._factoryReddot = RedDotController.instance:addRedDot(arg_21_0._goFactoryReddot, RedDotEnum.DotNode.V1a8DungeonFactory, nil, arg_21_0.refreshFactoryReddot, arg_21_0)
end

function var_0_0.refreshFactoryReddot(arg_22_0, arg_22_1)
	if not arg_22_1 then
		return
	end

	arg_22_1:defaultRefreshDot()

	if arg_22_1.show then
		return
	end

	local var_22_0 = Activity157Model.instance:getActId()

	if not ActivityModel.instance:isActOnLine(var_22_0) then
		return
	end

	local var_22_1 = Activity157Model.instance:getAllActiveNodeGroupList()
	local var_22_2 = Activity157Model.instance:getIsSideMissionUnlocked()

	for iter_22_0, iter_22_1 in ipairs(var_22_1) do
		local var_22_3 = {}
		local var_22_4 = Activity157Config.instance:isSideMissionGroup(var_22_0, iter_22_1)

		if not var_22_2 or var_22_4 and var_22_2 then
			var_22_3 = Activity157Config.instance:getAct157MissionList(var_22_0, iter_22_1)
		end

		for iter_22_2, iter_22_3 in ipairs(var_22_3) do
			local var_22_5 = Activity157Model.instance:getMissionStatus(iter_22_1, iter_22_3)
			local var_22_6 = Activity157Model.instance:getIsNeedPlayMissionUnlockAnim(iter_22_3)

			if var_22_5 == Activity157Enum.MissionStatus.Normal and var_22_6 then
				local var_22_7 = false

				if var_22_4 then
					var_22_7 = Activity157Model.instance:isInProgressOtherMissionGroup(iter_22_1)
				end

				arg_22_1.show = not var_22_7

				if arg_22_1.show then
					break
				end
			end
		end

		if arg_22_1.show then
			break
		end
	end

	arg_22_1:showRedDot(RedDotEnum.Style.Normal)
end

function var_0_0._everyMinuteCall(arg_23_0)
	arg_23_0:refreshUI()
end

function var_0_0.onUpdateParam(arg_24_0)
	arg_24_0:onOpen()
end

function var_0_0.onOpen(arg_25_0)
	VersionActivity1_8DungeonController.instance:onVersionActivityDungeonMapViewOpen()
	arg_25_0:refreshUI()
	gohelper.setActive(arg_25_0._gotopright, false)
end

function var_0_0.refreshUI(arg_26_0)
	arg_26_0:refreshBtnVisible()
	arg_26_0:refreshActivityCurrency()
	arg_26_0:refreshMask()
	arg_26_0:refreshStoreRemainTime()
end

function var_0_0.refreshBtnVisible(arg_27_0)
	local var_27_0 = Activity157Model.instance:getIsUnlockEntrance()

	gohelper.setActive(arg_27_0._btnReturnToWork.gameObject, var_27_0)

	if not var_27_0 then
		return
	end

	Activity157Controller.instance:dispatchEvent(Activity157Event.GuideHasUnlockFactoryEntrance)

	if arg_27_0._showRewardView then
		return
	end

	local var_27_1 = Activity157Model.instance:getActId()

	if not GuideModel.instance:isGuideFinish(GuideEnum.GuideId.Act157FactoryUnlock) then
		local var_27_2 = Activity157Config.instance:getAct157Const(var_27_1, Activity157Enum.ConstId.UnlockEntranceElement)

		DungeonController.instance:dispatchEvent(DungeonEvent.onGuideCloseFragmentInfoView, tonumber(var_27_2))
	else
		if Activity157Model.instance:getIsFirstComponentRepair() then
			return
		end

		local var_27_3 = Activity157Config.instance:getAct157Const(var_27_1, Activity157Enum.ConstId.FirstFactoryComponent)

		if Activity157Model.instance:isCanRepairComponent(var_27_3) then
			DungeonController.instance:dispatchEvent(DungeonEvent.onGuideCloseFragmentInfoView, Activity157Enum.UnlockBlueprintElement)
		end
	end
end

function var_0_0.endShowRewardView(arg_28_0)
	arg_28_0._showRewardView = false
end

function var_0_0.refreshActivityCurrency(arg_29_0)
	local var_29_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V1a8Dungeon)
	local var_29_1 = var_29_0 and var_29_0.quantity or 0

	arg_29_0._txtstorenum.text = GameUtil.numberDisplay(var_29_1)
end

function var_0_0.refreshMask(arg_30_0)
	local var_30_0 = arg_30_0.activityDungeonMo:isHardMode()

	gohelper.setActive(arg_30_0._simagenormalmask.gameObject, not var_30_0)
	gohelper.setActive(arg_30_0._simagehardmask.gameObject, var_30_0)
end

function var_0_0.refreshStoreRemainTime(arg_31_0)
	local var_31_0 = VersionActivity2_4Enum.ActivityId.ReactivityStore
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

function var_0_0.setNavBtnIsShow(arg_32_0, arg_32_1)
	gohelper.setActive(arg_32_0._gotopleft, arg_32_1 and true or false)
end

function var_0_0.onClose(arg_33_0)
	arg_33_0._showRewardView = false

	TaskDispatcher.cancelTask(arg_33_0._everyMinuteCall, arg_33_0)
	UIBlockMgr.instance:endBlock(VersionActivity1_8DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	UIBlockMgr.instance:endBlock(VersionActivity1_8DungeonEnum.BlockKey.MapViewPlayCloseAnim)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.onDestroyView(arg_34_0)
	return
end

return var_0_0
