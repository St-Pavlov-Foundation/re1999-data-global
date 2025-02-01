module("modules.logic.patface.model.PatFaceModel", package.seeall)

slot0 = class("PatFaceModel", BaseModel)
slot1 = {
	Disable = 0,
	Enable = 1
}

function slot0.onInit(slot0)
	slot0:clear()

	slot1 = false

	if isDebugBuild then
		slot1 = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewSkipPatFace)
	end

	slot0:setIsSkipPatFace(slot1 == uv0.Enable)
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.getIsPatting(slot0)
	return slot0._isPattingFace and true or false
end

function slot0.getIsSkipPatFace(slot0)
	return slot0._isSkipPatFace and true or false
end

function slot0.setIsPatting(slot0, slot1)
	if slot1 == slot0._isPattingFace then
		return
	end

	slot0._isPattingFace = slot1
end

function slot0.setIsSkipPatFace(slot0, slot1, slot2)
	slot3 = slot1 and true or false
	slot0._isSkipPatFace = slot3

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewSkipPatFace, slot3 and uv0.Enable or uv0.Disable)

	if slot2 then
		GameFacade.showToast(slot3 and ToastEnum.SkipPatFace or ToastEnum.CancelSkipPatFace)
	end
end

function slot0.clear(slot0)
	slot0:setIsPatting(false)
	uv0.super.clear(slot0)
end

slot0.instance = slot0.New()

return slot0
