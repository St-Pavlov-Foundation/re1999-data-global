module("modules.logic.fight.view.FightCardDeckViewItem", package.seeall)

slot0 = class("FightCardDeckViewItem", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._cardObj = gohelper.findChild(slot0.viewGO, "card/card")
	slot0._select = gohelper.findChild(slot0.viewGO, "select")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onRefreshViewParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._cardObj, FightViewCardItem, FightEnum.CardShowType.Deck)
end

function slot0.refreshItem(slot0, slot1)
	slot0._data = slot1

	slot0._cardItem:updateItem(slot1.entityId, slot1.skillId, slot1)
end

function slot0.showCount(slot0, slot1)
	slot0._cardItem:showCountPart(slot1)
end

function slot0.setSelect(slot0, slot1)
	gohelper.setActive(slot0._select, slot1)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
