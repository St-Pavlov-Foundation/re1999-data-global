module("modules.logic.fight.view.FightViewClothSkillMgrView", package.seeall)

slot0 = class("FightViewClothSkillMgrView", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._heroSkillGO = gohelper.findChild(slot0.viewGO, "root/heroSkill")
	slot0._goSimple = gohelper.findChild(slot0._heroSkillGO, "#go_simple")
	slot0._rogueSkillRoot = gohelper.findChild(slot0.viewGO, "root/rogueSkillRoot")
	slot0._toughbattleRoot = gohelper.findChild(slot0.viewGO, "root/#go_charsupport")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.BeforeEnterStepBehaviour, slot0._onBeforeEnterStepBehaviour, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnRestartStageBefore, slot0._onRestartStage, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0.onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.onCloseView, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onOpenView(slot0, slot1)
	if slot1 == ViewName.FightEnemyActionView then
		gohelper.setActive(slot0._heroSkillGO, false)
	end
end

function slot0.onCloseView(slot0, slot1)
	if slot1 == ViewName.FightEnemyActionView then
		gohelper.setActive(slot0._heroSkillGO, true)
	end
end

function slot0._editableInitView(slot0)
end

function slot0._onRestartStage(slot0)
	slot0:killAllChildView()
end

function slot0._onBeforeEnterStepBehaviour(slot0)
	if slot0:getCurChapterType() == DungeonEnum.ChapterType.Rouge then
		gohelper.setActive(slot0._goSimple, false)
		slot0:openSubView(FightViewRougeSkill, "ui/viewres/rouge/fight/rougeheroskillview.prefab", slot0._rogueSkillRoot)

		return
	end

	if slot1 == DungeonEnum.ChapterType.ToughBattle then
		slot0:openSubView(FightToughBattleSkillView, "ui/viewres/fight/charsupportlist.prefab", slot0._toughbattleRoot)
	end

	slot0:openSubView(FightViewClothSkill, slot0.viewGO)
end

function slot0.getCurChapterType(slot0)
	if not FightModel.instance:getFightParam() then
		return
	end

	return DungeonConfig.instance:getChapterCO(slot1.chapterId) and slot3.type
end

function slot0.checkIsToughBattle(slot0)
	if not FightModel.instance:getFightParam() then
		return
	end

	if not DungeonConfig.instance:getChapterCO(slot1.chapterId) or slot3.type ~= DungeonEnum.ChapterType.ToughBattle then
		return
	end
end

function slot0.onRefreshViewParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
