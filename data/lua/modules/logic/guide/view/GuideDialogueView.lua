module("modules.logic.guide.view.GuideDialogueView", package.seeall)

slot0 = class("GuideDialogueView", BaseView)

function slot0.onInitView(slot0)
	slot0._gotipsmask = gohelper.findChild(slot0.viewGO, "#go_tipsmask")
	slot0._gotype4 = gohelper.findChild(slot0.viewGO, "#go_type4")
	slot0._godialogue = gohelper.findChild(slot0.viewGO, "#go_dialogue")
	slot0._txtcontent = gohelper.findChildText(slot0.viewGO, "#go_dialogue/#txt_content")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_dialogue/#txt_name")
	slot0._simageleft = gohelper.findChildSingleImage(slot0.viewGO, "#go_dialogue/left/#simage_left")
	slot0._simageright = gohelper.findChildSingleImage(slot0.viewGO, "#go_dialogue/right/#simage_right")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._dialogueTr = slot0._godialogue.transform
end

function slot0.onDestroyView(slot0)
end

function slot0.onOpen(slot0)
	slot0:_updateUI()
	slot0:addEventCb(GuideController.instance, GuideEvent.UpdateMaskView, slot0._updateUI, slot0)
end

function slot0.onUpdateParam(slot0)
	slot0:_updateUI()
	slot0:removeEventCb(GuideController.instance, GuideEvent.UpdateMaskView, slot0._updateUI, slot0)
end

function slot0._updateUI(slot0)
	if not slot0.viewParam then
		return
	end

	gohelper.setActive(slot0._godialogue, slot0.viewParam.hasDialogue)

	if not slot0.viewParam.hasDialogue then
		return
	end

	if LangSettings.instance:getCurLang() == LangSettings.kr then
		slot0._txtcontent.text = slot0.viewParam.tipsContent
	else
		slot0._txtcontent.text = string.gsub(slot0.viewParam.tipsContent, " ", " ")
	end

	slot0._txtname.text = slot0.viewParam.tipsTalker

	gohelper.setActive(slot0._simageleft.gameObject, false)
	gohelper.setActive(slot0._simageright.gameObject, false)

	if string.nilorempty(slot0.viewParam.tipsHead) then
		return
	end

	if slot0.viewParam.portraitPos == 0 then
		slot0._simageTemp = slot0._simageleft
	else
		slot0._simageTemp = slot0._simageright
	end

	gohelper.setActive(slot0._simageTemp.gameObject, true)
	slot0._simageTemp:LoadImage(ResUrl.getHeadIconImg(slot0.viewParam.tipsHead), slot0._loadFinish, slot0)
end

function slot0._loadFinish(slot0)
	ZProj.UGUIHelper.SetImageSize(slot0._simageTemp.gameObject)
	slot0:_setPortraitOffset(slot0._simageTemp.gameObject)
end

function slot0._setPortraitOffset(slot0, slot1)
	if not SkinConfig.instance:getSkinCo(tonumber(slot0.viewParam.tipsHead)) then
		logError("no skin skinId:" .. slot0.viewParam.tipsHead)

		return
	end

	slot4 = SkinConfig.instance:getSkinOffset(slot0.viewParam.portraitPos == 0 and slot2.guideLeftPortraitOffset or slot2.guideRightPortraitOffset)
	slot5 = slot1.transform

	recthelper.setAnchor(slot5, tonumber(slot4[1]), tonumber(slot4[2]))
	transformhelper.setLocalScale(slot5, tonumber(slot4[3]), tonumber(slot4[3]), tonumber(slot4[3]))
end

function slot0.onClose(slot0)
	slot0._simageright:UnLoadImage()
	slot0._simageleft:UnLoadImage()
end

return slot0
