module("modules.logic.stat.rpc.StatRpc", package.seeall)

local var_0_0 = class("StatRpc", BaseRpc)

function var_0_0.sendClientStatBaseInfoRequest(arg_1_0, arg_1_1)
	local var_1_0 = StatModule_pb.ClientStatBaseInfoRequest()

	var_1_0.info = arg_1_1

	return arg_1_0:sendMsg(var_1_0)
end

function var_0_0.onReceiveClientStatBaseInfoReply(arg_2_0, arg_2_1, arg_2_2)
	return
end

function var_0_0.onReceiveStatInfoPush(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == 0 then
		if arg_3_2.fristCharge == true then
			SDKDataTrackMgr.instance:trackMediaEvent(SDKDataTrackMgr.MediaEvent.first_purchase)
			SDKChannelEventModel.instance:firstPurchase()
		end

		if arg_3_2.isFirstLogin == true then
			local var_3_0 = PayModel.instance:getGameRoleInfo()
			local var_3_1 = arg_3_2.playerInfo

			var_3_0.roleId = var_3_1.userId
			var_3_0.roleName = tostring(var_3_1.name)
			var_3_0.currentLevel = tonumber(var_3_1.level)
			var_3_0.roleCTime = tonumber(var_3_1.registerTime)
			var_3_0.loginTime = tonumber(var_3_1.lastLoginTime)
			var_3_0.logoutTime = tonumber(var_3_1.lastLogoutTime)
			var_3_0.accountRegisterTime = tonumber(var_3_1.registerTime)
			var_3_0.roleEstablishTime = tonumber(var_3_1.registerTime)

			local var_3_2 = cjson.encode(var_3_0)

			SDKMgr.instance:createRole(var_3_2)
		end

		if string.nilorempty(arg_3_2.userTag) == false then
			StatModel.instance:setRoleType(arg_3_2.userTag)

			if LoginController.instance:isEnteredGame() then
				SDKMgr.instance:updateRole(StatModel.instance:generateRoleInfo())
			end
		end

		SDKChannelEventModel.instance:totalChargeAmount(arg_3_2.totalChargeAmount)
	end
end

function var_0_0.sendUpdateClientStatBaseInfoRequest(arg_4_0, arg_4_1)
	local var_4_0 = StatModule_pb.UpdateClientStatBaseInfoRequest()

	var_4_0.info = arg_4_1

	return arg_4_0:sendMsg(var_4_0)
end

function var_0_0.onReceiveUpdateClientStatBaseInfoReply(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 ~= 0 then
		return
	end

	SDKModel.instance:setAccountBindBonus(arg_5_2.accountBindBonus)
end

var_0_0.instance = var_0_0.New()

return var_0_0
