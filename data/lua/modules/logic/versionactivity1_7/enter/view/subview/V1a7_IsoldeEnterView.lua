module("modules.logic.versionactivity1_7.enter.view.subview.V1a7_IsoldeEnterView", package.seeall)

slot0 = class("V1a7_IsoldeEnterView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "Right/#simage_Title")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Right/#txt_LimitTime")
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "Right/#txt_Descr")
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	slot0._btnEnter = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Enter")
	slot0._btnLocked = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Locked")
	slot0._txtLocked = gohelper.findChildText(slot0.viewGO, "Right/#btn_Locked/#txt_UnLocked")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnEnter:AddClickListener(slot0._btnEnterOnClick, slot0)
	slot0._btnLocked:AddClickListener(slot0._btnLockedOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnEnter:RemoveClickListener()
	slot0._btnLocked:RemoveClickListener()
end

function slot0._btnEnterOnClick(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_70103) or PlayerPrefsHelper.getNumber(PlayerPrefsKey.EnterRoleActivity .. "#" .. tostring(VersionActivity1_7Enum.ActivityId.Isolde) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId), 0) == 1 then
		ActIsoldeController.instance:enterActivity()

		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.Activity130OpenTips, MsgBoxEnum.BoxType.Yes_No, function ()
		PlayerPrefsHelper.setNumber(uv0, 1)
		ActIsoldeController.instance:enterActivity()
	end, nil, , , , , DungeonConfig.instance:getEpisodeDisplay(OpenConfig.instance:getOpenCo(OpenEnum.UnlockFunc.Act_70103).episodeId))
end

function slot0._btnLockedOnClick(slot0)
	slot1, slot2, slot3 = ActivityHelper.getActivityStatusAndToast(slot0.actId)

	if slot1 == ActivityEnum.ActivityStatus.NotUnlock and slot2 then
		GameFacade.showToastWithTableParam(slot2, slot3)
	end
end

function slot0._editableInitView(slot0)
	slot0.actId = VersionActivity1_7Enum.ActivityId.Isolde
	slot0.config = ActivityConfig.instance:getActivityCo(slot0.actId)
	slot0._txtDescr.text = slot0.config.actDesc
	slot0._txtLocked.text = OpenHelper.getActivityUnlockTxt(slot0.config.openId)

	slot0:initRewards()

	slot0.animComp = VersionActivitySubAnimatorComp.get(slot0.viewGO, slot0)
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0._onActStatusChange, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.UpdateActivity, slot0._showLeftTime, slot0)
	RedDotController.instance:addRedDot(gohelper.findChild(slot0._btnEnter.gameObject, "#go_reddot"), RedDotEnum.DotNode.PermanentRoleActivityTask, slot0.actId):setRedDotTranScale(RedDotEnum.Style.Normal, 1.4, 1.4)
	slot0:_freshLockStatus()
	slot0:_showLeftTime()
	TaskDispatcher.runRepeat(slot0._showLeftTime, slot0, 1)
	slot0.animComp:playOpenAnim()
end

function slot0.onClose(slot0)
	uv0.super.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._showLeftTime, slot0)
	slot0.animComp:destroy()
end

function slot0.initRewards(slot0)
	for slot5, slot6 in ipairs(string.split(slot0.config.activityBonus, "|")) do
		slot7 = string.splitToNumber(slot6, "#")
		slot8 = IconMgr.instance:getCommonItemIcon(slot0._gorewards)

		slot8:setMOValue(slot7[1], slot7[2], 1)
		slot8:isShowCount(false)
	end
end

function slot0._freshLockStatus(slot0)
	gohelper.setActive(slot0._btnEnter, ActivityHelper.getActivityStatus(slot0.actId) ~= ActivityEnum.ActivityStatus.NotUnlock)
	gohelper.setActive(slot0._btnLocked, slot1 == ActivityEnum.ActivityStatus.NotUnlock)
end

function slot0._showLeftTime(slot0)
	slot0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(slot0.actId)
end

function slot0._onActStatusChange(slot0)
	slot0:_freshLockStatus()
end

return slot0
