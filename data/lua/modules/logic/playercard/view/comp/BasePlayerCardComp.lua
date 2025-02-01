module("modules.logic.playercard.view.comp.BasePlayerCardComp", package.seeall)

slot0 = class("BasePlayerCardComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	if slot1 then
		for slot5, slot6 in pairs(slot1) do
			slot0[slot5] = slot6
		end
	end
end

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0.goSelect = gohelper.setActive(slot1, "#go_select")

	slot0:setEditMode(false)
	slot0:onInitView()
end

function slot0.refreshView(slot0, slot1)
	slot0.cardInfo = slot1

	slot0:onRefreshView()
end

function slot0.isPlayerSelf(slot0)
	return slot0.cardInfo and slot0.cardInfo:isSelf()
end

function slot0.getPlayerInfo(slot0)
	return slot0.cardInfo and slot0.cardInfo:getPlayerInfo()
end

function slot0.onInitView(slot0)
end

function slot0.onRefreshView(slot0)
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.setEditMode(slot0, slot1)
	gohelper.setActive(slot0.goSelect, slot1)
end

return slot0
