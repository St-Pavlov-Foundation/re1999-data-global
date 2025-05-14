module("modules.logic.equip.view.EquipChooseView", package.seeall)

local var_0_0 = class("EquipChooseView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._scrollequip = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_equip")
	arg_1_0._gostrengthenbtns = gohelper.findChild(arg_1_0.viewGO, "topright/#go_strengthenbtns")
	arg_1_0._btnfastadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "topright/#go_strengthenbtns/fast/#btn_fastadd")
	arg_1_0._btnupgrade = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "topright/#go_strengthenbtns/start/#btn_upgrade")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnfastadd:AddClickListener(arg_2_0._btnfastaddOnClick, arg_2_0)
	arg_2_0._btnupgrade:AddClickListener(arg_2_0._btnupgradeOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnfastadd:RemoveClickListener()
	arg_3_0._btnupgrade:RemoveClickListener()
end

function var_0_0._btnfastaddOnClick(arg_4_0)
	EquipController.instance:dispatchEvent(EquipEvent.onStrengthenFast)
end

function var_0_0._btnupgradeOnClick(arg_5_0)
	EquipController.instance:dispatchEvent(EquipEvent.onStrengthenUpgrade)
end

function var_0_0._btncloseOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._editableInitView(arg_7_0)
	EquipChooseListModel.instance:setEquipList()
end

function var_0_0._refreshBtns(arg_8_0)
	return
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	return
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
