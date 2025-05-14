module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogNormalRightItem", package.seeall)

local var_0_0 = class("AergusiDialogNormalRightItem", AergusiDialogItem)

function var_0_0.initView(arg_1_0)
	arg_1_0._gorolebg = gohelper.findChild(arg_1_0.go, "rolebg")
	arg_1_0._simageAvatar = gohelper.findChildSingleImage(arg_1_0.go, "rolebg/image_avatar")
	arg_1_0._gorolebggrey = gohelper.findChild(arg_1_0.go, "rolebg_grey")
	arg_1_0._simageAvatarGrey = gohelper.findChildSingleImage(arg_1_0.go, "rolebg_grey/image_avatar")
	arg_1_0._txtName = gohelper.findChildText(arg_1_0.go, "name")
	arg_1_0._txtNameGrey = gohelper.findChildText(arg_1_0.go, "name_grey")
	arg_1_0._txtContent = gohelper.findChildText(arg_1_0.go, "content_bg/txt_content")
	arg_1_0._goreference = gohelper.findChild(arg_1_0.go, "content_bg/txt_content/#go_reference")
	arg_1_0._txtreference = gohelper.findChildText(arg_1_0.go, "content_bg/txt_content/#go_reference/#txt_reference")
	arg_1_0._goiconobjection = gohelper.findChild(arg_1_0.go, "content_bg/txt_content/#go_reference/#txt_reference/icon_objection")
	arg_1_0._goiconask = gohelper.findChild(arg_1_0.go, "content_bg/txt_content/#go_reference/#txt_reference/icon_ask")
	arg_1_0._goreferencegrey = gohelper.findChild(arg_1_0.go, "content_bg/txt_content/#go_reference_grey")
	arg_1_0._txtreferencegrey = gohelper.findChildText(arg_1_0.go, "content_bg/txt_content/#go_reference_grey/#txt_reference")
	arg_1_0._goiconobjectiongrey = gohelper.findChild(arg_1_0.go, "content_bg/txt_content/#go_reference_grey/#txt_reference/icon_objection")
	arg_1_0._goiconaskgrey = gohelper.findChild(arg_1_0.go, "content_bg/txt_content/#go_reference_grey/#txt_reference/icon_ask")
	arg_1_0._goselectframe = gohelper.findChild(arg_1_0.go, "content_bg/selectframe")
	arg_1_0._gomaskgrey = gohelper.findChild(arg_1_0.go, "content_bg/mask_grey")
	arg_1_0._contentBgRt = gohelper.findChildComponent(arg_1_0.go, "content_bg", gohelper.Type_RectTransform)
	arg_1_0._contentRt = arg_1_0._txtContent:GetComponent(gohelper.Type_RectTransform)
	arg_1_0.go.name = string.format("normalrightitem_%s_%s", arg_1_0.stepCo.id, arg_1_0.stepCo.stepId)

	AudioMgr.instance:trigger(AudioEnum.Dialogue.play_ui_wulu_duihua)

	arg_1_0._isReference = false
	arg_1_0._txtContentMarkTopIndex = arg_1_0:createMarktopCmp(arg_1_0._txtContent)

	arg_1_0:setTopOffset(arg_1_0._txtContentMarkTopIndex, 0, -6.151)
end

function var_0_0.refresh(arg_2_0)
	local var_2_0 = AergusiDialogModel.instance:getCurDialogGroup()

	gohelper.setActive(arg_2_0._gorolebg, var_2_0 == arg_2_0.stepCo.id)
	gohelper.setActive(arg_2_0._gorolebggrey, var_2_0 ~= arg_2_0.stepCo.id)
	gohelper.setActive(arg_2_0._txtName.gameObject, var_2_0 == arg_2_0.stepCo.id)
	gohelper.setActive(arg_2_0._txtNameGrey.gameObject, var_2_0 ~= arg_2_0.stepCo.id)
	gohelper.setActive(arg_2_0._gomaskgrey, var_2_0 ~= arg_2_0.stepCo.id)
	gohelper.setActive(arg_2_0._goreference, var_2_0 == arg_2_0.stepCo.id)
	gohelper.setActive(arg_2_0._goreferencegrey, var_2_0 ~= arg_2_0.stepCo.id)
	arg_2_0:setTextWithMarktopByIndex(arg_2_0._txtContentMarkTopIndex, arg_2_0.stepCo.content)
	arg_2_0._simageAvatar:LoadImage(ResUrl.getHeadIconSmall(arg_2_0.stepCo.speakerIcon))
	arg_2_0._simageAvatarGrey:LoadImage(ResUrl.getHeadIconSmall(arg_2_0.stepCo.speakerIcon))

	arg_2_0._txtName.text = arg_2_0.stepCo.speaker
	arg_2_0._txtNameGrey.text = arg_2_0.stepCo.speaker

	gohelper.setActive(arg_2_0._goreference, arg_2_0._isReference)
	gohelper.setActive(arg_2_0._goreferencegrey, arg_2_0._isReference)
	gohelper.setActive(arg_2_0._goselectframe, false)
