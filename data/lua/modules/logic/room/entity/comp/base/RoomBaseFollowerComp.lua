module("modules.logic.room.entity.comp.base.RoomBaseFollowerComp", package.seeall)

slot0 = class("RoomBaseFollowerComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
	slot0._isMoveing = false
end

function slot0.init(slot0, slot1)
end

function slot0.getFollowPathData(slot0)
	if not slot0._followPathData then
		slot0._followPathData = RoomVehicleFollowPathData.New()
	end

	return slot0._followPathData
end

function slot0.setFollowPath(slot0, slot1)
	if slot0._followPathComp == slot1 then
		return
	end

	if slot0._followPathComp then
		slot0._followPathComp:removeFollower(slot0)

		slot0._followPathComp = nil
	end

	if slot1 then
		slot1:addFollower(slot0)

		slot0._followPathComp = slot1
	end

	slot0:stopMove()
end

function slot0.clearFollowPath(slot0)
	slot0:setFollowPath(nil)
end

function slot0.stopMove(slot0)
	if slot0._isMoveing then
		slot0._isMoveing = false

		slot0:onStopMove()
	end
end

function slot0.moveByPathData(slot0)
	if slot0.__willDestroy or not slot0._followPathComp or slot0._followPathComp:isWillDestory() then
		return
	end

	if not slot0._isMoveing then
		slot0._isMoveing = true

		slot0:onStartMove()
	end

	slot0:onMoveByPathData(slot0:getFollowPathData())
end

function slot0.addPathPos(slot0, slot1)
	if not slot0.__willDestroy then
		slot0:getFollowPathData():addPathPos(slot1)
	end
end

function slot0.onMoveByPathData(slot0, slot1)
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

	slot0:clearFollowPath()
end

return slot0
