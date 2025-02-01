module("modules.logic.playercard.view.comp.PlayerCardAssit", package.seeall)

slot0 = class("PlayerCardAssit", BasePlayerCardComp)

function slot0.onInitView(slot0)
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(PlayerController.instance, PlayerEvent.SetShowHero, slot0.onRefreshView, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0:removeEventCb(PlayerController.instance, PlayerEvent.SetShowHero, slot0.onRefreshView, slot0)
end

function slot0.onRefreshView(slot0)
	slot0:_initPlayerShowCard(slot0:getPlayerInfo().showHeros)
end

function slot0._initPlayerShowCard(slot0, slot1)
	for slot5 = 1, 3 do
		slot0:getOrCreateItem(slot5):setData(slot1[slot5], slot0:isPlayerSelf(), slot0.compType)
	end
end

function slot0.getOrCreateItem(slot0, slot1)
	if not slot0.items then
		slot0.items = {}
	end

	if not slot0.items[slot1] then
		slot0.items[slot1] = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.findChild(slot0.viewGO, "layout/#go_assithero" .. slot1), PlayerCardAssitItem)
	end

	return slot2
end

function slot0.onDestroy(slot0)
end

return slot0
