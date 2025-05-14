module("modules.logic.stat.model.StatModel", package.seeall)

local var_0_0 = class("StatModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._basePropertiesStr = nil
	arg_1_0._tempEventCommonProperties = nil
	arg_1_0._roleType = ""
end

function var_0_0.setRoleType(arg_2_0, arg_2_1)
	arg_2_0._roleType = arg_2_1
end

function var_0_0.getRoleType(arg_3_0)
	return arg_3_0._roleType
end

function var_0_0.reInit(arg_4_0)
	arg_4_0._basePropertiesStr = nil
	arg_4_0._tempEventCommonProperties = nil
	arg_4_0._roleType = ""
end

function var_0_0.updateBaseProperties(arg_5_0, arg_5_1)
	arg_5_0._basePropertiesStr = arg_5_1
end

function var_0_0.getEventCommonProperties(arg_6_0)
	local var_6_0 = PlayerModel.instance:getPlayinfo()

	if not arg_6_0._tempEventCommonProperties then
		arg_6_0._tempEventCommonProperties = {}
		arg_6_0._tempEventCommonProperties[StatEnum.EventCommonProperties.ServerName] = LoginModel.instance.serverName
		arg_6_0._tempEventCommonProperties[StatEnum.EventCommonProperties.RoleId] = tostring(var_6_0.userId)
		arg_6_0._tempEventCommonProperties[StatEnum.EventCommonProperties.RoleEstablishTime] = TimeUtil.timestampToString(ServerTime.timeInLocal(var_6_0.registerTime / 1000))
		arg_6_0._tempEventCommonProperties[StatEnum.EventCommonProperties.RoleType] = "正常"
	end

	local var_6_1 = {}
	local var_6_2 = CurrencyModel.instance:getDiamond()
	local var_6_3 = CurrencyModel.instance:getFreeDiamond()
	local var_6_4 = DungeonConfig.instance:getEpisodeCO(var_6_0.lastEpisodeId)
	local var_6_5 = var_6_4 and tostring(var_6_4.name .. var_6_4.id) or ""

	var_6_1[StatEnum.EventCommonProperties.RoleName] = var_6_0.name
	var_6_1[StatEnum.EventCommonProperties.GiveCurrencyNum] = var_6_3
	var_6_1[StatEnum.EventCommonProperties.PaidCurrencyNum] = var_6_2
	var_6_1[StatEnum.EventCommonProperties.CurrencyNum] = var_6_2 + var_6_3
	var_6_1[StatEnum.EventCommonProperties.RoleLevel] = var_6_0.level
	var_6_1[StatEnum.EventCommonProperties.CurrentProgress] = var_6_5

	for iter_6_0, iter_6_1 in pairs(arg_6_0._tempEventCommonProperties) do
		var_6_1[iter_6_0] = iter_6_1
	end

	if not LoginModel.instance:isDoneLogin() then
		arg_6_0._tempEventCommonProperties = nil
	end

	return var_6_1
end

function var_0_0.generateRoleInfo(arg_7_0)
	local var_7_0 = PayModel.instance:getGameRoleInfo()
	local var_7_1 = cjson.encode(var_7_0)

	logNormal(var_7_1)

	return var_7_1
end

function var_0_0.getPayInfo(arg_8_0)
	local var_8_0 = PayModel.instance:getGamePayInfo()
	local var_8_1 = cjson.encode(var_8_0)

	logNormal("Pay Info " .. var_8_1)

	return var_8_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
