module("modules.logic.voice.view.VoiceChooseItem", package.seeall)

slot0 = class("VoiceChooseItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._goSelect = gohelper.findChild(slot1, "#go_selected")
	slot0._txtTitle = gohelper.findChildText(slot1, "#txt_title")
	slot0._txtDec = gohelper.findChildText(slot1, "#txt_dec")
	slot0._click = gohelper.getClick(slot1)
end

function slot0.addEventListeners(slot0)
	slot0._click:AddClickListener(slot0._onClickThis, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._click:RemoveClickListener()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	gohelper.setActive(slot0._goSelect, slot0._mo.choose)

	slot0._txtTitle.text = luaLang("langtype_" .. slot0._mo.lang)
	slot0._txtDec.text = SettingsConfig.instance:getVoiceTips(slot0._mo.lang)
end

function slot0._onClickThis(slot0)
	VoiceChooseModel.instance:choose(slot0._mo.lang)
end

return slot0
