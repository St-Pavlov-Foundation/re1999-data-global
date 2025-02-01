module("modules.logic.equip.view.EquipChooseItem", package.seeall)

slot0 = class("EquipChooseItem", ListScrollCellExtend)

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
	slot0._longPressLister = SLFramework.UGUI.UILongPressListener.Get(slot0.viewGO)

	slot0._longPressLister:AddLongPressListener(slot0._longPressTimeEnd, slot0)
	slot0._longPressLister:SetLongPressTime({
		0.5,
		0.2
	})

	slot0._addClick = gohelper.getClick(slot0.viewGO)

	slot0._addClick:AddClickListener(slot0._onClick, slot0)

	slot0._reduceClick = gohelper.getClick(slot0._goreduce)

	slot0._reduceClick:AddClickListener(slot0._onReduceClick, slot0)

	slot0.animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._commonEquipIcon = IconMgr.instance:getCommonEquipIcon(slot0._goequip, 1)

	slot0._commonEquipIcon:_overrideLoadIconFunc(EquipHelper.getEquipIconLoadPath, slot0._commonEquipIcon)
end

function slot0._onReduceClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Forget)
	EquipChooseListModel.instance:deselectEquip(slot0._mo)
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
	slot0:addSelf()
end

function slot0._longPressTimeEnd(slot0)
	if not EquipHelper.isExpEquip(slot0._mo.config) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if slot0:addSelf() == EquipEnum.ChooseEquipStatus.Success then
		slot0.animator:Play(UIAnimationName.Click, 0, 0)
	end
end

function slot0.addSelf(slot0)
	if slot0._mo.isLock then
		return nil
	end

	if EquipChooseListModel.instance:selectEquip(slot0._mo) == EquipEnum.ChooseEquipStatus.BeyondEquipHadNum then
		return slot1
	elseif slot1 == EquipEnum.ChooseEquipStatus.Lock then
		return slot1
	elseif slot1 == EquipEnum.ChooseEquipStatus.BeyondMaxSelectEquip then
		GameFacade.showToast(ToastEnum.MaxEquips)

		return slot1
	elseif slot1 == EquipEnum.ChooseEquipStatus.BeyondMaxStrengthenExperience then
		GameFacade.showToast(ToastEnum.MaxLevEquips)

		return slot1
	end

	EquipController.instance:dispatchEvent(EquipEvent.onAddEquipToPlayEffect, slot0._mo.uid)

	return slot1
end

function slot0._onChooseEquip(slot0)
	EquipController.instance:dispatchEvent(EquipEvent.onChooseEquip)
end

function slot0._editableAddEvents(slot0)
	EquipController.instance:registerCallback(EquipEvent.onChooseChange, slot0._updateSelected, slot0)
	EquipController.instance:registerCallback(EquipEvent.onGuideChooseEquip, slot0._onGuideChooseEquip, slot0)
end

function slot0._editableRemoveEvents(slot0)
	EquipController.instance:unregisterCallback(EquipEvent.onChooseChange, slot0._updateSelected, slot0)
	EquipController.instance:unregisterCallback(EquipEvent.onGuideChooseEquip, slot0._onGuideChooseEquip, slot0)
end

function slot0._onGuideChooseEquip(slot0, slot1)
	if tonumber(slot1) == slot0._index then
		slot0:_onClick()
	end
end

function slot0._updateSelected(slot0)
	if (slot0._mo._chooseNum or 0) > 0 then
		gohelper.setActive(slot0._goreduce, true)

		slot0._commonEquipIcon._txtnum.text = string.format("%s/%s", slot0._mo._chooseNum, GameUtil.numberDisplay(slot0._mo.count))
	else
		gohelper.setActive(slot0._goreduce, false)

		slot0._commonEquipIcon._txtnum.text = GameUtil.numberDisplay(slot0._mo.count)
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0._commonEquipIcon:setEquipMO(slot1)
	slot0:_updateSelected()
end

function slot0.onSelect(slot0, slot1)
	slot0:onUpdateMO(slot0._mo)
end

function slot0.refreshLockUI(slot0)
	slot0._commonEquipIcon:refreshLock(slot0._mo.isLock)
end

function slot0.onDestroyView(slot0)
	slot0._longPressLister:RemoveLongPressListener()
	slot0._addClick:RemoveClickListener()
	slot0._reduceClick:RemoveClickListener()
end

return slot0
