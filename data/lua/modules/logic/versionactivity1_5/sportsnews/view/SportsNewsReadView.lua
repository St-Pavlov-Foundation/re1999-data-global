module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsReadView", package.seeall)

local var_0_0 = class("SportsNewsReadView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "#txt_Title")
	arg_1_0._txtTitleEn = gohelper.findChildText(arg_1_0.viewGO, "txt_TitleEn")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "Scroll View/Viewport/#txt_Descr")
	arg_1_0._goRedPoint = gohelper.findChild(arg_1_0.viewGO, "#go_RedPoint")
	arg_1_0._imagepic = gohelper.findChildSingleImage(arg_1_0.viewGO, "image_Pic")

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

function var_0_0._btnstartbtnOnClick(arg_5_0)
	return
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = arg_7_0.viewParam.orderMO

	arg_7_0._txtTitle.text = tostring(var_7_0.cfg.name)
	arg_7_0._txtTitleEn.text = tostring(var_7_0.cfg.titledesc)
	arg_7_0._txtDescr.text = var_7_0.cfg.infoDesc

	local var_7_1 = var_7_0.cfg.bossPic

	arg_7_0._imagepic:LoadImage(ResUrl.getV1a5News(var_7_1))
end

function var_0_0.onDestroyView(arg_8_0)
	arg_8_0._imagepic:UnLoadImage()
end

function var_0_0.onClickModalMask(arg_9_0)
	arg_9_0:closeThis()
end

return var_0_0
