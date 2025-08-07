module("modules.logic.character.view.extra.CharacterWeaponEffectView", package.seeall)

local var_0_0 = class("CharacterWeaponEffectView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")
	arg_1_0._goscroll = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/#scroll")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "root/#go_item")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.onChoiceHero3123WeaponReply, arg_2_0._onChoiceHero3123WeaponReply, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.onChoiceHero3123WeaponReply, arg_3_0._onChoiceHero3123WeaponReply, arg_3_0)
end

function var_0_0._onChoiceHero3123WeaponReply(arg_4_0, arg_4_1, arg_4_2)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0._items) do
		iter_4_1:refreshSelect()
	end
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.heroMo = arg_7_0.viewParam
	arg_7_0._items = arg_7_0:getUserDataTb_()

	gohelper.setActive(arg_7_0._goitem, false)

	local var_7_0 = CharacterWeaponListModel.instance:getMoList(arg_7_0.heroMo)

	gohelper.CreateObjList(arg_7_0, arg_7_0._createItem, var_7_0, arg_7_0._goscroll.content.gameObject, arg_7_0._goitem, CharacterWeaponEffectItem)
end

function var_0_0._createItem(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_1:onUpdateMO(arg_8_2, arg_8_0.heroMo, arg_8_3)

	arg_8_0._items[arg_8_3] = arg_8_1
end

function var_0_0.onClickModalMask(arg_9_0)
	arg_9_0:closeThis()
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
