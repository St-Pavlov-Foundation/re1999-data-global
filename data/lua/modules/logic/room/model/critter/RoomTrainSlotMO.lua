module("modules.logic.room.model.critter.RoomTrainSlotMO", package.seeall)

local var_0_0 = pureTable("RoomTrainSlotMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.isLock = arg_1_1.isLock
end

function var_0_0.setCritterMO(arg_2_0, arg_2_1)
	arg_2_0.critterMO = arg_2_1
end

function var_0_0.setWaitingCritterUid(arg_3_0, arg_3_1)
	arg_3_0.waitingTrainUid = arg_3_1
end

function var_0_0.isFree(arg_4_0)
	if not arg_4_0.isLock and arg_4_0.critterMO == nil then
		return true
	end
end

return var_0_0
