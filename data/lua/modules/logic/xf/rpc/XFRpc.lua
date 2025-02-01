module("modules.logic.xf.rpc.XFRpc", package.seeall)

slot0 = class("XFRpc", BaseRpc)

function slot0.onReceiveGuestTimeOutPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	SDKMgr.instance:showVistorPlayTimeOutDialog()
end

function slot0.onReceiveMinorPlayTimeOutPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	SDKMgr.instance:showMinorPlayTimeOutDialog(string.format("%.1f", slot2.timeOutHour / 60))
end

function slot0.onReceiveMinorLimitLoginTimePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.limitLoginTime

	if slot2.isLogin then
		SDKMgr.instance:showMinorLimitLoginTimeDialog()
	else
		SDKMgr.instance:showMinorPlayTimeOutDialog()
	end
end

slot0.instance = slot0.New()

return slot0
