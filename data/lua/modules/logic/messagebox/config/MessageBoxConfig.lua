module("modules.logic.messagebox.config.MessageBoxConfig", package.seeall)

slot0 = class("MessageBoxConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._messageBoxConfig = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"messagebox"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "messagebox" then
		slot0._messageBoxConfig = slot2
	end
end

function slot0.getMessageBoxCO(slot0, slot1)
	return slot0._messageBoxConfig.configDict[slot1]
end

function slot0.getMessage(slot0, slot1)
	if not slot0:getMessageBoxCO(slot1) then
		logError("找不到弹窗配置, id: " .. tostring(slot1))
	end

	return slot2 and slot2.content or ""
end

slot0.instance = slot0.New()

return slot0
