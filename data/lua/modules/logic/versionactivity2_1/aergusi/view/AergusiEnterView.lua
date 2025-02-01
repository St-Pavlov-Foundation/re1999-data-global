module("modules.logic.versionactivity2_1.aergusi.view.AergusiEnterView", package.seeall)

slot0 = class("AergusiEnterView", VersionActivityEnterBaseSubView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "Right/#simage_Title")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Right/image_LimitTimeBG/#txt_LimitTime")
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "Right/#txt_Descr")
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	slot0._btnEnter = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Enter")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "Right/#btn_Enter/#go_reddot")
	slot0._btnLocked = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Locked")
	slot0._txtUnLocked = gohelper.findChildText(slot0.viewGO, "Right/#btn_Locked/#txt_UnLocked")
	slot0._goTry = gohelper.findChild(slot0.viewGO, "Right/#go_Try")
	slot0._goTips = gohelper.findChild(slot0.viewGO, "Right/#go_Try/#go_Tips")
	slot0._simageReward = gohelper.findChildSingleImage(slot0.viewGO, "Right/#go_Try/#go_Tips/#simage_Reward")
	slot0._btnTrial = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_Try/image_TryBtn")
	slot0._txtNum = gohelper.findChildTextMesh(slot0.viewGO, "Right/#go_Try/#go_Tips/#txt_Num")
	slot0._btnItem = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_Try/#go_Tips/#btn_item")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnEnter:AddClickListener(slot0._btnEnterOnClick, slot0)
	slot0._btnLocked:AddClickListener(slot0._btnLockedOnClick, slot0)
	slot0._btnTrial:AddClickListener(slot0._btnTrailOnClick, slot0)
	slot0._btnItem:AddClickListener(slot0._btnItemOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnEnter:RemoveClickListener()
	slot0._btnLocked:RemoveClickListener()
	slot0._btnTrial:RemoveClickListener()
	slot0._btnItem:RemoveClickListener()
end

function slot0._btnEnterOnClick(slot0)
	AergusiController.instance:openAergusiLevelView()
end

function slot0._btnLockedOnClick(slot0)
	slot1, slot2 = OpenHelper.getToastIdAndParam(slot0.actCo.openId)

	if slot1 and slot1 ~= 0 then
		GameFacade.showToastWithTableParam(slot1, slot2)
	end
end

function slot0._btnTrailOnClick(slot0)
	if ActivityHelper.getActivityStatus(VersionActivity2_1Enum.ActivityId.Aergusi) == ActivityEnum.ActivityStatus.Normal then
		if slot0.actCo.tryoutEpisode <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		DungeonFightController.instance:enterFight(DungeonConfig.instance:getEpisodeCO(slot1).chapterId, slot1)
	else
		slot0:_clickLock()
	end
end

function slot0._btnItemOnClick(slot0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.FreeDiamondCoupon, false, nil, false)
end

function slot0._editableInitView(slot0)
	slot0.actCo = ActivityConfig.instance:getActivityCo(VersionActivity2_1Enum.ActivityId.Aergusi)
	slot0._txtDescr.text = slot0.actCo.actDesc
	slot2 = 0
	slot3 = false

	if slot0.actCo.tryoutEpisode > 0 then
		slot2 = DungeonModel.instance:getEpisodeFirstBonus(slot1)[1] and slot4[1][3] or 0
	end

	slot0._txtNum.text = slot2

	RedDotController.instance:addRedDot(slot0._goreddot, RedDotEnum.DotNode.V2a1AergusiTaskRed, VersionActivity2_1Enum.ActivityId.Aergusi)
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)
	slot0:_refreshTime()
end

function slot0.onClose(slot0)
	uv0.super.onClose(slot0)
end

function slot0.everySecondCall(slot0)
	slot0:_refreshTime()
end

function slot0._refreshTime(slot0)
	if ActivityModel.instance:getActivityInfo()[VersionActivity2_1Enum.ActivityId.Aergusi] then
		gohelper.setActive(slot0._txtLimitTime.gameObject, slot1:getRealEndTimeStamp() - ServerTime.now() > 0)

		if slot2 > 0 then
			slot0._txtLimitTime.text = TimeUtil.SecondToActivityTimeFormat(slot2)
		end

		slot3 = ActivityHelper.getActivityStatus(VersionActivity2_1Enum.ActivityId.Aergusi) ~= ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(slot0._btnEnter, not slot3)
		gohelper.setActive(slot0._btnLocked, slot3)
	end
end

return slot0
