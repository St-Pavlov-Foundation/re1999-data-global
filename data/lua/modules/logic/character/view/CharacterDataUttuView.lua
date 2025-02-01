module("modules.logic.character.view.CharacterDataUttuView", package.seeall)

slot0 = class("CharacterDataUttuView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simageredcircle1 = gohelper.findChildSingleImage(slot0.viewGO, "contentview/viewport/content/uttu1/icon/#simage_redcircle1")
	slot0._simageline = gohelper.findChildSingleImage(slot0.viewGO, "contentview/viewport/content/uttu2/icon/#simage_line")
	slot0._txtcontent1 = gohelper.findChildText(slot0.viewGO, "contentview/viewport/content/uttu2/txt/#txt_content1")
	slot0._txtcontent2 = gohelper.findChildText(slot0.viewGO, "contentview/viewport/content/uttu2/txt/#txt_content2")
	slot0._txtcontent3 = gohelper.findChildText(slot0.viewGO, "contentview/viewport/content/uttu3/txt/#txt_content3")
	slot0._gosign = gohelper.findChild(slot0.viewGO, "contentview/viewport/content/uttu3/icon/qianming/#go_sign")
	slot0._goexplain = gohelper.findChild(slot0.viewGO, "contentview/viewport/content/uttu3/icon/shouming/#go_explain")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gosign, false)
	gohelper.setActive(slot0._goexplain, false)
	slot0._simagebg:LoadImage(ResUrl.getCharacterDataIcon("full/bg.png"))
	slot0._simageredcircle1:LoadImage(ResUrl.getCharacterDataIcon("quan1.png"))
	slot0._simageline:LoadImage(ResUrl.getCharacterDataIcon("fengexian.png"))

	slot0._scrollbar = gohelper.findChildScrollbar(slot0.viewGO, "contentview/contentscrollbar")

	slot0._scrollbar:AddOnValueChanged(slot0._onValueChanged, slot0)

	slot0._contentEffect1 = gohelper.onceAddComponent(slot0._txtcontent1.gameObject, typeof(ZProj.TMPEffect))
	slot0._contentEffect2 = gohelper.onceAddComponent(slot0._txtcontent2.gameObject, typeof(ZProj.TMPEffect))
	slot0._contentEffect3 = gohelper.onceAddComponent(slot0._txtcontent3.gameObject, typeof(ZProj.TMPEffect))
	slot0._maxValue = 0
	slot0._content1LineCount = slot0._txtcontent1:GetTextInfo(slot0._txtcontent1.text).lineCount
	slot0._content2LineCount = slot0._txtcontent2:GetTextInfo(slot0._txtcontent2.text).lineCount
	slot0._content3LineCount = slot0._txtcontent3:GetTextInfo(slot0._txtcontent3.text).lineCount
end

function slot0._onValueChanged(slot0, slot1)
	slot0._maxValue = slot0._maxValue > 1 - slot1 and slot0._maxValue or 1 - slot1

	if slot1 < 0.1 then
		gohelper.setActive(slot0._goexplain, true)
	end

	if slot1 < 0.01 then
		gohelper.setActive(slot0._gosign, true)
	end

	if slot0._content1LineCount == 0 then
		slot0._content1LineCount = slot0._txtcontent1:GetTextInfo(slot0._txtcontent1.text).lineCount
		slot0._content2LineCount = slot0._txtcontent2:GetTextInfo(slot0._txtcontent2.text).lineCount
		slot0._content3LineCount = slot0._txtcontent3:GetTextInfo(slot0._txtcontent3.text).lineCount
	end

	if slot0._maxValue > 0.1 then
		slot0._contentEffect1.line = slot0._content1LineCount * 6 * (slot0._maxValue - 0.1)
	end

	if slot0._maxValue > 0.3 then
		slot0._contentEffect2.line = slot0._content2LineCount * 6 * (slot0._maxValue - 0.3)
	end

	if slot0._maxValue > 0.56 then
		slot0._contentEffect3.line = slot0._content3LineCount * 6 * (slot0._maxValue - 0.56)
	end

	slot0._contentEffect1:ForceUpdate()
	slot0._contentEffect2:ForceUpdate()
	slot0._contentEffect3:ForceUpdate()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._scrollbar:RemoveOnValueChanged()
	slot0._simagebg:UnLoadImage()
	slot0._simageredcircle1:UnLoadImage()
	slot0._simageline:UnLoadImage()
end

return slot0
