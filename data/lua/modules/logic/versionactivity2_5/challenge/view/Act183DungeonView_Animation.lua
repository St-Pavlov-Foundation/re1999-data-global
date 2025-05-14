module("modules.logic.versionactivity2_5.challenge.view.Act183DungeonView_Animation", package.seeall)

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
	arg_4_0._orderToAnimTypeMap = {}

	arg_4_0:_addConfigToOrderAnimTypeMap(1, 2, Act183Enum.RuleEscapeAnimType.Middle_Positive)
	arg_4_0:_addConfigToOrderAnimTypeMap(2, 1, Act183Enum.RuleEscapeAnimType.Middle_Negative)
	arg_4_0:_addConfigToOrderAnimTypeMap(1, 3, Act183Enum.RuleEscapeAnimType.Short_Positive)
	arg_4_0:_addConfigToOrderAnimTypeMap(3, 1, Act183Enum.RuleEscapeAnimType.Short_Negative)
	arg_4_0:_addConfigToOrderAnimTypeMap(1, 4, Act183Enum.RuleEscapeAnimType.Large_Left_Positive)
	arg_4_0:_addConfigToOrderAnimTypeMap(4, 1, Act183Enum.RuleEscapeAnimType.Large_Right_Negative)
	arg_4_0:_addConfigToOrderAnimTypeMap(2, 3, Act183Enum.RuleEscapeAnimType.Large_Right_Positive)
	arg_4_0:_addConfigToOrderAnimTypeMap(3, 2, Act183Enum.RuleEscapeAnimType.Large_Left_Negative)
	arg_4_0:_addConfigToOrderAnimTypeMap(3, 4, Act183Enum.RuleEscapeAnimType.Middle_Positive)
	arg_4_0:_addConfigToOrderAnimTypeMap(4, 3, Act183Enum.RuleEscapeAnimType.Middle_Negative)
	arg_4_0:_addConfigToOrderAnimTypeMap(2, 4, Act183Enum.RuleEscapeAnimType.Short_Positive)
	arg_4_0:_addConfigToOrderAnimTypeMap(4, 2, Act183Enum.RuleEscapeAnimType.Short_Negative)

	arg_4_0._lineTemplateMap = arg_4_0:getUserDataTb_()

	arg_4_0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.Short_Positive, arg_4_0._goline1, 0, 0, -90)
	arg_4_0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.Short_Positive, arg_4_0._goline1, 0, 0, -90)
	arg_4_0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.Short_Negative, arg_4_0._goline1, 0, 0, 90)
	arg_4_0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.Middle_Positive, arg_4_0._goline2, 0, 0, 0)
	arg_4_0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.Middle_Negative, arg_4_0._goline2, 0, 0, 180)
	arg_4_0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.Large_Left_Positive, arg_4_0._goline3, 0, 0, -30)
	arg_4_0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.Large_Right_Positive, arg_4_0._goline3, 0, 0, 200)
	arg_4_0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.Large_Left_Negative, arg_4_0._goline3, 0, 0, 30)
	arg_4_0:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.Large_Right_Negative, arg_4_0._goline3, 0, 0, -200)

	arg_4_0._episodeItemTab = arg_4_0.viewContainer:getMainView():getEpisodeItemTab()
	arg_4_0._animcompleted = gohelper.onceAddComponent(arg_4_0._gocompleted, gohelper.Type_Animator)
	arg_4_0._animdailycompleted = gohelper.onceAddComponent(arg_4_0._godailycompleted, gohelper.Type_Animator)
end

