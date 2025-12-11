module("modules.logic.sp01.act208.model.Act208InfoMo", package.seeall)

local var_0_0 = pureTable("Act208InfoMo")

function var_0_0.init(arg_1_0)
	arg_1_0.bonusList = {}
	arg_1_0.bonusDic = {}
end

function var_0_0.setInfo(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.activityId = arg_2_1

	tabletool.clear(arg_2_0.bonusList)
	tabletool.clear(arg_2_0.bonusDic)

	for iter_2_0, iter_2_1 in ipairs(arg_2_2) do
		table.insert(arg_2_0.bonusList, iter_2_1)

		arg_2_0.bonusDic[iter_2_1.id] = iter_2_1
	end
end

function var_0_0.canGet(arg_3_0)
	return
end

function var_0_0.isGet(arg_4_0)
	return
end

return var_0_0
