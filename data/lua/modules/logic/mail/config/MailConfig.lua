module("modules.logic.mail.config.MailConfig", package.seeall)

slot0 = class("MailConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._mailConfig = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"mail"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "mail" then
		slot0._mailConfig = slot2
	end
end

function slot0.getCategoryCO(slot0)
	return slot0._mailConfig.configDict
end

function slot0.getPropDetailCO(slot0, slot1)
	return slot0._mailConfig.configDict[slot1]
end

slot0.instance = slot0.New()

return slot0
