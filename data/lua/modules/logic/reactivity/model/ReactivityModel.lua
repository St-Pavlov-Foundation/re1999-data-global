module("modules.logic.reactivity.model.ReactivityModel", package.seeall)

local var_0_0 = class("ReactivityModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.isReactivity(arg_3_0, arg_3_1)
	if not arg_3_1 or arg_3_1 <= 0 then
		return false
	end

	local var_3_0 = ActivityConfig.instance:getActivityCo(arg_3_1)

	if not var_3_0 then
		return false
	end

	return var_3_0.isRetroAcitivity == 1
end

function var_0_0.getActivityCurrencyId(arg_4_0, arg_4_1)
	local var_4_0 = ReactivityEnum.ActivityDefine[arg_4_1]

	if var_4_0 then
		return var_4_0.storeCurrency
	end

	for iter_4_0, iter_4_1 in pairs(ReactivityEnum.ActivityDefine) do
		if iter_4_1.storeActId == arg_4_1 then
			return iter_4_1.storeCurrency
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
