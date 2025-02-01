module("modules.logic.room.utils.RoomFSMHelper", package.seeall)

return {
	isCanJompTo = function (slot0)
		if slot0 == RoomEnum.FSMEditState.PlaceConfirm then
			if RoomMapBlockModel.instance:getTempBlockMO() then
				return true
			end
		elseif slot0 == RoomEnum.FSMEditState.BackConfirm and RoomMapBlockModel.instance:getBackBlockModel() and slot1:getCount() > 0 then
			return true
		end

		return false
	end
}
