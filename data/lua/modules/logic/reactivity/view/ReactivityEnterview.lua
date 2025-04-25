module("modules.logic.reactivity.view.ReactivityEnterview", package.seeall)

slot0 = class("ReactivityEnterview", VersionActivityEnterBaseSubView)

function slot0.onInitView(slot0)
	slot0._btnreplay = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Replay")
	slot0._btnAchevement = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Achevement")
	slot0._btnstore = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Store")
	slot0._txtstoretime = gohelper.findChildTextMesh(slot0.viewGO, "Right/#btn_Store/#go_taglimit/#txt_limit")
	slot0._txtNum = gohelper.findChildTextMesh(slot0.viewGO, "Right/#btn_Store/#txt_Num")
	slot0._txttime = gohelper.findChildTextMesh(slot0.viewGO, "Logo/image_LimitTimeBG/#txt_LimitTime")
	slot0._txtdesc = gohelper.findChildTextMesh(slot0.viewGO, "Logo/#txt_Descr")
	slot0._btnExchange = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Exchange")
	slot0._btnEnter = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Enter")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "Right/#btn_Enter/#image_reddot")
	slot0._btnEnd = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_End")
	slot0._btnLock = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Locked")
	slot0._txtlockedtips = gohelper.findChildTextMesh(slot0.viewGO, "Right/#btn_Locked/txt_LockedTips")
	slot0._gorewardcontent = gohelper.findChild(slot0.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	slot0.rewardItems = {}

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnAchevement:AddClickListener(slot0._onClickAchevementBtn, slot0)
	slot0._btnstore:AddClickListener(slot0._onClickStoreBtn, slot0)
	slot0._btnEnter:AddClickListener(slot0._onClickEnter, slot0)
	slot0._btnreplay:AddClickListener(slot0._onClickReplay, slot0)
	slot0._btnExchange:AddClickListener(slot0._onClickExchange, slot0)
	slot0._btnEnd:AddClickListener(slot0._onClickEnter, slot0)
	slot0._btnLock:AddClickListener(slot0._onClickEnter, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnAchevement:RemoveClickListener()
	slot0._btnstore:RemoveClickListener()
	slot0._btnEnter:RemoveClickListener()
	slot0._btnreplay:RemoveClickListener()
	slot0._btnExchange:RemoveClickListener()
	slot0._btnEnd:RemoveClickListener()
	slot0._btnLock:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.refreshUI, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshCurrency, slot0)
end

function slot0._onClickAchevementBtn(slot0)
	if not slot0.actId then
		return
	end

	JumpController.instance:jump(ActivityConfig.instance:getActivityCo(slot0.actId) and slot1.achievementJumpId)
end

function slot0.onOpen(slot0)
	slot0:initRedDot()
	uv0.super.onOpen(slot0)
	slot0:refreshUI()
end

function slot0.onClose(slot0)
	uv0.super.onClose(slot0)
end

function slot0.initRedDot(slot0)
	if slot0.actId then
		return
	end

	slot0.actId = VersionActivity2_5Enum.ActivityId.Reactivity

	RedDotController.instance:addRedDot(slot0._goreddot, ActivityConfig.instance:getActivityCo(slot0.actId).redDotId)
end

function slot0._onRefreshRedDot(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0.rewardItems then
		for slot4, slot5 in pairs(slot0.rewardItems) do
			slot5:onDestroy()
		end

		slot0.rewardItems = nil
	end
end

function slot0.refreshUI(slot0)
	slot1 = ActivityConfig.instance:getActivityCo(slot0.actId)
	slot0._txtdesc.text = slot1.actDesc
	slot2 = GameUtil.splitString2(slot1.activityBonus, true) or {}
	slot6 = #slot0.rewardItems

	for slot6 = 1, math.max(#slot2, slot6) do
		slot8 = slot2[slot6]

		if not slot0.rewardItems[slot6] then
			slot0.rewardItems[slot6] = IconMgr.instance:getCommonItemIcon(slot0._gorewardcontent)
		end

		if slot8 then
			gohelper.setActive(slot7.go, true)
			slot7:setMOValue(slot8[1], slot8[2], slot8[3] or 1, nil, true)
			slot7:hideEquipLvAndCount()
			slot7:isShowCount(false)
		else
			gohelper.setActive(slot7.go, false)
		end
	end

	slot0:refreshEnterBtn()
	slot0:refreshCurrency()
	slot0:refreshRemainTime()
end

function slot0.everySecondCall(slot0)
	slot0:refreshRemainTime()
end

function slot0.refreshEnterBtn(slot0)
	slot1, slot2, slot3 = ActivityHelper.getActivityStatusAndToast(slot0.actId)

	gohelper.setActive(slot0._btnEnter, slot1 == ActivityEnum.ActivityStatus.Normal)
	gohelper.setActive(slot0._btnEnd, slot1 ~= ActivityEnum.ActivityStatus.Normal and slot1 ~= ActivityEnum.ActivityStatus.NotUnlock)
	gohelper.setActive(slot0._btnLock, slot1 == ActivityEnum.ActivityStatus.NotUnlock)

	if slot1 == ActivityEnum.ActivityStatus.NotUnlock then
		slot0._txtlockedtips.text = ToastController.instance:getToastMsgWithTableParam(slot2, slot3)
	end

	slot5 = ReactivityEnum.ActivityDefine[slot0.actId] and slot4.storeActId
	slot0.storeActId = slot5

	gohelper.setActive(slot0._btnstore, ActivityHelper.getActivityStatus(slot5) == ActivityEnum.ActivityStatus.Normal)
	gohelper.setActive(slot0._btnExchange, slot6 == ActivityEnum.ActivityStatus.Normal)
end

function slot0.refreshCurrency(slot0)
	slot0._txtNum.text = GameUtil.numberDisplay(CurrencyModel.instance:getCurrency(ReactivityModel.instance:getActivityCurrencyId(slot0.actId)) and slot2.quantity or 0)
end

function slot0._onClickEnter(slot0)
	slot1, slot2, slot3 = ActivityHelper.getActivityStatusAndToast(slot0.actId)

	if slot1 ~= ActivityEnum.ActivityStatus.Normal then
		if slot2 then
			GameFacade.showToastWithTableParam(slot2, slot3)
		end

		return
	end

	VersionActivity1_8DungeonController.instance:openVersionActivityDungeonMapView()
end

function slot0._onClickReplay(slot0)
	if not (ActivityModel.instance:getActMO(slot0.actId) and slot1.config and slot1.config.storyId) then
		logError(string.format("act id %s dot config story id", slot2))

		return
	end

	StoryController.instance:playStory(slot2, {
		isVersionActivityPV = true
	})
end

function slot0._onClickExchange(slot0)
	ViewMgr.instance:openView(ViewName.ReactivityRuleView)
end

function slot0._onClickStoreBtn(slot0)
	ReactivityController.instance:openReactivityStoreView(slot0.actId)
end

function slot0.refreshRemainTime(slot0)
	if ActivityModel.instance:getActMO(slot0.actId):getRealEndTimeStamp() - ServerTime.now() > 0 then
		slot0._txttime.text = TimeUtil.SecondToActivityTimeFormat(slot2)
	else
		slot0._txttime.text = luaLang("ended")
	end

	slot0:refreshStoreTime()
end

function slot0.refreshStoreTime(slot0)
	if not slot0.storeActId then
		return
	end

	if not ActivityModel.instance:getActMO(slot1) then
		return
	end

	if ActivityHelper.getActivityStatusAndToast(slot1) ~= ActivityEnum.ActivityStatus.Normal and slot3 ~= ActivityEnum.ActivityStatus.NotUnlock then
		slot0._txtstoretime.text = luaLang("turnback_end")
	else
		slot0._txtstoretime.text = slot2:getRemainTimeStr2ByEndTime(true)
	end
end

return slot0
