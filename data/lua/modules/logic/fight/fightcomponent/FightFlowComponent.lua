module("modules.logic.fight.fightcomponent.FightFlowComponent", package.seeall)

slot0 = class("FightFlowComponent", FightBaseClass)

function slot0.onConstructor(slot0)
end

function slot0.registCustomFlow(slot0, slot1)
	return slot0:newClass(slot1)
end

function slot0.onDestructor(slot0)
end

return slot0
