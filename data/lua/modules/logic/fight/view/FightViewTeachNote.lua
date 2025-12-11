module("modules.logic.fight.view.FightViewTeachNote", package.seeall)

local var_0_0 = class("FightViewTeachNote", BaseView)
local var_0_1
local var_0_2 = 0

function var_0_0.onInitView(arg_1_0)
	arg_1_0._teachNoteGO = gohelper.findChild(arg_1_0.viewGO, "root/teachnote")
	arg_1_0._teachNoteAnimator = arg_1_0._teachNoteGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._btnTeachNote = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/teachnote/#btn_help")
	arg_1_0._btnTeachNoteSkip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/teachnote/#go_skipbtn/btn_skipguide")
	arg_1_0._btnsGO = gohelper.findChild(arg_1_0.viewGO, "root/btns")

	local var_1_0 = gohelper.onceAddComponent(gohelper.findChild(arg_1_0.viewGO, "root/teachnote/#go_skipbtn"), typeof(UnityEngine.Canvas))
	local var_1_1 = gohelper.onceAddComponent(ViewMgr.instance:getUILayer(UILayerName.Guide), typeof(UnityEngine.Canvas))

	var_1_0.overrideSorting = true
	var_1_0.sortingOrder = var_1_1.sortingOrder + 1
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnTeachNote:AddClickListener(arg_2_0._onClickTeachNote, arg_2_0)
	arg_2_0._btnTeachNoteSkip:AddClickListener(arg_2_0._onClickTeachNoteSkip, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.PushEndFight, arg_2_0._pushEndFight, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.StageChanged, arg_2_0._delayCheckShowAnim, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0._onOpenView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0._delayCheckShowAnim, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnTeachNote:RemoveClickListener()
	arg_3_0._btnTeachNoteSkip:RemoveClickListener()
	arg_3_0:removeEventCb(FightController.instance, FightEvent.PushEndFight, arg_3_0._pushEndFight, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.StageChanged, arg_3_0._delayCheckShowAnim, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0._onOpenView, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_3_0._delayCheckShowAnim, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._checkShowAnim, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	local var_4_0 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)
	local var_4_1 = var_4_0 and var_4_0.type == DungeonEnum.EpisodeType.Sp
	local var_4_2 = arg_4_0:_getGuideId()
	local var_4_3 = false

	for iter_4_0, iter_4_1 in ipairs(lua_helppage.configList) do
		if iter_4_1.unlockGuideId == var_4_2 then
			var_4_3 = true
		end
	end

	arg_4_0._episodeId = DungeonModel.instance.curSendEpisodeId
	arg_4_0._isSpAndHasHelpPage = var_4_1 and var_4_3

	gohelper.setActive(arg_4_0._teachNoteGO, arg_4_0._isSpAndHasHelpPage)
	arg_4_0:_checkShowAnim()
end

function var_0_0._onOpenView(arg_5_0, arg_5_1)
	if not arg_5_0._isSpAndHasHelpPage then
		return
	end

	if arg_5_1 == ViewName.GuideView and arg_5_0._teachNoteGO.activeInHierarchy and arg_5_0._teachNoteAnimator.enabled then
		arg_5_0._teachNoteAnimator.enabled = false
	end

	arg_5_0:_checkShowSkip()
end

function var_0_0._delayCheckShowAnim(arg_6_0)
	if not arg_6_0._isSpAndHasHelpPage then
		return
	end

	TaskDispatcher.runDelay(arg_6_0._checkShowAnim, arg_6_0, 0.5)
end

function var_0_0._checkShowAnim(arg_7_0)
	if not arg_7_0._isSpAndHasHelpPage then
		return
	end

	if FightWorkPlayHandCard.playing > 0 then
		return
	end

	if arg_7_0.viewContainer.fightViewHandCard:isMoveCardFlow() then
		return
	end

	if arg_7_0.viewContainer.fightViewHandCard:isCombineCardFlow() then
		return
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		return
	end

	local var_7_0 = FightWorkPlayHandCard.playing > 0
	local var_7_1 = arg_7_0.viewContainer.fightViewHandCard:isMoveCardFlow()
	local var_7_2 = arg_7_0.viewContainer.fightViewHandCard:isCombineCardFlow()
	local var_7_3 = var_7_0 or var_7_1 or var_7_2
	local var_7_4 = ViewMgr.instance:isOpen(ViewName.GuideView)
	local var_7_5 = FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Operate

	if not var_7_3 and not var_7_4 and var_7_5 and var_0_2 > 0 then
		arg_7_0._teachNoteAnimator.enabled = true

		arg_7_0._teachNoteAnimator:Play("fightview_teachnote_loop")
	end

	arg_7_0:_checkShowSkip()
end

function var_0_0._checkShowSkip(arg_8_0)
	if not arg_8_0._isSpAndHasHelpPage then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.GuideView) and var_0_2 > 0 then
		gohelper.setActive(arg_8_0._btnTeachNoteSkip.gameObject, true)
		transformhelper.setLocalScale(arg_8_0._btnsGO.transform, 0, 0, 0)
	else
		gohelper.setActive(arg_8_0._btnTeachNoteSkip.gameObject, false)
		transformhelper.setLocalScale(arg_8_0._btnsGO.transform, 1, 1, 1)
	end
