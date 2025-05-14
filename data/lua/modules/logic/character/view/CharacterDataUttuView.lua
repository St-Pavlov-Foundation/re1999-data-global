module("modules.logic.character.view.CharacterDataUttuView", package.seeall)

local var_0_0 = class("CharacterDataUttuView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simageredcircle1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "contentview/viewport/content/uttu1/icon/#simage_redcircle1")
	arg_1_0._simageline = gohelper.findChildSingleImage(arg_1_0.viewGO, "contentview/viewport/content/uttu2/icon/#simage_line")
	arg_1_0._txtcontent1 = gohelper.findChildText(arg_1_0.viewGO, "contentview/viewport/content/uttu2/txt/#txt_content1")
	arg_1_0._txtcontent2 = gohelper.findChildText(arg_1_0.viewGO, "contentview/viewport/content/uttu2/txt/#txt_content2")
	arg_1_0._txtcontent3 = gohelper.findChildText(arg_1_0.viewGO, "contentview/viewport/content/uttu3/txt/#txt_content3")
	arg_1_0._gosign = gohelper.findChild(arg_1_0.viewGO, "contentview/viewport/content/uttu3/icon/qianming/#go_sign")
	arg_1_0._goexplain = gohelper.findChild(arg_1_0.viewGO, "contentview/viewport/content/uttu3/icon/shouming/#go_explain")

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
	gohelper.setActive(arg_4_0._gosign, false)
	gohelper.setActive(arg_4_0._goexplain, false)
	arg_4_0._simagebg:LoadImage(ResUrl.getCharacterDataIcon("full/bg.png"))
	arg_4_0._simageredcircle1:LoadImage(ResUrl.getCharacterDataIcon("quan1.png"))
	arg_4_0._simageline:LoadImage(ResUrl.getCharacterDataIcon("fengexian.png"))

	arg_4_0._scrollbar = gohelper.findChildScrollbar(arg_4_0.viewGO, "contentview/contentscrollbar")

	arg_4_0._scrollbar:AddOnValueChanged(arg_4_0._onValueChanged, arg_4_0)

	arg_4_0._contentEffect1 = gohelper.onceAddComponent(arg_4_0._txtcontent1.gameObject, typeof(ZProj.TMPEffect))
	arg_4_0._contentEffect2 = gohelper.onceAddComponent(arg_4_0._txtcontent2.gameObject, typeof(ZProj.TMPEffect))
	arg_4_0._contentEffect3 = gohelper.onceAddComponent(arg_4_0._txtcontent3.gameObject, typeof(ZProj.TMPEffect))
	arg_4_0._maxValue = 0
	arg_4_0._content1LineCount = arg_4_0._txtcontent1:GetTextInfo(arg_4_0._txtcontent1.text).lineCount
	arg_4_0._content2LineCount = arg_4_0._txtcontent2:GetTextInfo(arg_4_0._txtcontent2.text).lineCount
	arg_4_0._content3LineCount = arg_4_0._txtcontent3:GetTextInfo(arg_4_0._txtcontent3.text).lineCount
end

function var_0_0._onValueChanged(arg_5_0, arg_5_1)
	arg_5_0._maxValue = arg_5_0._maxValue > 1 - arg_5_1 and arg_5_0._maxValue or 1 - arg_5_1

	if arg_5_1 < 0.1 then
		gohelper.setActive(arg_5_0._goexplain, true)
	end

	if arg_5_1 < 0.01 then
		gohelper.setActive(arg_5_0._gosign, true)
	end

	if arg_5_0._content1LineCount == 0 then
		arg_5_0._content1LineCount = arg_5_0._txtcontent1:GetTextInfo(arg_5_0._txtcontent1.text).lineCount
		arg_5_0._content2LineCount = arg_5_0._txtcontent2:GetTextInfo(arg_5_0._txtcontent2.text).lineCount
		arg_5_0._content3LineCount = arg_5_0._txtcontent3:GetTextInfo(arg_5_0._txtcontent3.text).lineCount
	end

	if arg_5_0._maxValue > 0.1 then
		arg_5_0._contentEffect1.line = arg_5_0._content1LineCount * 6 * (arg_5_0._maxValue - 0.1)
	end

	if arg_5_0._maxValue > 0.3 then
		arg_5_0._contentEffect2.line = arg_5_0._content2LineCount * 6 * (arg_5_0._maxValue - 0.3)
	end

	if arg_5_0._maxValue > 0.56 then
		arg_5_0._contentEffect3.line = arg_5_0._content3LineCount * 6 * (arg_5_0._maxValue - 0.56)
	end

	arg_5_0._contentEffect1:ForceUpdate()
	arg_5_0._contentEffect2:ForceUpdate()
	arg_5_0._contentEffect3:ForceUpdate()
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	return
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0._scrollbar:RemoveOnValueChanged()
	arg_9_0._simagebg:UnLoadImage()
	arg_9_0._simageredcircle1:UnLoadImage()
	arg_9_0._simageline:UnLoadImage()
end

return var_0_0
