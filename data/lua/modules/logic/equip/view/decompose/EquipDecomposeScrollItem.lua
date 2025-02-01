module("modules.logic.equip.view.decompose.EquipDecomposeScrollItem", package.seeall)

slot0 = class("EquipDecomposeScrollItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goequip = gohelper.findChild(slot0.viewGO, "#go_commonequipicon")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "#go_selected")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.animator = slot0.viewGO:GetComponent(gohelper.Type_Animator)
	slot0.goAni = gohelper.findChild(slot0.viewGO, "vx_compose")
	slot0.click = gohelper.getClickWithDefaultAudio(slot0.viewGO)

	slot0.click:AddClickListener(slot0.onClick, slot0)

	slot0.commonEquipIcon = IconMgr.instance:getCommonEquipIcon(slot0._goequip, 1)

	slot0:addEventCb(EquipController.instance, EquipEvent.OnEquipDecomposeSelectEquipChange, slot0.updateSelected, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.OnEquipBeforeDecompose, slot0.beforeDecompose, slot0)
end

function slot0.onClick(slot0)
	if slot0.equipMo.isLock then
		GameFacade.showToast(ToastEnum.EquipChooseLock)
		ViewMgr.instance:openView(ViewName.EquipInfoTipsView, {
			equipMo = slot0.equipMo
		})

		return
	end

	ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)

	if EquipDecomposeListModel.instance:isSelect(slot0.equipUid) then
		EquipDecomposeListModel.instance:desSelectEquipMo(slot0.equipMo)
	else
		EquipDecomposeListModel.instance:selectEquipMo(slot0.equipMo)
	end
end

function slot0.updateSelected(slot0)
	gohelper.setActive(slot0._goselect, EquipDecomposeListModel.instance:isSelect(slot0.equipMo.id))
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.equipMo = slot1
	slot0.equipUid = slot0.equipMo.id

	slot0.commonEquipIcon:setEquipMO(slot1)
	slot0:updateSelected()
	gohelper.setActive(slot0.goAni, false)
end

function slot0.beforeDecompose(slot0)
	if EquipDecomposeListModel.instance:isSelect(slot0.equipUid) then
		gohelper.setActive(slot0.goAni, true)
	end
end

function slot0.getAnimator(slot0)
	return slot0.animator
end

function slot0.onDestroyView(slot0)
	slot0.click:RemoveClickListener()
end

return slot0
