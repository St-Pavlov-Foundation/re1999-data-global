module("modules.logic.versionactivity1_4.enter.view.VersionActivity1_4EnterView", package.seeall)

slot0 = class("VersionActivity1_4EnterView", VersionActivityEnterBaseView)

function slot0.onInitView(slot0)
	uv0.super.onInitView(slot0)

	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "img/#simage_bg/img/#simage_bg1")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "img/#simage_bg/img/#simage_bg2")
	slot0._simagebg3 = gohelper.findChildSingleImage(slot0.viewGO, "img/#simage_bg/img/#simage_bg3")
	slot0._simagebg4 = gohelper.findChildSingleImage(slot0.viewGO, "img/#simage_bg/img/#simage_bg4")
	slot0._simagemask = gohelper.findChildSingleImage(slot0.viewGO, "img/#simage_mask")
	slot0._txtremainday = gohelper.findChildText(slot0.viewGO, "logo/Time/#txt_remaintime")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "logo/Time/#txt_time")
	slot0.goTabNode = gohelper.findChild(slot0.viewGO, "logo/#go_change")
	slot0._btnmainentrance = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_mainentrance")
	slot0._btnroom = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_room")
	slot0._btnachievement = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_achievement")
	slot0._btnseasonstore = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_seasonstore")
	slot0._txtseasonstorenum = gohelper.findChildText(slot0.viewGO, "entrance/#btn_seasonstore/normal/storeBG/#txt_num")
	slot0._txtseasonstoretime = gohelper.findChildText(slot0.viewGO, "entrance/#btn_seasonstore/normal/#go_bg1/#txt_time")

	slot0:initTab()

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
	slot0._btnmainentrance:AddClickListener(slot0._onClickMainentranceBtn, slot0)
	slot0._btnroom:AddClickListener(slot0._onClickRoomBtn, slot0)
	slot0._btnachievement:AddClickListener(slot0._onClickAchievementBtn, slot0)
	slot0._btnseasonstore:AddClickListener(slot0._btnseasonstoreOnClick, slot0)
end

function slot0.removeEvents(slot0)
	uv0.super.removeEvents(slot0)
	slot0._btnmainentrance:RemoveClickListener()
	slot0._btnroom:RemoveClickListener()
	slot0._btnachievement:RemoveClickListener()
	slot0._btnseasonstore:RemoveClickListener()
end

function slot0._btnseasonstoreOnClick(slot0)
	slot3, slot4, slot5 = ActivityHelper.getActivityStatusAndToast(Activity104Enum.SeasonStore[Activity104Model.instance:getCurSeasonId()])

	if slot3 ~= ActivityEnum.ActivityStatus.Normal then
		if slot4 then
			GameFacade.showToast(slot4, slot5)
		end

		return
	end

	Activity104Controller.instance:openSeasonStoreView()
end

function slot0._onClickMainentranceBtn(slot0)
	GameFacade.jump(51)
end

function slot0._onClickRoomBtn(slot0)
	GameFacade.jump(440001)
end

function slot0._onClickAchievementBtn(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		ViewMgr.instance:openView(ViewName.AchievementMainView, {
			selectType = AchievementEnum.Type.Activity
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))
	end
end

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)
	slot0._simagebg1:LoadImage("singlebg/v1a4_enterview_singlebg/v1a4_enterview_fullbg_01.png")
	slot0._simagebg2:LoadImage("singlebg/v1a4_enterview_singlebg/v1a4_enterview_fullbg_02.png")
	slot0._simagebg3:LoadImage("singlebg/v1a4_enterview_singlebg/v1a4_enterview_fullbg_03.png")
	slot0._simagebg4:LoadImage("singlebg/v1a4_enterview_singlebg/v1a4_enterview_fullbg_04.png")
	slot0._simagemask:LoadImage("singlebg/v1a4_enterview_singlebg/v1a4_enterview_fullbgmask.png")
end

function slot0.onClickActivity1(slot0, slot1)
	Activity133Controller.instance:openActivity133MainView(slot1)
end

function slot0.onClickActivity2(slot0)
	Activity130Controller.instance:enterActivity130()
end

function slot0.onClickActivity3(slot0)
	BossRushController.instance:openMainView()
end

