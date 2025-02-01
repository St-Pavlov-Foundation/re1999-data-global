module("modules.logic.equip.view.EquipComposeItem", package.seeall)

slot0 = class("EquipComposeItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goequip = gohelper.findChild(slot0.viewGO, "#go_equip")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#txt_num")
	slot0._goavaliable = gohelper.findChild(slot0.viewGO, "#go_avaliable")
	slot0._gosummon = gohelper.findChild(slot0.viewGO, "#go_avaliable/#go_summon")
	slot0._goselected = gohelper.findChild(slot0.viewGO, "#go_avaliable/#go_selected")
	slot0._gonormalblackbg = gohelper.findChild(slot0.viewGO, "#go_normalblackbg")
	slot0._goblackbg = gohelper.findChild(slot0.viewGO, "#go_avaliable/#go_blackbg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._itemIcon = IconMgr.instance:getCommonEquipIcon(slot0._goequip)

	slot0._itemIcon:hideLockIcon()
	slot0._itemIcon:hideLv(true)
	gohelper.setActive(slot0._gonormalblackbg, true)

	slot0._click = gohelper.getClick(slot0.viewGO)

	slot0._click:AddClickListener(slot0._onClick, slot0)
end

function slot0._onClick(slot0)
	if slot0._num < slot0._needNum then
		GameFacade.showToast(ToastEnum.EquipCompose)

		return
	end

	slot0._mo._selected = not slot0._mo._selected

	slot0:_updateSelected()
end

function slot0.onDestroyView(slot0)
	slot0._click:RemoveClickListener()
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._equipId = slot1[3].id
	slot0._needNum = slot1[2]

	slot0._itemIcon:setMOValue(MaterialEnum.MaterialType.Equip, slot0._equipId, 0)

	slot0._num = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, slot1[1])
	slot0._txtnum.text = string.format("%s/%s", slot0._num, slot0._needNum)
	slot0._avalible = slot0._needNum <= slot0._num

	gohelper.setActive(slot0._goavaliable, slot0._avalible)
	gohelper.setActive(slot0._gonormalblackbg, not slot0._avalible)
	slot0:_updateSelected()
end

function slot0._updateSelected(slot0)
	if slot0._avalible then
		gohelper.setActive(slot0._gosummon, not slot0._mo._selected)
		gohelper.setActive(slot0._goblackbg, slot0._mo._selected)
		gohelper.setActive(slot0._goselected, slot0._mo._selected)
	end
end

function slot0.onSelect(slot0, slot1)
end

return slot0
