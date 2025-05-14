module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeTrackView", package.seeall)

local var_0_0 = class("VersionActivity2_4MusicFreeTrackView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotranscribelist = gohelper.findChild(arg_1_0.viewGO, "root/left/scroll_transcribelist/viewport/#go_transcribe_list")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0:_initTrackList()
end

function var_0_0._initTrackList(arg_5_0)
	arg_5_0._trackList = arg_5_0:getUserDataTb_()

	local var_5_0 = VersionActivity2_4MusicFreeModel.instance:getTrackList()

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		arg_5_0:_addTrack(iter_5_1)
	end

	arg_5_0:_selectedTrackItem(1)
end

function var_0_0._addTrack(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.index
	local var_6_1 = arg_6_0.viewContainer:getSetting().otherRes[1]
	local var_6_2 = arg_6_0:getResInst(var_6_1, arg_6_0._gotranscribelist, "track_" .. tostring(var_6_0))
	local var_6_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_6_2, VersionActivity2_4MusicFreeTrackItem)

	arg_6_0._trackList[var_6_0] = var_6_3

	var_6_3:onUpdateMO(arg_6_1)
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.ClickTrackItem, arg_8_0._onClickTrackItem, arg_8_0)
	arg_8_0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.UpdateTrackList, arg_8_0._onUpdateTrackList, arg_8_0)
	arg_8_0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.ActionStatusChange, arg_8_0._onActionStatusChange, arg_8_0)
end

function var_0_0._onActionStatusChange(arg_9_0)
	arg_9_0:_onUpdateTrackList()
end

function var_0_0._onUpdateTrackList(arg_10_0)
	local var_10_0 = VersionActivity2_4MusicFreeModel.instance:getTrackList()

	for iter_10_0, iter_10_1 in ipairs(arg_10_0._trackList) do
		iter_10_1:onUpdateMO(var_10_0[iter_10_0])
	end
end

function var_0_0._onClickTrackItem(arg_11_0, arg_11_1)
	arg_11_0:_selectedTrackItem(arg_11_1)
end

function var_0_0._selectedTrackItem(arg_12_0, arg_12_1)
	VersionActivity2_4MusicFreeModel.instance:setSelectedTrackIndex(arg_12_1)

	for iter_12_0, iter_12_1 in pairs(arg_12_0._trackList) do
		iter_12_1:updateSelected()
	end
end

function var_0_0.onClose(arg_13_0)
	return
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0
