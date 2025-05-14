module("modules.logic.store.view.StoreTipView", package.seeall)

local var_0_0 = class("StoreTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageblur = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_blur")
	arg_1_0._gomonthcardtip = gohelper.findChild(arg_1_0.viewGO, "#go_monthcardtip")
	arg_1_0._gotipcontent = gohelper.findChild(arg_1_0.viewGO, "#go_monthcardtip/tipscroll/Viewport/#go_tipcontent")
	arg_1_0._txttip = gohelper.findChildText(arg_1_0.viewGO, "#go_monthcardtip/tipscroll/Viewport/#go_tipcontent/#txt_tip")
	arg_1_0._simageicon1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_monthcardtip/bg/#simage_icon1")
	arg_1_0._simageicon2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_monthcardtip/bg/#simage_icon2")

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
	arg_4_0._simageicon2:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_4_0._simageicon1:LoadImage(ResUrl.getCommonIcon("bg_2"))

	arg_4_0._txtTitle = gohelper.findChildText(arg_4_0.viewGO, "#go_monthcardtip/title")
end

function var_0_0.onClickModalMask(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._desc(arg_6_0)
	return arg_6_0.viewParam.desc or ""
end

function var_0_0._title(arg_7_0)
	return arg_7_0.viewParam.title or luaLang("p_storetipview_title")
end

function var_0_0.onOpen(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_help_open)

	arg_8_0._txttip.text = arg_8_0:_desc()
	arg_8_0._txtTitle.text = arg_8_0:_title()
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._simageicon1:UnLoadImage()
	arg_10_0._simageicon2:UnLoadImage()
end

return var_0_0
