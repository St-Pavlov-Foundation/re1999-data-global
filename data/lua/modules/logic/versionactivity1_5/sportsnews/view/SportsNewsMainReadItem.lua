module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsMainReadItem", package.seeall)

slot0 = class("SportsNewsMainReadItem", LuaCompBase)

function slot0.onInitView(slot0)
	slot0._imageItemBG = gohelper.findChildImage(slot0.viewGO, "#image_ItemBG")
	slot0._btnInfo = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Info/Click")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "#txt_title")
	slot0._txtTitleEn = gohelper.findChildText(slot0.viewGO, "txt_TitleEn")
	slot0._scrolldesc = gohelper.findChild(slot0.viewGO, "Scroll View")
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "Scroll View/Viewport/#txt_Descr")
	slot0._goredpoint = gohelper.findChild(slot0.viewGO, "#go_redpoint")
	slot0._imagepic = gohelper.findChildSingleImage(slot0.viewGO, "image_Pic")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnInfo:AddClickListener(slot0._btnInfoOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnInfo:RemoveClickListener()
end

function slot0._btnInfoOnClick(slot0)
	if slot0.orderMO.status ~= ActivityWarmUpEnum.OrderStatus.Finished then
		SportsNewsModel.instance:onReadEnd(VersionActivity1_5Enum.ActivityId.SportsNews, slot0.orderMO.id)
	end

	ViewMgr.instance:openView(ViewName.SportsNewsReadView, {
		orderMO = slot0.orderMO
	})
end

function slot0._editableInitView(slot0)
	slot0._txtDescr.overflowMode = TMPro.TextOverflowModes.Ellipsis
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0:removeEvents()
	slot0._imagepic:UnLoadImage()
end

function slot0.initData(slot0, slot1, slot2)
	slot0.viewGO = slot1
	slot0.index = slot2

	slot0:onInitView()
	slot0:addEvents()
end

function slot0.onRefresh(slot0, slot1)
	slot0.orderMO = slot1
	slot0._txttitle.text = tostring(slot1.cfg.name)
	slot0._txtTitleEn.text = tostring(slot1.cfg.titledesc)
	slot0._txtDescr.text = slot0.orderMO.cfg.desc

	slot0._imagepic:LoadImage(ResUrl.getV1a5News(slot1.cfg.bossPic))
	RedDotController.instance:addRedDot(slot0._goredpoint, RedDotEnum.DotNode.v1a5NewsOrder, slot1.id)

	slot0._scrolldesc:GetComponent(gohelper.Type_LimitedScrollRect).verticalNormalizedPosition = 1
end

function slot0.onFinish(slot0)
end

function slot0.StopAnim(slot0)
end

return slot0
