module("modules.logic.social.model.SocialListModel", package.seeall)

slot0 = class("SocialListModel")

function slot0.ctor(slot0)
	slot0._models = {}
end

function slot0.reInit(slot0)
	for slot4, slot5 in pairs(slot0._models) do
		slot5:clear()
	end
end

function slot0.getModel(slot0, slot1)
	if not slot0._models[slot1] then
		slot0._models[slot1] = ListScrollModel.New()
	end

	return slot0._models[slot1]
end

function slot0.setModelList(slot0, slot1, slot2)
	slot3 = slot0:getModel(slot1)
	slot4 = {}

	if slot2 then
		for slot8, slot9 in pairs(slot2) do
			table.insert(slot4, slot9)
		end
	end

	if slot1 == SocialEnum.Type.Friend then
		table.sort(slot4, uv0.sortFriend)
	else
		table.sort(slot4, uv0.sort)
	end

	slot3:setList(slot4)
end

function slot0.sortFriendList(slot0)
	slot0:getModel(SocialEnum.Type.Friend):sort(uv0.sortFriend)
end

function slot0.sortFriend(slot0, slot1)
	slot3 = SocialMessageModel.instance:getUnReadLastMsgTime(slot1.userId)

	if SocialMessageModel.instance:getUnReadLastMsgTime(slot0.userId) ~= 0 and slot3 ~= 0 then
		return slot3 < slot2
	elseif slot2 ~= 0 or slot3 ~= 0 then
		return slot2 ~= 0
	else
		return uv0.sort(slot0, slot1)
	end
end

function slot0.sort(slot0, slot1)
	if tonumber(slot0.time) == 0 and tonumber(slot1.time) ~= 0 then
		return true
	elseif slot3 == 0 and slot2 ~= 0 then
		return false
	end

	if slot3 < slot2 then
		return true
	elseif slot2 < slot3 then
		return false
	end

	if slot1.level < slot0.level then
		return true
	elseif slot0.level < slot1.level then
		return false
	end

	if tonumber(slot0.userId) < tonumber(slot1.userId) then
		return true
	elseif tonumber(slot1.userId) < tonumber(slot0.userId) then
		return false
	end

	return false
end

slot0.instance = slot0.New()

return slot0
