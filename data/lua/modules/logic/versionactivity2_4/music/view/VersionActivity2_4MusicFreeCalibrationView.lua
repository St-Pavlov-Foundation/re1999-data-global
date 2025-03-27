module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeCalibrationView", package.seeall)

slot0 = class("VersionActivity2_4MusicFreeCalibrationView", BaseView)

function slot0.onInitView(slot0)
	slot0._gocalibrationlist = gohelper.findChild(slot0.viewGO, "root/#go_calibrationlist")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._itemList = slot0:getUserDataTb_()

	for slot4 = 1, 3 do
		slot0:_addItem(slot4):onUpdateMO(slot4)
	end
end

function slot0._addItem(slot0, slot1)
	slot4 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._gocalibrationlist), VersionActivity2_4MusicFreeCalibrationItem)
	slot0._itemList[slot1] = slot4

	return slot4
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
