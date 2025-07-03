module("modules.logic.fight.view.FightViewClothSkillMgrView", package.seeall)

local var_0_0 = class("FightViewClothSkillMgrView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._heroSkillGO = gohelper.findChild(arg_1_0.viewGO, "root/heroSkill")
	arg_1_0._goSimple = gohelper.findChild(arg_1_0._heroSkillGO, "#go_simple")
	arg_1_0._rogueSkillRoot = gohelper.findChild(arg_1_0.viewGO, "root/rogueSkillRoot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.BeforeEnterStepBehaviour, arg_2_0._onBeforeEnterStepBehaviour, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnRestartStageBefore, arg_2_0._onRestartStage, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0.onOpenView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0.onCloseView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onOpenView(arg_4_0, arg_4_1)
	if arg_4_1 == ViewName.FightEnemyActionView then
		gohelper.setActive(arg_4_0._heroSkillGO, false)
	end
end

function var_0_0.onCloseView(arg_5_0, arg_5_1)
	if arg_5_1 == ViewName.FightEnemyActionView then
		gohelper.setActive(arg_5_0._heroSkillGO, true)
	end
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0._onRestartStage(arg_7_0)
	arg_7_0:killAllChildView()
end

function var_0_0._onBeforeEnterStepBehaviour(arg_8_0)
	local var_8_0 = arg_8_0:getCurChapterType()

	if var_8_0 == DungeonEnum.ChapterType.Rouge then
		gohelper.setActive(arg_8_0._goSimple, false)
		arg_8_0:openSubView(FightViewRougeSkill, "ui/viewres/rouge/fight/rougeheroskillview.prefab", arg_8_0._rogueSkillRoot)

		return
	end

	if var_8_0 == DungeonEnum.ChapterType.ToughBattle then
		local var_8_1 = arg_8_0.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.CharSupport)

		arg_8_0:openSubView(FightToughBattleSkillView, "ui/viewres/fight/charsupportlist.prefab", var_8_1)
		arg_8_0.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.CharSupport)
	end

	arg_8_0:openSubView(FightViewClothSkill, arg_8_0.viewGO)
end

function var_0_0.getCurChapterType(arg_9_0)
	local var_9_0 = FightModel.instance:getFightParam()

	if not var_9_0 then
		return
	end

	local var_9_1 = var_9_0.chapterId
	local var_9_2 = DungeonConfig.instance:getChapterCO(var_9_1)

	return var_9_2 and var_9_2.type
end

function var_0_0.checkIsToughBattle(arg_10_0)
	local var_10_0 = FightModel.instance:getFightParam()

	if not var_10_0 then
		return
	end

	local var_10_1 = var_10_0.chapterId
	local var_10_2 = DungeonConfig.instance:getChapterCO(var_10_1)

	if not var_10_2 or var_10_2.type ~= DungeonEnum.ChapterType.ToughBattle then
		return
	end
end

function var_0_0.onRefreshViewParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	return
end

function var_0_0.onClose(arg_13_0)
	return
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0
