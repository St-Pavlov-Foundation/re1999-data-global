module("modules.logic.login.config.LoginConfig", package.seeall)

slot0 = class("LoginConfig", BaseConfig)

function slot0.reqConfigNames(slot0)
	return nil
end

function slot0.onInit(slot0)
	slot0._config = nil
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "" then
		slot0._config = slot2
	end
end

function slot0.getConfigTable(slot0)
	return slot0._config
end

slot0.instance = slot0.New()

return slot0