function slot0.onClickActivity4(slot0, slot1)
	ViewMgr.instance:openView(ViewName.VersionActivity1_4TaskView, {
		activityId = slot1
	})
end

function slot0.onClickActivity5(slot0, slot1)
	ViewMgr.instance:openView(ViewName.Activity129View, {
		actId = slot1
	})
end

function slot0.onClickActivity6(slot0, slot1)
	ViewMgr.instance:openView(ViewName.VersionActivity1_4DungeonView, {
		actId = slot1
	})
end

function slot0.onClickActivity7(slot0, slot1)
	BossRushController.instance:openMainView()
end

function slot0.onClickActivity8(slot0, slot1)
	Activity104Controller.instance:openSeasonMainView()
end

function slot0.onClickActivity9(slot0, slot1)
	Activity134Controller.instance:openActivity134MainView(slot1)
end

function slot0.onClickActivity10(slot0)
	Activity131Controller.instance:enterActivity131()
end

function slot0.onClickActivity11(slot0, slot1)
	ViewMgr.instance:openView(ViewName.Activity129View, {
		actId = slot1
	})
end

function slot0.onClickActivity12(slot0, slot1)
	ViewMgr.instance:openView(ViewName.VersionActivity1_4DungeonView, {
		actId = slot1
	})
end

function slot0.onOpen(slot0)
	slot0.onOpening = true

	slot0:initViewParam()
	slot0:initActivityNode()
	slot0:initActivityItemList()

	for slot4 = 2, 1, -1 do
		if slot0:checkTabIsOpen(slot4, true) then
			slot0:onChangeTab(slot4)

			break
		end
	end

	slot0:playOpenAnimation()
end

function slot0.playOpenAnimation(slot0)
	if slot0.skipOpenAnim then
		slot0.animator:Play(slot0.tabIndex == VersionActivity1_4Enum.TabEnum.First and "open_a" or "open_b", 0, 1)
		TaskDispatcher.runDelay(slot0.onOpenAnimationDone, slot0, 0.5)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_qiutu_open)
		slot0.animator:Play(slot1)
		TaskDispatcher.runDelay(slot0.onOpenAnimationDone, slot0, 2)
	end
end

function slot0.refreshUI(slot0)
	gohelper.setActive(slot0._btnroom, slot0.tabIndex == VersionActivity1_4Enum.TabEnum.First)
	slot0:refreshRemainTime()
	slot0:refreshCenterActUI()
	slot0:refreshActivityUI()
	slot0:refreshSeasonStore()
	slot0:refreshTabRed()
end

function slot0.refreshActivityItem(slot0, slot1)
	slot2 = slot1.index

	if not slot0.actIndex2TabIndex then
		slot0.actIndex2TabIndex = {}

		for slot6, slot7 in pairs(VersionActivity1_4Enum.TabActivityList) do
			for slot11, slot12 in ipairs(slot7) do
				slot0.actIndex2TabIndex[slot12] = slot6
			end
		end
	end

	slot3 = slot0.actIndex2TabIndex[slot2] == slot0.tabIndex

	gohelper.setActive(slot1.rootGo, slot3)

	if not slot3 then
		return
	end

	uv0.super.refreshActivityItem(slot0, slot1)
end

function slot0.refreshRemainTime(slot0)
	slot2 = ActivityModel.instance:getActivityInfo()[slot0.actId]:getRealEndTimeStamp() - ServerTime.now()

	if LangSettings.instance:isEn() then
		slot0._txtremainday.text = string.format(luaLang("remain"), string.format("%s%s %s%s", Mathf.Floor(slot2 / TimeUtil.OneDaySecond), luaLang("time_day"), Mathf.Floor(slot2 % TimeUtil.OneDaySecond / TimeUtil.OneHourSecond), luaLang("time_hour2")))
	else
		slot0._txtremainday.text = string.format(luaLang("remain"), string.format("%s%s%s%s", slot3, luaLang("time_day"), slot5, luaLang("time_hour2")))
	end
end

function slot0.refreshEnterViewTime(slot0)
	slot0:refreshRemainTime()
	slot0:refreshSeasonStore()
end

