module("modules.logic.fight.entity.comp.skill.FightTLEventRefreshRenderOrder", package.seeall)

slot0 = class("FightTLEventRefreshRenderOrder")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot6 = FightHelper.getDefenders(slot1, true)

	for slot10, slot11 in ipairs(FightHelper.getSideEntitys(FightHelper.getEntity(slot1.fromId):getSide(), true)) do
		FightRenderOrderMgr.instance:cancelOrder(slot11.id)
	end

	slot7 = tonumber(slot3[1])

	FightRenderOrderMgr.instance:setSortType(slot7)

	if slot7 == FightEnum.RenderOrderType.ZPos then
		slot0._keepOrderPriorityDict = {
			[slot4.id] = 0
		}

		for slot11, slot12 in ipairs(slot6) do
			slot0._keepOrderPriorityDict[slot12.id] = 1
		end

		TaskDispatcher.runRepeat(slot0._refreshOrder, slot0, tonumber(slot3[2]) or 0.33)
	end
end

function slot0.reset(slot0)
	slot0._keepOrderPriorityDict = nil

	TaskDispatcher.cancelTask(slot0._refreshOrder, slot0)
end

function slot0.dispose(slot0)
	slot0._keepOrderPriorityDict = nil

	TaskDispatcher.cancelTask(slot0._refreshOrder, slot0)
end

function slot0._refreshOrder(slot0)
	FightRenderOrderMgr.instance:refreshRenderOrder(slot0._keepOrderPriorityDict)
end

return slot0
