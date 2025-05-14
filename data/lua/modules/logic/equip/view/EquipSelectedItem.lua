module("modules.logic.equip.view.EquipSelectedItem", package.seeall)

local var_0_0 = class("EquipSelectedItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "#go_empty")
	arg_1_0._goequip = gohelper.findChild(arg_1_0.viewGO, "#go_equip")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")
	arg_1_0._goClickEffect = gohelper.findChild(arg_1_0.viewGO, "#click_effect")
	arg_1_0._goEffectImage = gohelper.findChild(arg_1_0.viewGO, "#click_effect/images")
	arg_1_0._addEffectAnim = arg_1_0._goClickEffect:GetComponent(typeof(UnityEngine.Animation))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0:addEventCb(EquipController.instance, EquipEvent.onAddEquipToPlayEffect, arg_2_0._playAddEquipEffect, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	if arg_4_0._isEmpty then
		EquipController.instance:dispatchEvent(EquipEvent.onChangeStrengthenScrollState, true)
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Forget)
		EquipChooseListModel.instance:deselectEquip(arg_4_0._mo)
		EquipController.instance:dispatchEvent(EquipEvent.onChooseEquip)
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._commonEquipIcon = IconMgr.instance:getCommonEquipIcon(arg_5_0._goequip, 1)

	arg_5_0._commonEquipIcon:_overrideLoadIconFunc(EquipHelper.getEquipIconLoadPath, arg_5_0._commonEquipIcon)
	gohelper.setActive(arg_5_0._goequip, false)
	gohelper.removeUIClickAudio(arg_5_0._btnclick.gameObject)

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

		arg_8_0._commonEquipIcon._txtnum.text = string.format("%s/%s", arg_8_0._mo._chooseNum, GameUtil.numberDisplay(arg_8_0._mo.count))
	end

	gohelper.setActive(arg_8_0._goClickEffect, not arg_8_0._isEmpty)
	gohelper.setActive(arg_8_0._goequip, not arg_8_0._isEmpty)
	gohelper.setActive(arg_8_0._goempty, arg_8_0._isEmpty)
end

function var_0_0.initAddEquipEffect(arg_9_0)
	local var_9_0 = gohelper.findChildImage(arg_9_0._goClickEffect, "images")
	local var_9_1 = var_9_0.material

	var_9_0.material = UnityEngine.Object.Instantiate(var_9_1)

	local var_9_2 = arg_9_0._goClickEffect:GetComponent(typeof(ZProj.MaterialPropsCtrl))

	var_9_2.mas:Clear()
	var_9_2.mas:Add(var_9_0.material)
	arg_9_0._addEffectAnim:Stop()
end

function var_0_0._playAddEquipEffect(arg_10_0, arg_10_1)
	if tabletool.indexOf(arg_10_1, arg_10_0._mo.uid) then
		arg_10_0._addEffectAnim.enabled = true

		gohelper.setActive(arg_10_0._goEffectImage, true)
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

	gohelper.setActive(arg_12_0._goEffectImage, false)
end

function var_0_0.onSelect(arg_13_0, arg_13_1)
	return
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0
