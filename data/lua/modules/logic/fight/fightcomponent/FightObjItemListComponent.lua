module("modules.logic.fight.fightcomponent.FightObjItemListComponent", package.seeall)

slot0 = class("FightObjItemListComponent", FightBaseClass)

function slot0.onConstructor(slot0)
end

function slot0.registObjItemList(slot0, slot1, slot2, slot3)
	return slot0:newClass(FightObjItemListItem, slot1, slot2, slot3)
end

function slot0.registViewItemList(slot0, slot1, slot2, slot3)
	return slot0:newClass(FightViewItemListItem, slot1, slot2, slot3)
end

function slot0.onDestructor(slot0)
end

return slot0
