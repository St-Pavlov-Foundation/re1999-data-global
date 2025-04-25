module("modules.logic.nfc.config.NFCConfig", package.seeall)

slot0 = class("NFCConfig", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"nfc_recognize"
	}
end

function slot0.onInit(slot0)
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "nfc_recognize" then
		slot0._nfcRecognizeConfig = slot2
	end
end

function slot0.getNFCRecognizeCo(slot0, slot1)
	return slot0._nfcRecognizeConfig.configDict[slot1]
end

slot0.instance = slot0.New()

return slot0
