module("modules.logic.weekwalk.view.WeekWalkGuideView", package.seeall)

slot0 = class("WeekWalkGuideView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "commen/#simage_bg")
	slot0._simagedecorate1 = gohelper.findChildSingleImage(slot0.viewGO, "commen/#simage_decorate1")
	slot0._simagedecorate3 = gohelper.findChildSingleImage(slot0.viewGO, "commen/#simage_decorate3")
	slot0._btnlook = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_look")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnlook:AddClickListener(slot0._btnlookOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnlook:RemoveClickListener()
end

function slot0._btnlookOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getWeekWalkBg("yd_yindaodi_1.png"))
	slot0._simagedecorate1:LoadImage(ResUrl.getCommonIcon("yd_biaoti_di"))
	slot0._simagedecorate3:LoadImage(ResUrl.getCommonIcon("yd_blxian"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_artificial_ui_openfunction)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagedecorate1:UnLoadImage()
	slot0._simagedecorate3:UnLoadImage()
end

return slot0
