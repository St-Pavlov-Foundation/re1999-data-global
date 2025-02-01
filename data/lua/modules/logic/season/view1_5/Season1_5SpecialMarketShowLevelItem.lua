module("modules.logic.season.view1_5.Season1_5SpecialMarketShowLevelItem", package.seeall)

slot0 = class("Season1_5SpecialMarketShowLevelItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._goline = gohelper.findChild(slot1, "#go_line")
	slot0._goselectedpass = gohelper.findChild(slot1, "#go_selectedpass")
	slot0._txtselectpassindex = gohelper.findChildText(slot1, "#go_selectedpass/#txt_selectpassindex")
	slot0._goselectedunpass = gohelper.findChild(slot1, "#go_selectedunpass")
	slot0._txtselectunpassindex = gohelper.findChildText(slot1, "#go_selectedunpass/#txt_selectunpassindex")
	slot0._gopass = gohelper.findChild(slot1, "#go_pass")
	slot0._txtpassindex = gohelper.findChildText(slot1, "#go_pass/#txt_passindex")
	slot0._gounpass = gohelper.findChild(slot1, "#go_unpass")
	slot0._txtunpassindex = gohelper.findChildText(slot1, "#go_unpass/#txt_unpassindex")
	slot0._btnClick = gohelper.findChildButtonWithAudio(slot1, "#btn_click")

	slot0._btnClick:AddClickListener(slot0._btnOnClick, slot0)
end

function slot0._btnOnClick(slot0)
	Activity104Controller.instance:dispatchEvent(Activity104Event.SwitchSpecialEpisode, slot0.index)
end

function slot0.reset(slot0, slot1, slot2, slot3)
	slot0.index = slot1
	slot0.targetIndex = slot2
	slot0.maxSpecialLayer = slot3

	slot0:_refreshItem()
end

function slot0._refreshItem(slot0)
	gohelper.setActive(slot0.go, true)
	gohelper.setActive(slot0._gopass, Activity104Model.instance:isSpecialLayerPassed(slot0.index) and slot0.targetIndex ~= slot0.index)
	gohelper.setActive(slot0._gounpass, not slot1 and slot0.targetIndex ~= slot0.index)
	gohelper.setActive(slot0._goselectedpass, slot1 and slot0.targetIndex == slot0.index)
	gohelper.setActive(slot0._goselectedunpass, not slot1 and slot0.targetIndex == slot0.index)
	gohelper.setActive(slot0._goline, slot0.index < slot0.maxSpecialLayer)

	slot0._txtselectpassindex.text = string.format("%02d", slot0.index)
	slot0._txtselectunpassindex.text = string.format("%02d", slot0.index)
	slot0._txtpassindex.text = string.format("%02d", slot0.index)
	slot0._txtunpassindex.text = string.format("%02d", slot0.index)
end

function slot0.destroy(slot0)
	slot0._btnClick:RemoveClickListener()
end

return slot0
