module("modules.logic.bgmswitch.model.BGMSwitchInfoMo", package.seeall)

local var_0_0 = pureTable("BGMSwitchInfoMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.bgmId = 0
	arg_1_0.unlock = 0
	arg_1_0.favorite = false
	arg_1_0.isRead = false
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.bgmId = arg_2_1.bgmId
	arg_2_0.unlock = arg_2_1.unlock
	arg_2_0.favorite = arg_2_1.favorite
	arg_2_0.isRead = arg_2_1.isRead
end

function var_0_0.reset(arg_3_0, arg_3_1)
	arg_3_0.bgmId = arg_3_1.bgmId
	arg_3_0.unlock = arg_3_1.unlock
	arg_3_0.favorite = arg_3_1.favorite
	arg_3_0.isRead = arg_3_1.isRead
end

return var_0_0
