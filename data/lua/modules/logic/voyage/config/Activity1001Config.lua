module("modules.logic.voyage.config.Activity1001Config", package.seeall)

slot0 = class("Activity1001Config", BaseConfig)

function slot0.ctor(slot0, slot1)
	slot0.__activityId = slot1
end

function slot0.checkActivityId(slot0, slot1)
	return slot0.__activityId == slot1
end

function slot0.getActivityId(slot0)
	return slot0.__activityId
end

function slot0.reqConfigNames(slot0)
	return {
		"activity1001",
		"activity1001_ext",
		"mail"
	}
end

function slot1(slot0, slot1, slot2)
	if not slot2 then
		return lua_activity1001_ext.configDict[slot0][slot1]
	end

	return lua_activity1001_ext.configDict[slot0] and slot3[slot1] or nil
end

function slot2(slot0, slot1)
	return lua_activity1001.configDict[slot0][slot1]
end

function slot0.getCO(slot0, slot1)
	return uv0(slot0.__activityId, slot1, true) or uv1(slot0.__activityId, slot1)
end

function slot0.getRewardStr(slot0, slot1)
	if slot0:getCO(slot1).mailId then
		return lua_mail.configDict[slot2.mailId].attachment
	else
		return slot2.rewards
	end
end

function slot0.getTitle(slot0)
	for slot5, slot6 in pairs(lua_activity1001_ext.configDict[slot0.__activityId]) do
		if not string.nilorempty(slot6.title) then
			return slot6.title
		end
	end

	return ""
end

function slot0._createOrGetShowTaskList(slot0)
	if slot0.__taskList then
		return slot0.__taskList
	end

	for slot5, slot6 in ipairs(lua_activity1001.configList) do
		if slot6.activityId == slot0.__activityId then
			table.insert({}, slot6)
		end
	end

	for slot5, slot6 in ipairs(lua_activity1001_ext.configList) do
		if slot6.activityId == slot0.__activityId then
			table.insert(slot1, slot6)
		end
	end

	table.sort(slot1, function (slot0, slot1)
		if slot0.sort ~= slot1.sort then
			return slot0.sort < slot1.sort
		end

		return slot0.id < slot1.id
	end)

	slot0.__taskList = slot1

	return slot1
end

return slot0
