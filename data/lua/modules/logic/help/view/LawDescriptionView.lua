module("modules.logic.help.view.LawDescriptionView", package.seeall)

slot0 = class("LawDescriptionView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageblur = gohelper.findChildSingleImage(slot0.viewGO, "#simage_blur")
	slot0._simagetop = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_top")
	slot0._simagebottom = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bottom")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "title/#txt_title")
	slot0._txttext = gohelper.findChildText(slot0.viewGO, "scroll/viewport/#txt_text")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._simagetop:LoadImage(ResUrl.getCommonIcon("bg_2"))
	slot0._simagebottom:LoadImage(ResUrl.getCommonIcon("bg_1"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot2 = HelpConfig.instance:getHelpPageCo(slot0.viewParam.id)
	slot0._txttitle.text = slot2.title
	slot0._txttext.text = slot2.text
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagetop:UnLoadImage()
	slot0._simagebottom:UnLoadImage()
end

return slot0
