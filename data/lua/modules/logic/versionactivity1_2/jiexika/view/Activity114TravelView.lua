module("modules.logic.versionactivity1_2.jiexika.view.Activity114TravelView", package.seeall)

slot0 = class("Activity114TravelView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagemaskbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_maskbg")
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg1")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg2")
	slot0._simagebg3 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg3")
	slot0._simagebg5 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg5")
	slot0._simageqianbi = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_qianbi")
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

function slot0._editableInitView(slot0)
	slot0._simagemaskbg:LoadImage(ResUrl.getVersionActivityTrip_1_2("bg_beijing"))
	slot0._simagebg1:LoadImage(ResUrl.getVersionActivityTrip_1_2("bg_zhizhang1"))
	slot0._simagebg2:LoadImage(ResUrl.getVersionActivityTrip_1_2("bg_zhizhang2"))
	slot0._simagebg3:LoadImage(ResUrl.getVersionActivityTrip_1_2("bg_zhizhang3"))
	slot0._simagebg5:LoadImage(ResUrl.getVersionActivityTrip_1_2("bg_zhizhang5"))

	slot4 = ResUrl.getVersionActivityTrip_1_2

	slot0._simageqianbi:LoadImage(slot4("bg_qianbi"))

	slot0.entrances = {}

	for slot4 = 1, 6 do
		slot0.entrances[slot4] = Activity114TravelItem.New(gohelper.findChild(slot0.viewGO, "entrances/entrance" .. slot4), slot4)
	end
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_mail_open)
end

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_delete)
end

function slot0.onDestroyView(slot0)
	slot0._simagemaskbg:UnLoadImage()
	slot0._simagebg1:UnLoadImage()
	slot0._simagebg2:UnLoadImage()
	slot0._simagebg3:UnLoadImage()
	slot0._simagebg5:UnLoadImage()
	slot0._simageqianbi:UnLoadImage()

	for slot4 = 1, 6 do
		slot0.entrances[slot4]:onDestroy()
	end
end

return slot0
