module("modules.logic.store.view.StoreTipView", package.seeall)

slot0 = class("StoreTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageblur = gohelper.findChildSingleImage(slot0.viewGO, "#simage_blur")
	slot0._gomonthcardtip = gohelper.findChild(slot0.viewGO, "#go_monthcardtip")
	slot0._gotipcontent = gohelper.findChild(slot0.viewGO, "#go_monthcardtip/tipscroll/Viewport/#go_tipcontent")
	slot0._txttip = gohelper.findChildText(slot0.viewGO, "#go_monthcardtip/tipscroll/Viewport/#go_tipcontent/#txt_tip")
	slot0._simageicon1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_monthcardtip/bg/#simage_icon1")
	slot0._simageicon2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_monthcardtip/bg/#simage_icon2")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._simageicon2:LoadImage(ResUrl.getCommonIcon("bg_1"))
	slot0._simageicon1:LoadImage(ResUrl.getCommonIcon("bg_2"))

	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "#go_monthcardtip/title")
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._desc(slot0)
	return slot0.viewParam.desc or ""
end

function slot0._title(slot0)
	return slot0.viewParam.title or luaLang("p_storetipview_title")
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_help_open)

	slot0._txttip.text = slot0:_desc()
	slot0._txtTitle.text = slot0:_title()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageicon1:UnLoadImage()
	slot0._simageicon2:UnLoadImage()
end

return slot0
