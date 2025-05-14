module("modules.logic.versionactivity2_5.act182.model.Activity182Model", package.seeall)

local var_0_0 = class("Activity182Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.actMoDic = {}
end

function var_0_0.setActInfo(arg_3_0, arg_3_1)
	arg_3_0.curActId = arg_3_1.activityId

	local var_3_0 = arg_3_0.actMoDic[arg_3_0.curActId]

	if var_3_0 then
		var_3_0:update(arg_3_1)
	else
		local var_3_1 = Act182MO.New()

		var_3_1:init(arg_3_1)

		arg_3_0.actMoDic[arg_3_0.curActId] = var_3_1
	end

	Activity182Controller.instance:dispatchEvent(Activity182Event.UpdateInfo)
end

function var_0_0.getCurActId(arg_4_0)
	return arg_4_0.curActId
end

function var_0_0.getActMo(arg_5_0, arg_5_1)
	arg_5_1 = arg_5_1 or arg_5_0.curActId

	local var_5_0 = arg_5_0.actMoDic[arg_5_1]

	if not var_5_0 then
		logError("dont exist actMo" .. tostring(arg_5_1))
	end

	return var_5_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
