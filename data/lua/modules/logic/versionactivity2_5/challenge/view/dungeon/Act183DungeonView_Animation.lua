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
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0:addEventCb(Act183Controller.instance, Act183Event.OnUpdateRepressInfo, arg_4_0._onUpdateRepressInfo, arg_4_0)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_4_0._onCloseViewFinish, arg_4_0)

	arg_4_0._lineEffectPool = arg_4_0:getUserDataTb_()
	arg_4_0._useLineEffectPool = arg_4_0:getUserDataTb_()
	arg_4_0._episodeItemTab = arg_4_0.viewContainer:getMainView():getEpisodeItemTab()
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

	arg_6_0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.Top2Bottom, arg_6_0._goline1, 0, 0, -90)
	arg_6_0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.Bottom2Top, arg_6_0._goline1, 0, 0, 90)
	arg_6_0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.Left2Right, arg_6_0._goline2, 0, 0, 0)
	arg_6_0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.Right2Left, arg_6_0._goline2, 0, 0, 180)
	arg_6_0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.LeftTop2RightBottom, arg_6_0._goline3, 0, 0, -30)
	arg_6_0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.RightTop2LeftBottom, arg_6_0._goline3, 0, 0, 200)
	arg_6_0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.LeftBottom2RightTop, arg_6_0._goline3, 0, 0, 30)
	arg_6_0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.RightBottom2LeftTop, arg_6_0._goline3, 0, 0, -200)
	arg_6_0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.LeftTop2Center, arg_6_0._goline1, 0, 0, -15)
	arg_6_0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.RightTop2Center, arg_6_0._goline1, 0, 0, 193)
	arg_6_0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.LeftBottom2Center, arg_6_0._goline1, 0, 0, 35)
	arg_6_0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.RightBottom2Center, arg_6_0._goline1, 0, 0, 135)
end

