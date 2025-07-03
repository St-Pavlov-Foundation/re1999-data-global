module("modules.logic.equip.view.EquipChooseItem", package.seeall)

local var_0_0 = class("EquipChooseItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goequip = gohelper.findChild(arg_1_0.viewGO, "#go_equip")
	arg_1_0._goreduce = gohelper.findChild(arg_1_0.viewGO, "#go_reduce")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._longPressLister = SLFramework.UGUI.UILongPressListener.Get(arg_4_0.viewGO)

	arg_4_0._longPressLister:AddLongPressListener(arg_4_0._longPressTimeEnd, arg_4_0)
	arg_4_0._longPressLister:SetLongPressTime({
		0.5,
		0.2
	})

	arg_4_0._addClick = gohelper.getClick(arg_4_0.viewGO)

	arg_4_0._addClick:AddClickListener(arg_4_0._onClick, arg_4_0)

	arg_4_0._reduceClick = gohelper.getClick(arg_4_0._goreduce)

	arg_4_0._reduceClick:AddClickListener(arg_4_0._onReduceClick, arg_4_0)

	arg_4_0.animator = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._commonEquipIcon = IconMgr.instance:getCommonEquipIcon(arg_4_0._goequip, 1)

	arg_4_0._commonEquipIcon:_overrideLoadIconFunc(EquipHelper.getEquipIconLoadPath, arg_4_0._commonEquipIcon)
end

function var_0_0._onReduceClick(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Forget)
	EquipChooseListModel.instance:deselectEquip(arg_5_0._mo)
	ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)
end

function var_0_0._onClick(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
	arg_6_0.animator:Play(UIAnimationName.Click, 0, 0)

	if arg_6_0._mo.isLock then
		GameFacade.showToast(ToastEnum.EquipChooseLock)

		if EquipHelper.isNormalEquip(arg_6_0._mo.config) then
			ViewMgr.instance:openView(ViewName.EquipInfoTipsView, {
				equipMo = arg_6_0._mo
			})
		end

		return
	end

	ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)
	arg_6_0:addSelf()
end

function var_0_0._longPressTimeEnd(arg_7_0)
	if not EquipHelper.isExpEquip(arg_7_0._mo.config) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if arg_7_0:addSelf() == EquipEnum.ChooseEquipStatus.Success then
		arg_7_0.animator:Play(UIAnimationName.Click, 0, 0)
	end
end

function var_0_0.addSelf(arg_8_0)
	if arg_8_0._mo.isLock then
		return nil
	end

	local var_8_0 = EquipChooseListModel.instance:selectEquip(arg_8_0._mo)

	if var_8_0 == EquipEnum.ChooseEquipStatus.BeyondEquipHadNum then
		return var_8_0
	elseif var_8_0 == EquipEnum.ChooseEquipStatus.Lock then
		return var_8_0
	elseif var_8_0 == EquipEnum.ChooseEquipStatus.BeyondMaxSelectEquip then
		GameFacade.showToast(ToastEnum.MaxEquips)

		return var_8_0
	elseif var_8_0 == EquipEnum.ChooseEquipStatus.BeyondMaxStrengthenExperience then
		GameFacade.showToast(ToastEnum.MaxLevEquips)

		return var_8_0
	end

	EquipController.instance:dispatchEvent(EquipEvent.onAddEquipToPlayEffect, {
		arg_8_0._mo.uid
	})

	return var_8_0
end

function var_0_0._onChooseEquip(arg_9_0)
	EquipController.instance:dispatchEvent(EquipEvent.onChooseEquip)
end

function var_0_0._editableAddEvents(arg_10_0)
	EquipController.instance:registerCallback(EquipEvent.onChooseChange, arg_10_0._updateSelected, arg_10_0)
	EquipController.instance:registerCallback(EquipEvent.onGuideChooseEquip, arg_10_0._onGuideChooseEquip, arg_10_0)
end

function var_0_0._editableRemoveEvents(arg_11_0)
	EquipController.instance:unregisterCallback(EquipEvent.onChooseChange, arg_11_0._updateSelected, arg_11_0)
	EquipController.instance:unregisterCallback(EquipEvent.onGuideChooseEquip, arg_11_0._onGuideChooseEquip, arg_11_0)
end

function var_0_0._onGuideChooseEquip(arg_12_0, arg_12_1)
	if tonumber(arg_12_1) == arg_12_0._index then
		arg_12_0:_onClick()
	end
end

function var_0_0._updateSelected(arg_13_0)
	if (arg_13_0._mo._chooseNum or 0) > 0 then
		gohelper.setActive(arg_13_0._goreduce, true)

		arg_13_0._commonEquipIcon._txtnum.text = string.format("%s/%s", arg_13_0._mo._chooseNum, GameUtil.numberDisplay(arg_13_0._mo.count))
	else
		gohelper.setActive(arg_13_0._goreduce, false)

		arg_13_0._commonEquipIcon._txtnum.text = GameUtil.numberDisplay(arg_13_0._mo.count)
	end
end

function var_0_0.onUpdateMO(arg_14_0, arg_14_1)
	arg_14_0._mo = arg_14_1

	arg_14_0._commonEquipIcon:setEquipMO(arg_14_1)
	arg_14_0:_updateSelected()
end

function var_0_0.onSelect(arg_15_0, arg_15_1)
	arg_15_0:onUpdateMO(arg_15_0._mo)
end

function var_0_0.refreshLockUI(arg_16_0)
	arg_16_0._commonEquipIcon:refreshLock(arg_16_0._mo.isLock)
end

function var_0_0.onDestroyView(arg_17_0)
	arg_17_0._longPressLister:RemoveLongPressListener()
	arg_17_0._addClick:RemoveClickListener()
	arg_17_0._reduceClick:RemoveClickListener()
end

return var_0_0
