module("modules.logic.notice.view.NoticeViewContainer", package.seeall)

slot0 = class("NoticeViewContainer", BaseViewContainer)

function slot0.trackNoticeLoad(slot0, slot1)
	if not slot1 then
		return
	end

	SDKDataTrackMgr.instance:trackNoticeLoad({
		notice_id = slot1.id
	})
end

function slot0.trackNoticeJump(slot0, slot1)
	if not slot1 then
		return
	end

	if not slot0._titleListView:getFirstSelect() then
		return
	end

	SDKDataTrackMgr.instance:trackNoticeJump({
		notice_jump_id = slot1.id,
		notice_id = slot2.id
	})
end

function slot0._trackNoticeFirstLoaded(slot0)
	if slot0._isTrackedFirstNoticeLoad then
		return
	end

	slot0:trackNoticeLoad(slot0._titleListView:getFirstSelect())

	slot0._isTrackedFirstNoticeLoad = true
end

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "left/#scroll_notice"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "left/#scroll_notice/Viewport/Content/noticeItem"
	slot2.cellClass = NoticeTitleItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 420
	slot2.cellHeight = 120
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 8
	slot2.startSpace = 0
	slot2.endSpace = 20
	slot3 = MixScrollParam.New()
	slot3.scrollGOPath = "right/#scroll_content"
	slot3.prefabType = ScrollEnum.ScrollPrefabFromView
	slot3.prefabUrl = "right/#scroll_content/Viewport/Content/cell/noticeContentItem"
	slot3.cellClass = NoticeContentItemWrap
	slot3.scrollDir = ScrollEnum.ScrollDirV
	slot0._titleListView = LuaListScrollView.New(NoticeModel.instance, slot2)
	slot0._contentListView = LuaMixScrollView.New(NoticeContentListModel.instance, slot3)
	slot0._noticeView = NoticeView.New()

	table.insert(slot1, slot0._titleListView)
	table.insert(slot1, slot0._contentListView)
	table.insert(slot1, slot0._noticeView)

	slot4 = ToggleListView.New(1, "right/#toggleGroup")
	slot4.onOpen = uv0.customToggleViewOpen

	table.insert(slot1, slot4)

	return slot1
end

function slot0.customToggleViewOpen(slot0)
	slot1 = slot0._toggleGroup.allowSwitchOff
	slot0._toggleGroup.allowSwitchOff = true

	for slot7, slot8 in pairs(slot0._toggleDict) do
		slot8.isOn = slot7 == NoticeType.getTypeIndex(slot0.viewContainer:getFirstShowNoticeType())

		slot8:AddOnValueChanged(slot0._onToggleValueChanged, slot0, slot7)
	end

	slot0._toggleGroup.allowSwitchOff = slot1
end

function slot0.onContainerInit(slot0)
	slot0:registerCallback(ViewEvent.ToSwitchTab, slot0._toSwitchTab, slot0)

	slot0._isTrackedFirstNoticeLoad = nil
end

function slot0.onContainerDestroy(slot0)
	slot0:unregisterCallback(ViewEvent.ToSwitchTab, slot0._toSwitchTab, slot0)
end

function slot0._toSwitchTab(slot0, slot1, slot2)
	if slot2 == NoticeModel.instance:getSelectType() then
		return
	end

	NoticeModel.instance:switchNoticeTypeByToggleId(slot2)
	slot0:selectFirstNotice()
	slot0:trackNoticeLoad(slot0._titleListView:getFirstSelect())
end

function slot0.selectFirstNotice(slot0)
	if NoticeModel.instance:getCount() > 0 then
		slot0._titleListView:getCsListScroll().VerticalScrollPixel = 0

		slot0._titleListView:selectCell(1, true)
		slot0:_trackNoticeFirstLoaded()
	else
		NoticeContentListModel.instance:setNoticeMO(nil)
	end
end

function slot0.getFirstShowNoticeType(slot0)
	slot2 = NoticeModel.instance.autoSelectType

	for slot7, slot8 in ipairs(NoticeType.NoticeList) do
		if #NoticeModel.instance:getNoticesByType(slot8) > 0 then
			slot3 = nil or slot8

			if not NoticeController.instance.autoOpen then
				return slot8
			elseif slot8 == slot2 then
				return slot8
			end
		end
	end

	return slot3
end

return slot0
