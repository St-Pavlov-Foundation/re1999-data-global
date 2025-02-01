module("modules.logic.settings.view.SettingsRoleVoiceViewLangBtn", package.seeall)

slot0 = class("SettingsRoleVoiceViewLangBtn", RougeSimpleItemBase)

function slot0.onInitView(slot0)
	slot0._btnCN = gohelper.findChildButtonWithAudio(slot0.viewGO, "click")
	slot0._goCNUnSelected = gohelper.findChild(slot0.viewGO, "unselected")
	slot0._info1 = gohelper.findChildText(slot0.viewGO, "unselected/info1")
	slot0._goCNSelected = gohelper.findChild(slot0.viewGO, "selected")
	slot0._info2 = gohelper.findChildText(slot0.viewGO, "selected/info2")
	slot0._goCNSelectPoint = gohelper.findChild(slot0.viewGO, "selected/point")

	uv0.super.onInitView(slot0)
end

function slot0.addEvents(slot0)
	slot0._btnCN:AddClickListener(slot0._btnCNOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnCN:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)
end

function slot0.refreshSelected(slot0, slot1)
	slot0:setSelected(slot1 == slot0:_langId())
end

function slot0._curSelectLang(slot0)
	return slot0:parent()._curSelectLang or 0
end

function slot0._useCurLang(slot0)
	slot0:parent():setcurSelectLang(slot0:_langId())
end

function slot0.refreshLangOptionDownloadState(slot0)
	slot0:parent():_refreshLangOptionDownloadState(slot0:_langId(), slot0._goCNUnSelected)
end

function slot0._lang(slot0)
	return slot0._mo.lang
end

function slot0._langId(slot0)
	return slot0._mo.langId
end

function slot0._isValid(slot0)
	return slot0._mo.available
end

function slot0.setData(slot0, slot1)
	slot0._mo = slot1
	slot2 = luaLang(slot0:_lang())
	slot0._info1.text = slot2
	slot0._info2.text = slot2

	slot0:refreshLangOptionDownloadState()
end

function slot0._btnCNOnClick(slot0)
	if slot0:isSelected() then
		return
	end

	if not slot0:_isValid() then
		GameFacade.showToast(ToastEnum.CharVoiceLangLost)

		return
	end

	slot0:_useCurLang()
	slot0:parent():afterSelectedNewLang()
end

function slot0.onSelect(slot0, slot1)
	slot0:_setSelectedActive(slot1)

	slot0._staticData.isSelected = slot1
end

function slot0._setSelectedActive(slot0, slot1)
	gohelper.setActive(slot0._goCNUnSelected, not slot1)
	gohelper.setActive(slot0._goCNSelected, slot1)
end

function slot0._setActive_goCNSelectPoint(slot0, slot1)
	gohelper.setActive(slot0._goCNSelectPoint, slot1)
end

function slot0.refreshLangOptionSelectState(slot0, slot1, slot2)
	slot0:_setActive_goCNSelectPoint(slot1 == slot0:_langId() and slot2)
end

function slot0.refreshLangMode(slot0, slot1)
	slot0:_setSelectedActive(slot1 == slot0:_langId())
end

function slot0.onDestroyView(slot0)
	uv0.super.onDestroyView(slot0)
end

return slot0
