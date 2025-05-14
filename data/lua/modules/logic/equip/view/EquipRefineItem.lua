module("modules.logic.equip.view.EquipRefineItem", package.seeall)

local var_0_0 = class("EquipRefineItem", ListScrollCellExtend)

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
	arg_4_0.click = gohelper.getClick(arg_4_0.viewGO)

	arg_4_0.click:AddClickListener(arg_4_0._onClick, arg_4_0)

	arg_4_0._reduceClick = gohelper.getClick(arg_4_0._goreduce)

	arg_4_0._reduceClick:AddClickListener(arg_4_0._onReduceClick, arg_4_0)

	arg_4_0.animator = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._commonEquipIcon = IconMgr.instance:getCommonEquipIcon(arg_4_0._goequip, 1)

	arg_4_0._commonEquipIcon:_overrideLoadIconFunc(EquipHelper.getEquipIconLoadPath, arg_4_0._commonEquipIcon)
end

function var_0_0._editableAddEvents(arg_5_0)
	EquipController.instance:registerCallback(EquipEvent.OnRefineSelectedEquipChange, arg_5_0.updateSelected, arg_5_0)
	EquipController.instance:registerCallback(EquipEvent.onEquipLockChange, arg_5_0.onEquipLockChange, arg_5_0)
end

function var_0_0._editableRemoveEvents(arg_6_0)
	EquipController.instance:unregisterCallback(EquipEvent.OnRefineSelectedEquipChange, arg_6_0.updateSelected, arg_6_0)
	EquipController.instance:unregisterCallback(EquipEvent.onEquipLockChange, arg_6_0.onEquipLockChange, arg_6_0)
end

function var_0_0.onEquipLockChange(arg_7_0, arg_7_1)
	if arg_7_0._mo.id == tonumber(arg_7_1.uid) then
		arg_7_0:refreshLockUI()

		if arg_7_1.isLock then
			EquipRefineListModel.instance:deselectEquip(arg_7_0._mo)
		end
	end
end

function var_0_0._onReduceClick(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Forget)
	EquipRefineListModel.instance:deselectEquip(arg_8_0._mo)
	gohelper.setActive(arg_8_0._goreduce, false)
	ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)
end

function var_0_0._onClick(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
	arg_9_0.animator:Play(UIAnimationName.Click, 0, 0)

	if arg_9_0._mo.isLock then
		GameFacade.showToast(ToastEnum.EquipChooseLock)

		if EquipHelper.isNormalEquip(arg_9_0._mo.config) then
			ViewMgr.instance:openView(ViewName.EquipInfoTipsView, {
				equipMo = arg_9_0._mo
			})
		end

		return
	end

	ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)

	local var_9_0 = EquipRefineListModel.instance:selectEquip(arg_9_0._mo)

	if var_9_0 == EquipRefineListModel.SelectStatusEnum.OutMaxRefineLv then
		GameFacade.showToast(ToastEnum.EquipOutMaxRefineLv)

		return
	elseif var_9_0 == EquipRefineListModel.SelectStatusEnum.Selected then
		return
	end

	gohelper.setActive(arg_9_0._goreduce, true)
end

function var_0_0.refreshLockUI(arg_10_0)
	arg_10_0._commonEquipIcon:refreshLock(arg_10_0._mo.isLock)
end

function var_0_0.updateSelected(arg_11_0)
	gohelper.setActive(arg_11_0._goreduce, EquipRefineListModel.instance:isSelected(arg_11_0._mo))
end

function var_0_0.onUpdateMO(arg_12_0, arg_12_1)
	arg_12_0._mo = arg_12_1

	arg_12_0._commonEquipIcon:setEquipMO(arg_12_1)
	arg_12_0:updateSelected()
end

function var_0_0.onDestroyView(arg_13_0)
	arg_13_0.click:RemoveClickListener()
	arg_13_0._reduceClick:RemoveClickListener()
end

return var_0_0
