module("modules.logic.signin.model.SignInListModel", package.seeall)

slot0 = class("SignInListModel", ListScrollModel)

function slot0.setPropList(slot0, slot1)
	slot0._moList = slot1 and slot1 or {}

	slot0:setList(slot0._moList)
end

function slot0.clearPropList(slot0)
	slot0._moList = nil

	slot0:clear()
end

slot0.instance = slot0.New()

return slot0
