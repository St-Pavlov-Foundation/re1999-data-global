module("modules.logic.voyage.model.VoyageModel", package.seeall)

slot0 = class("VoyageModel", Activity1001Model)

function slot0.reInit(slot0)
	uv0.super.reInit(slot0)

	slot1 = VoyageConfig.instance

	slot0:_internal_set_config(slot1)
	slot0:_internal_set_activity(slot1:getActivityId())
end

function slot0.hasAnyRewardAvailable(slot0)
	for slot4, slot5 in pairs(slot0.__id2StateDict) do
		if slot5 == VoyageEnum.State.Available then
			return true
		end
	end

	return false
end

slot0.instance = slot0.New()

return slot0
