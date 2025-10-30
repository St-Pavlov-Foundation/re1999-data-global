module("modules.logic.ressplit.work.VersionResSpiltAudioWhiteWork", package.seeall)

local var_0_0 = class("VersionResSpiltAudioWhiteWork", BaseWork)
local var_0_1 = {
	toNumber = 2,
	splitToNumber = 1
}
local var_0_2 = {
	{
		resKey = "roleVoice",
		separation = "|",
		luaName = "lua_room_character",
		funcType = var_0_1.splitToNumber
	}
}

function var_0_0.onStart(arg_1_0, arg_1_1)
	logError(string.format("VersionResSpiltAudioWhiteWork:onStart(context) =====>"))

	local var_1_0 = AudioConfig.instance:getAudioCO()
	local var_1_1 = arg_1_0:_getAuidoIdWhiteListDict() or {}
	local var_1_2 = arg_1_1 and arg_1_1.bankEvent2wenDic or {}

	arg_1_0.bankNameWhiteDic = {}
	arg_1_0.wenNameWhiteDic = {}

	for iter_1_0, iter_1_1 in pairs(var_1_1) do
		local var_1_3 = var_1_0[iter_1_0]

		if var_1_3 then
			arg_1_0.bankNameWhiteDic[var_1_3.bankName] = true

			local var_1_4 = var_1_2[var_1_3.eventName]
			local var_1_5 = var_1_4 and var_1_4[var_1_3.bankName]

			if var_1_5 and type(var_1_5) == "table" then
				for iter_1_2, iter_1_3 in ipairs(var_1_5) do
					arg_1_0.wenNameWhiteDic[iter_1_3] = true
				end
			end
		end
	end

	arg_1_0:onDone(true)
end

function var_0_0._getAuidoIdWhiteListDict(arg_2_0)
	local var_2_0 = {}

	if not arg_2_0._ToNumberFuncMap then
		arg_2_0._ToNumberFuncMap = {
			[var_0_1.splitToNumber] = var_0_0._gameCfgWhiteSplitToNumber,
			[var_0_1.toNumber] = var_0_0._gameCfgWhiteToNumber
		}
	end

	local var_2_1 = var_0_2
	local var_2_2 = arg_2_0._ToNumberFuncMap

	for iter_2_0 = 1, #var_2_1 do
		local var_2_3 = var_2_1[iter_2_0]
		local var_2_4 = _G[var_2_3.luaName]

		if var_2_4 and var_2_4.configList then
			local var_2_5 = var_2_4.configList

			for iter_2_1, iter_2_2 in ipairs(var_2_5) do
				local var_2_6 = var_2_2[var_2_3.funcType]

				if var_2_6 then
					var_2_6(var_2_0, iter_2_2[var_2_3.resKey], var_2_3.separation)
				end
			end
		end
	end

	return var_2_0
end

function var_0_0._gameCfgWhiteSplitToNumber(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0 and not string.nilorempty(arg_3_1) and not string.nilorempty(arg_3_2) then
		local var_3_0 = string.splitToNumber(arg_3_1, arg_3_2)

		if var_3_0 then
			for iter_3_0, iter_3_1 in ipairs(var_3_0) do
				arg_3_0[iter_3_1] = true
			end
		end
	end
end

function var_0_0._gameCfgWhiteToNumber(arg_4_0, arg_4_1)
	if arg_4_0 and arg_4_1 then
		arg_4_0[tonumber(arg_4_1)] = true
	end
end

return var_0_0
