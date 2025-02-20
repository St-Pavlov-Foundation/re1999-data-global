module("modules.logic.fight.fightcomponent.FightObjItemListComponent", package.seeall)

slot0 = class("FightObjItemListComponent", FightBaseClass)

function slot0.onInitialization(slot0)
end

function slot0.registObjItemList(slot0, slot1, slot2, slot3, slot4)
	return slot0:registClass(FightObjItemListItem, slot1, slot2, slot3, slot4)
end

function slot0.registViewItemList(slot0, slot1, slot2, slot3, slot4)
	return slot0:registClass(FightViewItemListItem, slot1, slot2, slot3, slot4)
end

function slot0.onDestructor(slot0)
end

return slot0
