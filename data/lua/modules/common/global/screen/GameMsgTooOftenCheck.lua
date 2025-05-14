module("modules.common.global.screen.GameMsgTooOftenCheck", package.seeall)

local var_0_0 = class("GameMsgTooOftenCheck", BasePreSender)
local var_0_1 = 1
local var_0_2 = 90
local var_0_3 = 3
local var_0_4 = {}

function var_0_0.ctor(arg_1_0)
	arg_1_0._sendProtoTime = {}
	arg_1_0._sendProtoList = {}
	arg_1_0._toSendProtoTime = {}
	arg_1_0._toSendProtoList = {}

	arg_1_0:addConstEvents()
end

function var_0_0.addConstEvents(arg_2_0)
	if isDebugBuild then
		LuaSocketMgr.instance:registerPreSender(arg_2_0)
	end
end

function var_0_0.blockSendProto(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if not arg_3_2 then
		return
	end

	if var_0_4[arg_3_1] then
		return
	end

	arg_3_0:_removeOutdatedProto(arg_3_0._sendProtoTime, arg_3_0._sendProtoList)
	arg_3_0:_removeOutdatedProto(arg_3_0._toSendProtoTime, arg_3_0._toSendProtoList)

	local var_3_0 = Time.realtimeSinceStartup

	table.insert(arg_3_0._toSendProtoTime, var_3_0)
	table.insert(arg_3_0._toSendProtoList, arg_3_2)

	local var_3_1 = 0
	local var_3_2

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._toSendProtoList) do
		if arg_3_2.__cname == iter_3_1.__cname then
			var_3_2 = var_3_2 or tostring(arg_3_2)

			if var_3_2 == tostring(iter_3_1) then
				var_3_1 = var_3_1 + 1

				if var_3_1 > var_0_3 then
					local var_3_3 = arg_3_2.__cname .. "{\n" .. var_3_2 .. "}"

					logError(string.format("发完全相同的包过于频繁，%d秒%d个\n%s", var_0_1, var_3_1, var_3_3))

					break
				end
			end
		end
	end

	if #arg_3_0._sendProtoList > var_0_2 then
		local var_3_4 = arg_3_2.__cname .. "{\n" .. var_3_2 .. "}"

		logError(string.format("发包过于频繁，%d秒%d个，请求已被拦截\n%s", var_0_1, #arg_3_0._toSendProtoList, var_3_4))

		return true
	end

	table.insert(arg_3_0._sendProtoTime, var_3_0)
	table.insert(arg_3_0._sendProtoList, arg_3_2)
end

function var_0_0._removeOutdatedProto(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = #arg_4_1
	local var_4_1 = Time.realtimeSinceStartup

	for iter_4_0 = 1, var_4_0 do
		if var_4_1 - arg_4_1[1] >= var_0_1 then
			table.remove(arg_4_1, 1)
			table.remove(arg_4_2, 1)
		else
			break
		end
	end
end

return var_0_0
