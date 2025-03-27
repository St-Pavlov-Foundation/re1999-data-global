module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeCalibrationItem", package.seeall)

slot0 = class("VersionActivity2_4MusicFreeCalibrationItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._btnnote = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_note")
	slot0._imageopen = gohelper.findChild(slot0.viewGO, "#btn_note/#image_open")
	slot0._imageicon1 = gohelper.findChildImage(slot0.viewGO, "#btn_note/#image_open/#image_icon1")
	slot0._txtname1 = gohelper.findChildText(slot0.viewGO, "#btn_note/#image_open/#txt_name1")
	slot0._imageclose = gohelper.findChildImage(slot0.viewGO, "#btn_note/#image_close")
	slot0._imageicon2 = gohelper.findChildImage(slot0.viewGO, "#btn_note/#image_close/#image_icon2")
	slot0._txtname2 = gohelper.findChildText(slot0.viewGO, "#btn_note/#image_close/#txt_name2")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnnote:AddClickListener(slot0._btnnoteOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnnote:RemoveClickListener()
end

function slot0._btnnoteOnClick(slot0)
	slot0._isOpen = not slot0._isOpen

	slot0:_updateStatus()
end

function slot0._editableInitView(slot0)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._id = slot1
	slot0._isOpen = VersionActivity2_4MusicFreeModel.instance:getAccompany(slot1) == VersionActivity2_4MusicEnum.AccompanyStatus.Open
	slot2 = slot0:_getName()
	slot0._txtname1.text = slot2
	slot0._txtname2.text = slot2
	slot3 = VersionActivity2_4MusicFreeModel.instance:getAccompanyIcon(slot1)

	UISpriteSetMgr.instance:setMusicSprite(slot0._imageicon1, slot3)
	UISpriteSetMgr.instance:setMusicSprite(slot0._imageicon2, slot3)
	slot0:_updateStatus()
end

function slot0._updateStatus(slot0)
	gohelper.setActive(slot0._imageopen, slot0._isOpen)
	gohelper.setActive(slot0._imageclose, not slot0._isOpen)

	slot1 = slot0._isOpen and VersionActivity2_4MusicEnum.AccompanyStatus.Open or VersionActivity2_4MusicEnum.AccompanyStatus.Close

	VersionActivity2_4MusicFreeModel.instance:setAccompany(slot0._id, slot1)
	AudioMgr.instance:setRTPCValue(VersionActivity2_4MusicEnum.AccompanyTypeName[slot0._id], slot1)
end

function slot0._getName(slot0)
	return luaLang("MusicAccompany" .. slot0._id)
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