function var_0_0._addConfigToTemplateMap(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	arg_7_0._lineTemplateMap[arg_7_1] = arg_7_0:getUserDataTb_()

	table.insert(arg_7_0._lineTemplateMap[arg_7_1], arg_7_2)
	table.insert(arg_7_0._lineTemplateMap[arg_7_1], arg_7_3)
	table.insert(arg_7_0._lineTemplateMap[arg_7_1], arg_7_4)
	table.insert(arg_7_0._lineTemplateMap[arg_7_1], arg_7_5)
end

function var_0_0._addConfigToOrderAnimTypeMap(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = string.format("%s_%s", arg_8_1, arg_8_2)

	arg_8_0._orderToAnimTypeMap[var_8_0] = arg_8_3
end

function var_0_0.checkIfNeedPlayEffect(arg_9_0)
	if not ViewHelper.instance:checkViewOnTheTop(arg_9_0.viewName) then
		return
	end

	local var_9_0 = Act183Model.instance:getNewFinishEpisodeId() ~= nil and var_0_1 or 0

	arg_9_0:destroyFlow()

	arg_9_0._flow = FlowSequence.New()

	arg_9_0._flow:addWork(FunctionWork.New(arg_9_0._lockScreen, arg_9_0, true))
	arg_9_0._flow:addWork(FunctionWork.New(arg_9_0.checkIfNeedPlayFinishEffect, arg_9_0))
	arg_9_0._flow:addWork(FunctionWork.New(arg_9_0.checkIfNeedPlayGroupFinishEffect, arg_9_0))
	arg_9_0._flow:addWork(FunctionWork.New(arg_9_0.checkIfNeedPlayGroupCategoryFinishAnim, arg_9_0))
	arg_9_0._flow:addWork(WorkWaitSeconds.New(var_9_0))
	arg_9_0._flow:addWork(FunctionWork.New(arg_9_0.checkIfNeedPlayRepressEffect, arg_9_0))
	arg_9_0._flow:addWork(WorkWaitSeconds.New(var_0_2))
	arg_9_0._flow:addWork(FunctionWork.New(arg_9_0._recycleLines, arg_9_0))
	arg_9_0._flow:addWork(FunctionWork.New(arg_9_0._lockScreen, arg_9_0, false))
	arg_9_0._flow:registerDoneListener(arg_9_0._onPlayEffectDone, arg_9_0)
	arg_9_0._flow:start()
end

function var_0_0._onPlayEffectDone(arg_10_0)
	Act183Model.instance:clearBattleFinishedInfo()
end

function var_0_0.destroyFlow(arg_11_0)
	if arg_11_0._flow then
		arg_11_0._flow:destroy()

		arg_11_0._flow = nil
	end
end

function var_0_0._lockScreen(arg_12_0, arg_12_1)
	if arg_12_1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("Act183DungeonView_Animation_PlayAnim")
	else
		UIBlockMgr.instance:endBlock("Act183DungeonView_Animation_PlayAnim")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function var_0_0.checkIfNeedPlayRepressEffect(arg_13_0)
	local var_13_0 = Act183Model.instance:getRecordLastRepressEpisodeId()

	if not var_13_0 or var_13_0 == 0 then
		return
	end

	local var_13_1 = Act183Model.instance:getEpisodeMoById(var_13_0)

	arg_13_0:_playRuleRepressEffect(var_13_1)
	Act183Model.instance:clearRecordLastRepressEpisodeId()
end

function var_0_0.checkIfNeedPlayGroupFinishEffect(arg_14_0)
	local var_14_0 = Act183Model.instance:getNewFinishGroupId()

	if not var_14_0 or arg_14_0._lastFinishGroupId == var_14_0 then
		return
	end

	local var_14_1 = Act183Model.instance:getGroupEpisodeMo(var_14_0)

	if (var_14_1 and var_14_1:getGroupType()) == Act183Enum.GroupType.Daily then
		gohelper.setActive(arg_14_0._godailycompleted, true)
		arg_14_0._animdailycompleted:Play("in", 0, 0)
	else
		gohelper.setActive(arg_14_0._gocompleted, true)
		arg_14_0._animcompleted:Play("in", 0, 0)
	end

	arg_14_0._lastFinishGroupId = var_14_0

	AudioMgr.instance:trigger(AudioEnum.UI.Act183_GroupFinished)
end

function var_0_0.checkIfNeedPlayFinishEffect(arg_15_0)
	local var_15_0 = Act183Model.instance:getNewFinishEpisodeId()

	if not var_15_0 or arg_15_0._lastFinishEpisodeId == var_15_0 then
		return
	end

	Act183Controller.instance:dispatchEvent(Act183Event.EpisodeStartPlayFinishAnim, var_15_0)

	arg_15_0._lastFinishEpisodeId = var_15_0
end

function var_0_0._onUpdateRepressInfo(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0:checkIfNeedPlayEffect()
end

function var_0_0._playRuleRepressEffect(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1:getGroupId()
	local var_17_1 = Act183Model.instance:getGroupEpisodeMo(var_17_0)

	if not var_17_1 then
		return
	end

	local var_17_2 = arg_17_0:_getUnfinishEpisodes(var_17_1)

	if (var_17_2 and #var_17_2 or 0) <= 0 then
		return
	end

	local var_17_3 = arg_17_1:getConfigOrder()

	for iter_17_0, iter_17_1 in ipairs(var_17_2) do
		local var_17_4 = iter_17_1:getConfigOrder()

		arg_17_0:_showRepressEffect(arg_17_1, var_17_3, var_17_4)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Act183_EscapeRuleLineEffect)
end

function var_0_0._showRepressEffect(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = string.format("%s_%s", arg_18_2, arg_18_3)
	local var_18_1 = arg_18_0._orderToAnimTypeMap[var_18_0]

	if not var_18_1 then
		logError(string.format("镇压连线动画类型不存在 episodeId = %s, startOrder = %s, endOrder = %s", arg_18_1:getEpisodeId(), arg_18_2, arg_18_3))

		return
	end

	local var_18_2 = arg_18_0:_getOrCreateLine(var_18_1)

	var_18_2.name = var_18_0
	arg_18_0._useLineEffectPool[var_18_1] = arg_18_0._useLineEffectPool[var_18_1] or arg_18_0:getUserDataTb_()

	table.insert(arg_18_0._useLineEffectPool[var_18_1], var_18_2)

	local var_18_3 = arg_18_0._episodeItemTab[arg_18_3]:getIconTran()
	local var_18_4, var_18_5 = recthelper.rectToRelativeAnchorPos2(var_18_3.position, arg_18_0._gomiddle.transform)

	gohelper.setActive(var_18_2, true)
	recthelper.setAnchor(var_18_2.transform, var_18_4, var_18_5)

	local var_18_6 = gohelper.findChild(var_18_2, "line1")
	local var_18_7 = gohelper.findChild(var_18_2, "line2")

	gohelper.setActive(var_18_6, arg_18_1:getRuleStatus(1) == Act183Enum.RuleStatus.Escape)
	gohelper.setActive(var_18_7, arg_18_1:getRuleStatus(2) == Act183Enum.RuleStatus.Escape)
end

function var_0_0._getUnfinishEpisodes(arg_19_0, arg_19_1)
	local var_19_0 = {}
	local var_19_1 = arg_19_1:getEpisodeMos()

	for iter_19_0, iter_19_1 in ipairs(var_19_1) do
		if not iter_19_1:isFinished() then
			table.insert(var_19_0, iter_19_1)
		end
	end

	return var_19_0
end

function var_0_0._getOrCreateLine(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0._lineEffectPool[arg_20_1]

	if not var_20_0 then
		var_20_0 = arg_20_0:getUserDataTb_()
		arg_20_0._lineEffectPool[arg_20_1] = var_20_0
	end

	local var_20_1 = table.remove(var_20_0, 1)

	if not var_20_1 then
		local var_20_2 = arg_20_0._lineTemplateMap[arg_20_1]

		var_20_1 = gohelper.clone(var_20_2[1], arg_20_0._gomiddle, "line_" .. arg_20_1)

		local var_20_3 = var_20_2[2]
		local var_20_4 = var_20_2[3]
		local var_20_5 = var_20_2[4]

		transformhelper.setLocalRotation(var_20_1.transform, var_20_3, var_20_4, var_20_5)
	end

	return var_20_1
end

function var_0_0._recycleLines(arg_21_0)
	if arg_21_0._useLineEffectPool then
		for iter_21_0, iter_21_1 in pairs(arg_21_0._useLineEffectPool) do
			for iter_21_2 = #iter_21_1, 1, -1 do
				local var_21_0 = table.remove(iter_21_1, iter_21_2)

				gohelper.setActive(var_21_0, false)

				arg_21_0._lineEffectPool[iter_21_0] = arg_21_0._lineEffectPool[iter_21_0] or arg_21_0:getUserDataTb_()

				table.insert(arg_21_0._lineEffectPool[iter_21_0], var_21_0)
			end
		end
	end
end

function var_0_0._onCloseViewFinish(arg_22_0, arg_22_1)
	if arg_22_1 == arg_22_0.viewName then
		return
	end

	arg_22_0:checkIfNeedPlayEffect()
end

function var_0_0.checkIfNeedPlayGroupCategoryFinishAnim(arg_23_0)
	local var_23_0 = Act183Model.instance:getUnfinishTaskMap()

	if var_23_0 then
		for iter_23_0, iter_23_1 in pairs(var_23_0) do
			for iter_23_2 = #iter_23_1, 1, -1 do
				if Act183Helper.isTaskFinished(iter_23_1[iter_23_2]) then
					table.remove(iter_23_1, iter_23_2)
				end
			end

			if #iter_23_1 <= 0 then
				var_23_0[iter_23_0] = nil

				Act183Controller.instance:dispatchEvent(Act183Event.OnGroupAllTaskFinished, iter_23_0)
			end
		end
	end
end

function var_0_0.onClose(arg_24_0)
	arg_24_0:destroyFlow()
	arg_24_0:_lockScreen(false)
	Act183Model.instance:clearBattleFinishedInfo()
end

return var_0_0
