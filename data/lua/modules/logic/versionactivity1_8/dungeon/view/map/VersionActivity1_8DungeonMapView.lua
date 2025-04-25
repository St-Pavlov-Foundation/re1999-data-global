module("modules.logic.versionactivity1_8.dungeon.view.map.VersionActivity1_8DungeonMapView", package.seeall)

slot0 = class("VersionActivity1_8DungeonMapView", BaseView)
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
	slot0._txtstorenum = gohelper.findChildText(slot0.viewGO, "#go_topright/#btn_activitystore/normal/#txt_num")
	slot0._imagestoreicon = gohelper.findChildImage(slot0.viewGO, "#go_topright/#btn_activitystore/normal/#simage_icon")
	slot0._txtStoreRemainTime = gohelper.findChildText(slot0.viewGO, "#go_topright/#btn_activitystore/#go_time/#txt_time")
	slot0._goTaskReddot = gohelper.findChild(slot0.viewGO, "#go_topright/#btn_activitytask/#go_reddot")
	slot0._goFactoryReddot = gohelper.findChild(slot0.viewGO, "#go_topright/#btn_wish/#go_reddot")
	slot0._goexcessive = gohelper.findChild(slot0.viewGO, "#go_excessive")
	slot0._btncloseview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closeview")
	slot0._btnactivitystore = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_topright/#btn_activitystore")
	slot0._btnactivitytask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_topright/#btn_activitytask")
	slot0._btnReturnToWork = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_topright/#btn_wish")

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
	slot0:addEventCb(Activity157Controller.instance, Activity157Event.Act157RefreshEntrance, slot0.refreshBtnVisible, slot0)
	slot0:addEventCb(Activity157Controller.instance, Activity157Event.Act157PlayMissionUnlockAnim, slot0.refreshReddot, slot0)
	slot0:addEventCb(Activity157Controller.instance, Activity157Event.Act157UpdateInfo, slot0.refreshReddot, slot0)
	slot0:addEventCb(Activity157Controller.instance, Activity157Event.Act157RepairComponent, slot0.refreshReddot, slot0)
	slot0:addEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnClickElement, slot0.onClickElement, slot0)
	slot0:addEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnHideInteractUI, slot0.showBtnUI, slot0)
	slot0._btncloseview:AddClickListener(slot0._btncloseviewOnClick, slot0)
	slot0._btnactivitystore:AddClickListener(slot0._btnactivitystoreOnClick, slot0)
	slot0._btnactivitytask:AddClickListener(slot0._btnactivitytaskOnClick, slot0)
	slot0._btnReturnToWork:AddClickListener(slot0._btnReturnToWorkOnClick, slot0)
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
	slot0:removeEventCb(Activity157Controller.instance, Activity157Event.Act157RefreshEntrance, slot0.refreshBtnVisible, slot0)
	slot0:removeEventCb(Activity157Controller.instance, Activity157Event.Act157PlayMissionUnlockAnim, slot0.refreshReddot, slot0)
	slot0:removeEventCb(Activity157Controller.instance, Activity157Event.Act157UpdateInfo, slot0.refreshReddot, slot0)
	slot0:removeEventCb(Activity157Controller.instance, Activity157Event.Act157RepairComponent, slot0.refreshReddot, slot0)
	slot0:removeEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnClickElement, slot0.onClickElement, slot0)
	slot0:removeEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnHideInteractUI, slot0.showBtnUI, slot0)
	slot0._btncloseview:RemoveClickListener()
	slot0._btnactivitystore:RemoveClickListener()
	slot0._btnactivitytask:RemoveClickListener()
	slot0._btnReturnToWork:RemoveClickListener()
end

function slot0._onOpenView(slot0, slot1)
	if slot1 ~= ViewName.VersionActivity1_8DungeonMapLevelView then
		return
	end

	slot0._rectmask2D.padding = uv0

	gohelper.setActive(slot0._btncloseview, true)
	slot0:hideBtnUI()
end

function slot0.hideBtnUI(slot0)
	slot0.animator:Play("close", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity1_8DungeonEnum.BlockKey.MapViewPlayCloseAnim)
	TaskDispatcher.runDelay(slot0.playCloseAnimaDone, slot0, uv0)
end

function slot0.playCloseAnimaDone(slot0)
	slot0:setNavBtnIsShow(false)
	gohelper.setActive(slot0._gotopright, false)
	gohelper.setActive(slot0._goswitchmodecontainer, false)
	UIBlockMgr.instance:endBlock(VersionActivity1_8DungeonEnum.BlockKey.MapViewPlayCloseAnim)
