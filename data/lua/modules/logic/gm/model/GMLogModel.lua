module("modules.logic.gm.model.GMLogModel", package.seeall)

local var_0_0 = class("GMLogModel", BaseModel)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0.errorModel = ListScrollModel.New()
end

function var_0_0.addMsg(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_1 = string.gsub(arg_2_1, "<color[^>]+>", "")
	arg_2_1 = string.gsub(arg_2_1, "</color>", "")
	arg_2_2 = string.gsub(arg_2_2, "<color[^>]+>", "")
	arg_2_2 = string.gsub(arg_2_2, "</color>", "")

	local var_2_0 = {
		msg = arg_2_1,
		stackTrace = arg_2_2,
		type = arg_2_3,
		time = ServerTime.now()
	}

	if var_2_0.type == 0 then
		arg_2_0.errorModel:addAtFirst(var_2_0)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
