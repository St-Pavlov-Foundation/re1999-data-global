module("modules.logic.versionactivity2_5.challenge.view.Act183DungeonView_Animation", package.seeall)

slot0 = class("Act183DungeonView_Animation", BaseView)
slot1 = 0.667
slot2 = 1.167

function slot0.onInitView(slot0)
	slot0._gomiddle = gohelper.findChild(slot0.viewGO, "root/middle")
	slot0._goline1 = gohelper.findChild(slot0.viewGO, "root/#go_line1")
	slot0._goline2 = gohelper.findChild(slot0.viewGO, "root/#go_line2")
	slot0._goline3 = gohelper.findChild(slot0.viewGO, "root/#go_line3")
	slot0._gocompleted = gohelper.findChild(slot0.viewGO, "root/middle/#go_Completed")
	slot0._godailycompleted = gohelper.findChild(slot0.viewGO, "root/middle/#go_DailyCompleted")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(Act183Controller.instance, Act183Event.OnUpdateRepressInfo, slot0._onUpdateRepressInfo, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)

	slot0._lineEffectPool = slot0:getUserDataTb_()
	slot0._useLineEffectPool = slot0:getUserDataTb_()
	slot0._orderToAnimTypeMap = {}

	slot0:_addConfigToOrderAnimTypeMap(1, 2, Act183Enum.RuleEscapeAnimType.Middle_Positive)
	slot0:_addConfigToOrderAnimTypeMap(2, 1, Act183Enum.RuleEscapeAnimType.Middle_Negative)
	slot0:_addConfigToOrderAnimTypeMap(1, 3, Act183Enum.RuleEscapeAnimType.Short_Positive)
	slot0:_addConfigToOrderAnimTypeMap(3, 1, Act183Enum.RuleEscapeAnimType.Short_Negative)
	slot0:_addConfigToOrderAnimTypeMap(1, 4, Act183Enum.RuleEscapeAnimType.Large_Left_Positive)
	slot0:_addConfigToOrderAnimTypeMap(4, 1, Act183Enum.RuleEscapeAnimType.Large_Right_Negative)
	slot0:_addConfigToOrderAnimTypeMap(2, 3, Act183Enum.RuleEscapeAnimType.Large_Right_Positive)
	slot0:_addConfigToOrderAnimTypeMap(3, 2, Act183Enum.RuleEscapeAnimType.Large_Left_Negative)
	slot0:_addConfigToOrderAnimTypeMap(3, 4, Act183Enum.RuleEscapeAnimType.Middle_Positive)
	slot0:_addConfigToOrderAnimTypeMap(4, 3, Act183Enum.RuleEscapeAnimType.Middle_Negative)
	slot0:_addConfigToOrderAnimTypeMap(2, 4, Act183Enum.RuleEscapeAnimType.Short_Positive)
	slot0:_addConfigToOrderAnimTypeMap(4, 2, Act183Enum.RuleEscapeAnimType.Short_Negative)

	slot0._lineTemplateMap = slot0:getUserDataTb_()

	slot0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.Short_Positive, slot0._goline1, 0, 0, -90)
	slot0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.Short_Positive, slot0._goline1, 0, 0, -90)
	slot0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.Short_Negative, slot0._goline1, 0, 0, 90)
	slot0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.Middle_Positive, slot0._goline2, 0, 0, 0)
	slot0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.Middle_Negative, slot0._goline2, 0, 0, 180)
	slot0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.Large_Left_Positive, slot0._goline3, 0, 0, -30)
	slot0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.Large_Right_Positive, slot0._goline3, 0, 0, 200)
	slot0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.Large_Left_Negative, slot0._goline3, 0, 0, 30)
	slot0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.Large_Right_Negative, slot0._goline3, 0, 0, -200)

	slot0._episodeItemTab = slot0.viewContainer:getMainView():getEpisodeItemTab()
	slot0._animcompleted = gohelper.onceAddComponent(slot0._gocompleted, gohelper.Type_Animator)
	slot0._animdailycompleted = gohelper.onceAddComponent(slot0._godailycompleted, gohelper.Type_Animator)
