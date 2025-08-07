module("modules.logic.sp01.assassin2.outside.view.AssassinStealthGameGetItemView", package.seeall)

local var_0_0 = class("AssassinStealthGameGetItemView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclick = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "#simage_Mask", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "root/Grid")
	arg_1_0._goItem = gohelper.findChild(arg_1_0.viewGO, "root/Grid/#go_Item")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnCloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_getitems)
	gohelper.CreateObjList(arg_7_0, arg_7_0._onCreateItem, arg_7_0.viewParam, arg_7_0._gocontent, arg_7_0._goItem)
end

function var_0_0._onCreateItem(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = gohelper.findChildImage(arg_8_1, "#simage_Icon")
	local var_8_1 = gohelper.findChildText(arg_8_1, "image_TipsBG/#txt_Num")

	AssassinHelper.setAssassinItemIcon(arg_8_2.itemId, var_8_0)

	var_8_1.text = arg_8_2.count
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
