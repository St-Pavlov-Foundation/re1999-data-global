module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeInstrumentItem", package.seeall)

slot0 = class("VersionActivity2_4MusicFreeInstrumentItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#image_icon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._imagecir = gohelper.findChildImage(slot0.viewGO, "#image_cir")
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
	if slot0:getNoteAudioId(1) == nil then
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

function slot0.getNoteAudioId(slot0, slot1)
	return Activity179Config.instance:getNoteConfig(slot0._mo.id, slot1) and slot2.resource
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._txtname.text = slot1.name

	UISpriteSetMgr.instance:setMusicSprite(slot0._imagecir, "v2a4_bakaluoer_freeinstrument_dianji_" .. slot1.icon)
	UISpriteSetMgr.instance:setMusicSprite(slot0._imageicon, "v2a4_bakaluoer_freeinstrument_" .. slot1.icon)
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
