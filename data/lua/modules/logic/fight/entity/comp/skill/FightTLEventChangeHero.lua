module("modules.logic.fight.entity.comp.skill.FightTLEventChangeHero", package.seeall)

slot0 = class("FightTLEventChangeHero")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot0._fightStepMO = slot1
end

function slot0.reset(slot0)
	slot0:dispose()
end

function slot0.dispose(slot0)
end

function slot0.onSkillEnd(slot0)
	FightController.instance:dispatchEvent(FightEvent.OnChangeHeroEnd, slot0._fightStepMO.fromId, slot0._fightStepMO.toId)
end

function slot0.endChangeHero(slot0)
	FightController.instance:dispatchEvent(FightEvent.OnChangeHeroEnd, slot0._fightStepMO.fromId, slot0._fightStepMO.toId)
end

return slot0
