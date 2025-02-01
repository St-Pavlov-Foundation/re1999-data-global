module("modules.logic.seasonver.act123.utils.Season123EquipLocalRecord", package.seeall)

slot0 = class("Season123EquipLocalRecord")

function slot0.init(slot0, slot1, slot2)
	slot0.activityId = slot1
	slot0.reasonKey = slot2
	slot0._list = nil
	slot0._dict = nil

	slot0:initLocalSave()
end

function slot0.initLocalSave(slot0)
	slot0._dict = {}

	if not string.nilorempty(PlayerPrefsHelper.getString(slot0:getLocalKey(), "")) then
		slot0._list = cjson.decode(slot1)

		for slot5, slot6 in ipairs(slot0._list) do
			slot0._dict[slot6] = 1
		end
	else
		slot0._list = {}
	end
end

function slot0.recordAllItem(slot0)
	for slot5, slot6 in pairs(Season123Model.instance:getAllUnlockAct123EquipIds(slot0.activityId) or {}) do
		slot0:add(slot5)
	end

	slot0:save()
end

function slot0.add(slot0, slot1)
	if not slot0._dict[slot1] then
		table.insert(slot0._list, slot1)

		slot0._dict[slot1] = 1
	end
end

function slot0.contain(slot0, slot1)
	return slot0._dict[slot1]
end

function slot0.save(slot0)
	PlayerPrefsHelper.setString(slot0:getLocalKey(), cjson.encode(slot0._list))
end

function slot0.getLocalKey(slot0)
	return tostring(slot0.reasonKey) .. "#" .. tostring(slot0.activityId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

return slot0
