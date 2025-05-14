module("modules.logic.backpack.model.BackpackMo", package.seeall)

local var_0_0 = pureTable("BackpackMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = 0
	arg_1_0.uid = 0
	arg_1_0.type = 0
	arg_1_0.subType = 0
	arg_1_0.icon = ""
	arg_1_0.quantity = 0
	arg_1_0.icon = ""
	arg_1_0.rare = 0
	arg_1_0.isStackable = false
	arg_1_0.isShow = false
	arg_1_0.isTimeShow = 0
	arg_1_0.deadline = 0
	arg_1_0.expireTime = -1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.uid = arg_2_1.uid
	arg_2_0.type = arg_2_1.type
	arg_2_0.subType = arg_2_1.subType == nil and 0 or arg_2_1.subType
	arg_2_0.quantity = arg_2_1.quantity
	arg_2_0.icon = arg_2_1.icon
	arg_2_0.rare = arg_2_1.rare
	arg_2_0.isStackable = arg_2_1.isStackable == nil and 1 or arg_2_1.isStackable
	arg_2_0.isShow = arg_2_1.isShow == nil and 1 or arg_2_1.isShow
	arg_2_0.isTimeShow = arg_2_1.isTimeShow == nil and 0 or arg_2_1.isTimeShow
	arg_2_0.expireTime = arg_2_1.expireTime and arg_2_1.expireTime or -1
end

function var_0_0.itemExpireTime(arg_3_0)
	if arg_3_0.expireTime == nil or arg_3_0.expireTime == -1 or arg_3_0.expireTime == "" then
		return -1
	end

	if type(arg_3_0.expireTime) == "number" then
		return arg_3_0.expireTime
	else
		return TimeUtil.stringToTimestamp(arg_3_0.expireTime)
	end
end

return var_0_0
