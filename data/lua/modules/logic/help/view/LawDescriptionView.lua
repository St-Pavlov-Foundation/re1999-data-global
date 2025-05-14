module("modules.logic.help.view.LawDescriptionView", package.seeall)

local var_0_0 = class("LawDescriptionView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageblur = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_blur")
	arg_1_0._simagetop = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_top")
	arg_1_0._simagebottom = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bottom")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "title/#txt_title")
	arg_1_0._txttext = gohelper.findChildText(arg_1_0.viewGO, "scroll/viewport/#txt_text")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.onClickModalMask(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._simagetop:LoadImage(ResUrl.getCommonIcon("bg_2"))
	arg_6_0._simagebottom:LoadImage(ResUrl.getCommonIcon("bg_1"))
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	local var_8_0 = arg_8_0.viewParam.id
	local var_8_1 = HelpConfig.instance:getHelpPageCo(var_8_0)

	arg_8_0._txttitle.text = var_8_1.title
	arg_8_0._txttext.text = var_8_1.text
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._simagetop:UnLoadImage()
	arg_10_0._simagebottom:UnLoadImage()
end

return var_0_0
