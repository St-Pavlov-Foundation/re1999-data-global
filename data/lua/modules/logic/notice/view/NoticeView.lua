module("modules.logic.notice.view.NoticeView", package.seeall)

slot0 = class("NoticeView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._btncloseBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "#simage_bg/top/#btn_closeBtn")
	slot0._scrollnotice = gohelper.findChildScrollRect(slot0.viewGO, "left/#scroll_notice")
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "left/#scroll_notice/Viewport/Content/noticeItem/#go_normal")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "left/#scroll_notice/Viewport/Content/noticeItem/#go_select")
	slot0._goredtip = gohelper.findChild(slot0.viewGO, "left/#scroll_notice/Viewport/Content/noticeItem/#go_redtip")
	slot0._scrollcontent = gohelper.findChildScrollRect(slot0.viewGO, "right/#scroll_content")
	slot0._gotoptitle = gohelper.findChild(slot0.viewGO, "right/#scroll_content/Viewport/Content/#go_toptitle")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "right/#scroll_content/Viewport/Content/#go_toptitle/#txt_title")
	slot0._simagecontent = gohelper.findChildSingleImage(slot0.viewGO, "right/#scroll_content/Viewport/Content/#simage_content")
	slot0._txtcontentTitle = gohelper.findChildText(slot0.viewGO, "right/#scroll_content/Viewport/Content/contentTitle/#txt_contentTitle")
	slot0._txtcontent = gohelper.findChildText(slot0.viewGO, "right/#scroll_content/Viewport/Content/#txt_content")
	slot0._simagenotice = gohelper.findChildSingleImage(slot0.viewGO, "right/#simage_notice")
	slot0._gocontentMask = gohelper.findChild(slot0.viewGO, "right/#scroll_content/#go_contentMask")
	slot0._btncloseview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closeview")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncloseBtn:AddClickListener(slot0._btncloseBtnOnClick, slot0)
	slot0._btncloseview:AddClickListener(slot0._btncloseBtnOnClick, slot0)
	slot0._scrollcontent:AddOnValueChanged(slot0._onContentScrollValueChanged, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncloseBtn:RemoveClickListener()
	slot0._btncloseview:RemoveClickListener()
	slot0._scrollcontent:RemoveOnValueChanged()
end

function slot0._btncloseBtnOnClick(slot0)
	slot0:closeThis()
end

function slot0.createToggleItem(slot0, slot1, slot2)
	slot3 = slot0:getUserDataTb_()
	slot3.type = slot2
	slot3.goToggle = slot1
	slot3.click = gohelper.getClick(slot1)
	slot3.selectLabel = gohelper.findChild(slot1, "selectLabel")
	slot3.unselectLabel = gohelper.findChild(slot1, "unselectLabel")
	slot3.goReddot = gohelper.findChild(slot1, "unselectLabel/reddot")

	slot3.click:AddClickListener(slot0._toggleBeSelect, slot0)
	slot3.click:AddClickDownListener(slot0._toggleBeClickDown, slot0, slot3)
	slot3.click:AddClickUpListener(slot0._toggleBeClickUp, slot0, slot3)
	gohelper.addUIClickAudio(slot1, AudioEnum.UI.play_ui_feedback_open)
	table.insert(slot0.toggleItemList, slot3)

	return slot3
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getNoticeBg("bg_announcement"))

	slot0._goContent = gohelper.findChild(slot0._scrollcontent.gameObject, "Viewport/Content")
	slot0.toggleItemList = {}
	slot0.goToggle1 = gohelper.findChild(slot0.viewGO, "right/#toggleGroup/Toggle1")
	slot0.goToggle2 = gohelper.findChild(slot0.viewGO, "right/#toggleGroup/Toggle2")
	slot0.goToggle3 = gohelper.findChild(slot0.viewGO, "right/#toggleGroup/Toggle3")
	slot0.goToggle4 = gohelper.findChild(slot0.viewGO, "right/#toggleGroup/Toggle4")

	slot0:createToggleItem(slot0.goToggle1, NoticeType.Activity)
	slot0:createToggleItem(slot0.goToggle2, NoticeType.Game)
	slot0:createToggleItem(slot0.goToggle3, NoticeType.System)
	slot0:createToggleItem(slot0.goToggle4, NoticeType.Information)

	slot0._scrollContentHeight = recthelper.getHeight(slot0._goContent.transform)
