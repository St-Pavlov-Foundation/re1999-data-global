module("modules.logic.guide.view.GuideDialogueView", package.seeall)

local var_0_0 = class("GuideDialogueView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotipsmask = gohelper.findChild(arg_1_0.viewGO, "#go_tipsmask")
	arg_1_0._gotype4 = gohelper.findChild(arg_1_0.viewGO, "#go_type4")
	arg_1_0._godialogue = gohelper.findChild(arg_1_0.viewGO, "#go_dialogue")
	arg_1_0._txtcontent = gohelper.findChildText(arg_1_0.viewGO, "#go_dialogue/#txt_content")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_dialogue/#txt_name")
	arg_1_0._simageleft = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_dialogue/left/#simage_left")
	arg_1_0._simageright = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_dialogue/right/#simage_right")

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
	arg_4_0._dialogueTr = arg_4_0._godialogue.transform
end

function var_0_0.onDestroyView(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:_updateUI()
	arg_6_0:addEventCb(GuideController.instance, GuideEvent.UpdateMaskView, arg_6_0._updateUI, arg_6_0)
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0:_updateUI()
	arg_7_0:removeEventCb(GuideController.instance, GuideEvent.UpdateMaskView, arg_7_0._updateUI, arg_7_0)
end

function var_0_0._updateUI(arg_8_0)
	if not arg_8_0.viewParam then
		return
	end

	gohelper.setActive(arg_8_0._godialogue, arg_8_0.viewParam.hasDialogue)

	if not arg_8_0.viewParam.hasDialogue then
		return
	end

	if LangSettings.instance:getCurLang() == LangSettings.kr or LangSettings.instance:isEn() then
		arg_8_0._txtcontent.text = arg_8_0.viewParam.tipsContent
	else
		arg_8_0._txtcontent.text = string.gsub(arg_8_0.viewParam.tipsContent, " ", " ")
	end

	arg_8_0._txtname.text = arg_8_0.viewParam.tipsTalker

	gohelper.setActive(arg_8_0._simageleft.gameObject, false)
	gohelper.setActive(arg_8_0._simageright.gameObject, false)

	if string.nilorempty(arg_8_0.viewParam.tipsHead) then
		return
	end

	if arg_8_0.viewParam.portraitPos == 0 then
		arg_8_0._simageTemp = arg_8_0._simageleft
	else
		arg_8_0._simageTemp = arg_8_0._simageright
	end

	gohelper.setActive(arg_8_0._simageTemp.gameObject, true)
	arg_8_0._simageTemp:LoadImage(ResUrl.getHeadIconImg(arg_8_0.viewParam.tipsHead), arg_8_0._loadFinish, arg_8_0)
end

function var_0_0._loadFinish(arg_9_0)
	ZProj.UGUIHelper.SetImageSize(arg_9_0._simageTemp.gameObject)
	arg_9_0:_setPortraitOffset(arg_9_0._simageTemp.gameObject)
end

function var_0_0._setPortraitOffset(arg_10_0, arg_10_1)
	local var_10_0 = SkinConfig.instance:getSkinCo(tonumber(arg_10_0.viewParam.tipsHead))

	if not var_10_0 then
		logError("no skin skinId:" .. arg_10_0.viewParam.tipsHead)

		return
	end

	local var_10_1 = arg_10_0.viewParam.portraitPos == 0
	local var_10_2 = SkinConfig.instance:getSkinOffset(var_10_1 and var_10_0.guideLeftPortraitOffset or var_10_0.guideRightPortraitOffset)
	local var_10_3 = arg_10_1.transform

	recthelper.setAnchor(var_10_3, tonumber(var_10_2[1]), tonumber(var_10_2[2]))
	transformhelper.setLocalScale(var_10_3, tonumber(var_10_2[3]), tonumber(var_10_2[3]), tonumber(var_10_2[3]))
end

function var_0_0.onClose(arg_11_0)
	arg_11_0._simageright:UnLoadImage()
	arg_11_0._simageleft:UnLoadImage()
end

return var_0_0
