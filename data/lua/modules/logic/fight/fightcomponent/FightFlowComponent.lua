module("modules.logic.fight.fightcomponent.FightFlowComponent", package.seeall)

slot0 = class("FightFlowComponent", FightBaseClass)

function slot0.onInitialization(slot0)
end

function slot0.registCustomFlow(slot0, slot1)
	return slot0:registClass(slot1)
end

function slot0.onDestructor(slot0)
end

return slot0
