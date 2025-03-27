module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeTrackView", package.seeall)

slot0 = class("VersionActivity2_4MusicFreeTrackView", BaseView)

function slot0.onInitView(slot0)
	slot0._gotranscribelist = gohelper.findChild(slot0.viewGO, "root/left/scroll_transcribelist/viewport/#go_transcribe_list")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0:_initTrackList()
end

function slot0._initTrackList(slot0)
	slot0._trackList = slot0:getUserDataTb_()

	for slot5, slot6 in ipairs(VersionActivity2_4MusicFreeModel.instance:getTrackList()) do
		slot0:_addTrack(slot6)
	end

	slot0:_selectedTrackItem(1)
end

function slot0._addTrack(slot0, slot1)
	slot2 = slot1.index
	slot5 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._gotranscribelist, "track_" .. tostring(slot2)), VersionActivity2_4MusicFreeTrackItem)
	slot0._trackList[slot2] = slot5

	slot5:onUpdateMO(slot1)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.ClickTrackItem, slot0._onClickTrackItem, slot0)
	slot0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.UpdateTrackList, slot0._onUpdateTrackList, slot0)
	slot0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.ActionStatusChange, slot0._onActionStatusChange, slot0)
end

function slot0._onActionStatusChange(slot0)
	slot0:_onUpdateTrackList()
end

function slot0._onUpdateTrackList(slot0)
	for slot5, slot6 in ipairs(slot0._trackList) do
		slot6:onUpdateMO(VersionActivity2_4MusicFreeModel.instance:getTrackList()[slot5])
	end
end

function slot0._onClickTrackItem(slot0, slot1)
	slot0:_selectedTrackItem(slot1)
end

function slot0._selectedTrackItem(slot0, slot1)
	VersionActivity2_4MusicFreeModel.instance:setSelectedTrackIndex(slot1)

	for slot5, slot6 in pairs(slot0._trackList) do
		slot6:updateSelected()
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
