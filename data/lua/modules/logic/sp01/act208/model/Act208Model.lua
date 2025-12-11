module("modules.logic.sp01.act208.model.Act208Model", package.seeall)

local var_0_0 = class("Act208Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._infoMoDic = {}
end

function var_0_0.onGetInfo(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0

	if arg_3_0._infoMoDic[arg_3_1] == nil then
		var_3_0 = Act208InfoMo.New()

		var_3_0:init()

		arg_3_0._infoMoDic[arg_3_1] = var_3_0
	else
		var_3_0 = arg_3_0._infoMoDic[arg_3_1]
	end

	var_3_0:setInfo(arg_3_1, arg_3_2)
	Act208Controller.instance:dispatchEvent(Act208Event.onGetInfo, arg_3_1)
end

function var_0_0.onGetBonus(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0._infoMoDic[arg_4_1]

	if var_4_0 == nil then
		logError("Act208 不存在的活动id ：" .. tostring(arg_4_1))

		return
	end

	local var_4_1 = var_4_0.bonusDic[arg_4_2]

	if var_4_1 == nil then
		logError("Act208 不存在的活动id: " .. tostring(arg_4_1) .. " 奖励id: " .. tostring(arg_4_2))

		return
	end

	var_4_1.status = Act208Enum.BonusState.HaveGet

	Act208Controller.instance:dispatchEvent(Act208Event.onGetBonus, arg_4_1, arg_4_2)
end

function var_0_0.getInfo(arg_5_0, arg_5_1)
	if arg_5_0._infoMoDic then
		return arg_5_0._infoMoDic[arg_5_1]
	end

	return nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
