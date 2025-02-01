module("modules.logic.seasonver.act123.utils.Season123UnlockLocalRecord", package.seeall)

slot0 = class("Season123UnlockLocalRecord")

function slot0.init(slot0, slot1, slot2)
	slot0.activityId = slot1
	slot0.reasonKey = slot2
	slot0._localKey = slot0:getLocalKey()
	slot0._dict = nil
	slot0._moduleSet = {}

	slot0:initLocalSave()
end

function slot0.initLocalSave(slot0)
	if string.nilorempty(slot0._localKey) then
		return
	end

	if not string.nilorempty(PlayerPrefsHelper.getString(slot0._localKey, "")) then
		if cjson.decode(slot1) then
			slot0._dict = slot2

			for slot6, slot7 in pairs(slot2) do
				slot0._moduleSet[slot6] = {}

				for slot11, slot12 in ipairs(slot7) do
					slot0._moduleSet[slot6][slot12] = true
				end
			end
		else
			slot0._dict = {}
		end
	else
		slot0._dict = {}
	end
end

function slot0.add(slot0, slot1, slot2)
	if string.nilorempty(slot0._localKey) then
		return
	end

	slot0._moduleSet[slot2] = slot0._moduleSet[slot2] or {}

	if not slot0._moduleSet[slot2][slot1] then
		slot0._moduleSet[slot2][slot1] = true
		slot0._dict[slot2] = slot0._dict[slot2] or {}

		table.insert(slot0._dict[slot2], slot1)
		slot0:save()
	end
end

function slot0.contain(slot0, slot1, slot2)
	if string.nilorempty(slot0._localKey) then
		return false
	end

	return slot0._moduleSet[slot2] and slot0._moduleSet[slot2][slot1]
end

function slot0.save(slot0)
	if string.nilorempty(slot0._localKey) then
		return
	end

	PlayerPrefsHelper.setString(slot0._localKey, cjson.encode(slot0._dict))
end

function slot0.getLocalKey(slot0)
	return tostring(slot0.reasonKey) .. "#" .. tostring(slot0.activityId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

return slot0
