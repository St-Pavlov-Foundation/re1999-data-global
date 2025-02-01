module("modules.logic.login.controller.work.LogoutOpenLoginWork", package.seeall)

slot0 = class("LogoutOpenLoginWork", BaseWork)

function slot0.ctor(slot0)
end

function slot0.onStart(slot0, slot1)
	LoginController.instance:login({
		isModuleLogout = true,
		isSdkLogout = slot1.isSdkLogout
	})
	slot0:onDone(true)
end

return slot0