function slot0.onRefreshActivity5(slot0, slot1)
	gohelper.setActive(gohelper.findChild(slot1.goNormal, "#go_bg1"), ActivityHelper.getActivityStatus(slot1.actId) == ActivityEnum.ActivityStatus.Normal)
	gohelper.setActive(gohelper.findChild(slot1.goNormal, "storeBG"), slot2 == ActivityEnum.ActivityStatus.Normal)

	if slot2 == ActivityEnum.ActivityStatus.Normal then
		gohelper.findChildTextMesh(slot1.goNormal, "#go_bg1/#txt_time").text = ActivityModel.instance:getActMO(slot1.actId):getRemainTimeStr(true)
		gohelper.findChildTextMesh(slot1.goNormal, "storeBG/#txt_num").text = tostring(ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, Activity129Config.instance:getConstValue1(slot1.actId, Activity129Enum.ConstEnum.CostId)))
	end
end

function slot0.onRefreshActivity8(slot0, slot1)
	slot3 = ActivityHelper.getActivityStatus(slot1.actId) == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(gohelper.findChild(slot1.goNormal, "week"), slot3 and Activity104Model.instance:isEnterSpecial())
	gohelper.setActive(gohelper.findChild(slot1.goNormal, "score"), slot3)

	if slot3 and Activity104Model.instance:tryGetActivityInfo(slot1.actId, slot0.checkNeedRefreshUI, slot0) then
		gohelper.setActive(gohelper.findChildImage(slot1.rootGo, "normal/score/stage7"), Activity104Model.instance:getAct104CurStage() == 7)

		for slot11 = 1, 7 do
			UISpriteSetMgr.instance:setV1a4EnterViewSprite(gohelper.findChildImage(slot1.rootGo, "normal/score/stage" .. slot11), slot11 <= slot6 and "v1a4_enterview_scorefg" or "v1a4_enterview_scorebg", true)
		end
	end
end

function slot0.onRefreshActivity11(slot0, slot1)
	gohelper.setActive(gohelper.findChild(slot1.goNormal, "#go_bg1"), ActivityHelper.getActivityStatus(slot1.actId) == ActivityEnum.ActivityStatus.Normal)
	gohelper.setActive(gohelper.findChild(slot1.goNormal, "storeBG"), slot2 == ActivityEnum.ActivityStatus.Normal)

	if slot2 == ActivityEnum.ActivityStatus.Normal then
		gohelper.findChildTextMesh(slot1.goNormal, "#go_bg1/#txt_time").text = ActivityModel.instance:getActMO(slot1.actId):getRemainTimeStr(true)
		gohelper.findChildTextMesh(slot1.goNormal, "storeBG/#txt_num").text = tostring(ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, Activity129Config.instance:getConstValue1(slot1.actId, Activity129Enum.ConstEnum.CostId)))
	end
end

function slot0.refreshSeasonStore(slot0)
	if slot0.tabIndex == VersionActivity1_4Enum.TabEnum.First then
		gohelper.setActive(slot0._btnseasonstore, false)

		return
	end

	if ActivityHelper.getActivityStatus(Activity104Model.instance:getCurSeasonId()) == ActivityEnum.ActivityStatus.Normal then
		gohelper.setActive(slot0._btnseasonstore, false)

		return
	end

	gohelper.setActive(slot0._btnseasonstore, ActivityHelper.getActivityStatus(Activity104Enum.SeasonStore[slot1]) == ActivityEnum.ActivityStatus.Normal)

	if slot4 ~= ActivityEnum.ActivityStatus.Normal then
		return
	end

	slot0._txtseasonstorenum.text = GameUtil.numberDisplay(CurrencyModel.instance:getCurrency(Activity104Enum.StoreUTTU[slot1]) and slot5.quantity or 0)
	slot0._txtseasonstoretime.text = ActivityModel.instance:getActMO(slot3) and slot7:getRemainTimeStr2ByEndTime(true) or ""
end

function slot0.getSeasonStoreActivity(slot0)
	if ActivityHelper.getActivityStatus(Activity104Model.instance:getCurSeasonId()) == ActivityEnum.ActivityStatus.Normal then
		return false
	end

	return ActivityHelper.getActivityStatus(Activity104Enum.SeasonStore[slot1]) == ActivityEnum.ActivityStatus.Normal
end

