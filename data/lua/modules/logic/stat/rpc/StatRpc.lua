-- chunkname: @modules/logic/stat/rpc/StatRpc.lua

module("modules.logic.stat.rpc.StatRpc", package.seeall)

local StatRpc = class("StatRpc", BaseRpc)

function StatRpc:sendClientStatBaseInfoRequest(info)
	local req = StatModule_pb.ClientStatBaseInfoRequest()

	req.info = info

	return self:sendMsg(req)
end

function StatRpc:onReceiveClientStatBaseInfoReply(resultCode, msg)
	return
end

function StatRpc:onReceiveStatInfoPush(resultCode, msg)
	if resultCode == 0 then
		if msg.fristCharge == true then
			SDKDataTrackMgr.instance:trackMediaEvent(SDKDataTrackMgr.MediaEvent.first_purchase)
			SDKChannelEventModel.instance:firstPurchase()
		end

		if msg.isFirstLogin == true then
			local roleInfo = PayModel.instance:getGameRoleInfo()
			local playerinfo = msg.playerInfo

			roleInfo.roleId = playerinfo.userId
			roleInfo.roleName = tostring(playerinfo.name)
			roleInfo.currentLevel = tonumber(playerinfo.level)
			roleInfo.roleCTime = tonumber(playerinfo.registerTime)
			roleInfo.loginTime = tonumber(playerinfo.lastLoginTime)
			roleInfo.logoutTime = tonumber(playerinfo.lastLogoutTime)
			roleInfo.accountRegisterTime = tonumber(playerinfo.registerTime)
			roleInfo.roleEstablishTime = tonumber(playerinfo.registerTime)

			local jsonRoleInfo = cjson.encode(roleInfo)

			SDKMgr.instance:createRole(jsonRoleInfo)
		end

		if string.nilorempty(msg.userTag) == false then
			StatModel.instance:setRoleType(msg.userTag)

			if LoginController.instance:isEnteredGame() then
				SDKMgr.instance:updateRole(StatModel.instance:generateRoleInfo())
			end
		end

		SDKChannelEventModel.instance:totalChargeAmount(msg.totalChargeAmount)
	end
end

function StatRpc:sendUpdateClientStatBaseInfoRequest(info)
	local req = StatModule_pb.UpdateClientStatBaseInfoRequest()

	req.info = info

	return self:sendMsg(req)
end

function StatRpc:onReceiveUpdateClientStatBaseInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	SDKModel.instance:setAccountBindBonus(msg.accountBindBonus)
end

StatRpc.instance = StatRpc.New()

return StatRpc
