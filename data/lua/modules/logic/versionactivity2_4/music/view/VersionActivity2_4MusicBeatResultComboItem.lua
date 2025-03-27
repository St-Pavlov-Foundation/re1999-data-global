module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicBeatResultComboItem", package.seeall)

slot0 = class("VersionActivity2_4MusicBeatResultComboItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gostate1 = gohelper.findChild(slot0.viewGO, "image_state/#go_state1")
	slot0._gostate2 = gohelper.findChild(slot0.viewGO, "image_state/#go_state2")
	slot0._gostate3 = gohelper.findChild(slot0.viewGO, "image_state/#go_state3")
	slot0._txtcombonum = gohelper.findChildText(slot0.viewGO, "#txt_combonum")
	slot0._txtscorenum = gohelper.findChildText(slot0.viewGO, "#txt_scorenum")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	for slot4 = 1, 3 do
		gohelper.setActive(slot0["_gostate" .. slot4], false)
	end
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot0["_gostate" .. slot1], true)

	slot0._txtcombonum.text = VersionActivity2_4MusicEnum.times_sign .. slot2
	slot0._txtscorenum.text = slot3
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