function slot0.everyMinuteCall(slot0)
	uv0.super.everyMinuteCall(slot0)
	slot0:refreshEnterViewTime()
end

function slot0.playBgm(slot0)
end

function slot0.stopBgm(slot0)
end

function slot0.initTab(slot0)
	slot0.tabList = {}

	for slot4 = 1, 2 do
		slot0.tabList[slot4] = slot0:createTab(slot4)
	end
end

function slot0.createTab(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = gohelper.findChild(slot0.goTabNode, string.format("Item%s", slot1))
	slot2.goSelect = gohelper.findChild(slot2.go, "#btn_select")
	slot2.btn = gohelper.findButtonWithAudio(slot2.go, AudioEnum.UI.play_ui_leimi_theft_open)

	slot2.btn:AddClickListener(slot0.onChangeTab, slot0, slot1)

	slot2.goRed = gohelper.findChild(slot2.go, "#go_reddot")

	return slot2
end

function slot0.refreshTabRed(slot0)
	for slot4, slot5 in ipairs(slot0.tabList) do
		if not slot5.redDot then
			slot5.redDot = RedDotController.instance:addRedDot(slot5.goRed, slot4 == VersionActivity1_4Enum.TabEnum.First and 1075 or 1088)
		else
			slot5.redDot:refreshDot()
		end
	end
end

function slot0.destoryTab(slot0, slot1)
	if slot1 then
		slot1.btn:RemoveClickListener()
	end
end

function slot0.onChangeTab(slot0, slot1)
	if slot0.tabIndex == slot1 then
		return
	end

	if not slot0:checkTabIsOpen(slot1) then
		return
	end

	slot2 = slot0.tabIndex ~= nil
	slot0.tabIndex = slot1

	gohelper.setActive(slot0._btnachievement, true)

	for slot6, slot7 in ipairs(slot0.tabList) do
		gohelper.setActive(slot7.goSelect, slot0.tabIndex == slot6)
	end

	TaskDispatcher.cancelTask(slot0.onSwitchAnimEnd, slot0)

	if slot2 then
		slot0.animator:Play(slot0.tabIndex == VersionActivity1_4Enum.TabEnum.First and "switch_b" or "switch_a")

		for slot7, slot8 in ipairs(slot0.activityItemList) do
			gohelper.setActive(slot8.rootGo, true)
		end

		gohelper.setActive(slot0._btnroom, true)

		if slot0:getSeasonStoreActivity() then
			gohelper.setActive(slot0._btnseasonstore, true)
		end

		TaskDispatcher.runDelay(slot0.onSwitchAnimEnd, slot0, 0.5)
	else
		slot0:onSwitchAnimEnd()
	end
end

function slot0.onSwitchAnimEnd(slot0)
	slot0:refreshUI()
end

function slot0.checkTabIsOpen(slot0, slot1, slot2)
	slot3 = VersionActivity1_4Enum.ActivityId.EnterView

	if slot1 == VersionActivity1_4Enum.TabEnum.Second then
		slot3 = VersionActivity1_4Enum.ActivityId.SecondEnter
	end

	slot4, slot5, slot6 = ActivityHelper.getActivityStatusAndToast(slot3)

	if slot4 ~= ActivityEnum.ActivityStatus.Normal then
		if not slot2 then
			if slot4 == ActivityEnum.ActivityStatus.NotOpen then
				slot7 = ActivityModel.instance:getActMO(slot3)

				GameFacade.showToast(ToastEnum.V1a4_ActPreTips, slot7.config.name, TimeUtil.getFormatTime_overseas(slot7:getRealStartTimeStamp() - ServerTime.now()))
			elseif slot5 then
				GameFacade.showToast(slot5, slot6)
			end
		end

		return false
	end

	return true
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.onSwitchAnimEnd, slot0)
	slot0._simagebg1:UnLoadImage()
	slot0._simagebg2:UnLoadImage()
	slot0._simagebg3:UnLoadImage()
	slot0._simagebg4:UnLoadImage()
	slot0._simagemask:UnLoadImage()

	if slot0.tabList then
		for slot4, slot5 in pairs(slot0.tabList) do
			slot0:destoryTab(slot5)
		end

		slot0.tabList = nil
	end

	uv0.super.onDestroyView(slot0)
end

return slot0