function var_0_0._addConfigToTemplateMap(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	arg_5_0._lineTemplateMap[arg_5_1] = arg_5_0:getUserDataTb_()

	table.insert(arg_5_0._lineTemplateMap[arg_5_1], arg_5_2)
	table.insert(arg_5_0._lineTemplateMap[arg_5_1], arg_5_3)
	table.insert(arg_5_0._lineTemplateMap[arg_5_1], arg_5_4)
	table.insert(arg_5_0._lineTemplateMap[arg_5_1], arg_5_5)
end

function var_0_0._addConfigToOrderAnimTypeMap(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = string.format("%s_%s", arg_6_1, arg_6_2)

	arg_6_0._orderToAnimTypeMap[var_6_0] = arg_6_3
end

function var_0_0.checkIfNeedPlayEffect(arg_7_0)
	if not ViewHelper.instance:checkViewOnTheTop(arg_7_0.viewName) then
		return
	end

	local var_7_0 = Act183Model.instance:getNewFinishEpisodeId() ~= nil and var_0_1 or 0

	arg_7_0:destroyFlow()

	arg_7_0._flow = FlowSequence.New()

	arg_7_0._flow:addWork(FunctionWork.New(arg_7_0._lockScreen, arg_7_0, true))
	arg_7_0._flow:addWork(FunctionWork.New(arg_7_0.checkIfNeedPlayFinishEffect, arg_7_0))
	arg_7_0._flow:addWork(FunctionWork.New(arg_7_0.checkIfNeedPlayGroupFinishEffect, arg_7_0))
	arg_7_0._flow:addWork(FunctionWork.New(arg_7_0.checkIfNeedPlayGroupCategoryFinishAnim, arg_7_0))
	arg_7_0._flow:addWork(WorkWaitSeconds.New(var_7_0))
	arg_7_0._flow:addWork(FunctionWork.New(arg_7_0.checkIfNeedPlayRepressEffect, arg_7_0))
	arg_7_0._flow:addWork(WorkWaitSeconds.New(var_0_2))
	arg_7_0._flow:addWork(FunctionWork.New(arg_7_0._recycleLines, arg_7_0))
	arg_7_0._flow:addWork(FunctionWork.New(arg_7_0._lockScreen, arg_7_0, false))
	arg_7_0._flow:registerDoneListener(arg_7_0._onPlayEffectDone, arg_7_0)
	arg_7_0._flow:start()
end

function var_0_0._onPlayEffectDone(arg_8_0)
	Act183Model.instance:clearBattleFinishedInfo()
end

function var_0_0.destroyFlow(arg_9_0)
	if arg_9_0._flow then
		arg_9_0._flow:destroy()

		arg_9_0._flow = nil
	end
end

function var_0_0._lockScreen(arg_10_0, arg_10_1)
	if arg_10_1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("Act183DungeonView_Animation_PlayAnim")
	else
		UIBlockMgr.instance:endBlock("Act183DungeonView_Animation_PlayAnim")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function var_0_0.checkIfNeedPlayRepressEffect(arg_11_0)
	local var_11_0 = Act183Model.instance:getRecordLastRepressEpisodeId()

	if not var_11_0 or var_11_0 == 0 then
		return
	end

	local var_11_1 = Act183Model.instance:getEpisodeMoById(var_11_0)

	arg_11_0:_playRuleRepressEffect(var_11_1)
	Act183Model.instance:clearRecordLastRepressEpisodeId()
end

function var_0_0.checkIfNeedPlayGroupFinishEffect(arg_12_0)
	local var_12_0 = Act183Model.instance:getNewFinishGroupId()

	if not var_12_0 or arg_12_0._lastFinishGroupId == var_12_0 then
		return
	end

	local var_12_1 = Act183Model.instance:getGroupEpisodeMo(var_12_0)

	if (var_12_1 and var_12_1:getGroupType()) == Act183Enum.GroupType.Daily then
		gohelper.setActive(arg_12_0._godailycompleted, true)
		arg_12_0._animdailycompleted:Play("in", 0, 0)
	else
		gohelper.setActive(arg_12_0._gocompleted, true)
		arg_12_0._animcompleted:Play("in", 0, 0)
	end

	arg_12_0._lastFinishGroupId = var_12_0

	AudioMgr.instance:trigger(AudioEnum.UI.Act183_GroupFinished)
end

function var_0_0.checkIfNeedPlayFinishEffect(arg_13_0)
	local var_13_0 = Act183Model.instance:getNewFinishEpisodeId()

	if not var_13_0 or arg_13_0._lastFinishEpisodeId == var_13_0 then
		return
	end

	local var_13_1 = Act183Model.instance:getEpisodeMoById(var_13_0):getConfigOrder()
	local var_13_2 = arg_13_0._episodeItemTab[var_13_1]

	if not var_13_2 then
		return
	end

	var_13_2:playFinishAnim()

	arg_13_0._lastFinishEpisodeId = var_13_0
end

function var_0_0._onUpdateRepressInfo(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0:checkIfNeedPlayEffect()
end

function var_0_0._playRuleRepressEffect(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1:getGroupId()
	local var_15_1 = Act183Model.instance:getGroupEpisodeMo(var_15_0)

	if not var_15_1 then
		return
	end

	local var_15_2 = arg_15_0:_getUnfinishSubEpisodes(var_15_1)

	if (var_15_2 and #var_15_2 or 0) <= 0 then
		return
	end

	local var_15_3 = arg_15_1:getConfigOrder()

	for iter_15_0, iter_15_1 in ipairs(var_15_2) do
		local var_15_4 = iter_15_1:getConfigOrder()

		arg_15_0:_showRepressEffect(arg_15_1, var_15_3, var_15_4)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Act183_EscapeRuleLineEffect)
end

function var_0_0._showRepressEffect(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = string.format("%s_%s", arg_16_2, arg_16_3)
	local var_16_1 = arg_16_0._orderToAnimTypeMap[var_16_0]
	local var_16_2 = arg_16_0:_getOrCreateLine(var_16_1)

	var_16_2.name = var_16_0
	arg_16_0._useLineEffectPool[var_16_1] = arg_16_0._useLineEffectPool[var_16_1] or arg_16_0:getUserDataTb_()

	table.insert(arg_16_0._useLineEffectPool[var_16_1], var_16_2)

	local var_16_3 = arg_16_0._episodeItemTab[arg_16_3]:getIconTran()
	local var_16_4, var_16_5 = recthelper.rectToRelativeAnchorPos2(var_16_3.position, arg_16_0._gomiddle.transform)

	gohelper.setActive(var_16_2, true)
	recthelper.setAnchor(var_16_2.transform, var_16_4, var_16_5)

	local var_16_6 = gohelper.findChild(var_16_2, "line1")
	local var_16_7 = gohelper.findChild(var_16_2, "line2")

	gohelper.setActive(var_16_6, arg_16_1:getRuleStatus(1) == Act183Enum.RuleStatus.Escape)
	gohelper.setActive(var_16_7, arg_16_1:getRuleStatus(2) == Act183Enum.RuleStatus.Escape)
end

function var_0_0._getUnfinishSubEpisodes(arg_17_0, arg_17_1)
	local var_17_0 = {}
	local var_17_1 = arg_17_1:getEpisodeMos()

	for iter_17_0, iter_17_1 in ipairs(var_17_1) do
		local var_17_2 = iter_17_1:getEpisodeType()
		local var_17_3 = iter_17_1:isFinished()

		if var_17_2 == Act183Enum.EpisodeType.Sub and not var_17_3 then
			table.insert(var_17_0, iter_17_1)
		end
	end

	return var_17_0
end

function var_0_0._getOrCreateLine(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._lineEffectPool[arg_18_1]

	if not var_18_0 then
		var_18_0 = arg_18_0:getUserDataTb_()
		arg_18_0._lineEffectPool[arg_18_1] = var_18_0
	end

	local var_18_1 = table.remove(var_18_0, 1)

	if not var_18_1 then
		local var_18_2 = arg_18_0._lineTemplateMap[arg_18_1]

		var_18_1 = gohelper.clone(var_18_2[1], arg_18_0._gomiddle, "line_" .. arg_18_1)

		local var_18_3 = var_18_2[2]
		local var_18_4 = var_18_2[3]
		local var_18_5 = var_18_2[4]

		transformhelper.setLocalRotation(var_18_1.transform, var_18_3, var_18_4, var_18_5)
	end

	return var_18_1
end

function var_0_0._recycleLines(arg_19_0)
	if arg_19_0._useLineEffectPool then
		for iter_19_0, iter_19_1 in pairs(arg_19_0._useLineEffectPool) do
			for iter_19_2 = #iter_19_1, 1, -1 do
				local var_19_0 = table.remove(iter_19_1, iter_19_2)

				gohelper.setActive(var_19_0, false)

				arg_19_0._lineEffectPool[iter_19_0] = arg_19_0._lineEffectPool[iter_19_0] or arg_19_0:getUserDataTb_()

				table.insert(arg_19_0._lineEffectPool[iter_19_0], var_19_0)
			end
		end
	end
end

function var_0_0._onCloseViewFinish(arg_20_0, arg_20_1)
	if arg_20_1 == arg_20_0.viewName then
		return
	end

	arg_20_0:checkIfNeedPlayEffect()
end

function var_0_0.checkIfNeedPlayGroupCategoryFinishAnim(arg_21_0)
	local var_21_0 = Act183Model.instance:getUnfinishTaskMap()

	if var_21_0 then
		for iter_21_0, iter_21_1 in pairs(var_21_0) do
			for iter_21_2 = #iter_21_1, 1, -1 do
				if Act183Helper.isTaskFinished(iter_21_1[iter_21_2]) then
					table.remove(iter_21_1, iter_21_2)
				end
			end

			if #iter_21_1 <= 0 then
				var_21_0[iter_21_0] = nil

				Act183Controller.instance:dispatchEvent(Act183Event.OnGroupAllTaskFinished, iter_21_0)
			end
		end
	end
end

function var_0_0.onClose(arg_22_0)
	arg_22_0:destroyFlow()
	arg_22_0:_lockScreen(false)
	Act183Model.instance:clearBattleFinishedInfo()
end

return var_0_0
