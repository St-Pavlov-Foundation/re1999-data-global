module("modules.logic.scene.room.compwork.FlowParallelRoom", package.seeall)

slot0 = class("FlowParallelRoom", FlowParallel)

function slot0.onStartInternal(slot0, slot1)
	if #slot0._workList == 0 then
		slot0:onDone(true)

		return
	end

	slot0._doneCount = 0
	slot0._succCount = 0

	for slot5, slot6 in ipairs(slot0._workList) do
		if isTypeOf(slot6, RoomSceneCommonCompWork) then
			RoomHelper.logElapse("++++++ " .. slot6.__cname .. " " .. slot6._comp.__cname, 0.001)
		elseif isTypeOf(slot6, RoomSceneWaitEventCompWork) then
			RoomHelper.logElapse("++++++ " .. slot6.__cname .. " " .. slot6._comp.__cname, 0.001)
		else
			RoomHelper.logElapse("++++++ " .. slot6.__cname, 0.001)
		end

		slot6:onStartInternal(slot1)
	end
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
