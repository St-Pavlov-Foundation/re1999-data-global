module("modules.logic.voyage.model.Activity1001Model", package.seeall)

slot0 = class("Activity1001Model", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0.__activityId = false
	slot0.__config = false
	slot0.__id2StateDict = {}
end

function slot0._internal_set_activity(slot0, slot1)
	slot0.__activityId = slot1
end

function slot0._internal_set_config(slot0, slot1)
	assert(isTypeOf(slot1, Activity1001Config), debug.traceback())

	slot0.__config = slot1
end

function slot0.getConfig(slot0)
	return assert(slot0.__config, "pleaes call self:_internal_set_config(config) first")
end

function slot0._updateInfo(slot0, slot1)
	slot0.__id2StateDict[slot1.id] = slot1.state
end

function slot0.onReceiveAct1001GetInfoReply(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.act1001Infos) do
		slot0:_updateInfo(slot6)
	end
end

function slot0.onReceiveAct1001UpdatePush(slot0, slot1)
	slot0:_updateInfo(slot1)
end

function slot0.getStateById(slot0, slot1)
	return slot0.__id2StateDict[slot1] or VoyageEnum.State.None
end

return slot0