end

function slot0._onCloseView(slot0, slot1)
	if slot1 ~= ViewName.VersionActivity1_8DungeonMapLevelView then
		return
	end

	slot0._rectmask2D.padding = uv0

	gohelper.setActive(slot0._btncloseview, false)
	slot0:showBtnUI()
end

function slot0.showBtnUI(slot0)
	slot0:setNavBtnIsShow(true)
	gohelper.setActive(slot0._gotopright, false)
	gohelper.setActive(slot0._goswitchmodecontainer, true)
	slot0.animator:Play("open", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity1_8DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	TaskDispatcher.runDelay(slot0.playOpenAnimaDone, slot0, uv0)
end

function slot0.playOpenAnimaDone(slot0)
	UIBlockMgr.instance:endBlock(VersionActivity1_8DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function slot0.onRemoveElement(slot0, slot1)
	if not ActivityModel.instance:isActOnLine(Activity157Model.instance:getActId()) then
		return
	end

	if slot1 and slot1 == tonumber(Activity157Config.instance:getAct157Const(slot2, Activity157Enum.ConstId.UnlockEntranceElement)) then
		Activity157Controller.instance:getAct157ActInfo()
	end
end

function slot0.beginShowRewardView(slot0)
	slot0._showRewardView = true
end

function slot0.onModeChange(slot0)
	slot0:refreshMask()
end

function slot0.onRefreshActivityState(slot0, slot1)
	slot2 = Activity157Model.instance:getActId()

	if slot1 and slot1 ~= slot2 then
		return
	end

	if ActivityModel.instance:isActOnLine(slot2) then
		Activity157Controller.instance:getAct157ActInfo(false, true, slot0.refreshBtnVisible, slot0)
	else
		gohelper.setActive(slot0._btnReturnToWork.gameObject, false)
	end
end

function slot0.refreshReddot(slot0)
	slot0:refreshFactoryReddot(slot0._factoryReddot)
end

function slot0.onClickElement(slot0)
	slot0:hideBtnUI()
	slot0:setNavBtnIsShow(false)
end

function slot0._btncloseviewOnClick(slot0)
	ViewMgr.instance:closeView(ViewName.VersionActivity1_8DungeonMapLevelView)
end

function slot0._btnactivitystoreOnClick(slot0)
	ReactivityController.instance:openReactivityStoreView(VersionActivity2_4Enum.ActivityId.Reactivity)
end

function slot0._btnactivitytaskOnClick(slot0)
	ReactivityController.instance:openReactivityTaskView(VersionActivity2_4Enum.ActivityId.Reactivity)
end

function slot0._btnReturnToWorkOnClick(slot0)
	Activity157Controller.instance:openFactoryMapView()
end

function slot0._onEscBtnClick(slot0)
	if VersionActivity1_8DungeonModel.instance:checkIsShowInteractView() then
		slot0.viewContainer.interactView:hide()
	else
		slot0:closeThis()
	end
end

function slot0._editableInitView(slot0)
	if CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.V1a8Dungeon) then
		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imagestoreicon, string.format("%s_1", slot1 and slot1.icon))
	end

	NavigateMgr.instance:addEscape(slot0.viewName, slot0._onEscBtnClick, slot0)
	TaskDispatcher.runRepeat(slot0._everyMinuteCall, slot0, TimeUtil.OneMinuteSecond)
	RedDotController.instance:addRedDot(slot0._goTaskReddot, RedDotEnum.DotNode.V1a8DungeonTask)

	slot0._factoryReddot = RedDotController.instance:addRedDot(slot0._goFactoryReddot, RedDotEnum.DotNode.V1a8DungeonFactory, nil, slot0.refreshFactoryReddot, slot0)
end

