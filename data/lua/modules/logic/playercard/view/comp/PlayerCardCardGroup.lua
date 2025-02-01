module("modules.logic.playercard.view.comp.PlayerCardCardGroup", package.seeall)

slot0 = class("PlayerCardCardGroup", BasePlayerCardComp)

function slot0.onInitView(slot0)
	slot0.items = {}

	for slot4 = 1, 4 do
		slot0.items[slot4] = slot0:createItem(slot4)
	end
end

function slot0.createItem(slot0, slot1)
	return MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.clone(slot0.itemRes, gohelper.findChild(slot0.viewGO, "#go_card"), tostring(slot1)), PlayerCardCardItem, {
		index = slot1,
		compType = slot0.compType
	})
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.onRefreshView(slot0)
	for slot5, slot6 in ipairs(slot0.items) do
		slot6:refreshView(slot0.cardInfo, PlayerCardConfig.instance:getCardConfig(slot0.cardInfo:getCardData()[slot5]))
	end

	slot2 = not slot0:isSingle()

	slot0.items[3]:setVisible(slot2)
	slot0.items[4]:setVisible(slot2)
end

function slot0.isSingle(slot0)
	if not slot0.cardInfo then
		return
	end

	return slot0.cardInfo:getCardData() and #slot1 < 3
end

function slot0.onDestroy(slot0)
end

return slot0
