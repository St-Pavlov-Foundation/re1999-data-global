module("modules.logic.versionactivity2_5.act186.view.Activity186GiftView", package.seeall)

slot0 = class("Activity186GiftView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simageItem = gohelper.findChildSingleImage(slot0.viewGO, "Item/#simage_Item")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._clickbg:AddClickListener(slot0._onBgClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._clickbg:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._clickbg = gohelper.getClickWithAudio(slot0._simageFullBG.gameObject)
end

function slot0._onBgClick(slot0)
	slot0:closeThis()
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.NewYearEve.play_ui_shuori_evegift_popup)
	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	slot0._simageItem:LoadImage(ResUrl.getAntiqueIcon("v2a5_antique_icon_1"))
end

function slot0.onClose(slot0)
	slot3 = {}

	for slot7, slot8 in ipairs(GameUtil.splitString2(Activity186Config.instance:getConstStr(Activity186Enum.ConstId.AvgReward), true)) do
		slot9 = MaterialDataMO.New()

		slot9:initValue(slot8[1], slot8[2], slot8[3])
		table.insert(slot3, slot9)
	end

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, slot3)
end

function slot0.onDestroyView(slot0)
	slot0._simageItem:UnLoadImage()
end

return slot0
