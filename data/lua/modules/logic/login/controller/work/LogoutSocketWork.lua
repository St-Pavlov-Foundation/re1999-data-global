module("modules.logic.login.controller.work.LogoutSocketWork", package.seeall)

slot0 = class("LogoutSocketWork", BaseWork)

function slot0.ctor(slot0)
end

function slot0.onStart(slot0, slot1)
	if slot1.isConnected then
		-- Nothing
	end

	ConnectAliveMgr.instance:logout()
	slot0:onDone(true)
end

return slot0
