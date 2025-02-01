module("modules.logic.stat.rpc.StatRpc", package.seeall)

slot0 = class("StatRpc", BaseRpc)

function slot0.sendClientStatBaseInfoRequest(slot0, slot1)
	slot2 = StatModule_pb.ClientStatBaseInfoRequest()
	slot2.info = slot1

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveClientStatBaseInfoReply(slot0, slot1, slot2)
end

function slot0.onReceiveStatInfoPush(slot0, slot1, slot2)
	if slot1 == 0 then
		if slot2.fristCharge == true then
			SDKDataTrackMgr.instance:trackMediaEvent(SDKDataTrackMgr.MediaEvent.first_purchase)
			SDKChannelEventModel.instance:firstPurchase()
		end

		if slot2.isFirstLogin == true then
			slot3 = PayModel.instance:getGameRoleInfo()
			slot4 = slot2.playerInfo
			slot3.roleId = slot4.userId
			slot3.roleName = tostring(slot4.name)
			slot3.currentLevel = tonumber(slot4.level)
			slot3.roleCTime = tonumber(slot4.registerTime)
			slot3.loginTime = tonumber(slot4.lastLoginTime)
			slot3.logoutTime = tonumber(slot4.lastLogoutTime)
			slot3.accountRegisterTime = tonumber(slot4.registerTime)
			slot3.roleEstablishTime = tonumber(slot4.registerTime)

			SDKMgr.instance:createRole(cjson.encode(slot3))
		end

		if string.nilorempty(slot2.userTag) == false then
			StatModel.instance:setRoleType(slot2.userTag)

			if LoginController.instance:isEnteredGame() then
				SDKMgr.instance:updateRole(StatModel.instance:generateRoleInfo())
			end
		end

		SDKChannelEventModel.instance:totalChargeAmount(slot2.totalChargeAmount)
	end
end

function slot0.sendUpdateClientStatBaseInfoRequest(slot0, slot1)
	slot2 = StatModule_pb.UpdateClientStatBaseInfoRequest()
	slot2.info = slot1

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveUpdateClientStatBaseInfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	SDKModel.instance:setAccountBindBonus(slot2.accountBindBonus)
end

slot0.instance = slot0.New()

return slot0
