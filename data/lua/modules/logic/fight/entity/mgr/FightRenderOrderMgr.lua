module("modules.logic.fight.entity.mgr.FightRenderOrderMgr", package.seeall)

slot0 = class("FightRenderOrderMgr")
slot0.MaxOrder = 20 * FightEnum.OrderRegion
slot0.MinOrder = 0
slot0.LYEffect = 1
slot0.AssistBossOrder = 2
slot0.MinSpecialOrder = 2

function slot0.init(slot0)
	slot0._registIdList = {}
	slot0._entityId2OrderSort = {}
	slot0._entityId2OrderFixed = {}
	slot0._entityId2WrapList = {}
	slot0._renderOrderType = FightEnum.RenderOrderType.StandPos
	slot0._entityMgr = GameSceneMgr.instance:getScene(SceneType.Fight).entityMgr
end

function slot0.setSortType(slot0, slot1)
	slot0._renderOrderType = slot1

	slot0:refreshRenderOrder()
end

function slot0.refreshRenderOrder(slot0, slot1)
	slot5 = slot1
	slot0._entityId2OrderSort = uv0.sortOrder(slot0._renderOrderType, slot0._registIdList, slot5)

	for slot5, slot6 in ipairs(slot0._registIdList) do
		slot0:_resetRenderOrder(slot6)
	end
end

function slot0.dispose(slot0)
	slot0._registIdList = nil
	slot0._entityId2OrderSort = nil
	slot0._entityId2OrderFixed = nil
	slot0._entityId2WrapList = nil

	TaskDispatcher.cancelTask(slot0.refreshRenderOrder, slot0)
end

function slot0.register(slot0, slot1)
	TaskDispatcher.cancelTask(slot0.refreshRenderOrder, slot0)
	TaskDispatcher.runDelay(slot0.refreshRenderOrder, slot0, 0.1)
	table.insert(slot0._registIdList, slot1)
end

function slot0.unregister(slot0, slot1)
	if slot0._registIdList then
		tabletool.removeValue(slot0._registIdList, slot1)
	end

	if slot0._entityId2OrderFixed then
		slot0._entityId2OrderFixed[slot1] = nil
	end
end

function slot0.onAddEffectWrap(slot0, slot1, slot2)
	if not slot0._entityId2WrapList then
		return
	end

	if not slot0._entityId2WrapList[slot1] then
		slot0._entityId2WrapList[slot1] = {}
	end

	table.insert(slot0._entityId2WrapList[slot1], slot2)
	slot2:setRenderOrder(slot0:getOrder(slot1))
end

function slot0.addEffectWrapByOrder(slot0, slot1, slot2, slot3)
	if not slot0._entityId2WrapList then
		return
	end

	if not slot0._entityId2WrapList[slot1] then
		slot0._entityId2WrapList[slot1] = {}
	end

	table.insert(slot0._entityId2WrapList[slot1], slot2)
	slot2:setRenderOrder(slot3 or FightEnum.OrderRegion)
end

function slot0.onRemoveEffectWrap(slot0, slot1, slot2)
	if slot0._entityId2WrapList and slot0._entityId2WrapList[slot1] then
		tabletool.removeValue(slot0._entityId2WrapList[slot1], slot2)
	end

	slot2:setRenderOrder(0)
end

function slot0.setEffectOrder(slot0, slot1, slot2)
	slot1:setRenderOrder(slot2 * FightEnum.OrderRegion)
end

function slot0.setOrder(slot0, slot1, slot2)
	slot0._entityId2OrderFixed[slot1] = slot2

	slot0:_resetRenderOrder(slot1)
end

function slot0.cancelOrder(slot0, slot1)
	if slot0._entityId2OrderFixed and slot0._entityId2OrderFixed[slot1] then
		slot0._entityId2OrderFixed[slot1] = nil

		slot0:_resetRenderOrder(slot1)
	end
end

function slot0._resetRenderOrder(slot0, slot1)
	if slot0._entityMgr:getEntity(slot1) then
		slot3:setRenderOrder(slot0:getOrder(slot1))
	end

	if slot0._entityId2WrapList[slot1] then
		for slot8, slot9 in ipairs(slot4) do
			slot9:setRenderOrder(slot2)
		end
	end
end

function slot0.getOrder(slot0, slot1)
	slot2 = 1

	if slot0._entityId2OrderFixed[slot1] then
		slot2 = slot0._entityId2OrderFixed[slot1]
	elseif slot0._entityId2OrderSort[slot1] then
		slot2 = slot0._entityId2OrderSort[slot1]
	end

	return slot2 * FightEnum.OrderRegion
end

function slot0.sortOrder(slot0, slot1, slot2)
	if slot0 == FightEnum.RenderOrderType.SameOrder then
		return {}
	end

	slot4 = {}

	for slot8, slot9 in ipairs(slot1) do
		slot10 = FightHelper.getEntity(slot9)
		slot11 = nil

		if slot2 and slot2[slot9] then
			slot11 = slot2[slot9]
		end

		if slot10 then
			if slot0 == FightEnum.RenderOrderType.StandPos then
				slot12, slot13, slot14 = FightHelper.getEntityStandPos(slot10:getMO())

				table.insert(slot4, {
					slot9,
					slot14,
					slot11
				})
			elseif slot0 == FightEnum.RenderOrderType.ZPos then
				slot12, slot13, slot14 = transformhelper.getPos(slot10.go.transform)

				table.insert(slot4, {
					slot9,
					slot14,
					slot11
				})
			end
		end
	end

	table.sort(slot4, function (slot0, slot1)
		if slot0[2] ~= slot1[2] then
			return slot1[2] < slot0[2]
		elseif slot0[3] and slot1[3] and slot0[3] ~= slot1[3] then
			return slot1[3] < slot0[3]
		else
			return tonumber(slot0[1]) < tonumber(slot1[1])
		end
	end)

	slot5 = 1

	for slot9, slot10 in ipairs(slot4) do
		slot3[slot10[1]] = slot5
		slot5 = slot5 + 1
	end

	for slot10, slot11 in pairs(slot3) do
		if FightHelper.isAssembledMonster(FightHelper.getEntity(slot10)) then
			slot3[slot10] = nil or slot11
		end
	end

	for slot11, slot12 in pairs(slot3) do
		slot3[slot11] = slot12 + uv0.MinSpecialOrder
	end

	for slot11, slot12 in pairs(slot3) do
		if FightDataHelper.entityMgr:isAssistBoss(slot11) then
			slot3[slot11] = uv0.AssistBossOrder
		end
	end

	return slot3
end

slot0.instance = slot0.New()

return slot0
