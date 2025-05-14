module("modules.logic.notice.view.NoticeViewContainer", package.seeall)

local var_0_0 = class("NoticeViewContainer", BaseViewContainer)

function var_0_0.trackNoticeLoad(arg_1_0, arg_1_1)
	if not arg_1_1 then
		return
	end

	local var_1_0 = {
		notice_id = tonumber(arg_1_1.id)
	}

	SDKDataTrackMgr.instance:trackNoticeLoad(var_1_0)
end

function var_0_0.trackNoticeJump(arg_2_0, arg_2_1)
	if not arg_2_1 then
		return
	end

	local var_2_0 = arg_2_0._titleListView:getFirstSelect()

	if not var_2_0 then
		return
	end

	local var_2_1 = {
		notice_jump_id = tonumber(arg_2_1.id),
		notice_id = tonumber(var_2_0.id)
	}

	SDKDataTrackMgr.instance:trackNoticeJump(var_2_1)
end

function var_0_0._trackNoticeFirstLoaded(arg_3_0)
	if arg_3_0._isTrackedFirstNoticeLoad then
		return
	end

	arg_3_0:trackNoticeLoad(arg_3_0._titleListView:getFirstSelect())

	arg_3_0._isTrackedFirstNoticeLoad = true
end

function var_0_0.buildViews(arg_4_0)
	local var_4_0 = {}
	local var_4_1 = ListScrollParam.New()

	var_4_1.scrollGOPath = "left/#scroll_notice"
	var_4_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_4_1.prefabUrl = "left/#scroll_notice/Viewport/Content/noticeItem"
	var_4_1.cellClass = NoticeTitleItem
	var_4_1.scrollDir = ScrollEnum.ScrollDirV
	var_4_1.lineCount = 1
	var_4_1.cellWidth = 420
	var_4_1.cellHeight = 120
	var_4_1.cellSpaceH = 0
	var_4_1.cellSpaceV = 8
	var_4_1.startSpace = 0
	var_4_1.endSpace = 20

	local var_4_2 = MixScrollParam.New()

	var_4_2.scrollGOPath = "right/#scroll_content"
	var_4_2.prefabType = ScrollEnum.ScrollPrefabFromView
	var_4_2.prefabUrl = "right/#scroll_content/Viewport/Content/cell/noticeContentItem"
	var_4_2.cellClass = NoticeContentItemWrap
	var_4_2.scrollDir = ScrollEnum.ScrollDirV
	arg_4_0._titleListView = LuaListScrollView.New(NoticeModel.instance, var_4_1)
	arg_4_0._contentListView = LuaMixScrollView.New(NoticeContentListModel.instance, var_4_2)
	arg_4_0._noticeView = NoticeView.New()

	table.insert(var_4_0, arg_4_0._titleListView)
	table.insert(var_4_0, arg_4_0._contentListView)
	table.insert(var_4_0, arg_4_0._noticeView)

	local var_4_3 = ToggleListView.New(1, "right/#toggleGroup")

	var_4_3.onOpen = var_0_0.customToggleViewOpen

	table.insert(var_4_0, var_4_3)

	return var_4_0
end

function var_0_0.customToggleViewOpen(arg_5_0)
	local var_5_0 = arg_5_0._toggleGroup.allowSwitchOff

	arg_5_0._toggleGroup.allowSwitchOff = true

	local var_5_1 = arg_5_0.viewContainer:getFirstShowNoticeType()
	local var_5_2 = NoticeType.getTypeIndex(var_5_1)

	for iter_5_0, iter_5_1 in pairs(arg_5_0._toggleDict) do
		iter_5_1.isOn = iter_5_0 == var_5_2

		iter_5_1:AddOnValueChanged(arg_5_0._onToggleValueChanged, arg_5_0, iter_5_0)
	end

	arg_5_0._toggleGroup.allowSwitchOff = var_5_0
end

function var_0_0.onContainerInit(arg_6_0)
	arg_6_0:registerCallback(ViewEvent.ToSwitchTab, arg_6_0._toSwitchTab, arg_6_0)

	arg_6_0._isTrackedFirstNoticeLoad = nil
end

function var_0_0.onContainerDestroy(arg_7_0)
	arg_7_0:unregisterCallback(ViewEvent.ToSwitchTab, arg_7_0._toSwitchTab, arg_7_0)
end

function var_0_0._toSwitchTab(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_2 == NoticeModel.instance:getSelectType() then
		return
	end

	NoticeModel.instance:switchNoticeTypeByToggleId(arg_8_2)
	arg_8_0:selectFirstNotice()
	arg_8_0:trackNoticeLoad(arg_8_0._titleListView:getFirstSelect())
end

function var_0_0.selectFirstNotice(arg_9_0)
	if NoticeModel.instance:getCount() > 0 then
		arg_9_0._titleListView:getCsListScroll().VerticalScrollPixel = 0

		arg_9_0._titleListView:selectCell(1, true)
		arg_9_0:_trackNoticeFirstLoaded()
	else
		NoticeContentListModel.instance:setNoticeMO(nil)
	end
end

function var_0_0.getFirstShowNoticeType(arg_10_0)
	local var_10_0 = NoticeController.instance.autoOpen
	local var_10_1 = NoticeModel.instance.autoSelectType
	local var_10_2

	for iter_10_0, iter_10_1 in ipairs(NoticeType.NoticeList) do
		if #NoticeModel.instance:getNoticesByType(iter_10_1) > 0 then
			var_10_2 = var_10_2 or iter_10_1

			if not var_10_0 then
				return iter_10_1
			elseif iter_10_1 == var_10_1 then
				return iter_10_1
			end
		end
	end

	return var_10_2
end

return var_0_0
