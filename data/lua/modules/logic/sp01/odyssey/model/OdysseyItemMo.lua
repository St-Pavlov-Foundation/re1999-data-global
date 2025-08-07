module("modules.logic.sp01.odyssey.model.OdysseyItemMo", package.seeall)

local var_0_0 = pureTable("OdysseyItemMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.config = OdysseyConfig.instance:getItemConfig(arg_1_1)
	arg_1_0.addCount = 0
	arg_1_0.count = 0
end

function var_0_0.updateInfo(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.uid = arg_2_1.uid
	arg_2_0.id = arg_2_1.id

	if arg_2_2 then
		arg_2_0.count = arg_2_0.count + arg_2_1.count
		arg_2_0.addCount = arg_2_1.count
	else
		arg_2_0.count = arg_2_1.count
	end

	arg_2_0.newFlag = arg_2_1.newFlag
end

function var_0_0.isNew(arg_3_0)
	return arg_3_0.newFlag
end

function var_0_0.cleanAddCount(arg_4_0)
	arg_4_0.addCount = 0
end

return var_0_0
