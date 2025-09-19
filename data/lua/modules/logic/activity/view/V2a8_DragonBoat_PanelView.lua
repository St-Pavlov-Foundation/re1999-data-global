module("modules.logic.activity.view.V2a8_DragonBoat_PanelView", package.seeall)

local var_0_0 = class("V2a8_DragonBoat_PanelView", V2a8_DragonBoat_ViewImpl)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#simage_FullBG")
	arg_1_0._imagetitle = gohelper.findChildImage(arg_1_0.viewGO, "root/#image_title")
	arg_1_0._imagelogo = gohelper.findChildImage(arg_1_0.viewGO, "root/#image_logo")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "root/timebg/#txt_LimitTime")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/Left/#btn_start")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "root/reward/normal/#go_item")
	arg_1_0._scrollItemList = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/#scroll_ItemList")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
	arg_2_0._btnnormal:AddClickListener(arg_2_0._onItemClick, arg_2_0)
	arg_2_0._btncanget:AddClickListener(arg_2_0._onItemClick, arg_2_0)
	arg_2_0._btnhasget:AddClickListener(arg_2_0._onItemClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnstart:RemoveClickListener()
	arg_3_0._btnnormal:RemoveClickListener()
	arg_3_0._btncanget:RemoveClickListener()
	arg_3_0._btnhasget:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnstartOnClick(arg_5_0)
	arg_5_0:_onClickMedicinalBath()
end

function var_0_0._btnemptyTopOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._btnemptyBottomOnClick(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0._btnemptyLeftOnClick(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0._btnemptyRightOnClick(arg_9_0)
	arg_9_0:closeThis()
end

function var_0_0.onClickModalMask(arg_10_0)
	arg_10_0:closeThis()
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0._normalGo = gohelper.findChild(arg_11_0.viewGO, "root/reward/normal")
	arg_11_0._cangetGo = gohelper.findChild(arg_11_0.viewGO, "root/reward/canget")
	arg_11_0._hasgetGo = gohelper.findChild(arg_11_0.viewGO, "root/reward/hasget")
	arg_11_0._txt_dec = gohelper.findChildText(arg_11_0._normalGo, "tips/txt_dec")
	arg_11_0._leftGo = gohelper.findChild(arg_11_0.viewGO, "root/Left")
	arg_11_0._btnstartGO = arg_11_0._btnstart.gameObject
	arg_11_0._scrollItemListGo = arg_11_0._scrollItemList.gameObject
	arg_11_0._btnnormal = gohelper.getClickWithDefaultAudio(arg_11_0._normalGo)
	arg_11_0._btncanget = gohelper.getClickWithDefaultAudio(arg_11_0._cangetGo)
	arg_11_0._btnhasget = gohelper.getClickWithDefaultAudio(arg_11_0._hasgetGo)

	arg_11_0:internal_set_openMode(Activity101SignViewBase.eOpenMode.PaiLian)
	var_0_0.super._editableInitView(arg_11_0)
end

return var_0_0
