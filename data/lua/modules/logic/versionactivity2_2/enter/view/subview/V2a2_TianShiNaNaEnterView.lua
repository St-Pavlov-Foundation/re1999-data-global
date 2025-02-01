module("modules.logic.versionactivity2_2.enter.view.subview.V2a2_TianShiNaNaEnterView", package.seeall)

slot0 = class("V2a2_TianShiNaNaEnterView", VersionActivityEnterBaseSubView)

function slot0.onInitView(slot0)
	slot0._txtLimitTime = gohelper.findChildTextMesh(slot0.viewGO, "image_LimitTimeBG/#txt_LimitTime")
	slot0._txtDescr = gohelper.findChildTextMesh(slot0.viewGO, "#txt_Descr")
	slot0._btnEnter = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Enter")
	slot0._gored = gohelper.findChild(slot0.viewGO, "Right/#btn_Enter/#go_reddot")
	slot0._btnLocked = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Locked")
	slot0._btnTrial = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_Try/image_TryBtn")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnEnter:AddClickListener(slot0._enterGame, slot0)
	slot0._btnLocked:AddClickListener(slot0._clickLock, slot0)
	slot0._btnTrial:AddClickListener(slot0._clickTrial, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnEnter:RemoveClickListener()
	slot0._btnLocked:RemoveClickListener()
	slot0._btnTrial:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0.actCo = ActivityConfig.instance:getActivityCo(VersionActivity2_2Enum.ActivityId.TianShiNaNa)
	slot0._txtDescr.text = slot0.actCo.actDesc
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)
	RedDotController.instance:addRedDot(slot0._gored, RedDotEnum.DotNode.V2a2TianShiNaNaTaskRed, VersionActivity2_2Enum.ActivityId.TianShiNaNa)
	slot0:_refreshTime()
end

function slot0._enterGame(slot0)
	TianShiNaNaController.instance:openMainView()
end

function slot0._clickLock(slot0)
	slot1, slot2 = OpenHelper.getToastIdAndParam(slot0.actCo.openId)

	if slot1 and slot1 ~= 0 then
		GameFacade.showToastWithTableParam(slot1, slot2)
	end
end

function slot0._clickTrial(slot0)
	if ActivityHelper.getActivityStatus(VersionActivity2_2Enum.ActivityId.TianShiNaNa) == ActivityEnum.ActivityStatus.Normal then
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
	if ActivityModel.instance:getActivityInfo()[VersionActivity2_2Enum.ActivityId.TianShiNaNa] then
		gohelper.setActive(slot0._txtLimitTime.gameObject, slot1:getRealEndTimeStamp() - ServerTime.now() > 0)

		if slot2 > 0 then
			slot0._txtLimitTime.text = TimeUtil.SecondToActivityTimeFormat(slot2)
		end

		slot3 = ActivityHelper.getActivityStatus(VersionActivity2_2Enum.ActivityId.TianShiNaNa) ~= ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(slot0._btnEnter, not slot3)
		gohelper.setActive(slot0._btnLocked, slot3)
	end
end

return slot0
