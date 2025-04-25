module("modules.logic.versionactivity2_5.enter.view.subview.VersionActivity2_5FeiLinShiDuoEnterView", package.seeall)

slot0 = class("VersionActivity2_5FeiLinShiDuoEnterView", VersionActivityEnterBaseSubView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "Right/#txt_Descr")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Right/image_LimitTimeBG/#txt_LimitTime")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "Right/#simage_Title")
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	slot0._btnEnter = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Enter")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "Right/#btn_Enter/#go_reddot")
	slot0._btnLocked = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Locked")
	slot0._txtUnLocked = gohelper.findChildText(slot0.viewGO, "Right/#btn_Locked/#txt_UnLocked")
	slot0._goTry = gohelper.findChild(slot0.viewGO, "Right/#go_Try")
	slot0._goTips = gohelper.findChild(slot0.viewGO, "Right/#go_Try/#go_Tips")
	slot0._simageReward = gohelper.findChildSingleImage(slot0.viewGO, "Right/#go_Try/#go_Tips/#simage_Reward")
	slot0._txtNum = gohelper.findChildText(slot0.viewGO, "Right/#go_Try/#go_Tips/#txt_Num")
	slot0._btnitem = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_Try/#go_Tips/#btn_item")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnEnter:AddClickListener(slot0._btnEnterOnClick, slot0)
	slot0._btnLocked:AddClickListener(slot0._btnLockedOnClick, slot0)
	slot0._btnitem:AddClickListener(slot0._btnitemOnClick, slot0)
	slot0._btnTrial:AddClickListener(slot0._btnTrialOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnEnter:RemoveClickListener()
	slot0._btnLocked:RemoveClickListener()
	slot0._btnitem:RemoveClickListener()
	slot0._btnTrial:RemoveClickListener()
end

function slot0._btnEnterOnClick(slot0)
	FeiLinShiDuoGameController.instance:enterEpisodeLevelView(slot0.actId)
end

function slot0._btnLockedOnClick(slot0)
	slot1, slot2 = OpenHelper.getToastIdAndParam(slot0.actCo.openId)

	if slot1 and slot1 ~= 0 then
		GameFacade.showToast(slot1)
	end
end

function slot0._btnitemOnClick(slot0)
end

function slot0._btnTrialOnClick(slot0)
	if ActivityHelper.getActivityStatus(slot0.actId) == ActivityEnum.ActivityStatus.Normal then
		if slot0.actCo.tryoutEpisode <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		DungeonFightController.instance:enterFight(DungeonConfig.instance:getEpisodeCO(slot1).chapterId, slot1)
	else
		slot0:_clickLock()
	end
end

function slot0._editableInitView(slot0)
	slot0._btnTrial = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_Try/image_TryBtn")
	slot0.actId = VersionActivity2_5Enum.ActivityId.FeiLinShiDuo
	slot0.actCo = ActivityConfig.instance:getActivityCo(slot0.actId)
	slot0._txtDescr.text = slot0.actCo.actDesc
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	RedDotController.instance:addRedDot(slot0._goreddot, RedDotEnum.DotNode.V2a5_Act185)
	uv0.super.onOpen(slot0)
	slot0:_refreshTime()
	TaskDispatcher.runRepeat(slot0._refreshTime, slot0, TimeUtil.OneMinuteSecond)
end

function slot0._refreshTime(slot0)
	if ActivityModel.instance:getActivityInfo()[slot0.actId] then
		gohelper.setActive(slot0._txtLimitTime.gameObject, slot2:getRealEndTimeStamp() - ServerTime.now() > 0)

		if slot3 > 0 then
			slot0._txtLimitTime.text = TimeUtil.SecondToActivityTimeFormat(slot3)
		end

		slot4 = ActivityHelper.getActivityStatus(slot1) ~= ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(slot0._btnEnter, not slot4)
		gohelper.setActive(slot0._btnLocked, slot4)
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._refreshTime, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
