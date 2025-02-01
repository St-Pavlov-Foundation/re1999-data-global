module("modules.logic.scene.room.compwork.FlowSequenceRoom", package.seeall)

slot0 = class("FlowSequenceRoom", FlowSequence)

function slot0._runNext(slot0)
	if slot0._workList[slot0._curIndex + 1] then
		if isTypeOf(slot1, RoomSceneCommonCompWork) then
			RoomHelper.logElapse("++++++ " .. slot1.__cname .. " " .. slot1._comp.__cname, 0.001)
		elseif isTypeOf(slot1, RoomSceneWaitEventCompWork) then
			RoomHelper.logElapse("++++++ " .. slot1.__cname .. " " .. slot1._comp.__cname, 0.001)
		else
			RoomHelper.logElapse("++++++ " .. slot1.__cname, 0.001)
		end
	end

	uv0.super._runNext(slot0)
end

function slot0.onWorkDone(slot0, slot1)
	if isTypeOf(slot1, RoomSceneCommonCompWork) then
		RoomHelper.logElapse("-------- " .. slot1.__cname .. " " .. slot1._comp.__cname, 0.001)
	elseif isTypeOf(slot1, RoomSceneWaitEventCompWork) then
		RoomHelper.logElapse("-------- " .. slot1.__cname .. " " .. slot1._comp.__cname, 0.001)
	else
		RoomHelper.logElapse("-------- " .. slot1.__cname, 0.001)
	end

	uv0.super.onWorkDone(slot0, slot1)
end

return slot0
