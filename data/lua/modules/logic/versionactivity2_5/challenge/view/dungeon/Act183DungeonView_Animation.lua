module("modules.logic.versionactivity2_5.challenge.view.dungeon.Act183DungeonView_Animation", package.seeall)

local var_0_0 = class("Act183DungeonView_Animation", BaseView)
local var_0_1 = 0.667
local var_0_2 = 1.167

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gomiddle = gohelper.findChild(arg_1_0.viewGO, "root/middle")
	arg_1_0._goline1 = gohelper.findChild(arg_1_0.viewGO, "root/#go_line1")
	arg_1_0._goline2 = gohelper.findChild(arg_1_0.viewGO, "root/#go_line2")
	arg_1_0._goline3 = gohelper.findChild(arg_1_0.viewGO, "root/#go_line3")
	arg_1_0._gocompleted = gohelper.findChild(arg_1_0.viewGO, "root/middle/#go_Completed")
	arg_1_0._godailycompleted = gohelper.findChild(arg_1_0.viewGO, "root/middle/#go_DailyCompleted")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(Act183Controller.instance, Act183Event.OnUpdateRepressInfo, arg_2_0._onUpdateRepressInfo, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0._onCloseViewFinish, arg_2_0)
	arg_2_0:addEventCb(Act183Controller.instance, Act183Event.FightBossIfSubUnfinish, arg_2_0._onFightBossIfSubUnfinish, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._lineEffectPool = arg_4_0:getUserDataTb_()
	arg_4_0._useLineEffectPool = arg_4_0:getUserDataTb_()
	arg_4_0._animcompleted = gohelper.onceAddComponent(arg_4_0._gocompleted, gohelper.Type_Animator)
	arg_4_0._animdailycompleted = gohelper.onceAddComponent(arg_4_0._godailycompleted, gohelper.Type_Animator)

	arg_4_0:_buildConfigToOrderAnimTypeMap()
	arg_4_0:_buildConfigToTemplateMap()
end

function var_0_0._buildConfigToOrderAnimTypeMap(arg_5_0)
	arg_5_0._orderToAnimTypeMap = {}

	arg_5_0:_addConfigToOrderAnimTypeMap(1, 2, Act183Enum.RuleEscapeAnimType.Left2Right)
	arg_5_0:_addConfigToOrderAnimTypeMap(2, 1, Act183Enum.RuleEscapeAnimType.Right2Left)
	arg_5_0:_addConfigToOrderAnimTypeMap(1, 3, Act183Enum.RuleEscapeAnimType.Top2Bottom)
	arg_5_0:_addConfigToOrderAnimTypeMap(3, 1, Act183Enum.RuleEscapeAnimType.Bottom2Top)
	arg_5_0:_addConfigToOrderAnimTypeMap(1, 4, Act183Enum.RuleEscapeAnimType.LeftTop2RightBottom)
	arg_5_0:_addConfigToOrderAnimTypeMap(4, 1, Act183Enum.RuleEscapeAnimType.RightBottom2LeftTop)
	arg_5_0:_addConfigToOrderAnimTypeMap(2, 3, Act183Enum.RuleEscapeAnimType.RightTop2LeftBottom)
	arg_5_0:_addConfigToOrderAnimTypeMap(3, 2, Act183Enum.RuleEscapeAnimType.LeftBottom2RightTop)
	arg_5_0:_addConfigToOrderAnimTypeMap(3, 4, Act183Enum.RuleEscapeAnimType.Left2Right)
	arg_5_0:_addConfigToOrderAnimTypeMap(4, 3, Act183Enum.RuleEscapeAnimType.Right2Left)
	arg_5_0:_addConfigToOrderAnimTypeMap(2, 4, Act183Enum.RuleEscapeAnimType.Top2Bottom)
	arg_5_0:_addConfigToOrderAnimTypeMap(4, 2, Act183Enum.RuleEscapeAnimType.Bottom2Top)
	arg_5_0:_addConfigToOrderAnimTypeMap(1, 101, Act183Enum.RuleEscapeAnimType.LeftTop2Center)
	arg_5_0:_addConfigToOrderAnimTypeMap(2, 101, Act183Enum.RuleEscapeAnimType.RightTop2Center)
	arg_5_0:_addConfigToOrderAnimTypeMap(3, 101, Act183Enum.RuleEscapeAnimType.LeftBottom2Center)
	arg_5_0:_addConfigToOrderAnimTypeMap(4, 101, Act183Enum.RuleEscapeAnimType.RightBottom2Center)
end

function var_0_0._buildConfigToTemplateMap(arg_6_0)
	arg_6_0._lineTemplateMap = arg_6_0:getUserDataTb_()

	arg_6_0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.Top2Bottom, arg_6_0._goline1)
	arg_6_0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.Bottom2Top, arg_6_0._goline1)
	arg_6_0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.Left2Right, arg_6_0._goline2)
	arg_6_0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.Right2Left, arg_6_0._goline2)
	arg_6_0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.LeftTop2RightBottom, arg_6_0._goline3)
	arg_6_0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.RightTop2LeftBottom, arg_6_0._goline3)
	arg_6_0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.LeftBottom2RightTop, arg_6_0._goline3)
	arg_6_0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.RightBottom2LeftTop, arg_6_0._goline3)
	arg_6_0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.LeftTop2Center, arg_6_0._goline1)
	arg_6_0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.RightTop2Center, arg_6_0._goline1)
	arg_6_0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.LeftBottom2Center, arg_6_0._goline1)
	arg_6_0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.RightBottom2Center, arg_6_0._goline1)
