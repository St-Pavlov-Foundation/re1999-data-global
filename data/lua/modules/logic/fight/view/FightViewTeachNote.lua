module("modules.logic.fight.view.FightViewTeachNote", package.seeall)

slot0 = class("FightViewTeachNote", BaseView)
slot1 = nil
slot2 = 0

function slot0.onInitView(slot0)
	slot0._teachNoteGO = gohelper.findChild(slot0.viewGO, "root/teachnote")
	slot0._teachNoteAnimator = slot0._teachNoteGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._btnTeachNote = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/teachnote/#btn_help")
	slot0._btnTeachNoteSkip = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/teachnote/#go_skipbtn/btn_skipguide")
	slot0._btnsGO = gohelper.findChild(slot0.viewGO, "root/btns")
	slot1 = gohelper.onceAddComponent(gohelper.findChild(slot0.viewGO, "root/teachnote/#go_skipbtn"), typeof(UnityEngine.Canvas))
	slot1.overrideSorting = true
	slot1.sortingOrder = gohelper.onceAddComponent(ViewMgr.instance:getUILayer(UILayerName.Guide), typeof(UnityEngine.Canvas)).sortingOrder + 1
end

function slot0.addEvents(slot0)
	slot0._btnTeachNote:AddClickListener(slot0._onClickTeachNote, slot0)
	slot0._btnTeachNoteSkip:AddClickListener(slot0._onClickTeachNoteSkip, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.PushEndFight, slot0._pushEndFight, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnStageChange, slot0._delayCheckShowAnim, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._delayCheckShowAnim, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnTeachNote:RemoveClickListener()
	slot0._btnTeachNoteSkip:RemoveClickListener()
	slot0:removeEventCb(FightController.instance, FightEvent.PushEndFight, slot0._pushEndFight, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnStageChange, slot0._delayCheckShowAnim, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._delayCheckShowAnim, slot0)
	TaskDispatcher.cancelTask(slot0._checkShowAnim, slot0)
end

function slot0.onOpen(slot0)
	slot2 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId) and slot1.type == DungeonEnum.EpisodeType.Sp
	slot4 = false

	for slot8, slot9 in ipairs(lua_helppage.configList) do
		if slot9.unlockGuideId == slot0:_getGuideId() then
			slot4 = true
		end
	end

	slot0._episodeId = DungeonModel.instance.curSendEpisodeId
	slot0._isSpAndHasHelpPage = slot2 and slot4

	gohelper.setActive(slot0._teachNoteGO, slot0._isSpAndHasHelpPage)
	slot0:_checkShowAnim()
end

function slot0._onOpenView(slot0, slot1)
	if not slot0._isSpAndHasHelpPage then
		return
	end

	if slot1 == ViewName.GuideView and slot0._teachNoteGO.activeInHierarchy and slot0._teachNoteAnimator.enabled then
		slot0._teachNoteAnimator.enabled = false
	end

	slot0:_checkShowSkip()
end

function slot0._delayCheckShowAnim(slot0)
	if not slot0._isSpAndHasHelpPage then
		return
	end

	TaskDispatcher.runDelay(slot0._checkShowAnim, slot0, 0.5)
end

function slot0._checkShowAnim(slot0)
	if not slot0._isSpAndHasHelpPage then
		return
	end

	if slot0.viewContainer.fightViewHandCard:isPlayCardFlow() then
		return
	end

	if slot0.viewContainer.fightViewHandCard:isMoveCardFlow() then
		return
	end

	if slot0.viewContainer.fightViewHandCard:isCombineCardFlow() then
		return
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		return
	end

	if not (slot0.viewContainer.fightViewHandCard:isPlayCardFlow() or slot0.viewContainer.fightViewHandCard:isMoveCardFlow() or slot0.viewContainer.fightViewHandCard:isCombineCardFlow()) and not ViewMgr.instance:isOpen(ViewName.GuideView) and FightModel.instance:getCurStage() == FightEnum.Stage.Card and uv0 > 0 then
		slot0._teachNoteAnimator.enabled = true

		slot0._teachNoteAnimator:Play("fightview_teachnote_loop")
	end

	slot0:_checkShowSkip()
end

function slot0._checkShowSkip(slot0)
	if not slot0._isSpAndHasHelpPage then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.GuideView) and uv0 > 0 then
		gohelper.setActive(slot0._btnTeachNoteSkip.gameObject, true)
		transformhelper.setLocalScale(slot0._btnsGO.transform, 0, 0, 0)
	else
		gohelper.setActive(slot0._btnTeachNoteSkip.gameObject, false)
		transformhelper.setLocalScale(slot0._btnsGO.transform, 1, 1, 1)
	end
end

function slot0._pushEndFight(slot0)
	if slot0._episodeId ~= uv0 then
		uv1 = 0
	end

	uv0 = slot0._episodeId

	if (FightModel.instance:getRecordMO() and slot1.fightResult) == FightEnum.FightResult.Fail or slot2 == FightEnum.FightResult.OutOfRoundFail then
		uv1 = uv1 + 1
	else
		uv1 = 0
	end
end

function slot0._onClickTeachNote(slot0)
	if FightModel.instance:getCurStage() == FightEnum.Stage.StartRound or slot1 == FightEnum.Stage.Distribute then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.GuideView) and not GuideUtil.isGuideViewTarget(slot0._btnTeachNote.gameObject) then
		return
	end

	if slot0:_getGuideId() then
		ViewMgr.instance:openView(ViewName.HelpView, {
			id = HelpEnum.HelpId.Fight,
			viewParam = HelpEnum.HelpId.Fight,
			guideId = slot2
		})
	else
		logError("没有正在执行的教学笔记引导，无法打开帮助说明界面")
	end
end

function slot0._onClickTeachNoteSkip(slot0)
	if slot0:_getDoingGuideId() then
		GuideController.instance:oneKeyFinishGuide(slot1, false)
		gohelper.setActive(slot0._btnTeachNoteSkip.gameObject, false)
		transformhelper.setLocalScale(slot0._btnsGO.transform, 1, 1, 1)
	else
		logError("没有正在执行的教学笔记引导，无法跳过引导")
	end
end

function slot0._getGuideId(slot0)
	for slot6, slot7 in ipairs(GuideConfig.instance:getGuideList()) do
		slot8 = FightStrUtil.instance:getSplitCache(slot7.trigger, "#")
		slot10 = tonumber(slot8[2])

		if slot8[1] and slot9 == "EnterEpisode" and slot10 and slot10 == DungeonModel.instance.curSendEpisodeId and slot7.restart == 1 then
			return slot7.id
		end
	end
end

function slot0._getDoingGuideId(slot0)
	for slot6, slot7 in ipairs(GuideConfig.instance:getGuideList()) do
		slot8 = FightStrUtil.instance:getSplitCache(slot7.trigger, "#")
		slot10 = tonumber(slot8[2])

		if slot8[1] and slot9 == "EnterEpisode" and slot10 and slot10 == DungeonModel.instance.curSendEpisodeId and slot7.restart == 1 and GuideModel.instance:getById(slot7.id) and (not slot11.isFinish or slot11.currStepId > 0) then
			return slot7.id
		end
	end
end

return slot0
