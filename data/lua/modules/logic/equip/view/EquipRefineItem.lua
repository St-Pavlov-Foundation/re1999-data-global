module("modules.logic.equip.view.EquipRefineItem", package.seeall)

slot0 = class("EquipRefineItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goequip = gohelper.findChild(slot0.viewGO, "#go_equip")
	slot0._goreduce = gohelper.findChild(slot0.viewGO, "#go_reduce")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.click = gohelper.getClick(slot0.viewGO)

	slot0.click:AddClickListener(slot0._onClick, slot0)

	slot0._reduceClick = gohelper.getClick(slot0._goreduce)

	slot0._reduceClick:AddClickListener(slot0._onReduceClick, slot0)

	slot0.animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._commonEquipIcon = IconMgr.instance:getCommonEquipIcon(slot0._goequip, 1)

	slot0._commonEquipIcon:_overrideLoadIconFunc(EquipHelper.getEquipIconLoadPath, slot0._commonEquipIcon)
end

function slot0._editableAddEvents(slot0)
	EquipController.instance:registerCallback(EquipEvent.OnRefineSelectedEquipChange, slot0.updateSelected, slot0)
	EquipController.instance:registerCallback(EquipEvent.onEquipLockChange, slot0.onEquipLockChange, slot0)
end

function slot0._editableRemoveEvents(slot0)
	EquipController.instance:unregisterCallback(EquipEvent.OnRefineSelectedEquipChange, slot0.updateSelected, slot0)
	EquipController.instance:unregisterCallback(EquipEvent.onEquipLockChange, slot0.onEquipLockChange, slot0)
end

function slot0.onEquipLockChange(slot0, slot1)
	if slot0._mo.id == tonumber(slot1.uid) then
		slot0:refreshLockUI()

		if slot1.isLock then
			EquipRefineListModel.instance:deselectEquip(slot0._mo)
		end
	end
end

function slot0._onReduceClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Forget)
	EquipRefineListModel.instance:deselectEquip(slot0._mo)
	gohelper.setActive(slot0._goreduce, false)
	ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)
end

function slot0._onClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
	slot0.animator:Play(UIAnimationName.Click, 0, 0)

	if slot0._mo.isLock then
		GameFacade.showToast(ToastEnum.EquipChooseLock)

		if EquipHelper.isNormalEquip(slot0._mo.config) then
			ViewMgr.instance:openView(ViewName.EquipInfoTipsView, {
				equipMo = slot0._mo
			})
		end

		return
	end

	ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)

	if EquipRefineListModel.instance:selectEquip(slot0._mo) == EquipRefineListModel.SelectStatusEnum.OutMaxRefineLv then
		GameFacade.showToast(ToastEnum.EquipOutMaxRefineLv)

		return
	elseif slot1 == EquipRefineListModel.SelectStatusEnum.Selected then
		return
	end

	gohelper.setActive(slot0._goreduce, true)
end

function slot0.refreshLockUI(slot0)
	slot0._commonEquipIcon:refreshLock(slot0._mo.isLock)
end

function slot0.updateSelected(slot0)
	gohelper.setActive(slot0._goreduce, EquipRefineListModel.instance:isSelected(slot0._mo))
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0._commonEquipIcon:setEquipMO(slot1)
	slot0:updateSelected()
end

function slot0.onDestroyView(slot0)
	slot0.click:RemoveClickListener()
	slot0._reduceClick:RemoveClickListener()
end

return slot0
