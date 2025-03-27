module("modules.logic.versionactivity2_4.enter.view.subview.V2a4_PinballEnterView", package.seeall)

slot0 = class("V2a4_PinballEnterView", VersionActivityEnterBaseSubView)

function slot0.onInitView(slot0)
	slot0._txtLimitTime = gohelper.findChildTextMesh(slot0.viewGO, "#simage_FullBG/image_LimitTimeBG/#txt_LimitTime")
	slot0._btnEnter = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Enter")
	slot0._gored = gohelper.findChild(slot0.viewGO, "Right/#btn_Enter/#go_reddot")
	slot0._txtlock = gohelper.findChildTextMesh(slot0.viewGO, "Right/#btn_Locked/#txt_UnLocked")
	slot0._btnTask = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_task")
	slot0._goTaskRed = gohelper.findChild(slot0.viewGO, "Right/#btn_task/#go_reddotreward")
	slot0._btnReset = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_reset")
	slot0._btnTrial = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_Try/image_TryBtn")
	slot0._txtmainlv = gohelper.findChildTextMesh(slot0.viewGO, "Right/#go_main/#txt_lv")
	slot0._goslider1 = gohelper.findChildImage(slot0.viewGO, "Right/#go_main/#go_slider/#go_slider1")
	slot0._goslider2 = gohelper.findChildImage(slot0.viewGO, "Right/#go_main/#go_slider/#go_slider2")
	slot0._goslider3 = gohelper.findChildImage(slot0.viewGO, "Right/#go_main/#go_slider/#go_slider3")
	slot0._txtmainnum = gohelper.findChildTextMesh(slot0.viewGO, "Right/#go_main/#txt_num")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnEnter:AddClickListener(slot0._enterGame, slot0)
	slot0._btnTrial:AddClickListener(slot0._clickTrial, slot0)
	slot0._btnTask:AddClickListener(slot0._clickTask, slot0)
	slot0._btnReset:AddClickListener(slot0._clickReset, slot0)
	PinballController.instance:registerCallback(PinballEvent.OnCurrencyChange, slot0._refreshMainLv, slot0)
	PinballController.instance:registerCallback(PinballEvent.DataInited, slot0._refreshMainLv, slot0)
	PinballController.instance:registerCallback(PinballEvent.DataInited, slot0._refreshResetShow, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnEnter:RemoveClickListener()
	slot0._btnTrial:RemoveClickListener()
	slot0._btnTask:RemoveClickListener()
	slot0._btnReset:RemoveClickListener()
	PinballController.instance:unregisterCallback(PinballEvent.OnCurrencyChange, slot0._refreshMainLv, slot0)
	PinballController.instance:unregisterCallback(PinballEvent.DataInited, slot0._refreshMainLv, slot0)
	PinballController.instance:unregisterCallback(PinballEvent.DataInited, slot0._refreshResetShow, slot0)
end

function slot0._editableInitView(slot0)
	slot0.actCo = ActivityConfig.instance:getActivityCo(VersionActivity2_4Enum.ActivityId.Pinball)
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)
	RedDotController.instance:addRedDot(slot0._gored, RedDotEnum.DotNode.V2a4PinballTaskRed)
	RedDotController.instance:addRedDot(slot0._goTaskRed, RedDotEnum.DotNode.V2a4PinballTaskRed)

	slot0._isLock = true

	slot0:_refreshTime()
	slot0:_refreshMainLv()
	slot0:_refreshResetShow()
end

function slot0._enterGame(slot0)
	PinballController.instance:openMainView()
end

function slot0._clickLock(slot0)
	slot1, slot2 = OpenHelper.getToastIdAndParam(slot0.actCo.openId)

	if slot1 and slot1 ~= 0 then
		GameFacade.showToastWithTableParam(slot1, slot2)
	end
end

function slot0._clickTask(slot0)
	ViewMgr.instance:openView(ViewName.PinballTaskView)
end

function slot0._clickReset(slot0)
	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.PinballReset, MsgBoxEnum.BoxType.Yes_No, slot0._realReset, nil, , slot0)
end

function slot0._realReset(slot0)
	PinballStatHelper.instance:sendResetCity()
	Activity178Rpc.instance:sendAct178Reset(VersionActivity2_4Enum.ActivityId.Pinball)
end

function slot0._clickTrial(slot0)
	if ActivityHelper.getActivityStatus(VersionActivity2_4Enum.ActivityId.Pinball) == ActivityEnum.ActivityStatus.Normal then
		if slot0.actCo.tryoutEpisode <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		DungeonFightController.instance:enterFight(DungeonConfig.instance:getEpisodeCO(slot1).chapterId, slot1)
	else
		slot0:_clickLock()
	end
end

function slot0.everySecondCall(slot0)
	slot0:_refreshTime()
end

function slot0._refreshTime(slot0)
	if ActivityModel.instance:getActivityInfo()[VersionActivity2_4Enum.ActivityId.Pinball] then
		gohelper.setActive(slot0._txtLimitTime.gameObject, slot1:getRealEndTimeStamp() - ServerTime.now() > 0)

		if slot2 > 0 then
			slot0._txtLimitTime.text = TimeUtil.SecondToActivityTimeFormat(slot2)
		end

		slot3 = ActivityHelper.getActivityStatus(VersionActivity2_4Enum.ActivityId.Pinball) ~= ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(slot0._btnEnter, not slot3)
		gohelper.setActive(slot0._btnLocked, slot3)
		gohelper.setActive(slot0._btnTask, false)
		gohelper.setActive(slot0._btnTrial, not slot3)

		slot0._isLock = slot3

		slot0:_refreshResetShow()

		if slot3 then
			slot0._txtlock.text = OpenHelper.getActivityUnlockTxt(slot0.actCo.openId)
		end
	end
end

function slot0._refreshMainLv(slot0)
	slot0._txtmainlv.text, slot2, slot3 = PinballModel.instance:getScoreLevel()
	slot4, slot5 = PinballModel.instance:getResNum(PinballEnum.ResType.Score)
	slot0._goslider1.fillAmount = 0

	if slot3 == slot2 then
		slot0._goslider2.fillAmount = 1
	else
		slot0._goslider2.fillAmount = (slot4 - slot2) / (slot3 - slot2)
	end

	slot0._goslider3.fillAmount = 0
	slot0._txtmainnum.text = string.format("%d/%d", slot4, slot3)
end

function slot0._refreshResetShow(slot0)
	gohelper.setActive(slot0._btnReset, not slot0._isLock and PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ResetDay) <= PinballModel.instance.day)
end

return slot0
