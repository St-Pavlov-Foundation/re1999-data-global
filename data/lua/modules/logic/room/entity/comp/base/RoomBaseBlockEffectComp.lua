module("modules.logic.room.entity.comp.base.RoomBaseBlockEffectComp", package.seeall)

slot0 = class("RoomBaseBlockEffectComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
	slot0.delayTaskTime = 0.1
	slot0._effectKeyDict = {}
	slot0._allEffectKeyList = {}
	slot0._effectPrefixKey = slot0.__cname
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.onBeforeDestroy(slot0)
end

function slot0.onRunDelayTask(slot0)
end

function slot0.removeParamsAndPlayAnimator(slot0, slot1, slot2, slot3)
	slot4 = slot0.entity.effect

	if slot3 then
		for slot8 = 1, #slot1 do
			slot4:playEffectAnimator(slot1[slot8], slot2)
		end
	end

	slot4:removeParams(slot1, slot3)
end

function slot0.getEffectKeyById(slot0, slot1)
	if not slot0._effectKeyDict[slot1] then
		slot2 = slot0:formatEffectKey(slot1)
		slot0._effectKeyDict[slot1] = slot2

		table.insert(slot0._allEffectKeyList, slot2)
	end

	return slot0._effectKeyDict[slot1]
end

function slot0.formatEffectKey(slot0, slot1)
	return string.format("%s_%s", slot0._effectPrefixKey, slot1)
end

function slot0.startWaitRunDelayTask(slot0)
	if not slot0.__hasWaitRunDelayTask_ then
		slot0.__hasWaitRunDelayTask_ = true

		TaskDispatcher.runDelay(slot0.__onWaitRunDelayTask_, slot0, math.max(0.001, tonumber(slot0.delayTaskTime or 0.001)))
	end
end

function slot0.__onWaitRunDelayTask_(slot0)
	slot0.__hasWaitRunDelayTask_ = false

	if not slot0:isWillDestory() then
		slot0:onRunDelayTask()
	end
end

function slot0.isWillDestory(slot0)
	return slot0.__willDestroy
end

function slot0.beforeDestroy(slot0)
	slot0.__willDestroy = true
	slot0.__hasWaitRunDelayTask_ = false

	TaskDispatcher.cancelTask(slot0.__onWaitRunDelayTask_, slot0)
	slot0:onBeforeDestroy()
end

return slot0
