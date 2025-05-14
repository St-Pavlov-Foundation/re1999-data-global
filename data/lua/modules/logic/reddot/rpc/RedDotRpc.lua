module("modules.logic.reddot.rpc.RedDotRpc", package.seeall)

local var_0_0 = class("RedDotRpc", BaseRpc)

function var_0_0.sendGetRedDotInfosRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = RedDotModule_pb.GetRedDotInfosRequest()

	if arg_1_1 then
		for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
			table.insert(var_1_0.ids, iter_1_1)
		end
	end

	return arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGetRedDotInfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		RedDotModel.instance:setRedDotInfo(arg_2_2.redDotInfos)

		local var_2_0 = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_2.redDotInfos) do
			local var_2_1 = RedDotModel.instance:_getAssociateRedDots(iter_2_1.defineId)

			for iter_2_2, iter_2_3 in pairs(var_2_1) do
				var_2_0[iter_2_3] = true
			end
		end

		RedDotController.instance:CheckExpireDot()
		RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, var_2_0)
		RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)
	end
end

function var_0_0.onReceiveUpdateRedDotPush(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == 0 then
		RedDotModel.instance:updateRedDotInfo(arg_3_2.redDotInfos)

		local var_3_0 = {}

		for iter_3_0, iter_3_1 in ipairs(arg_3_2.redDotInfos) do
			local var_3_1 = RedDotModel.instance:_getAssociateRedDots(iter_3_1.defineId)

			for iter_3_2, iter_3_3 in pairs(var_3_1) do
				var_3_0[iter_3_3] = true
			end
		end

		RedDotController.instance:CheckExpireDot()
		RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, var_3_0)
		RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)
	end
end

function var_0_0.sendShowRedDotRequest(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = RedDotModule_pb.ShowRedDotRequest()

	var_4_0.defineId = arg_4_1
	var_4_0.isVisible = arg_4_2

	arg_4_0:sendMsg(var_4_0)
end

function var_0_0.onReceiveShowRedDotReply(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == 0 then
		-- block empty
	end
end

function var_0_0.clientAddRedDotGroupList(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		var_6_0[iter_6_1.id] = var_6_0[iter_6_1.id] or {}

		local var_6_1 = arg_6_0:clientMakeRedDotGroupItem(iter_6_1.uid, iter_6_1.value)

		table.insert(var_6_0[iter_6_1.id], var_6_1)
	end

	local var_6_2 = {
		redDotInfos = {},
		replaceAll = arg_6_2 or false
	}

	for iter_6_2, iter_6_3 in pairs(var_6_0) do
		local var_6_3 = arg_6_0:clientMakeRedDotGroup(iter_6_2, iter_6_3, arg_6_2)

		table.insert(var_6_2.redDotInfos, var_6_3)
	end

	arg_6_0:onReceiveUpdateRedDotPush(0, var_6_2)
end

function var_0_0.clientMakeRedDotGroupItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	return {
		id = arg_7_1 or 0,
		value = arg_7_2 or 0,
		time = arg_7_3 or 0,
		ext = arg_7_4 or ""
	}
end

function var_0_0.clientMakeRedDotGroup(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	return {
		defineId = arg_8_1,
		infos = arg_8_2,
		replaceAll = arg_8_3 or false
	}
end

var_0_0.instance = var_0_0.New()

return var_0_0
