module("modules.logic.roomfishing.model.FishingFriendInfoMO", package.seeall)

local var_0_0 = pureTable("FishingFriendInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.type = arg_1_1.type
	arg_1_0.userId = arg_1_1.userId
	arg_1_0.name = arg_1_1.name
	arg_1_0.portrait = arg_1_1.portrait
	arg_1_0.poolId = arg_1_1.poolId
end

return var_0_0
