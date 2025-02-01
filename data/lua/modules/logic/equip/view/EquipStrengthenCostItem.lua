module("modules.logic.equip.view.EquipStrengthenCostItem", package.seeall)

slot0 = class("EquipStrengthenCostItem", BaseChildView)

function slot0.onInitView(slot0)
	slot0._goitem = gohelper.findChild(slot0.viewGO, "#go_item")
	slot0._goblank = gohelper.findChild(slot0.viewGO, "#go_blank")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._click = gohelper.getClickWithAudio(slot0.viewGO)

	slot0._click:AddClickListener(slot0._onClick, slot0)
end

function slot0._onClick(slot0)
	EquipController.instance:openEquipChooseView()
end

function slot0.onUpdateParam(slot0)
	if not slot0.viewParam then
		slot0._goblank:SetActive(true)
		slot0._goitem:SetActive(false)

		return
	end

	slot0._goblank:SetActive(false)
	slot0._goitem:SetActive(true)

	if not slot0._itemIcon then
		slot0._itemIcon = IconMgr.instance:getCommonEquipIcon(slot0._goitem)
	end

	slot0._itemIcon:setEquipMO(slot0.viewParam)
	slot0._itemIcon:showLevel()
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._click:RemoveClickListener()
end

return slot0