function slot0.refreshFactoryReddot(slot0, slot1)
	if not slot1 then
		return
	end

	slot1:defaultRefreshDot()

	if slot1.show then
		return
	end

	if not ActivityModel.instance:isActOnLine(Activity157Model.instance:getActId()) then
		return
	end

	slot5 = Activity157Model.instance:getIsSideMissionUnlocked()

	for slot9, slot10 in ipairs(Activity157Model.instance:getAllActiveNodeGroupList()) do
		slot11 = {}

		if not slot5 or Activity157Config.instance:isSideMissionGroup(slot2, slot10) and slot5 then
			slot11 = Activity157Config.instance:getAct157MissionList(slot2, slot10)
		end

		for slot16, slot17 in ipairs(slot11) do
			if Activity157Model.instance:getMissionStatus(slot10, slot17) == Activity157Enum.MissionStatus.Normal and Activity157Model.instance:getIsNeedPlayMissionUnlockAnim(slot17) then
				slot20 = false

				if slot12 then
					slot20 = Activity157Model.instance:isInProgressOtherMissionGroup(slot10)
				end

				slot1.show = not slot20

				if slot1.show then
					break
				end
			end
		end

		if slot1.show then
			break
		end
	end

	slot1:showRedDot(RedDotEnum.Style.Normal)
end

function slot0._everyMinuteCall(slot0)
	slot0:refreshUI()
end

function slot0.onUpdateParam(slot0)
	slot0:onOpen()
end

function slot0.onOpen(slot0)
	VersionActivity1_8DungeonController.instance:onVersionActivityDungeonMapViewOpen()
	slot0:refreshUI()
	gohelper.setActive(slot0._gotopright, false)
end

function slot0.refreshUI(slot0)
	slot0:refreshBtnVisible()
	slot0:refreshActivityCurrency()
	slot0:refreshMask()
	slot0:refreshStoreRemainTime()
end

function slot0.refreshBtnVisible(slot0)
	slot1 = Activity157Model.instance:getIsUnlockEntrance()

	gohelper.setActive(slot0._btnReturnToWork.gameObject, slot1)

	if not slot1 then
		return
	end

	Activity157Controller.instance:dispatchEvent(Activity157Event.GuideHasUnlockFactoryEntrance)

	if slot0._showRewardView then
		return
	end

	if not GuideModel.instance:isGuideFinish(GuideEnum.GuideId.Act157FactoryUnlock) then
		DungeonController.instance:dispatchEvent(DungeonEvent.onGuideCloseFragmentInfoView, tonumber(Activity157Config.instance:getAct157Const(Activity157Model.instance:getActId(), Activity157Enum.ConstId.UnlockEntranceElement)))
	else
		if Activity157Model.instance:getIsFirstComponentRepair() then
			return
		end

		if Activity157Model.instance:isCanRepairComponent(Activity157Config.instance:getAct157Const(slot2, Activity157Enum.ConstId.FirstFactoryComponent)) then
			DungeonController.instance:dispatchEvent(DungeonEvent.onGuideCloseFragmentInfoView, Activity157Enum.UnlockBlueprintElement)
		end
	end
end

function slot0.endShowRewardView(slot0)
	slot0._showRewardView = false
end

function slot0.refreshActivityCurrency(slot0)
	slot0._txtstorenum.text = GameUtil.numberDisplay(CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V1a8Dungeon) and slot1.quantity or 0)
end

function slot0.refreshMask(slot0)
	slot1 = slot0.activityDungeonMo:isHardMode()

	gohelper.setActive(slot0._simagenormalmask.gameObject, not slot1)
	gohelper.setActive(slot0._simagehardmask.gameObject, slot1)
end

function slot0.refreshStoreRemainTime(slot0)
	if TimeUtil.OneDaySecond < ActivityModel.instance:getActMO(VersionActivity2_4Enum.ActivityId.ReactivityStore):getRealEndTimeStamp() - ServerTime.now() then
		slot0._txtStoreRemainTime.text = Mathf.Floor(slot4 / TimeUtil.OneDaySecond) .. "d"

		return
	end

	if TimeUtil.OneHourSecond < slot4 then
		slot0._txtStoreRemainTime.text = Mathf.Floor(slot4 / TimeUtil.OneHourSecond) .. "h"

		return
	end

	slot0._txtStoreRemainTime.text = "1h"
end

function slot0.setNavBtnIsShow(slot0, slot1)
	gohelper.setActive(slot0._gotopleft, slot1 and true or false)
end

function slot0.onClose(slot0)
	slot0._showRewardView = false

	TaskDispatcher.cancelTask(slot0._everyMinuteCall, slot0)
	UIBlockMgr.instance:endBlock(VersionActivity1_8DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	UIBlockMgr.instance:endBlock(VersionActivity1_8DungeonEnum.BlockKey.MapViewPlayCloseAnim)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function slot0.onDestroyView(slot0)
end

return slot0
