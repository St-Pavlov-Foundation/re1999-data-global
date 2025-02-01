module("modules.logic.toast.config.ToastConfig", package.seeall)

slot0 = class("ToastConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0.toastConfig = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"toast"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "toast" then
		slot0.toastConfig = slot2
	end
end

function slot0.getToastCO(slot0, slot1)
	return slot0.toastConfig.configDict[slot1]
end

slot0.instance = slot0.New()

return slot0