end

function var_0_0.setQutation(arg_3_0, arg_3_1)
	if not arg_3_1 then
		gohelper.setActive(arg_3_0._goreference, false)

		return
	end

	local var_3_0 = string.splitToNumber(arg_3_1.condition, "#")[1]

	arg_3_0._isReference = true

	gohelper.setActive(arg_3_0._goreference, true)

	arg_3_0._txtreference.text = arg_3_1.content
	arg_3_0._txtreferencegrey.text = arg_3_1.content

	gohelper.setActive(arg_3_0._goiconask, var_3_0 == AergusiEnum.OperationType.Probe)
	gohelper.setActive(arg_3_0._goiconobjection, var_3_0 == AergusiEnum.OperationType.Refutation)
	gohelper.setActive(arg_3_0._goiconaskgrey, var_3_0 == AergusiEnum.OperationType.Probe)
	gohelper.setActive(arg_3_0._goiconobjectiongrey, var_3_0 == AergusiEnum.OperationType.Refutation)
	arg_3_0:refresh()
	arg_3_0:calculateHeight()
end

function var_0_0.calculateHeight(arg_4_0)
	local var_4_0 = arg_4_0._txtContent.preferredWidth

	if var_4_0 <= AergusiEnum.MessageTxtMaxWidth then
		local var_4_1 = AergusiEnum.MessageTxtOneLineHeight + AergusiEnum.MessageBgOffsetHeight

		recthelper.setSize(arg_4_0._contentBgRt, var_4_0 + AergusiEnum.MessageBgOffsetWidth, var_4_1)
		recthelper.setSize(arg_4_0._contentRt, var_4_0, AergusiEnum.MessageTxtOneLineHeight)

		return
	end

	local var_4_2 = AergusiEnum.MessageTxtMaxWidth
	local var_4_3 = arg_4_0._txtContent.preferredHeight
	local var_4_4 = var_4_3 + AergusiEnum.MessageBgOffsetHeight

	recthelper.setSize(arg_4_0._contentBgRt, AergusiEnum.MessageTxtMaxWidth + AergusiEnum.MessageBgOffsetWidth, var_4_4)
	recthelper.setSize(arg_4_0._contentRt, var_4_2, var_4_3)
end

function var_0_0.getHeight(arg_5_0)
	local var_5_0 = arg_5_0._isReference and AergusiEnum.DialogDoubtOffsetHeight or 0

	if arg_5_0._txtContent.preferredWidth <= AergusiEnum.MessageTxtMaxWidth then
		local var_5_1 = AergusiEnum.MessageTxtOneLineHeight + AergusiEnum.MessageBgOffsetHeight

		arg_5_0.height = Mathf.Max(AergusiEnum.MinHeight[arg_5_0.type] + var_5_0 + AergusiEnum.DialogDoubtOffsetHeight, var_5_1 + AergusiEnum.MessageNameHeight + var_5_0 + AergusiEnum.DialogDoubtOffsetHeight)

		return arg_5_0.height
	end

	local var_5_2 = AergusiEnum.MessageTxtMaxWidth
	local var_5_3 = AergusiEnum.MessageTxtOneLineHeight * arg_5_0._txtContent:GetTextInfo(arg_5_0._txtContent.text).lineCount + AergusiEnum.MessageBgOffsetHeight

	arg_5_0.height = Mathf.Max(AergusiEnum.MinHeight[arg_5_0.type] + var_5_0 + AergusiEnum.DialogDoubtOffsetHeight, var_5_3 + AergusiEnum.MessageNameHeight + var_5_0 + AergusiEnum.DialogDoubtOffsetHeight)

	return arg_5_0.height
end

function var_0_0.onDestroy(arg_6_0)
	arg_6_0._simageAvatar:UnLoadImage()
	arg_6_0._simageAvatarGrey:UnLoadImage()
end

return var_0_0
