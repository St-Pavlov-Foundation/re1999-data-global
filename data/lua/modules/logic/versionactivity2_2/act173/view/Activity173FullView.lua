module("modules.logic.versionactivity2_2.act173.view.Activity173FullView", package.seeall)

slot0 = class("Activity173FullView", BaseView)
slot1 = 1

function slot0.onInitView(slot0)
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "Left/#txt_Descr")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Left/image_LimitTimeBG/#txt_LimitTime")
	slot0._btnGO = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_GO")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnGO:AddClickListener(slot0._btnGOOnClick, slot0)
	slot0._btnClose:AddClickListener(slot0._btnCloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnGO:RemoveClickListener()
	slot0._btnClose:RemoveClickListener()
end

function slot0._btnGOOnClick(slot0)
	slot0:closeThis()
	GameFacade.jump(JumpEnum.JumpId.Activity173)
end

function slot0._btnCloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0.onOpen(slot0)
	PatFaceCustomHandler.setHasShow(PatFaceEnum.patFace.V2a2_LimitDecorate_PanelView)
	slot0:refreshActRemainTime()
	TaskDispatcher.cancelTask(slot0.refreshActRemainTime, slot0)
	TaskDispatcher.runRepeat(slot0.refreshActRemainTime, slot0, uv0)
	slot0:initRewards()
	slot0:initActivityInfo()
end

function slot0.refreshActRemainTime(slot0)
	slot0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(VersionActivity2_2Enum.ActivityId.LimitDecorate)
end

function slot0.initActivityInfo(slot0)
	slot0._txtDescr.text = ActivityConfig.instance:getActivityCo(VersionActivity2_2Enum.ActivityId.LimitDecorate) and slot1.actDesc
end

function slot0.initRewards(slot0)
	slot0._onlineTasks = Activity173Config.instance:getAllOnlineTasks()
	slot0._bonusMap = {}

	for slot4 = 1, #slot0._onlineTasks do
		slot6 = slot0:getOrCreateRewardItem(slot4)

		if string.nilorempty(slot0._onlineTasks[slot4].bonus) then
			logError("限定装饰品奖励活动任务奖励配置为空: 任务Id = " .. tostring(slot5.id))
		else
			if slot0:checkIsPortraitReward(string.splitToNumber(slot5.bonus, "#")) then
				slot0:onConfigPortraitReward(slot7, slot6)
			end

			slot0._bonusMap[slot5.id] = slot7
			slot6.txtNum.text = luaLang("multiple") .. tostring(slot7[3])
		end
	end
end

function slot0.getOrCreateRewardItem(slot0, slot1)
	slot0._rewardItems = slot0._rewardItems or slot0:getUserDataTb_()

	if not slot0._rewardItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.goRewardItem = gohelper.findChild(slot0.viewGO, "Right/Reward" .. slot1)
		slot2.txtNum = gohelper.findChildText(slot2.goRewardItem, "image_NumBG/txt_Num")
		slot2.simageheadicon = gohelper.findChildSingleImage(slot2.goRewardItem, "#simage_HeadIcon")
		slot2.btnclick = gohelper.findChildButtonWithAudio(slot2.goRewardItem, "btn_click")

		slot2.btnclick:AddClickListener(slot0.onClickRewardIcon, slot0, slot1)

		slot0._rewardItems[slot1] = slot2
	end

	return slot2
end

function slot0.onClickRewardIcon(slot0, slot1)
	if not (slot0._onlineTasks and slot0._onlineTasks[slot1]) then
		return
	end

	if not (slot0._bonusMap and slot0._bonusMap[slot2.id]) then
		logError("打开物品详情界面失败:缺少奖励配置 任务Id = " .. tostring(slot2.id))

		return
	end

	MaterialTipController.instance:showMaterialInfo(slot3[1], slot3[2])
end

function slot0.checkIsPortraitReward(slot0, slot1)
	if slot1[1] == MaterialEnum.MaterialType.Item and ItemModel.instance:getItemConfig(slot2, slot1[2]) and slot4.subType == ItemEnum.SubType.Portrait then
		return true
	end
end

function slot0.onConfigPortraitReward(slot0, slot1, slot2)
	if slot2.simageheadicon then
		if not slot0._liveHeadIcon then
			slot0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(slot2.simageheadicon)
		end

		slot0._liveHeadIcon:setLiveHead(tonumber(slot1[2]))
	end
end

function slot0.removeAllRewardIconClick(slot0)
	if slot0._rewardItems then
		for slot4, slot5 in pairs(slot0._rewardItems) do
			if slot5.btnclick then
				slot5.btnclick:RemoveClickListener()
			end
		end
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.refreshActRemainTime, slot0)
	slot0:removeAllRewardIconClick()
end

function slot0.onDestroyView(slot0)
end

return slot0