end

function slot0.onDestroy(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	NoticeModel.instance:onOpenNoticeView()
	slot0:_addEvent()
	slot0:updateUI()
	NavigateMgr.instance:addEscape(ViewName.NoticeView, slot0._btncloseBtnOnClick, slot0)
end

function slot0._addEvent(slot0)
	NoticeController.instance:registerCallback(NoticeEvent.OnSelectNoticeItem, slot0._onSelectNoticeItem, slot0)
	slot0:addEventCb(NoticeController.instance, NoticeEvent.OnGetNoticeInfo, slot0.updateUI, slot0)
	slot0:addEventCb(NoticeController.instance, NoticeEvent.OnRefreshRedDot, slot0.refreshRedDot, slot0)
	slot0:addEventCb(GameSceneMgr.instance, SceneEventName.EnterScene, slot0._enterScene, slot0)
end

function slot0._enterScene(slot0, slot1, slot2)
	slot0:closeThis()
end

function slot0.onClose(slot0)
	slot0:_removeEvent()
	NoticeModel.instance:onCloseNoticeView()
end

function slot0._removeEvent(slot0)
	NoticeController.instance:unregisterCallback(NoticeEvent.OnSelectNoticeItem, slot0._onSelectNoticeItem, slot0)
end

function slot0.updateUI(slot0)
	slot5 = slot0.viewContainer:getFirstShowNoticeType()

	NoticeModel.instance:switchNoticeType(slot5)

	for slot5, slot6 in ipairs(slot0.toggleItemList) do
		gohelper.setActive(slot6.goToggle, #NoticeModel.instance:getNoticesByType(slot6.type) > 0)
	end

	slot0:refreshRedDot()
	slot0.viewContainer:selectFirstNotice()
	slot0:_toggleBeSelect()
end

function slot0.refreshRedDot(slot0)
	for slot4, slot5 in ipairs(slot0.toggleItemList) do
		gohelper.setActive(slot5.goReddot, not NoticeModel.instance:getNoticeTypeIsRead(slot5.type))
	end
end

function slot0._onSelectNoticeItem(slot0, slot1)
	NoticeContentListModel.instance:setNoticeMO(slot1)

	slot0._scrollcontent.verticalNormalizedPosition = 1

	slot0:_refreshScrollContent()
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()

	for slot4, slot5 in ipairs(slot0.toggleItemList) do
		slot5.click:RemoveClickListener()
		slot5.click:RemoveClickDownListener()
		slot5.click:RemoveClickUpListener()
	end

	slot0.toggleItemList = nil
end

function slot0._toggleBeSelect(slot0)
	slot1 = NoticeModel.instance:getSelectType()

	for slot5, slot6 in ipairs(slot0.toggleItemList) do
		gohelper.setActive(slot6.selectLabel, slot1 == slot6.type)
		gohelper.setActive(slot6.unselectLabel, slot1 ~= slot6.type)
	end
end

function slot0._toggleBeClickDown(slot0, slot1)
	UIColorHelper.setGameObjectPressState(slot0, slot1.goToggle, true)
end

function slot0._toggleBeClickUp(slot0, slot1)
	UIColorHelper.setGameObjectPressState(slot0, slot1.goToggle, false)
end

function slot0._refreshScrollContent(slot0)
	ZProj.UGUIHelper.RebuildLayout(slot0._goContent.transform)

	slot0._couldScroll = slot0._scrollContentHeight < recthelper.getHeight(slot0._goContent.transform) and true or false

	gohelper.setActive(slot0._gocontentMask, slot0._couldScroll)
end

function slot0._onContentScrollValueChanged(slot0, slot1)
	gohelper.setActive(slot0._gocontentMask, slot0._couldScroll and gohelper.getRemindFourNumberFloat(slot0._scrollcontent.verticalNormalizedPosition) > 0)
end

return slot0
