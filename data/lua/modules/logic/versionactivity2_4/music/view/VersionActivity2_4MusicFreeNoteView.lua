module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeNoteView", package.seeall)

slot0 = class("VersionActivity2_4MusicFreeNoteView", BaseView)

function slot0.onInitView(slot0)
	slot0._gomusic1 = gohelper.findChild(slot0.viewGO, "root/right/#go_music1")
	slot0._gomusic2 = gohelper.findChild(slot0.viewGO, "root/right/#go_music2")
	slot0._goinstruments = gohelper.findChild(slot0.viewGO, "root/right/bottom/#go_instruments")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0._initNoteList(slot0)
	slot0._noteList = slot0:getUserDataTb_()

	for slot4 = 1, 2 do
		slot0:_addNoteListItem(slot4)
	end

	slot0:_updateNoteListItem()
end

function slot0._addNoteListItem(slot0, slot1)
	slot4 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[2], slot0["_gomusic" .. slot1], "note_" .. tostring(slot1)), VersionActivity2_4MusicFreeNoteListItem)

	table.insert(slot0._noteList, slot1, slot4)
	slot4:initNoteItemList(slot0._addNoteItem, slot0)
end

function slot0._updateNoteListItem(slot0)
	for slot5, slot6 in ipairs(slot0._noteList) do
		slot6:onUpdateMO(VersionActivity2_4MusicFreeModel.instance:getInstrumentIndexList()[slot5])
	end
end

function slot0._addNoteItem(slot0, slot1)
	return MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[3], slot1), VersionActivity2_4MusicFreeNoteItem)
end

function slot0._initInstruments(slot0)
	slot0._instrumentList = slot0:getUserDataTb_()

	for slot5, slot6 in ipairs(Activity179Config.instance:getInstrumentNoSwitchList()) do
		slot0:_addInstrumentItem(slot5):onUpdateMO(slot6)
	end
end

function slot0._addInstrumentItem(slot0, slot1)
	slot4 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[4], slot0._goinstruments, "instrument_" .. tostring(slot1)), VersionActivity2_4MusicFreeInstrumentItem)

	table.insert(slot0._instrumentList, slot1, slot4)

	return slot4
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.InstrumentSelectChange, slot0._onInstrumentSelectChange, slot0)
	slot0:_initNoteList()
	slot0:_initInstruments()
end

function slot0._onInstrumentSelectChange(slot0)
	slot0:_updateNoteListItem()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
