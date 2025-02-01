module("modules.logic.room.entity.comp.base.RoomBaseFollowPathComp", package.seeall)

slot0 = class("RoomBaseFollowPathComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
	slot0._tbFollowerList = {}
	slot0._tbPools = {}
	slot0._isMoveing = false
end

function slot0.addPathPos(slot0, slot1)
	for slot6 = #slot0._tbFollowerList, 1, -1 do
		if slot0._tbFollowerList[slot6].follower then
			slot7.follower:addPathPos(slot1)
		else
			slot0:_push(slot7)
			table.remove(slot0._tbFollowerList, slot6)
		end
	end
end

function slot0.addFollower(slot0, slot1)
	if slot0.__willDestroy or not slot1 or slot1:isWillDestory() then
		return
	end

	if not slot0:_findIndexOf(slot1) then
		table.insert(slot0._tbFollowerList, slot0:_pop(slot1))
		slot1:setFollowPath(slot0)
	end
end

function slot0.removeFollower(slot0, slot1)
	if slot1 and #slot0._tbFollowerList > 0 and tabletool.indexOf(slot0._tbFollowerList, slot1) then
		slot0._tbFollowerList[slot2].follower = nil

		slot1:clearFollowPath()
	end
end

function slot0._pop(slot0, slot1)
	slot2 = nil

	if #slot0._tbPools > 0 then
		slot2 = slot0._tbPools[#slot0._tbPools]

		table.remove(slot0._tbPools, #slot0._tbPools)
	else
		slot2 = {}
	end

	slot2.follower = slot1

	return slot2
end

function slot0._push(slot0, slot1)
	if slot1 then
		slot1.follower = nil

		table.insert(slot0._tbPools, slot1)
	end
end

function slot0._findIndexOf(slot0, slot1)
	for slot6 = 1, #slot0._tbFollowerList do
		if slot0._tbFollowerList[slot6].follower == slot1 then
			return slot6
		end
	end
end

function slot0.stopMove(slot0)
	for slot5 = #slot0._tbFollowerList, 1, -1 do
		if slot0._tbFollowerList[slot5].follower then
			slot6.follower:stopMove()
		else
			slot0:_push(slot6)
			table.remove(slot0._tbFollowerList, slot5)
		end
	end

	slot0._isMoveing = false

	slot0:onStopMove()
end

function slot0.moveByPathData(slot0)
	if not slot0._isMoveing then
		slot0._isMoveing = true

		slot0:onStartMove()
	end

	for slot5 = #slot0._tbFollowerList, 1, -1 do
		if slot0._tbFollowerList[slot5].follower then
			slot6.follower:moveByPathData()
		else
			slot0:_push(slot6)
			table.remove(slot0._tbFollowerList, slot5)
		end
	end
end

function slot0.getCount(slot0)
	return #slot0._tbFollowerList
end

function slot0.onStopMove(slot0)
end

function slot0.onStartMove(slot0)
end

function slot0.isWillDestory(slot0)
	return slot0.__willDestroy
end

function slot0.beforeDestroy(slot0)
	slot0.__willDestroy = true

	if slot0._tbFollowerList and #slot0._tbFollowerList > 0 then
		slot0._tbFollowerList = {}

		for slot5, slot6 in ipairs(slot0._tbFollowerList) do
			if slot6.follower then
				slot6.follower:clearFollowPath()
			end
		end
	end
end

return slot0
