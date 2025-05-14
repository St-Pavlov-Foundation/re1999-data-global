module("modules.logic.dialogue.view.items.DialogueNormalItem", package.seeall)

local var_0_0 = class("DialogueNormalItem", DialogueItem)

function var_0_0._showContent(arg_1_0, arg_1_1)
	TaskDispatcher.cancelTask(arg_1_0._delayShowContent, arg_1_0)

	arg_1_1 = arg_1_1 or ""
	arg_1_0._markTopList = StoryTool.getMarkTopTextList(arg_1_1)
	arg_1_0._contentStr = StoryTool.filterMarkTop(arg_1_1)

	arg_1_0:_setLineSpacing(arg_1_0:_getLineSpacing())

	arg_1_0.txtContent.text = arg_1_0._contentStr

	TaskDispatcher.runDelay(arg_1_0._delayShowContent, arg_1_0, 0.01)
end

function var_0_0._delayShowContent(arg_2_0)
	arg_2_0._conMark:SetMarksTop(arg_2_0._markTopList)
end

function var_0_0._getLineSpacing(arg_3_0)
	return #arg_3_0._markTopList > 0 and arg_3_0._lineSpacing or arg_3_0._originalLineSpacing
end

function var_0_0._setLineSpacing(arg_4_0, arg_4_1)
	arg_4_0.txtContent.lineSpacing = arg_4_1 or 0
end

function var_0_0.initView(arg_5_0)
	arg_5_0.simageAvatar = gohelper.findChildSingleImage(arg_5_0.go, "rolebg/#image_avatar")
	arg_5_0.txtName = gohelper.findChildText(arg_5_0.go, "#txt_name")
	arg_5_0.txtContent = gohelper.findChildText(arg_5_0.go, "content_bg/#txt_content")
	arg_5_0.goLoading = gohelper.findChild(arg_5_0.go, "content_bg/#go_loading")
	arg_5_0.contentBgRectTr = gohelper.findChildComponent(arg_5_0.go, "content_bg", gohelper.Type_RectTransform)
	arg_5_0.txtRectTr = arg_5_0.txtContent:GetComponent(gohelper.Type_RectTransform)
	arg_5_0._txtmarktop = IconMgr.instance:getCommonTextMarkTop(arg_5_0.txtContent.gameObject):GetComponent(gohelper.Type_TextMesh)
	arg_5_0._conMark = gohelper.onceAddComponent(arg_5_0.txtContent.gameObject, typeof(ZProj.TMPMark))

	arg_5_0._conMark:SetMarkTopGo(arg_5_0._txtmarktop.gameObject)
	arg_5_0._conMark:SetTopOffset(8, -2.4)

	arg_5_0._originalLineSpacing = arg_5_0.txtContent.lineSpacing
	arg_5_0._lineSpacing = 26
end

function var_0_0.refresh(arg_6_0)
	arg_6_0.simageAvatar:LoadImage(ResUrl.getHeadIconSmall(arg_6_0.stepCo.avatar))

	arg_6_0.txtName.text = arg_6_0.stepCo.name

	arg_6_0:_showContent(arg_6_0.stepCo.content)
	AudioMgr.instance:trigger(AudioEnum.Dialogue.play_ui_wulu_duihua)
end

function var_0_0.calculateHeight(arg_7_0)
	local var_7_0 = arg_7_0.txtContent.preferredWidth

	if var_7_0 <= DialogueEnum.MessageTxtMaxWidth then
		local var_7_1 = DialogueEnum.MessageTxtOneLineHeight + DialogueEnum.MessageBgOffsetHeight

		recthelper.setSize(arg_7_0.contentBgRectTr, var_7_0 + DialogueEnum.MessageBgOffsetWidth, var_7_1)
		recthelper.setSize(arg_7_0.txtRectTr, var_7_0, DialogueEnum.MessageTxtOneLineHeight)

		arg_7_0.height = Mathf.Max(DialogueEnum.MinHeight[DialogueEnum.Type.LeftMessage], var_7_1 + DialogueEnum.MessageNameHeight)

		return
	end

	local var_7_2 = DialogueEnum.MessageTxtMaxWidth
	local var_7_3 = arg_7_0.txtContent.preferredHeight
	local var_7_4 = var_7_3 + DialogueEnum.MessageBgOffsetHeight

	recthelper.setSize(arg_7_0.contentBgRectTr, DialogueEnum.MessageTxtMaxWidth + DialogueEnum.MessageBgOffsetWidth, var_7_4)
	recthelper.setSize(arg_7_0.txtRectTr, var_7_2, var_7_3)

	arg_7_0.height = Mathf.Max(DialogueEnum.MinHeight[DialogueEnum.Type.LeftMessage], var_7_4 + DialogueEnum.MessageNameHeight)
end

function var_0_0.logHeight(arg_8_0)
	logError(string.format("【%s】", arg_8_0.stepCo.id) .. " : " .. arg_8_0.txtContent.preferredHeight)
	logError(string.format("【%s】", arg_8_0.stepCo.id) .. " : " .. arg_8_0.txtContent.preferredWidth)
	logError(string.format("【%s】", arg_8_0.stepCo.id) .. " : " .. arg_8_0.txtContent.renderedWidth)
	logError(string.format("【%s】", arg_8_0.stepCo.id) .. " : " .. arg_8_0.txtContent.renderedHeight)
end

function var_0_0.onDestroy(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._delayShowContent, arg_9_0)
	arg_9_0.simageAvatar:UnLoadImage()
end

return var_0_0
