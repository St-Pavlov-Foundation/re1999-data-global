module("modules.logic.bossrush.model.v2a1.BossRushEnhanceRoleViewListModel", package.seeall)

slot0 = class("BossRushEnhanceRoleViewListModel", ListScrollModel)

function slot0.setListData(slot0)
	if BossRushConfig.instance:getActRoleEnhance() then
		slot2 = {}
		slot3 = 0

		for slot7, slot8 in pairs(slot1) do
			slot9 = {
				characterId = slot8.characterId,
				sort = slot8.sort
			}

			if slot8.sort == 1 then
				slot3 = slot8.characterId
			end

			table.insert(slot2, slot9)
		end

		table.sort(slot2, slot0.sort)
		slot0:setList(slot2)

		if slot3 ~= 0 then
			slot0:setSelect(slot3)
		end
	end
end

function slot0.sort(slot0, slot1)
	return slot0.sort < slot1.sort
end

function slot0.clearSelect(slot0)
	for slot4, slot5 in ipairs(slot0._scrollViews) do
		slot5:setSelect(nil)
	end

	slot0._selectHeroId = nil
end

function slot0._refreshSelect(slot0)
	slot1 = nil

	for slot6, slot7 in ipairs(slot0:getList()) do
		if slot7.characterId == slot0._selectHeroId then
			slot1 = slot7
		end
	end

	for slot6, slot7 in ipairs(slot0._scrollViews) do
		slot7:setSelect(slot1)
	end
end

function slot0.setSelect(slot0, slot1)
	slot0._selectHeroId = slot1

	slot0:_refreshSelect()
	BossRushController.instance:dispatchEvent(BossRushEvent.OnSelectEnhanceRole, slot1)
end

function slot0.getSelectHeroId(slot0)
	return slot0._selectHeroId
end

slot0.instance = slot0.New()

return slot0
