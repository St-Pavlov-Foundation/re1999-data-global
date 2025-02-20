module("modules.logic.tower.view.fight.TowerHeroGroupListView", package.seeall)

slot0 = class("TowerHeroGroupListView", HeroGroupListView)

function slot0._getHeroItemCls(slot0)
	return TowerHeroGroupHeroItem
end

function slot0.onOpen(slot0)
	slot0:checkReplaceHeroList()
	uv0.super.onOpen(slot0)
end

function slot0.checkReplaceHeroList(slot0)
	if TowerModel.instance:getRecordFightParam().isHeroGroupLock then
		slot2 = slot1.heros or {}
		slot3 = slot1.assistBoss
		slot4 = {}

		for slot8 = 1, #slot2 do
			if HeroModel.instance:getByHeroId(slot2[slot8] or 0) then
				table.insert(slot4, slot9.uid)
			end
		end

		slot5 = HeroGroupModel.instance:getCurGroupMO()

		slot5:replaceTowerHeroList(slot4)
		slot5:setAssistBossId(slot3)
		HeroSingleGroupModel.instance:setSingleGroup(slot5)
	end
end

function slot0._checkRestrictHero(slot0)
	if TowerModel.instance:getRecordFightParam().isHeroGroupLock then
		return
	end

	slot2 = {}

	for slot6, slot7 in ipairs(slot0._heroItemList) do
		if slot7:checkTower() then
			table.insert(slot2, slot8)
		end
	end

	if #slot2 == 0 then
		return
	end

	UIBlockMgr.instance:startBlock("removeTowerHero")

	slot0._heroInCdList = slot2

	TaskDispatcher.runDelay(slot0._removeTowerHero, slot0, 1.5)
end

function slot0._removeTowerHero(slot0)
	UIBlockMgr.instance:endBlock("removeTowerHero")

	if not slot0._heroInCdList then
		return
	end

	slot0._heroInCdList = nil

	for slot5, slot6 in ipairs(slot0._heroInCdList) do
		HeroSingleGroupModel.instance:remove(slot6)
	end

	for slot5, slot6 in ipairs(slot0._heroItemList) do
		slot6:resetGrayFactor()
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
end

function slot0.canDrag(slot0, slot1, slot2)
	if not uv0.super.canDrag(slot0, slot1, slot2) then
		return false
	end

	return true
end

function slot0.onDestroyView(slot0)
	UIBlockMgr.instance:endBlock("removeTowerHero")
	TaskDispatcher.cancelTask(slot0._removeTowerHero, slot0)
	uv0.super.onDestroyView(slot0)
end

return slot0
