module("modules.logic.activity.view.V2a8_DragonBoat_FullView", package.seeall)

local var_0_0 = class("V2a8_DragonBoat_FullView", V2a8_DragonBoat_ViewImpl)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._imagetitle = gohelper.findChildImage(arg_1_0.viewGO, "#image_title")
	arg_1_0._imagelogo = gohelper.findChildImage(arg_1_0.viewGO, "#image_logo")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "timebg/#txt_LimitTime")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_start")
	arg_1_0._scrollItemList = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_ItemList")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
	arg_2_0._btnnormal:AddClickListener(arg_2_0._onItemClick, arg_2_0)
	arg_2_0._btncanget:AddClickListener(arg_2_0._onItemClick, arg_2_0)
	arg_2_0._btnhasget:AddClickListener(arg_2_0._onItemClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0._btnstart:RemoveClickListener()
	arg_3_0._btnnormal:RemoveClickListener()
	arg_3_0._btncanget:RemoveClickListener()
	arg_3_0._btnhasget:RemoveClickListener()
end

function var_0_0._btnstartOnClick(arg_4_0)
	arg_4_0:_onClickMedicinalBath()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._normalGo = gohelper.findChild(arg_5_0.viewGO, "reward/normal")
	arg_5_0._cangetGo = gohelper.findChild(arg_5_0.viewGO, "reward/canget")
	arg_5_0._hasgetGo = gohelper.findChild(arg_5_0.viewGO, "reward/hasget")
	arg_5_0._txt_dec = gohelper.findChildText(arg_5_0._normalGo, "tips/txt_dec")
	arg_5_0._leftGo = gohelper.findChild(arg_5_0.viewGO, "Left")
	arg_5_0._btnstartGO = arg_5_0._btnstart.gameObject
	arg_5_0._scrollItemListGo = arg_5_0._scrollItemList.gameObject
	arg_5_0._btnnormal = gohelper.getClickWithDefaultAudio(arg_5_0._normalGo)
	arg_5_0._btncanget = gohelper.getClickWithDefaultAudio(arg_5_0._cangetGo)
	arg_5_0._btnhasget = gohelper.getClickWithDefaultAudio(arg_5_0._hasgetGo)

	arg_5_0:internal_set_openMode(Activity101SignViewBase.eOpenMode.ActivityBeginnerView)
	var_0_0.super._editableInitView(arg_5_0)
end

return var_0_0
