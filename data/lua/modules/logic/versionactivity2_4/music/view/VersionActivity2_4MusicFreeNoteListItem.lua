module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeNoteListItem", package.seeall)

slot0 = class("VersionActivity2_4MusicFreeNoteListItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._btnchangebtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_changebtn")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#btn_changebtn/#image_icon")
	slot0._imagenullicon = gohelper.findChildImage(slot0.viewGO, "#btn_changebtn/#image_nullicon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#btn_changebtn/#txt_name")
	slot0._scrollmusiclist1 = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_musiclist1")
	slot0._goimageFrame = gohelper.findChild(slot0.viewGO, "#scroll_musiclist1/viewport/#go_image_Frame")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#scroll_musiclist1/viewport/#go_content")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "#scroll_musiclist1/#go_empty")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnchangebtn:AddClickListener(slot0._btnchangebtnOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnchangebtn:RemoveClickListener()
end

function slot0._btnchangebtnOnClick(slot0)
	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicFreeInstrumentSetView()
end

function slot0._editableInitView(slot0)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.initNoteItemList(slot0, slot1, slot2)
	slot0._addNoteItem = slot1
	slot0._noteView = slot2

	for slot6 = 1, 7 do
		slot0._addNoteItem(slot0._noteView, slot0._gocontent):onUpdateMO(slot6, slot0)
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._instrumentId = slot1
	slot0._instrumentConfig = slot0._instrumentId and lua_activity179_instrument.configDict[slot0._instrumentId] or nil
	slot0._txtname.text = slot0._instrumentConfig and slot0._instrumentConfig.name or luaLang("MusicFreeNoInstrument")

	gohelper.setActive(slot0._gocontent, slot0._instrumentConfig ~= nil)
	gohelper.setActive(slot0._imageicon, slot0._instrumentConfig ~= nil)
	gohelper.setActive(slot0._goempty, slot0._instrumentConfig == nil)
	gohelper.setActive(slot0._goimageFrame, slot0._instrumentConfig ~= nil)
	gohelper.setActive(slot0._imagenullicon, slot0._instrumentConfig == nil)

	if slot0._instrumentConfig then
		UISpriteSetMgr.instance:setMusicSprite(slot0._imageicon, "v2a4_bakaluoer_freeinstrument_" .. slot0._instrumentConfig.icon)
	end
end

function slot0.getNoteAudioId(slot0, slot1)
	if slot0._instrumentId == 0 then
		return
	end

	return Activity179Config.instance:getNoteConfig(slot0._instrumentId, slot1) and slot2.resource
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
