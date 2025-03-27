module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeNoteItem", package.seeall)

slot0 = class("VersionActivity2_4MusicFreeNoteItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._imagecir = gohelper.findChildImage(slot0.viewGO, "#image_cir")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#txt_num")
	slot0._goclick = gohelper.findChild(slot0.viewGO, "#go_click")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._clickEffect = gohelper.findChild(slot0.viewGO, "#click")

	MonoHelper.addNoUpdateLuaComOnceToGo(slot0._goclick, VersionActivity2_4MusicTouchComp, {
		callback = slot0._onClickDown,
		callbackTarget = slot0
	})
end

function slot0._onClickDown(slot0)
	if slot0._parentView:getNoteAudioId(slot0._index) == nil then
		return
	end

	AudioMgr.instance:trigger(slot1)
	gohelper.setActive(slot0._clickEffect, false)
	gohelper.setActive(slot0._clickEffect, true)

	if not VersionActivity2_4MusicFreeModel.instance:isRecording() then
		return
	end

	VersionActivity2_4MusicFreeModel.instance:addNote(slot1)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1, slot2)
	slot0._index = slot1
	slot0._parentView = slot2

	UISpriteSetMgr.instance:setMusicSprite(slot0._imagecir, "v2a4_bakaluoer_freenote_" .. VersionActivity2_4MusicEnum.NoteIcon[slot0._index])
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
