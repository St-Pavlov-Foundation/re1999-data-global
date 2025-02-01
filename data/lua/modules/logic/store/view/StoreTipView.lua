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
end

function slot0.onUpdateParam(slot0)
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0.onOpen(slot0)
	slot1 = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), slot0.viewGO.transform)
	slot0._txttip.text = CommonConfig.instance:getConstStr(ConstEnum.MouthTipsDesc)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageicon1:UnLoadImage()
	slot0._simageicon2:UnLoadImage()
end

return slot0
