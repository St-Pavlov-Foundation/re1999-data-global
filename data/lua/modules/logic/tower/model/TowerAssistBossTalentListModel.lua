module("modules.logic.tower.model.TowerAssistBossTalentListModel", package.seeall)

slot0 = class("TowerAssistBossTalentListModel", ListScrollModel)

function slot0.initBoss(slot0, slot1)
	slot0.bossId = slot1
	slot0.selectTalentId = nil
end

function slot0.refreshList(slot0)
	if #slot0._scrollViews == 0 then
		return
	end

	if not TowerAssistBossModel.instance:getById(slot0.bossId) then
		return
	end

	slot0:setList(slot1:getTalentTree():getList())
end

function slot0.getSelectTalent(slot0)
	return slot0.selectTalentId
end

function slot0.isSelectTalent(slot0, slot1)
	return slot0.selectTalentId == slot1
end

function slot0.setSelectTalent(slot0, slot1)
	if slot0:isSelectTalent(slot1) then
		return
	end

	slot0.selectTalentId = slot1

	slot0:refreshList()
	TowerController.instance:dispatchEvent(TowerEvent.SelectTalentItem)
end

function slot0.isTalentCanReset(slot0, slot1, slot2)
	if not (slot1 or slot0.selectTalentId) then
		return false
	end

	if not TowerAssistBossModel.instance:getById(slot0.bossId):isActiveTalent(slot1) then
		return false
	end

	if not slot3:getTalentTree():getNode(slot1) then
		return false
	end

	if not slot5:isLeafNode() then
		return false
	end

	return true
end

slot0.instance = slot0.New()

return slot0