end

function var_0_0._pushEndFight(arg_9_0)
	if arg_9_0._episodeId ~= var_0_1 then
		var_0_2 = 0
	end

	var_0_1 = arg_9_0._episodeId

	local var_9_0 = FightModel.instance:getRecordMO()
	local var_9_1 = var_9_0 and var_9_0.fightResult

	if var_9_1 == FightEnum.FightResult.Fail or var_9_1 == FightEnum.FightResult.OutOfRoundFail then
		var_0_2 = var_0_2 + 1
	else
		var_0_2 = 0
	end
end

function var_0_0._onClickTeachNote(arg_10_0)
	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.Enter) or FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DistributeCard) then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.GuideView) and not GuideUtil.isGuideViewTarget(arg_10_0._btnTeachNote.gameObject) then
		return
	end

	local var_10_0 = arg_10_0:_getGuideId()

	if var_10_0 then
		local var_10_1 = {
			id = HelpEnum.HelpId.Fight,
			viewParam = HelpEnum.HelpId.Fight,
			guideId = var_10_0
		}

		ViewMgr.instance:openView(ViewName.HelpView, var_10_1)
	else
		logError("没有正在执行的教学笔记引导，无法打开帮助说明界面")
	end
end

function var_0_0._onClickTeachNoteSkip(arg_11_0)
	local var_11_0 = arg_11_0:_getDoingGuideId()

	if var_11_0 then
		GuideController.instance:oneKeyFinishGuide(var_11_0, false)
		gohelper.setActive(arg_11_0._btnTeachNoteSkip.gameObject, false)
		transformhelper.setLocalScale(arg_11_0._btnsGO.transform, 1, 1, 1)
	else
		logError("没有正在执行的教学笔记引导，无法跳过引导")
	end
end

function var_0_0._getGuideId(arg_12_0)
	local var_12_0 = DungeonModel.instance.curSendEpisodeId
	local var_12_1 = GuideConfig.instance:getGuideList()

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		local var_12_2 = FightStrUtil.instance:getSplitCache(iter_12_1.trigger, "#")
		local var_12_3 = var_12_2[1]
		local var_12_4 = tonumber(var_12_2[2])

		if var_12_3 and var_12_3 == "EnterEpisode" and var_12_4 and var_12_4 == var_12_0 and iter_12_1.restart == 1 then
			return iter_12_1.id
		end
	end
end

function var_0_0._getDoingGuideId(arg_13_0)
	local var_13_0 = DungeonModel.instance.curSendEpisodeId
	local var_13_1 = GuideConfig.instance:getGuideList()

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		local var_13_2 = FightStrUtil.instance:getSplitCache(iter_13_1.trigger, "#")
		local var_13_3 = var_13_2[1]
		local var_13_4 = tonumber(var_13_2[2])

		if var_13_3 and var_13_3 == "EnterEpisode" and var_13_4 and var_13_4 == var_13_0 and iter_13_1.restart == 1 then
			local var_13_5 = GuideModel.instance:getById(iter_13_1.id)

			if var_13_5 and (not var_13_5.isFinish or var_13_5.currStepId > 0) then
				return iter_13_1.id
			end
		end
	end
end

return var_0_0
