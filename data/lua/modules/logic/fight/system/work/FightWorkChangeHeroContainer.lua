module("modules.logic.fight.system.work.FightWorkChangeHeroContainer", package.seeall)

slot0 = class("FightWorkChangeHeroContainer", FightStepEffectFlow)

function slot0.onStart(slot0)
	for slot7, slot8 in ipairs(slot0:getAdjacentSameEffectList(nil, true)) do
		slot0:com_registWorkDoneFlowSequence():registWork(FightWorkFlowParallel):registWork(FightStepBuilder.ActEffectWorkCls[slot8.effect.effectType], slot8.stepMO, slot8.effect)
	end

	slot2:registWork(FightWorkFocusMonsterAfterChangeHero)
	slot2:start()
end

function slot0._showSubEntity(slot0)
	GameSceneMgr.instance:getCurScene().entityMgr:showSubEntity()
end

function slot0.clearWork(slot0)
end

return slot0
