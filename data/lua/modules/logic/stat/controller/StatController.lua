module("modules.logic.stat.controller.StatController", package.seeall)

local var_0_0 = class("StatController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.sendBaseProperties(arg_3_0)
	local var_3_0 = ""
	local var_3_1 = SDKDataTrackMgr.instance:getDataTrackProperties()

	if string.nilorempty(var_3_1) then
		var_3_1 = cjson.encode(StatEnum.DefaultBaseProperties)
	end

	logNormal(var_3_1)
	StatModel.instance:updateBaseProperties(var_3_1)
	StatRpc.instance:sendClientStatBaseInfoRequest(var_3_1)
end

function var_0_0.onLogin(arg_4_0)
	arg_4_0:sendBaseProperties()

	local var_4_0 = PlayerModel.instance:getMyUserId()

	SDKDataTrackMgr.instance:roleLogin(tostring(var_4_0))

	local var_4_1 = PlayerModel.instance:getPlayinfo()

	if not string.nilorempty(var_4_1.name) then
		SDKMgr.instance:enterGame(StatModel.instance:generateRoleInfo())
	end
end

function var_0_0.setUserProperties(arg_5_0, arg_5_1)
	SDKDataTrackMgr.instance:profileSet(arg_5_1)
end

function var_0_0.track(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2 = arg_6_2 or {}

	local var_6_0 = StatModel.instance:getEventCommonProperties()

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		arg_6_2[iter_6_0] = iter_6_1
	end

	local var_6_1 = {}

	for iter_6_2, iter_6_3 in pairs(arg_6_2) do
		local var_6_2 = StatEnum.PropertyTypes[iter_6_2]

		if not string.nilorempty(var_6_2) and type(iter_6_3) ~= SDKDataTrackMgr.DefinedTypeToLuaType[var_6_2] then
			logError(string.format("埋点 属性类型不一致, propertyName: %s, param: %s, currentType: %s, definedType: %s", tostring(iter_6_2), tostring(iter_6_3), type(iter_6_3), SDKDataTrackMgr.DefinedTypeToLuaType[var_6_2]))
		end

		if var_6_2 == "array" or var_6_2 == "list" then
			JsonUtil.markAsArray(iter_6_3)
		end

		if var_6_2 == "array" and #iter_6_3 <= 0 then
			table.insert(var_6_1, iter_6_2)
		end
	end

	for iter_6_4, iter_6_5 in ipairs(var_6_1) do
		arg_6_2[iter_6_5] = nil
	end

	SDKDataTrackMgr.instance:track(arg_6_1, arg_6_2)
end

function var_0_0.onInitFinish(arg_7_0)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0
