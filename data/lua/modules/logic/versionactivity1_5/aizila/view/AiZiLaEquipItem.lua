module("modules.logic.versionactivity1_5.aizila.view.AiZiLaEquipItem", package.seeall)

slot0 = class("AiZiLaEquipItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0._gounSelected = gohelper.findChild(slot0.viewGO, "go_unSelected")
	slot0._txtunlevel = gohelper.findChildText(slot0.viewGO, "go_unSelected/txt_unlevel")
	slot0._txtunname = gohelper.findChildText(slot0.viewGO, "go_unSelected/txt_unname")
	slot0._goselected = gohelper.findChild(slot0.viewGO, "go_selected")
	slot0._txtlevel = gohelper.findChildText(slot0.viewGO, "go_selected/txt_level")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "go_selected/txt_name")
	slot0._goLeUp = gohelper.findChild(slot0.viewGO, "image_LvUp")
	slot0._btnClick = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn_Click")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEventListeners(slot0)
	slot0._btnClick:AddClickListener(slot0._btnClickOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnClick:RemoveClickListener()
end

function slot0._btnClickOnClick(slot0)
	AiZiLaController.instance:dispatchEvent(AiZiLaEvent.UISelectEquipType, slot0:getTypeId())
end

function slot0._editableInitView(slot0)
	slot0._govxrefresh = gohelper.findChild(slot0.viewGO, "vx_refresh")
end

function slot0.onDestroy(slot0)
end

function slot0.setName(slot0, slot1)
	slot0._txtunname.text = slot1
	slot0._txtname.text = slot1
end

function slot0.setCfg(slot0, slot1)
	slot0._config = slot1
	slot0._typeId = slot1.typeId

	slot0:setName(slot1.name)
end

function slot0.getTypeId(slot0)
	return slot0._typeId
end

function slot0.refreshUpLevel(slot0)
	slot0:refreshUI()
	gohelper.setActive(slot0._govxrefresh, false)
	gohelper.setActive(slot0._govxrefresh, true)
end

function slot0.refreshUI(slot0, slot1)
	slot2 = AiZiLaModel.instance:getEquipMO(slot0._typeId)

	gohelper.setActive(slot0._txtlevel, slot2)
	gohelper.setActive(slot0._txtunlevel, slot2)
	gohelper.setActive(slot0._goLeUp, slot1 ~= true and slot2 and slot2:isCanUpLevel())

	if slot2 and slot0._lastLevel ~= (slot2:getConfig() and slot3.level) then
		slot0._lastLevel = slot4
		slot5 = string.format("Lv.%s", slot4)
		slot0._txtlevel.text = slot5
		slot0._txtunlevel.text = slot5
	end
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._goselected, slot1)
	gohelper.setActive(slot0._gounSelected, not slot1)
end

return slot0
