module("modules.logic.versionactivity1_6.enter.view.Va1_6SeasonEnterView", package.seeall)

slot0 = class("Va1_6SeasonEnterView", VersionActivityEnterBaseSubView)

function slot0.onInitView(slot0)
	slot0._goStore = gohelper.findChild(slot0.viewGO, "Right/Store")
	slot0._btnstore = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/Store/#btn_Store")
	slot0._txtNum = gohelper.findChildTextMesh(slot0.viewGO, "Right/Store/#btn_Store/#txt_Num")
	slot0._txtstoretime = gohelper.findChildTextMesh(slot0.viewGO, "Right/Store/#go_taglimit/#txt_limit")
	slot0._txttime = gohelper.findChildTextMesh(slot0.viewGO, "Right/LimitTime/#txt_LimitTime")
	slot0._btnEnterNormal = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Normal")
	slot0._btnEnterClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Close")
	slot0._btnEnterUnOpen = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_UnOpen")
	slot0._txtunlocktips = gohelper.findChildTextMesh(slot0.viewGO, "Right/#btn_UnOpen/#txt_Tips")
	slot0._txtdesc = gohelper.findChildTextMesh(slot0.viewGO, "Right/txtDescr")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "Right/#btn_Normal/#image_reddot")
	slot0._gorewardcontent = gohelper.findChild(slot0.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	slot0.rewardItems = {}

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnstore:AddClickListener(slot0._onClickStoreBtn, slot0)
	slot0._btnEnterNormal:AddClickListener(slot0._onClickMainActivity, slot0)
	slot0._btnEnterClose:AddClickListener(slot0._onClickMainActivity, slot0)
	slot0._btnEnterUnOpen:AddClickListener(slot0._onClickMainActivity, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnstore:RemoveClickListener()
	slot0._btnEnterNormal:RemoveClickListener()
	slot0._btnEnterClose:RemoveClickListener()
	slot0._btnEnterUnOpen:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0.actId = Activity104Model.instance:getCurSeasonId()

	RedDotController.instance:addRedDot(slot0._goreddot, ActivityConfig.instance:getActivityCo(slot0.actId).redDotId)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.refreshUI, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshCurrency, slot0)
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)
	slot0:refreshUI()
	slot0:refreshRemainTime()
end

function slot0.onClose(slot0)
	uv0.super.onClose(slot0)
end

function slot0._onRefreshRedDot(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.refreshEnterBtn(slot0)
	slot1, slot2, slot3 = ActivityHelper.getActivityStatusAndToast(slot0.actId)

	gohelper.setActive(slot0._btnEnterNormal, slot1 == ActivityEnum.ActivityStatus.Normal)
	gohelper.setActive(slot0._btnEnterClose, slot1 ~= ActivityEnum.ActivityStatus.Normal and slot1 ~= ActivityEnum.ActivityStatus.NotUnlock)
	gohelper.setActive(slot0._btnEnterUnOpen, slot1 == ActivityEnum.ActivityStatus.NotUnlock)

	if slot1 == ActivityEnum.ActivityStatus.NotUnlock then
		slot0._txtunlocktips.text = ToastController.instance:getToastMsgWithTableParam(slot2, slot3)
	end

	gohelper.setActive(slot0._goStore, ActivityHelper.getActivityStatus(VersionActivity1_6Enum.ActivityId.SeasonStore) == ActivityEnum.ActivityStatus.Normal)
end

function slot0.refreshCurrency(slot0)
	slot0._txtNum.text = GameUtil.numberDisplay(CurrencyModel.instance:getCurrency(Activity104Enum.StoreUTTU[slot0.actId]) and slot2.quantity or 0)
end

function slot0.refreshUI(slot0)
	slot1 = ActivityConfig.instance:getActivityCo(slot0.actId)
	slot0._txtdesc.text = slot1.actDesc
	slot6 = #(GameUtil.splitString2(slot1.activityBonus, true) or {})

	for slot6 = 1, math.max(slot6, #slot0.rewardItems) do
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
end

function slot0.onDestroyView(slot0)
	if slot0.rewardItems then
		for slot4, slot5 in pairs(slot0.rewardItems) do
			slot5:onDestroy()
		end

		slot0.rewardItems = nil
	end
end

function slot0.everySecondCall(slot0)
	slot0:refreshRemainTime()
end

function slot0._onClickMainActivity(slot0)
	Activity104Controller.instance:openSeasonMainView()
end

function slot0._onClickStoreBtn(slot0)
	Activity104Controller.instance:openSeasonStoreView()
end

function slot0.refreshRemainTime(slot0)
	slot0:refreshMainTime()
	slot0:refreshStoreTime()
end

function slot0.refreshMainTime(slot0)
	if not ActivityModel.instance:getActMO(slot0.actId) then
		slot0._txttime.text = ""

		return
	end

	if slot1:getRealEndTimeStamp() - ServerTime.now() > 0 then
		slot0._txttime.text = TimeUtil.SecondToActivityTimeFormat(slot2)
	else
		slot0._txttime.text = luaLang("ended")
	end
end

function slot0.refreshStoreTime(slot0)
	if not ActivityModel.instance:getActMO(Activity104Enum.SeasonStore[slot0.actId]) then
		return
	end

	if ActivityHelper.getActivityStatusAndToast(slot1) ~= ActivityEnum.ActivityStatus.Normal and slot3 ~= ActivityEnum.ActivityStatus.NotUnlock then
		slot0._txtstoretime.text = luaLang("turnback_end")
	else
		slot0._txtstoretime.text = slot2:getRemainTimeStr2ByEndTime(true)
	end
end

return slot0
