module("modules.logic.fight.fightcomponent.FightSequenceAutoWorkComponent", package.seeall)

slot0 = class("FightSequenceAutoWorkComponent", FightBaseClass)

function slot0.onInitialization(slot0)
	slot0._item = slot0:registClass(FightSequenceAutoWorkItem)
end

function slot0.registAutoWork(slot0, slot1, ...)
	return slot0._item:registAutoWork(slot1, ...)
end

function slot0.playAutoWork(slot0, slot1)
	return slot0._item:playAutoWork(slot1)
end

function slot0.registAutoSequence(slot0)
	return slot0:registClass(FightSequenceAutoWorkItem)
end

function slot0.onDestructor(slot0)
end

return slot0
