module("modules.logic.versionactivity1_2.jiexika.view.Activity114MeetView", package.seeall)

slot0 = class("Activity114MeetView", BaseView)

function slot0.onInitView(slot0)
	slot0._itemParents = gohelper.findChild(slot0.viewGO, "root/items")
	slot0._btnleft = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_left")
	slot0._btnright = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_right")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_close")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simagehuimianpu1 = gohelper.findChildSingleImage(slot0.viewGO, "root/bg/#simage_huimianpu1")
	slot0._simagehuimianpu3 = gohelper.findChildSingleImage(slot0.viewGO, "root/bg/#simage_huimianpu3")
	slot0._simagehuimianpu4 = gohelper.findChildSingleImage(slot0.viewGO, "root/bg/#simage_huimianpu4")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnleft:AddClickListener(slot0._btnleftOnClick, slot0)
	slot0._btnright:AddClickListener(slot0._btnrightOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnleft:RemoveClickListener()
	slot0._btnright:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btnleftOnClick(slot0)
	slot0:updatePage(slot0.curPage - 1)
end

function slot0._btnrightOnClick(slot0)
	slot0:updatePage(slot0.curPage + 1)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getAct114MeetIcon("bg"))
	slot0._simagehuimianpu1:LoadImage(ResUrl.getAct114MeetIcon("bg_huimianpu1"))
	slot0._simagehuimianpu3:LoadImage(ResUrl.getAct114MeetIcon("bg_huimianpu3"))

	slot4 = ResUrl.getAct114MeetIcon

	slot0._simagehuimianpu4:LoadImage(slot4("bg_huimianpu4"))

	slot0.meetList = {}

	for slot4 = 1, 6 do
		slot0.meetList[slot4] = Activity114MeetItem.New(gohelper.findChild(slot0._itemParents, "#go_characteritem" .. slot4))

		slot0:addChildView(slot0.meetList[slot4])
	end

	slot0:updatePage(1)
end

function slot0.updatePage(slot0, slot1)
	slot0.curPage = slot1
	slot4 = math.ceil(#Activity114Config.instance:getMeetingCoList(Activity114Model.instance.id) / 6)

	for slot8 = 1, 6 do
		slot0.meetList[slot8]:updateMo(slot2[slot8 + (slot0.curPage - 1) * 6])
	end

	gohelper.setActive(slot0._btnleft.gameObject, slot1 > 1)
	gohelper.setActive(slot0._btnright.gameObject, slot1 < slot4)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_meeting_book_open)
end

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_meeting_book_close)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagehuimianpu1:UnLoadImage()
	slot0._simagehuimianpu3:UnLoadImage()
	slot0._simagehuimianpu4:UnLoadImage()
end

return slot0
