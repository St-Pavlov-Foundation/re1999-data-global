module("modules.logic.notice.view.NoticeView", package.seeall)

local var_0_0 = class("NoticeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._btncloseBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#simage_bg/top/#btn_closeBtn")
	arg_1_0._scrollnotice = gohelper.findChildScrollRect(arg_1_0.viewGO, "left/#scroll_notice")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "left/#scroll_notice/Viewport/Content/noticeItem/#go_normal")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "left/#scroll_notice/Viewport/Content/noticeItem/#go_select")
	arg_1_0._goredtip = gohelper.findChild(arg_1_0.viewGO, "left/#scroll_notice/Viewport/Content/noticeItem/#go_redtip")
	arg_1_0._scrollcontent = gohelper.findChildScrollRect(arg_1_0.viewGO, "right/#scroll_content")
	arg_1_0._gotoptitle = gohelper.findChild(arg_1_0.viewGO, "right/#scroll_content/Viewport/Content/#go_toptitle")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "right/#scroll_content/Viewport/Content/#go_toptitle/#txt_title")
	arg_1_0._simagecontent = gohelper.findChildSingleImage(arg_1_0.viewGO, "right/#scroll_content/Viewport/Content/#simage_content")
	arg_1_0._txtcontentTitle = gohelper.findChildText(arg_1_0.viewGO, "right/#scroll_content/Viewport/Content/contentTitle/#txt_contentTitle")
	arg_1_0._txtcontent = gohelper.findChildText(arg_1_0.viewGO, "right/#scroll_content/Viewport/Content/#txt_content")
	arg_1_0._simagenotice = gohelper.findChildSingleImage(arg_1_0.viewGO, "right/#simage_notice")
	arg_1_0._gocontentMask = gohelper.findChild(arg_1_0.viewGO, "right/#scroll_content/#go_contentMask")
	arg_1_0._btncloseview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closeview")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncloseBtn:AddClickListener(arg_2_0._btncloseBtnOnClick, arg_2_0)
	arg_2_0._btncloseview:AddClickListener(arg_2_0._btncloseBtnOnClick, arg_2_0)
	arg_2_0._scrollcontent:AddOnValueChanged(arg_2_0._onContentScrollValueChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncloseBtn:RemoveClickListener()
	arg_3_0._btncloseview:RemoveClickListener()
	arg_3_0._scrollcontent:RemoveOnValueChanged()
end

function var_0_0._btncloseBtnOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.createToggleItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:getUserDataTb_()

	var_5_0.type = arg_5_2
	var_5_0.goToggle = arg_5_1
	var_5_0.click = gohelper.getClick(arg_5_1)
	var_5_0.selectLabel = gohelper.findChild(arg_5_1, "selectLabel")
	var_5_0.unselectLabel = gohelper.findChild(arg_5_1, "unselectLabel")
	var_5_0.goReddot = gohelper.findChild(arg_5_1, "unselectLabel/reddot")

	var_5_0.click:AddClickListener(arg_5_0._toggleBeSelect, arg_5_0)
	var_5_0.click:AddClickDownListener(arg_5_0._toggleBeClickDown, arg_5_0, var_5_0)
	var_5_0.click:AddClickUpListener(arg_5_0._toggleBeClickUp, arg_5_0, var_5_0)
	gohelper.addUIClickAudio(arg_5_1, AudioEnum.UI.play_ui_feedback_open)
	table.insert(arg_5_0.toggleItemList, var_5_0)

	return var_5_0
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._simagebg:LoadImage(ResUrl.getNoticeBg("bg_announcement"))

	arg_6_0._goContent = gohelper.findChild(arg_6_0._scrollcontent.gameObject, "Viewport/Content")
	arg_6_0.toggleItemList = {}
	arg_6_0.goToggle1 = gohelper.findChild(arg_6_0.viewGO, "right/#toggleGroup/Toggle1")
	arg_6_0.goToggle2 = gohelper.findChild(arg_6_0.viewGO, "right/#toggleGroup/Toggle2")
	arg_6_0.goToggle3 = gohelper.findChild(arg_6_0.viewGO, "right/#toggleGroup/Toggle3")
	arg_6_0.goToggle4 = gohelper.findChild(arg_6_0.viewGO, "right/#toggleGroup/Toggle4")

	arg_6_0:createToggleItem(arg_6_0.goToggle1, NoticeType.Activity)
	arg_6_0:createToggleItem(arg_6_0.goToggle2, NoticeType.Game)
	arg_6_0:createToggleItem(arg_6_0.goToggle3, NoticeType.System)
	arg_6_0:createToggleItem(arg_6_0.goToggle4, NoticeType.Information)

	arg_6_0._scrollContentHeight = recthelper.getHeight(arg_6_0._goContent.transform)
end

function var_0_0.onDestroy(arg_7_0)
	return
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	NoticeModel.instance:onOpenNoticeView()
	arg_9_0:_addEvent()
	arg_9_0:updateUI()
	NavigateMgr.instance:addEscape(ViewName.NoticeView, arg_9_0._btncloseBtnOnClick, arg_9_0)
end

function var_0_0._addEvent(arg_10_0)
	NoticeController.instance:registerCallback(NoticeEvent.OnSelectNoticeItem, arg_10_0._onSelectNoticeItem, arg_10_0)
	arg_10_0:addEventCb(NoticeController.instance, NoticeEvent.OnGetNoticeInfo, arg_10_0.updateUI, arg_10_0)
	arg_10_0:addEventCb(NoticeController.instance, NoticeEvent.OnRefreshRedDot, arg_10_0.refreshRedDot, arg_10_0)
	arg_10_0:addEventCb(GameSceneMgr.instance, SceneEventName.EnterScene, arg_10_0._enterScene, arg_10_0)
end

function var_0_0._enterScene(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0:closeThis()
end

function var_0_0.onClose(arg_12_0)
	arg_12_0:_removeEvent()
	NoticeModel.instance:onCloseNoticeView()
end

function var_0_0._removeEvent(arg_13_0)
	NoticeController.instance:unregisterCallback(NoticeEvent.OnSelectNoticeItem, arg_13_0._onSelectNoticeItem, arg_13_0)
end

function var_0_0.updateUI(arg_14_0)
	local var_14_0 = arg_14_0.viewContainer:getFirstShowNoticeType()

	NoticeModel.instance:switchNoticeType(var_14_0)

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.toggleItemList) do
		gohelper.setActive(iter_14_1.goToggle, #NoticeModel.instance:getNoticesByType(iter_14_1.type) > 0)
	end

	arg_14_0:refreshRedDot()
	arg_14_0.viewContainer:selectFirstNotice()
	arg_14_0:_toggleBeSelect()
end

function var_0_0.refreshRedDot(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.toggleItemList) do
		gohelper.setActive(iter_15_1.goReddot, not NoticeModel.instance:getNoticeTypeIsRead(iter_15_1.type))
	end
end

function var_0_0._onSelectNoticeItem(arg_16_0, arg_16_1)
	NoticeContentListModel.instance:setNoticeMO(arg_16_1)

	arg_16_0._scrollcontent.verticalNormalizedPosition = 1

	arg_16_0:_refreshScrollContent()
end

function var_0_0.onDestroyView(arg_17_0)
	arg_17_0._simagebg:UnLoadImage()

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.toggleItemList) do
		iter_17_1.click:RemoveClickListener()
		iter_17_1.click:RemoveClickDownListener()
		iter_17_1.click:RemoveClickUpListener()
	end

	arg_17_0.toggleItemList = nil
end

function var_0_0._toggleBeSelect(arg_18_0)
	local var_18_0 = NoticeModel.instance:getSelectType()

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.toggleItemList) do
		gohelper.setActive(iter_18_1.selectLabel, var_18_0 == iter_18_1.type)
		gohelper.setActive(iter_18_1.unselectLabel, var_18_0 ~= iter_18_1.type)
	end
end

function var_0_0._toggleBeClickDown(arg_19_0, arg_19_1)
	UIColorHelper.setGameObjectPressState(arg_19_0, arg_19_1.goToggle, true)
end

function var_0_0._toggleBeClickUp(arg_20_0, arg_20_1)
	UIColorHelper.setGameObjectPressState(arg_20_0, arg_20_1.goToggle, false)
end

function var_0_0._refreshScrollContent(arg_21_0)
	ZProj.UGUIHelper.RebuildLayout(arg_21_0._goContent.transform)

	arg_21_0._couldScroll = recthelper.getHeight(arg_21_0._goContent.transform) > arg_21_0._scrollContentHeight and true or false

	gohelper.setActive(arg_21_0._gocontentMask, arg_21_0._couldScroll)
end

function var_0_0._onContentScrollValueChanged(arg_22_0, arg_22_1)
	gohelper.setActive(arg_22_0._gocontentMask, arg_22_0._couldScroll and not (gohelper.getRemindFourNumberFloat(arg_22_0._scrollcontent.verticalNormalizedPosition) <= 0))
end

return var_0_0
