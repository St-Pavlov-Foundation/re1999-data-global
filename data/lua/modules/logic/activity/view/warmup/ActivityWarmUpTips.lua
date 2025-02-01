module("modules.logic.activity.view.warmup.ActivityWarmUpTips", package.seeall)

slot0 = class("ActivityWarmUpTips", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg1")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_icon")
	slot0._txtinfo = gohelper.findChildText(slot0.viewGO, "#scroll_info/Viewport/Content/#txt_info")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "#txt_title")
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

function slot0._editableInitView(slot0)
	slot0._simagebg1:LoadImage(ResUrl.getActivityWarmUpBg("bg_zi8"))
	slot0._simageicon:LoadImage(ResUrl.getActivityWarmUpBg("bg_tu1"))
end

function slot0.onDestroyView(slot0)
	slot0._simagebg1:UnLoadImage()
	slot0._simageicon:UnLoadImage()
end

function slot0.onOpen(slot0)
	slot0.orderCo = Activity106Config.instance:getActivityWarmUpOrderCo(slot0.viewParam.actId, slot0.viewParam.orderId)

	slot0:refreshUI()
end

function slot0.onClose(slot0)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0.refreshUI(slot0)
	if slot0.orderCo then
		slot0._txtinfo.text = slot0.orderCo.desc
		slot0._txttitle.text = slot0.orderCo.name
	else
		slot0._txtinfo.text = ""
		slot0._txttitle.text = ""
	end
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
