module("modules.logic.reactivity.model.ReactivityModel", package.seeall)

slot0 = class("ReactivityModel", BaseModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.isReactivity(slot0, slot1)
	if not slot1 or slot1 <= 0 then
		return false
	end

	if not ActivityConfig.instance:getActivityCo(slot1) then
		return false
	end

	return slot2.isRetroAcitivity == 1
end

function slot0.getActivityCurrencyId(slot0, slot1)
	if ReactivityEnum.ActivityDefine[slot1] then
		return slot2.storeCurrency
	end

	for slot6, slot7 in pairs(ReactivityEnum.ActivityDefine) do
		if slot7.storeActId == slot1 then
			return slot7.storeCurrency
		end
	end
end

slot0.instance = slot0.New()

return slot0
