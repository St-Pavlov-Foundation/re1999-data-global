module("modules.logic.versionactivity2_7.act191.model.Activity191Model", package.seeall)

local var_0_0 = class("Activity191Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.actMoDic = {}
end

function var_0_0.setActInfo(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.curActId = arg_3_1

	if not arg_3_0.actMoDic[arg_3_1] then
		arg_3_0.actMoDic[arg_3_1] = Act191MO.New()
	end

	arg_3_0.actMoDic[arg_3_1]:initBadgeInfo(arg_3_1)
	arg_3_0.actMoDic[arg_3_1]:init(arg_3_2)
	Act191StatController.instance:setActInfo(arg_3_1, arg_3_0.actMoDic[arg_3_1])
end

function var_0_0.getCurActId(arg_4_0)
	return arg_4_0.curActId
end

function var_0_0.getActInfo(arg_5_0, arg_5_1)
	arg_5_1 = arg_5_1 or arg_5_0.curActId

	return arg_5_0.actMoDic[arg_5_1]
end

function var_0_0.setGameEndInfo(arg_6_0, arg_6_1)
	arg_6_0.endInfo = arg_6_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