end

function slot0._addConfigToTemplateMap(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0._lineTemplateMap[slot1] = slot0:getUserDataTb_()

	table.insert(slot0._lineTemplateMap[slot1], slot2)
	table.insert(slot0._lineTemplateMap[slot1], slot3)
	table.insert(slot0._lineTemplateMap[slot1], slot4)
	table.insert(slot0._lineTemplateMap[slot1], slot5)
end

function slot0._addConfigToOrderAnimTypeMap(slot0, slot1, slot2, slot3)
	slot0._orderToAnimTypeMap[string.format("%s_%s", slot1, slot2)] = slot3
end

function slot0.checkIfNeedPlayEffect(slot0)
	if not ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		return
	end

	slot0:destroyFlow()

	slot0._flow = FlowSequence.New()

	slot0._flow:addWork(FunctionWork.New(slot0._lockScreen, slot0, true))
	slot0._flow:addWork(FunctionWork.New(slot0.checkIfNeedPlayFinishEffect, slot0))
	slot0._flow:addWork(FunctionWork.New(slot0.checkIfNeedPlayGroupFinishEffect, slot0))
	slot0._flow:addWork(FunctionWork.New(slot0.checkIfNeedPlayGroupCategoryFinishAnim, slot0))
	slot0._flow:addWork(WorkWaitSeconds.New(Act183Model.instance:getNewFinishEpisodeId() ~= nil and uv0 or 0))
	slot0._flow:addWork(FunctionWork.New(slot0.checkIfNeedPlayRepressEffect, slot0))
	slot0._flow:addWork(WorkWaitSeconds.New(uv1))
	slot0._flow:addWork(FunctionWork.New(slot0._recycleLines, slot0))
	slot0._flow:addWork(FunctionWork.New(slot0._lockScreen, slot0, false))
	slot0._flow:registerDoneListener(slot0._onPlayEffectDone, slot0)
	slot0._flow:start()
end

function slot0._onPlayEffectDone(slot0)
	Act183Model.instance:clearBattleFinishedInfo()
end

function slot0.destroyFlow(slot0)
	if slot0._flow then
		slot0._flow:destroy()

		slot0._flow = nil
	end
end

function slot0._lockScreen(slot0, slot1)
	if slot1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("Act183DungeonView_Animation_PlayAnim")
	else
		UIBlockMgr.instance:endBlock("Act183DungeonView_Animation_PlayAnim")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function slot0.checkIfNeedPlayRepressEffect(slot0)
	if not Act183Model.instance:getRecordLastRepressEpisodeId() or slot1 == 0 then
		return
	end

	slot0:_playRuleRepressEffect(Act183Model.instance:getEpisodeMoById(slot1))
	Act183Model.instance:clearRecordLastRepressEpisodeId()
end

function slot0.checkIfNeedPlayGroupFinishEffect(slot0)
	if not Act183Model.instance:getNewFinishGroupId() or slot0._lastFinishGroupId == slot1 then
		return
	end

	if (Act183Model.instance:getGroupEpisodeMo(slot1) and slot2:getGroupType()) == Act183Enum.GroupType.Daily then
		gohelper.setActive(slot0._godailycompleted, true)
		slot0._animdailycompleted:Play("in", 0, 0)
	else
		gohelper.setActive(slot0._gocompleted, true)
		slot0._animcompleted:Play("in", 0, 0)
	end

	slot0._lastFinishGroupId = slot1

	AudioMgr.instance:trigger(AudioEnum.UI.Act183_GroupFinished)
end

function slot0.checkIfNeedPlayFinishEffect(slot0)
	if not Act183Model.instance:getNewFinishEpisodeId() or slot0._lastFinishEpisodeId == slot1 then
		return
	end

	if not slot0._episodeItemTab[Act183Model.instance:getEpisodeMoById(slot1):getConfigOrder()] then
		return
	end

	slot4:playFinishAnim()

	slot0._lastFinishEpisodeId = slot1
end

function slot0._onUpdateRepressInfo(slot0, slot1, slot2)
	slot0:checkIfNeedPlayEffect()
end

function slot0._playRuleRepressEffect(slot0, slot1)
	if not Act183Model.instance:getGroupEpisodeMo(slot1:getGroupId()) then
		return
	end

	if (slot0:_getUnfinishSubEpisodes(slot3) and #slot4 or 0) <= 0 then
		return
	end

	for slot10, slot11 in ipairs(slot4) do
		slot0:_showRepressEffect(slot1, slot1:getConfigOrder(), slot11:getConfigOrder())
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Act183_EscapeRuleLineEffect)
end

function slot0._showRepressEffect(slot0, slot1, slot2, slot3)
	slot4 = string.format("%s_%s", slot2, slot3)
	slot5 = slot0._orderToAnimTypeMap[slot4]
	slot0:_getOrCreateLine(slot5).name = slot4
	slot0._useLineEffectPool[slot5] = slot0._useLineEffectPool[slot5] or slot0:getUserDataTb_()

	table.insert(slot0._useLineEffectPool[slot5], slot6)

	slot9, slot10 = recthelper.rectToRelativeAnchorPos2(slot0._episodeItemTab[slot3]:getIconTran().position, slot0._gomiddle.transform)

	gohelper.setActive(slot6, true)
	recthelper.setAnchor(slot6.transform, slot9, slot10)
	gohelper.setActive(gohelper.findChild(slot6, "line1"), slot1:getRuleStatus(1) == Act183Enum.RuleStatus.Escape)
	gohelper.setActive(gohelper.findChild(slot6, "line2"), slot1:getRuleStatus(2) == Act183Enum.RuleStatus.Escape)
end

function slot0._getUnfinishSubEpisodes(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in ipairs(slot1:getEpisodeMos()) do
		if slot8:getEpisodeType() == Act183Enum.EpisodeType.Sub and not slot8:isFinished() then
			table.insert(slot2, slot8)
		end
	end

	return slot2
end

function slot0._getOrCreateLine(slot0, slot1)
	if not slot0._lineEffectPool[slot1] then
		slot0._lineEffectPool[slot1] = slot0:getUserDataTb_()
	end

	if not table.remove(slot2, 1) then
		slot4 = slot0._lineTemplateMap[slot1]

		transformhelper.setLocalRotation(gohelper.clone(slot4[1], slot0._gomiddle, "line_" .. slot1).transform, slot4[2], slot4[3], slot4[4])
	end

	return slot3
end

function slot0._recycleLines(slot0)
	if slot0._useLineEffectPool then
		for slot4, slot5 in pairs(slot0._useLineEffectPool) do
			for slot9 = #slot5, 1, -1 do
				gohelper.setActive(table.remove(slot5, slot9), false)

				slot0._lineEffectPool[slot4] = slot0._lineEffectPool[slot4] or slot0:getUserDataTb_()

				table.insert(slot0._lineEffectPool[slot4], slot10)
			end
		end
	end
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == slot0.viewName then
		return
	end

	slot0:checkIfNeedPlayEffect()
end

function slot0.checkIfNeedPlayGroupCategoryFinishAnim(slot0)
	if Act183Model.instance:getUnfinishTaskMap() then
		for slot5, slot6 in pairs(slot1) do
			for slot10 = #slot6, 1, -1 do
				if Act183Helper.isTaskFinished(slot6[slot10]) then
					table.remove(slot6, slot10)
				end
			end

			if #slot6 <= 0 then
				slot1[slot5] = nil

				Act183Controller.instance:dispatchEvent(Act183Event.OnGroupAllTaskFinished, slot5)
			end
		end
	end
end

function slot0.onClose(slot0)
	slot0:destroyFlow()
	slot0:_lockScreen(false)
	Act183Model.instance:clearBattleFinishedInfo()
end

return slot0
