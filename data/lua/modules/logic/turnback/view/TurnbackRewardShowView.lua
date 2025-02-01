module("modules.logic.turnback.view.TurnbackRewardShowView", package.seeall)

slot0 = class("TurnbackRewardShowView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "timebg/#txt_time")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#txt_desc")
	slot0._scrollreward = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_reward")
	slot0._gorewardContent = gohelper.findChild(slot0.viewGO, "#scroll_reward/Viewport/#go_rewardContent")
	slot0._btnreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_reward")
	slot0._gocanget = gohelper.findChild(slot0.viewGO, "#btn_reward/#go_canget")
	slot0._gohasget = gohelper.findChild(slot0.viewGO, "#btn_reward/#go_hasget")
	slot0._btnstory = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_story")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnreward:AddClickListener(slot0._btnrewardOnClick, slot0)
	slot0._btnstory:AddClickListener(slot0._btnstoryOnClick, slot0)
	slot0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshOnceBonusGetState, slot0._refreshOnceBonusGetState, slot0)
	slot0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshRemainTime, slot0._refreshRemainTime, slot0)
	slot0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, slot0._refreshUI, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnreward:RemoveClickListener()
	slot0._btnstory:RemoveClickListener()
	slot0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshOnceBonusGetState, slot0._refreshOnceBonusGetState, slot0)
	slot0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshRemainTime, slot0._refreshRemainTime, slot0)
	slot0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, slot0._refreshUI, slot0)
end

function slot0._btnrewardOnClick(slot0)
	if not slot0.hasGet then
		TurnbackRpc.instance:sendTurnbackOnceBonusRequest(slot0.turnbackId)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_task_slide)
	end
end

function slot0._btnstoryOnClick(slot0)
	if TurnbackModel.instance:getCurTurnbackMo() and slot1.config and slot1.config.startStory then
		StoryController.instance:playStory(slot2)
	else
		logError(string.format("TurnbackRewardShowView startStoryId is nil", slot2))
	end
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getTurnbackIcon("turnback_rewardfullbg"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)

	slot0.turnbackId = TurnbackModel.instance:getCurTurnbackId()

	slot0:_createReward()
	slot0:_refreshUI()
	slot0:_refreshOnceBonusGetState()
end

function slot0._refreshUI(slot0)
	slot0.config = TurnbackConfig.instance:getTurnbackSubModuleCo(slot0.viewParam.actId)
	slot0._txtdesc.text = slot0.config.actDesc

	slot0:_refreshRemainTime()
	gohelper.setActive(slot0._btnstory, true)
end

function slot0._refreshRemainTime(slot0)
	slot0._txttime.text = TurnbackController.instance:refreshRemainTime()
end

function slot0._createReward(slot0)
	for slot6 = 1, #string.split(TurnbackConfig.instance:getTurnbackCo(slot0.turnbackId).onceBonus, "|") do
		slot7 = string.split(slot2[slot6], "#")
		slot8 = IconMgr.instance:getCommonPropItemIcon(slot0._gorewardContent)

		slot8:setMOValue(slot7[1], slot7[2], slot7[3], nil, true)
		slot8:setPropItemScale(0.9)
		slot8:setCountFontSize(36)
		slot8:setHideLvAndBreakFlag(true)
		slot8:hideEquipLvAndBreak(true)
		gohelper.setActive(slot8.go, true)
	end
end

function slot0._refreshOnceBonusGetState(slot0)
	slot0.hasGet = TurnbackModel.instance:getOnceBonusGetState()

	gohelper.setActive(slot0._gocanget, not slot0.hasGet)
	gohelper.setActive(slot0._gohasget, slot0.hasGet)
end

function slot0.onClose(slot0)
	slot0._simagebg:UnLoadImage()
end

function slot0.onDestroyView(slot0)
end

return slot0
