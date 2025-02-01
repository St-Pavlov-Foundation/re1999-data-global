module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsReadView", package.seeall)

slot0 = class("SportsNewsReadView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "#txt_Title")
	slot0._txtTitleEn = gohelper.findChildText(slot0.viewGO, "txt_TitleEn")
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "Scroll View/Viewport/#txt_Descr")
	slot0._goRedPoint = gohelper.findChild(slot0.viewGO, "#go_RedPoint")
	slot0._imagepic = gohelper.findChildSingleImage(slot0.viewGO, "image_Pic")

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

function slot0._btnstartbtnOnClick(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onOpen(slot0)
	slot1 = slot0.viewParam.orderMO
	slot0._txtTitle.text = tostring(slot1.cfg.name)
	slot0._txtTitleEn.text = tostring(slot1.cfg.titledesc)
	slot0._txtDescr.text = slot1.cfg.infoDesc

	slot0._imagepic:LoadImage(ResUrl.getV1a5News(slot1.cfg.bossPic))
end

function slot0.onDestroyView(slot0)
	slot0._imagepic:UnLoadImage()
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
