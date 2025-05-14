module("modules.logic.room.utils.RoomFSMHelper", package.seeall)

return {
	isCanJompTo = function(arg_1_0)
		if arg_1_0 == RoomEnum.FSMEditState.PlaceConfirm then
			if RoomMapBlockModel.instance:getTempBlockMO() then
				return true
			end
		elseif arg_1_0 == RoomEnum.FSMEditState.BackConfirm then
			local var_1_0 = RoomMapBlockModel.instance:getBackBlockModel()

			if var_1_0 and var_1_0:getCount() > 0 then
				return true
			end
		end

		return false
	end
}
