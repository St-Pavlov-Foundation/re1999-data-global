module("modules.logic.sp01.assassin2.outside.view.AssassinBackpackItem", package.seeall)

local var_0_0 = class("AssassinBackpackItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#simage_icon")
	arg_1_0._goequip = gohelper.findChild(arg_1_0.viewGO, "#go_equip")
	arg_1_0._txtequipIndex = gohelper.findChildText(arg_1_0.viewGO, "#go_equip/#txt_equipIndex")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#txt_num")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "#go_selected")
	arg_1_0._btnclick = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "#btn_click", AudioEnum2_9.StealthGame.play_ui_cikeshang_itemchoose)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.OnChangeEquippedItem, arg_2_0._onChangeEquippedItem, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0:removeEventCb(AssassinController.instance, AssassinEvent.OnChangeEquippedItem, arg_3_0._onChangeEquippedItem, arg_3_0)
end

function var_0_0._btnclickOnClick(arg_4_0)
	AssassinController.instance:backpackSelectItem(arg_4_0._index, true)
end

function var_0_0._onChangeEquippedItem(arg_5_0)
	arg_5_0:refresh(true)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._animator = arg_6_0._goselected:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0._mo = arg_7_1

	arg_7_0:refresh()
end

function var_0_0.refresh(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._mo:getId()

	AssassinHelper.setAssassinItemIcon(var_8_0, arg_8_0._imageicon)

	arg_8_0._txtnum.text = arg_8_0._mo:getCount()

	local var_8_1 = arg_8_0._view.viewContainer.viewParam.assassinHeroId
	local var_8_2 = AssassinHeroModel.instance:getItemCarryIndex(var_8_1, var_8_0)

	if var_8_2 then
		arg_8_0._txtequipIndex.text = var_8_2

		if arg_8_1 and var_8_2 and not arg_8_0._goequip.activeSelf then
			arg_8_0._animator:Play("click", 0, 0)
		end
	end

	gohelper.setActive(arg_8_0._goequip, var_8_2)
end

function var_0_0.onSelect(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0._goselected, arg_9_1)
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
