module("modules.logic.seasonver.act123.utils.Season123LayerLocalRecord", package.seeall)

slot0 = class("Season123LayerLocalRecord")

function slot0.init(slot0, slot1)
	slot0.activityId = slot1
	slot0.reasonKey = PlayerPrefsKey.Season123LayerAnimAlreadyPlay
	slot0._localKey = slot0:getLocalKey()
	slot0._dict = nil

	slot0:initLocalSave()
end

function slot0.initLocalSave(slot0)
	if not string.nilorempty(PlayerPrefsHelper.getString(slot0._localKey, "")) then
		if cjson.decode(slot1) then
			slot0._dict = slot2
		else
			slot0._dict = {}
		end
	else
		slot0._dict = {}
	end
end

function slot0.add(slot0, slot1, slot2, slot3)
	if slot2 > (slot0._dict[slot1] or 0) then
		slot0._dict[slot1] = slot2

		slot0:save()
	end
end

function slot0.contain(slot0, slot1, slot2, slot3)
	return slot2 > (slot0._dict[slot1] or 0)
end

function slot0.save(slot0)
	PlayerPrefsHelper.setString(slot0._localKey, cjson.encode(slot0._dict))
end

function slot0.getLocalKey(slot0)
	return tostring(slot0.reasonKey) .. "#" .. tostring(slot0.activityId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

return slot0