end

function var_0_0._addConfigToTemplateMap(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._lineTemplateMap[arg_7_1] = arg_7_0:getUserDataTb_()

	table.insert(arg_7_0._lineTemplateMap[arg_7_1], arg_7_2)
end

function var_0_0._addConfigToOrderAnimTypeMap(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = string.format("%s_%s", arg_8_1, arg_8_2)

	arg_8_0._orderToAnimTypeMap[var_8_0] = arg_8_3
end

function var_0_0.checkIfNeedPlayEffect(arg_9_0)
	if not ViewHelper.instance:checkViewOnTheTop(arg_9_0.viewName) or arg_9_0:isRunningEffectFlow() then
		return
	end

	local var_9_0 = Act183Model.instance:getNewFinishEpisodeId()
	local var_9_1 = var_9_0 ~= nil and var_0_1 or 0

	arg_9_0:destroyFlow()

	arg_9_0._flow = FlowSequence.New()

	arg_9_0._flow:addWork(FunctionWork.New(arg_9_0._lockScreen, arg_9_0, true))
	arg_9_0._flow:addWork(FunctionWork.New(arg_9_0.checkIfNeedPlayFinishEffect, arg_9_0))
	arg_9_0._flow:addWork(FunctionWork.New(arg_9_0.checkIfNeedPlayGroupFinishEffect, arg_9_0))
	arg_9_0._flow:addWork(FunctionWork.New(arg_9_0.checkIfNeedPlayGroupCategoryFinishAnim, arg_9_0))
	arg_9_0._flow:addWork(WorkWaitSeconds.New(var_9_1))
	arg_9_0._flow:addWork(FunctionWork.New(arg_9_0.checkIfNeedPlayRepressEffect, arg_9_0))
	arg_9_0._flow:addWork(WorkWaitSeconds.New(var_0_2))
	arg_9_0._flow:addWork(FunctionWork.New(arg_9_0._recycleLines, arg_9_0))
	arg_9_0._flow:addWork(FunctionWork.New(arg_9_0._lockScreen, arg_9_0, false))
	arg_9_0._flow:registerDoneListener(arg_9_0._onPlayEffectDone, arg_9_0)
	arg_9_0._flow:start({
		episodeId = var_9_0
	})
end

function var_0_0.isRunningEffectFlow(arg_10_0)
	return arg_10_0._flow and arg_10_0._flow.status == WorkStatus.Running
end

function var_0_0._onPlayEffectDone(arg_11_0)
	Act183Model.instance:clearBattleFinishedInfo()
end

function var_0_0.destroyFlow(arg_12_0)
	if arg_12_0._flow then
		arg_12_0._flow:destroy()

		arg_12_0._flow = nil
	end
end

function var_0_0._lockScreen(arg_13_0, arg_13_1)
	if arg_13_1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("Act183DungeonView_Animation_PlayAnim")
	else
		UIBlockMgr.instance:endBlock("Act183DungeonView_Animation_PlayAnim")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function var_0_0.checkIfNeedPlayRepressEffect(arg_14_0)
	local var_14_0 = Act183Model.instance:getRecordLastRepressEpisodeId()

	if not var_14_0 or var_14_0 == 0 then
		return
	end

	local var_14_1 = Act183Model.instance:getEpisodeMoById(var_14_0)

	arg_14_0:_playRuleRepressEffect(var_14_1)
	Act183Model.instance:clearRecordLastRepressEpisodeId()
end

function var_0_0.checkIfNeedPlayGroupFinishEffect(arg_15_0)
	local var_15_0 = Act183Model.instance:getNewFinishGroupId()

	if not var_15_0 or arg_15_0._lastFinishGroupId == var_15_0 then
		return
	end

	local var_15_1 = Act183Model.instance:getGroupEpisodeMo(var_15_0)

	if (var_15_1 and var_15_1:getGroupType()) == Act183Enum.GroupType.Daily then
		gohelper.setActive(arg_15_0._godailycompleted, true)
		arg_15_0._animdailycompleted:Play("in", 0, 0)
	else
		gohelper.setActive(arg_15_0._gocompleted, true)
		arg_15_0._animcompleted:Play("in", 0, 0)
	end

	arg_15_0._lastFinishGroupId = var_15_0

	AudioMgr.instance:trigger(AudioEnum.UI.Act183_GroupFinished)
end

function var_0_0.checkIfNeedPlayFinishEffect(arg_16_0)
	local var_16_0 = Act183Model.instance:getNewFinishEpisodeId()

	if not var_16_0 or arg_16_0._lastFinishEpisodeId == var_16_0 then
		return
	end

	Act183Controller.instance:dispatchEvent(Act183Event.EpisodeStartPlayFinishAnim, var_16_0)

	arg_16_0._lastFinishEpisodeId = var_16_0
end

function var_0_0._onUpdateRepressInfo(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0:checkIfNeedPlayEffect()
end

function var_0_0._playRuleRepressEffect(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1:getGroupId()
	local var_18_1 = Act183Model.instance:getGroupEpisodeMo(var_18_0)

	if not var_18_1 then
		return
	end

	local var_18_2 = arg_18_0:_getUnfinishEpisodes(var_18_1)

	if (var_18_2 and #var_18_2 or 0) <= 0 then
		return
	end

	local var_18_3 = arg_18_1:getConfigOrder()

	for iter_18_0, iter_18_1 in ipairs(var_18_2) do
		local var_18_4 = iter_18_1:getConfigOrder()

		arg_18_0:_showRepressEffect(arg_18_1, var_18_3, var_18_4)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Act183_EscapeRuleLineEffect)
end

function var_0_0._showRepressEffect(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = string.format("%s_%s", arg_19_2, arg_19_3)
	local var_19_1 = arg_19_0._orderToAnimTypeMap[var_19_0]

	if not var_19_1 then
		logError(string.format("镇压连线动画类型不存在 episodeId = %s, startOrder = %s, endOrder = %s", arg_19_1:getEpisodeId(), arg_19_2, arg_19_3))

		return
	end

	local var_19_2 = arg_19_0:_getOrCreateLine(var_19_1)

	var_19_2.name = var_19_0
	arg_19_0._useLineEffectPool[var_19_1] = arg_19_0._useLineEffectPool[var_19_1] or arg_19_0:getUserDataTb_()

	table.insert(arg_19_0._useLineEffectPool[var_19_1], var_19_2)
	arg_19_0:_setLinePosAndRotation(arg_19_2, arg_19_3, var_19_2)

	local var_19_3 = gohelper.findChild(var_19_2, "line1")
	local var_19_4 = gohelper.findChild(var_19_2, "line2")

	gohelper.setActive(var_19_3, arg_19_1:getRuleStatus(1) ~= Act183Enum.RuleStatus.Repress)
	gohelper.setActive(var_19_4, arg_19_1:getRuleStatus(2) ~= Act183Enum.RuleStatus.Repress)
end

function var_0_0._setLinePosAndRotation(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = arg_20_0:getEpisodeItemTab()
	local var_20_1 = var_20_0 and var_20_0[arg_20_1]
	local var_20_2 = var_20_0 and var_20_0[arg_20_2]

	if not var_20_1 or not var_20_2 then
		return
	end

	local var_20_3 = var_20_1:getIconTran()
	local var_20_4 = recthelper.rectToRelativeAnchorPos(var_20_3.position, arg_20_0._gomiddle.transform)
	local var_20_5 = var_20_2:getIconTran()
	local var_20_6 = recthelper.rectToRelativeAnchorPos(var_20_5.position, arg_20_0._gomiddle.transform)

	gohelper.setActive(arg_20_3, true)
	recthelper.setAnchor(arg_20_3.transform, var_20_6.x, var_20_6.y)

	local var_20_7, var_20_8, var_20_9 = arg_20_0:_calcLineRotation(var_20_4, var_20_6)

	transformhelper.setLocalRotation(arg_20_3.transform, var_20_7, var_20_8, var_20_9)
end

function var_0_0._calcLineRotation(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_2 - arg_21_1
	local var_21_1 = Mathf.Atan2(var_21_0.y, var_21_0.x) * Mathf.Rad2Deg

	var_21_1 = var_21_1 < 0 and var_21_1 + 360 or var_21_1

	return 0, 0, var_21_1
end

function var_0_0._getUnfinishEpisodes(arg_22_0, arg_22_1)
	local var_22_0 = {}
	local var_22_1 = arg_22_1:getEpisodeMos()

	for iter_22_0, iter_22_1 in ipairs(var_22_1) do
		if not iter_22_1:isFinished() then
			table.insert(var_22_0, iter_22_1)
		end
	end

	return var_22_0
end

function var_0_0._getOrCreateLine(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0._lineEffectPool[arg_23_1]

	if not var_23_0 then
		var_23_0 = arg_23_0:getUserDataTb_()
		arg_23_0._lineEffectPool[arg_23_1] = var_23_0
	end

	local var_23_1 = table.remove(var_23_0, 1)

	if not var_23_1 then
		local var_23_2 = arg_23_0._lineTemplateMap[arg_23_1]

		var_23_1 = gohelper.clone(var_23_2[1], arg_23_0._gomiddle, "line_" .. arg_23_1)
	end

	return var_23_1
end

function var_0_0._recycleLines(arg_24_0)
	if arg_24_0._useLineEffectPool then
		for iter_24_0, iter_24_1 in pairs(arg_24_0._useLineEffectPool) do
			for iter_24_2 = #iter_24_1, 1, -1 do
				local var_24_0 = table.remove(iter_24_1, iter_24_2)

				gohelper.setActive(var_24_0, false)

				arg_24_0._lineEffectPool[iter_24_0] = arg_24_0._lineEffectPool[iter_24_0] or arg_24_0:getUserDataTb_()

				table.insert(arg_24_0._lineEffectPool[iter_24_0], var_24_0)
			end
		end
	end
end

function var_0_0._onCloseViewFinish(arg_25_0, arg_25_1)
	if arg_25_1 == arg_25_0.viewName then
		return
	end

	arg_25_0:checkIfNeedPlayEffect()
end

function var_0_0.checkIfNeedPlayGroupCategoryFinishAnim(arg_26_0)
	local var_26_0 = Act183Model.instance:getUnfinishTaskMap()

	if var_26_0 then
		for iter_26_0, iter_26_1 in pairs(var_26_0) do
			for iter_26_2 = #iter_26_1, 1, -1 do
				if Act183Helper.isTaskFinished(iter_26_1[iter_26_2]) then
					table.remove(iter_26_1, iter_26_2)
				end
			end

			if #iter_26_1 <= 0 then
				var_26_0[iter_26_0] = nil

				Act183Controller.instance:dispatchEvent(Act183Event.OnGroupAllTaskFinished, iter_26_0)
			end
		end
	end
end

function var_0_0._onFightBossIfSubUnfinish(arg_27_0, arg_27_1)
	local var_27_0 = Act183Model.instance:getEpisodeMoById(arg_27_1)

	if not var_27_0 then
		return
	end

	arg_27_0:destroyFlow()

	arg_27_0._flow = FlowSequence.New()

	arg_27_0._flow:addWork(FunctionWork.New(arg_27_0._lockScreen, arg_27_0, true))
	arg_27_0._flow:addWork(FunctionWork.New(arg_27_0._playRuleRepressEffect2BossEpisode, arg_27_0, var_27_0))
	arg_27_0._flow:addWork(WorkWaitSeconds.New(var_0_2))
	arg_27_0._flow:addWork(FunctionWork.New(arg_27_0._recycleLines, arg_27_0))
	arg_27_0._flow:addWork(FunctionWork.New(arg_27_0._lockScreen, arg_27_0, false))
	arg_27_0._flow:addWork(FunctionWork.New(arg_27_0._onPlayFightBossEffectDone, arg_27_0, arg_27_1))
	arg_27_0._flow:start()
end

function var_0_0._playRuleRepressEffect2BossEpisode(arg_28_0, arg_28_1)
	local var_28_0 = Act183Model.instance:getGroupEpisodeMo(arg_28_1:getGroupId())

	if not var_28_0 then
		return
	end

	local var_28_1 = var_28_0:getTargetTypeAndStatusEpisodes(Act183Enum.EpisodeType.Sub, Act183Enum.EpisodeStatus.Unlocked)
	local var_28_2 = var_28_0:getTargetTypeAndStatusEpisodes(Act183Enum.EpisodeType.Sub, Act183Enum.EpisodeStatus.Locked)
	local var_28_3 = {}

	tabletool.addValues(var_28_3, var_28_1)
	tabletool.addValues(var_28_3, var_28_2)

	local var_28_4 = arg_28_1:getConfigOrder()

	for iter_28_0, iter_28_1 in ipairs(var_28_3) do
		local var_28_5 = iter_28_1:getConfigOrder()

		arg_28_0:_showRepressEffect(iter_28_1, var_28_5, var_28_4)
		arg_28_0:_showEscapeEffect(var_28_5)
	end
end

function var_0_0._showEscapeEffect(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:getEpisodeItemTab()
	local var_29_1 = var_29_0 and var_29_0[arg_29_1]

	if not var_29_1 then
		return
	end

	if var_29_1.playFakeRepressAnim then
		var_29_1:playFakeRepressAnim()
	end
end

function var_0_0._onPlayFightBossEffectDone(arg_30_0, arg_30_1)
	Act183Controller.instance:dispatchEvent(Act183Event.OnPlayEffectDoneIfSubUnfinish, arg_30_1)
end

function var_0_0.getEpisodeItemTab(arg_31_0)
	local var_31_0 = arg_31_0.viewContainer:getMainView()

	return var_31_0 and var_31_0:getEpisodeItemTab()
end

function var_0_0.onClose(arg_32_0)
	arg_32_0:destroyFlow()
	arg_32_0:_lockScreen(false)
	Act183Model.instance:clearBattleFinishedInfo()
end

return var_0_0
