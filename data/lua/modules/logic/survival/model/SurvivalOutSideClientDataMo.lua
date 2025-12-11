module("modules.logic.survival.model.SurvivalOutSideClientDataMo", package.seeall)

local var_0_0 = pureTable("SurvivalOutSideClientDataMo")

function var_0_0.init(arg_1_0, arg_1_1)
	local var_1_0 = {}

	if not string.nilorempty(arg_1_1) then
		var_1_0 = cjson.decode(arg_1_1)
	end

	if var_1_0.ver and var_1_0.ver ~= arg_1_0:getCurVersion() then
		var_1_0 = {}
	end

	var_1_0.ver = var_1_0.ver or arg_1_0:getCurVersion()
	arg_1_0.data = var_1_0
end

function var_0_0.getCurVersion(arg_2_0)
	return 1
end

function var_0_0.saveDataToServer(arg_3_0)
	SurvivalOutSideRpc.instance:sendSurvivalSurvivalOutSideClientData(cjson.encode(arg_3_0.data))
end

return var_0_0
