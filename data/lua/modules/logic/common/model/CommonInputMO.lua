module("modules.logic.common.model.CommonInputMO", package.seeall)

slot0 = class("CommonInputMO")

function slot0.ctor(slot0, slot1, slot2, slot3, slot4)
	slot0.title = slot1 or ""
	slot0.defaultInput = slot2 or ""
	slot0.characterLimit = 50
	slot0.cancelBtnName = luaLang("cancel")
	slot0.sureBtnName = luaLang("sure")
	slot0.cancelCallback = nil
	slot0.sureCallback = slot3
	slot0.callbackObj = slot4
end

return slot0
