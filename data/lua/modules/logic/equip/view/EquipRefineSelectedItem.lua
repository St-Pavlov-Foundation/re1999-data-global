module("modules.logic.equip.view.EquipRefineSelectedItem", package.seeall)

local var_0_0 = class("EquipRefineSelectedItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "#go_cost_empty")
	arg_1_0._goequip = gohelper.findChild(arg_1_0.viewGO, "#go_cost_equip")
	arg_1_0._btnclick = gohelper.findChildButton(arg_1_0.viewGO, "#btn_add_click")
	arg_1_0._goClickEffect = gohelper.findChild(arg_1_0.viewGO, "#click_effect")
	arg_1_0._effectImage = gohelper.findChildImage(arg_1_0.viewGO, "#click_effect/images")
	arg_1_0._addEffectAnim = arg_1_0._goClickEffect:GetComponent(typeof(UnityEngine.Animation))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	if arg_4_0._isEmpty then
		EquipController.instance:dispatchEvent(EquipEvent.onChangeRefineScrollState, true)
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Forget)
		EquipRefineListModel.instance:deselectEquip(arg_4_0._mo)
		EquipRefineListModel.instance:refreshData()
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._commonEquipIcon = IconMgr.instance:getCommonEquipIcon(arg_5_0._goequip, 1)

	arg_5_0._commonEquipIcon:_overrideLoadIconFunc(EquipHelper.getEquipIconLoadPath, arg_5_0._commonEquipIcon)
	gohelper.setActive(arg_5_0._goequip, false)

	arg_5_0._isEmpty = true

	arg_5_0:initAddEquipEffect()
end

function var_0_0._editableAddEvents(arg_6_0)
	return
end

function var_0_0._editableRemoveEvents(arg_7_0)
	return
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0:_stopAddEquipEffect()

	arg_8_0._mo = arg_8_1
	arg_8_0._isEmpty = true

	if arg_8_0._mo.config then
		arg_8_0._isEmpty = false

		arg_8_0._commonEquipIcon:setEquipMO(arg_8_0._mo)
	end

	gohelper.setActive(arg_8_0._goClickEffect, not arg_8_0._isEmpty)
	gohelper.setActive(arg_8_0._goequip, not arg_8_0._isEmpty)
	gohelper.setActive(arg_8_0._goempty, arg_8_0._isEmpty)
end

function var_0_0.initAddEquipEffect(arg_9_0)
	local var_9_0 = arg_9_0._effectImage.material

	arg_9_0._effectImage.material = UnityEngine.Object.Instantiate(var_9_0)

	local var_9_1 = arg_9_0._goClickEffect:GetComponent(typeof(ZProj.MaterialPropsCtrl))

	var_9_1.mas:Clear()
	var_9_1.mas:Add(arg_9_0._effectImage.material)
	arg_9_0._addEffectAnim:Stop()
end

function var_0_0._playAddEquipEffect(arg_10_0, arg_10_1)
	if arg_10_0._mo.uid == arg_10_1 then
		arg_10_0._addEffectAnim.enabled = true

		gohelper.setActive(arg_10_0._effectImage.gameObject, true)
		arg_10_0._addEffectAnim:Stop()
		arg_10_0._addEffectAnim:Play()
	end
end

function var_0_0.dispose(arg_11_0)
	return
end

function var_0_0._stopAddEquipEffect(arg_12_0)
	arg_12_0._addEffectAnim:Rewind()

	arg_12_0._addEffectAnim.enabled = false

	gohelper.setActive(arg_12_0._effectImage.gameObject, false)
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
