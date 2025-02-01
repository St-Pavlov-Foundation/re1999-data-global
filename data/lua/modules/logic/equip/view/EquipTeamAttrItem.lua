module("modules.logic.equip.view.EquipTeamAttrItem", package.seeall)

slot0 = class("EquipTeamAttrItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._txtvalue1 = gohelper.findChildText(slot0.viewGO, "#txt_value1")
	slot0._txtname1 = gohelper.findChildText(slot0.viewGO, "#txt_name1")
	slot0._simageicon1 = gohelper.findChildImage(slot0.viewGO, "#simage_icon1")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot2 = slot0._mo.attrId

	CharacterController.instance:SetAttriIcon(slot0._simageicon1, slot2)

	slot0._txtvalue1.text = EquipConfig.instance:getEquipValueStr(slot0._mo)
	slot0._txtname1.text = HeroConfig.instance:getHeroAttributeCO(slot2).name
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
