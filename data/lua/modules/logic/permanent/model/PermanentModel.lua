module("modules.logic.permanent.model.PermanentModel", package.seeall)

slot0 = class("PermanentModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0.localReadDic = {}
end

function slot0.getActivityDic(slot0)
	for slot6, slot7 in pairs(PermanentConfig.instance:getPermanentDic()) do
		if ActivityModel.instance:getActMO(slot6) then
			-- Nothing
		end
	end

	return {
		[slot6] = slot8
	}
end

function slot0.undateActivityInfo(slot0, slot1)
	if slot1 then
		-- Nothing
	else
		for slot7, slot8 in pairs(PermanentConfig.instance:getPermanentDic()) do
			if ActivityModel.instance:getActMO(slot7) and slot9:isOnline() then
				slot2[#slot2 + 1] = slot7
			end
		end
	end

	if #{
		slot1
	} > 0 then
		ActivityRpc.instance:sendGetActivityInfosWithParamRequest(slot2)
	end
end

function slot0.hasActivityOnline(slot0)
	for slot5, slot6 in pairs(slot0:getActivityDic()) do
		if slot6.online then
			return true
		end
	end

	return false
end

function slot0.setActivityLocalRead(slot0, slot1)
	slot0:_initLocalRead()

	if slot1 then
		slot0.localReadDic[tostring(slot1)] = true
	else
		for slot6, slot7 in pairs(slot0:getActivityDic()) do
			if not slot0.localReadDic[tostring(slot6)] then
				slot0.localReadDic[slot6] = true
			end
		end
	end

	slot0:_saveLocalRead()
end

function slot0.isActivityLocalRead(slot0, slot1)
	slot0:_initLocalRead()

	slot2 = slot0:getActivityDic()

	if not slot1 then
		for slot6, slot7 in pairs(slot2) do
			slot6 = tostring(slot6)

			if ActivityModel.instance:isActOnLine(slot6) and not slot0.localReadDic[slot6] then
				return false
			end
		end

		return true
	end

	return slot0.localReadDic[tostring(slot1)]
end

function slot0._initLocalRead(slot0)
	if next(slot0.localReadDic) then
		return
	end

	if not string.nilorempty(PlayerPrefsHelper.getString(PlayerPrefsKey.PermanentLocalRead .. PlayerModel.instance:getMyUserId())) then
		slot0.localReadDic = cjson.decode(slot2)
	end
end

function slot0._saveLocalRead(slot0)
	PlayerPrefsHelper.setString(PlayerPrefsKey.PermanentLocalRead .. PlayerModel.instance:getMyUserId(), cjson.encode(slot0.localReadDic))
end

slot0.instance = slot0.New()

return slot0
