module("modules.logic.fight.fightcomponent.FightViewItemListItem", package.seeall)

slot0 = class("FightViewItemListItem", FightObjItemListItem)

function slot0.newItem(slot0)
	slot1 = uv0.super.newItem(slot0)
	slot3 = slot0.PARENT_ROOT_CLASS.PARENT_ROOT_CLASS
	slot1.viewName = slot3.viewName
	slot1.viewContainer = slot3.viewContainer
	slot1.PARENT_VIEW = slot3
	slot1.viewGO = slot1.keyword_gameObject

	slot1:inner_startView()

	return slot1
end

return slot0
