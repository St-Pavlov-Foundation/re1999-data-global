module("modules.logic.equip.view.decompose.EquipDecomposeScrollItem", package.seeall)

local var_0_0 = class("EquipDecomposeScrollItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goequip = gohelper.findChild(arg_1_0.viewGO, "#go_commonequipicon")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_selected")

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
	arg_4_0.animator = arg_4_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_4_0.goAni = gohelper.findChild(arg_4_0.viewGO, "vx_compose")
	arg_4_0.click = gohelper.getClickWithDefaultAudio(arg_4_0.viewGO)

	arg_4_0.click:AddClickListener(arg_4_0.onClick, arg_4_0)

	arg_4_0.commonEquipIcon = IconMgr.instance:getCommonEquipIcon(arg_4_0._goequip, 1)

	arg_4_0:addEventCb(EquipController.instance, EquipEvent.OnEquipDecomposeSelectEquipChange, arg_4_0.updateSelected, arg_4_0)
	arg_4_0:addEventCb(EquipController.instance, EquipEvent.OnEquipBeforeDecompose, arg_4_0.beforeDecompose, arg_4_0)
end

function var_0_0.onClick(arg_5_0)
	if arg_5_0.equipMo.isLock then
		GameFacade.showToast(ToastEnum.EquipChooseLock)
		ViewMgr.instance:openView(ViewName.EquipInfoTipsView, {
			equipMo = arg_5_0.equipMo
		})

		return
	end

	ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)

	if EquipDecomposeListModel.instance:isSelect(arg_5_0.equipUid) then
		EquipDecomposeListModel.instance:desSelectEquipMo(arg_5_0.equipMo)
	else
		EquipDecomposeListModel.instance:selectEquipMo(arg_5_0.equipMo)
	end
end

function var_0_0.updateSelected(arg_6_0)
	gohelper.setActive(arg_6_0._goselect, EquipDecomposeListModel.instance:isSelect(arg_6_0.equipMo.id))
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0.equipMo = arg_7_1
	arg_7_0.equipUid = arg_7_0.equipMo.id

	arg_7_0.commonEquipIcon:setEquipMO(arg_7_1)
	arg_7_0:updateSelected()
	gohelper.setActive(arg_7_0.goAni, false)
end

function var_0_0.beforeDecompose(arg_8_0)
	if EquipDecomposeListModel.instance:isSelect(arg_8_0.equipUid) then
		gohelper.setActive(arg_8_0.goAni, true)
	end
end

function var_0_0.getAnimator(arg_9_0)
	return arg_9_0.animator
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0.click:RemoveClickListener()
end

return var_0_0
