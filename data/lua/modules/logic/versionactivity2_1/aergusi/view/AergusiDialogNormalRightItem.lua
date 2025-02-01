module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogNormalRightItem", package.seeall)

slot0 = class("AergusiDialogNormalRightItem", AergusiDialogItem)

function slot0.initView(slot0)
	slot0._gorolebg = gohelper.findChild(slot0.go, "rolebg")
	slot0._simageAvatar = gohelper.findChildSingleImage(slot0.go, "rolebg/image_avatar")
	slot0._gorolebggrey = gohelper.findChild(slot0.go, "rolebg_grey")
	slot0._simageAvatarGrey = gohelper.findChildSingleImage(slot0.go, "rolebg_grey/image_avatar")
	slot0._txtName = gohelper.findChildText(slot0.go, "name")
	slot0._txtNameGrey = gohelper.findChildText(slot0.go, "name_grey")
	slot0._txtContent = gohelper.findChildText(slot0.go, "content_bg/txt_content")
	slot0._goreference = gohelper.findChild(slot0.go, "content_bg/txt_content/#go_reference")
	slot0._txtreference = gohelper.findChildText(slot0.go, "content_bg/txt_content/#go_reference/#txt_reference")
	slot0._goiconobjection = gohelper.findChild(slot0.go, "content_bg/txt_content/#go_reference/#txt_reference/icon_objection")
	slot0._goiconask = gohelper.findChild(slot0.go, "content_bg/txt_content/#go_reference/#txt_reference/icon_ask")
	slot0._goreferencegrey = gohelper.findChild(slot0.go, "content_bg/txt_content/#go_reference_grey")
	slot0._txtreferencegrey = gohelper.findChildText(slot0.go, "content_bg/txt_content/#go_reference_grey/#txt_reference")
	slot0._goiconobjectiongrey = gohelper.findChild(slot0.go, "content_bg/txt_content/#go_reference_grey/#txt_reference/icon_objection")
	slot0._goiconaskgrey = gohelper.findChild(slot0.go, "content_bg/txt_content/#go_reference_grey/#txt_reference/icon_ask")
	slot0._goselectframe = gohelper.findChild(slot0.go, "content_bg/selectframe")
	slot0._gomaskgrey = gohelper.findChild(slot0.go, "content_bg/mask_grey")
	slot0._contentBgRt = gohelper.findChildComponent(slot0.go, "content_bg", gohelper.Type_RectTransform)
	slot0._contentRt = slot0._txtContent:GetComponent(gohelper.Type_RectTransform)
	slot0.go.name = string.format("normalrightitem_%s_%s", slot0.stepCo.id, slot0.stepCo.stepId)

	AudioMgr.instance:trigger(AudioEnum.Dialogue.play_ui_wulu_duihua)

	slot0._isReference = false
	slot0._txtContentMarkTopIndex = slot0:createMarktopCmp(slot0._txtContent)

	slot0:setTopOffset(slot0._txtContentMarkTopIndex, 0, -6.151)
end

function slot0.refresh(slot0)
	gohelper.setActive(slot0._gorolebg, AergusiDialogModel.instance:getCurDialogGroup() == slot0.stepCo.id)
	gohelper.setActive(slot0._gorolebggrey, slot1 ~= slot0.stepCo.id)
	gohelper.setActive(slot0._txtName.gameObject, slot1 == slot0.stepCo.id)
	gohelper.setActive(slot0._txtNameGrey.gameObject, slot1 ~= slot0.stepCo.id)
	gohelper.setActive(slot0._gomaskgrey, slot1 ~= slot0.stepCo.id)
	gohelper.setActive(slot0._goreference, slot1 == slot0.stepCo.id)
	gohelper.setActive(slot0._goreferencegrey, slot1 ~= slot0.stepCo.id)
	slot0:setTextWithMarktopByIndex(slot0._txtContentMarkTopIndex, slot0.stepCo.content)
	slot0._simageAvatar:LoadImage(ResUrl.getHeadIconSmall(slot0.stepCo.speakerIcon))
	slot0._simageAvatarGrey:LoadImage(ResUrl.getHeadIconSmall(slot0.stepCo.speakerIcon))

	slot0._txtName.text = slot0.stepCo.speaker
	slot0._txtNameGrey.text = slot0.stepCo.speaker

	gohelper.setActive(slot0._goreference, slot0._isReference)
	gohelper.setActive(slot0._goreferencegrey, slot0._isReference)
	gohelper.setActive(slot0._goselectframe, false)
end

function slot0.setQutation(slot0, slot1)
	if not slot1 then
		gohelper.setActive(slot0._goreference, false)

		return
	end

	slot0._isReference = true

	gohelper.setActive(slot0._goreference, true)

	slot0._txtreference.text = slot1.content
	slot0._txtreferencegrey.text = slot1.content

	gohelper.setActive(slot0._goiconask, string.splitToNumber(slot1.condition, "#")[1] == AergusiEnum.OperationType.Probe)
	gohelper.setActive(slot0._goiconobjection, slot2 == AergusiEnum.OperationType.Refutation)
	gohelper.setActive(slot0._goiconaskgrey, slot2 == AergusiEnum.OperationType.Probe)
	gohelper.setActive(slot0._goiconobjectiongrey, slot2 == AergusiEnum.OperationType.Refutation)
	slot0:refresh()
	slot0:calculateHeight()
end

function slot0.calculateHeight(slot0)
	if slot0._txtContent.preferredWidth <= AergusiEnum.MessageTxtMaxWidth then
		recthelper.setSize(slot0._contentBgRt, slot1 + AergusiEnum.MessageBgOffsetWidth, AergusiEnum.MessageTxtOneLineHeight + AergusiEnum.MessageBgOffsetHeight)
		recthelper.setSize(slot0._contentRt, slot1, AergusiEnum.MessageTxtOneLineHeight)

		return
	end

	slot2 = slot0._txtContent.preferredHeight

	recthelper.setSize(slot0._contentBgRt, AergusiEnum.MessageTxtMaxWidth + AergusiEnum.MessageBgOffsetWidth, slot2 + AergusiEnum.MessageBgOffsetHeight)
	recthelper.setSize(slot0._contentRt, AergusiEnum.MessageTxtMaxWidth, slot2)
end

function slot0.getHeight(slot0)
	slot1 = slot0._isReference and AergusiEnum.DialogDoubtOffsetHeight or 0

	if slot0._txtContent.preferredWidth <= AergusiEnum.MessageTxtMaxWidth then
		slot0.height = Mathf.Max(AergusiEnum.MinHeight[slot0.type] + slot1 + AergusiEnum.DialogDoubtOffsetHeight, AergusiEnum.MessageTxtOneLineHeight + AergusiEnum.MessageBgOffsetHeight + AergusiEnum.MessageNameHeight + slot1 + AergusiEnum.DialogDoubtOffsetHeight)

		return slot0.height
	end

	slot2 = AergusiEnum.MessageTxtMaxWidth
	slot0.height = Mathf.Max(AergusiEnum.MinHeight[slot0.type] + slot1 + AergusiEnum.DialogDoubtOffsetHeight, AergusiEnum.MessageTxtOneLineHeight * slot0._txtContent:GetTextInfo(slot0._txtContent.text).lineCount + AergusiEnum.MessageBgOffsetHeight + AergusiEnum.MessageNameHeight + slot1 + AergusiEnum.DialogDoubtOffsetHeight)

	return slot0.height
end

function slot0.onDestroy(slot0)
	slot0._simageAvatar:UnLoadImage()
	slot0._simageAvatarGrey:UnLoadImage()
end

return slot0
