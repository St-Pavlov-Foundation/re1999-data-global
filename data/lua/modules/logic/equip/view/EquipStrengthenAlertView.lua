module("modules.logic.equip.view.EquipStrengthenAlertView", package.seeall)

local var_0_0 = class("EquipStrengthenAlertView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagetipbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_tipbg")
	arg_1_0._txtcontent = gohelper.findChildText(arg_1_0.viewGO, "#txt_content")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._btnselect = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_btns/#btn_select")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "#go_btns/#btn_select/#go_selected")
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_btns/#btn_cancel")
	arg_1_0._btnok = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_btns/#btn_ok")
	arg_1_0._simagebgnum = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg_num")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnselect:AddClickListener(arg_2_0._btnselectOnClick, arg_2_0)
	arg_2_0._btncancel:AddClickListener(arg_2_0._btncancelOnClick, arg_2_0)
	arg_2_0._btnok:AddClickListener(arg_2_0._btnokOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnselect:RemoveClickListener()
	arg_3_0._btncancel:RemoveClickListener()
	arg_3_0._btnok:RemoveClickListener()
end

function var_0_0._btnselectOnClick(arg_4_0)
	arg_4_0._isSelected = not arg_4_0._isSelected

	arg_4_0._goselected:SetActive(arg_4_0._isSelected)
end

function var_0_0._btncancelOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._btnokOnClick(arg_6_0)
	arg_6_0:closeThis()
	arg_6_0.viewParam.callback(arg_6_0._isSelected)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._simagetipbg:LoadImage(ResUrl.getMessageIcon("bg_tanchuang"))
	arg_7_0._simagebgnum:LoadImage(ResUrl.getMessageIcon("bg_num"))
	gohelper.addUIClickAudio(arg_7_0._btncancel.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
	gohelper.addUIClickAudio(arg_7_0._btnok.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0._txtcontent.text = arg_9_0.viewParam.content
	arg_9_0._isSelected = false

	arg_9_0._goselected:SetActive(arg_9_0._isSelected)
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._simagetipbg:UnLoadImage()
	arg_11_0._simagebgnum:UnLoadImage()
end

return var_0_0
