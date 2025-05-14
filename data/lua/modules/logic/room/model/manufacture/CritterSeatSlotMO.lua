module("modules.logic.room.model.manufacture.CritterSeatSlotMO", package.seeall)

local var_0_0 = pureTable("CritterSeatSlotMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._id = arg_1_1.critterSlotId
	arg_1_0._critterUid = arg_1_1.critterUid
end

function var_0_0.getSeatSlotId(arg_2_0)
	return arg_2_0._id
end

function var_0_0.getRestingCritter(arg_3_0)
	if not arg_3_0:isEmpty() then
		return arg_3_0._critterUid
	end
end

function var_0_0.isEmpty(arg_4_0)
	local var_4_0 = true

	if arg_4_0._critterUid and arg_4_0._critterUid ~= CritterEnum.InvalidCritterUid and arg_4_0._critterUid ~= tonumber(CritterEnum.InvalidCritterUid) then
		var_4_0 = false
	end

	return var_4_0
end

function var_0_0.removeCritter(arg_5_0)
	arg_5_0._critterUid = CritterEnum.InvalidCritterUid
end

return var_0_0
