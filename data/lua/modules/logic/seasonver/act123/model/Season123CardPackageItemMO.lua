﻿local var_0_0 = pureTable("Season123CardPackageItemMO")

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1
	arg_2_0.itemId = arg_2_1
	arg_2_0.count = 1
	arg_2_0.config = Season123Config.instance:getSeasonEquipCo(arg_2_1)
end

return var_0_0
