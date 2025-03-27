module("modules.logic.messagebox.controller.MessageBoxController", package.seeall)

slot0 = class("MessageBoxController", BaseController)

function slot0.onInit(slot0)
	slot0._showQueue = {}
	slot0.enableClickAudio = true
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
	slot0._showQueue = {}
end

function slot0.setEnableClickAudio(slot0, slot1)
	slot0.enableClickAudio = slot1

	if ViewMgr.instance:getContainer(ViewName.MessageBoxView) and not gohelper.isNil(slot2.viewGO) then
		if not gohelper.isNil(gohelper.findChild(slot2.viewGO, "#btn_yes")) then
			gohelper.addUIClickAudio(slot3, slot1 and AudioEnum.UI.UI_Common_Click or 0)
		end

		if not gohelper.isNil(gohelper.findChild(slot2.viewGO, "#btn_no")) then
			gohelper.addUIClickAudio(slot4, slot1 and AudioEnum.UI.UI_Common_Click or 0)
		end
	end
end

function slot0.showSystemMsgBox(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, ...)
	slot0._showQueue = {}
	slot0._isShowSystemMsgBox = true

	ViewMgr.instance:closeView(ViewName.MessageBoxView)
	ViewMgr.instance:openView(ViewName.TopMessageBoxView, {
		msg = MessageBoxConfig.instance:getMessage(slot1),
		msgBoxType = slot2,
		yesCallback = slot3,
		noCallback = slot4,
		openCallback = slot5,
		yesCallbackObj = slot6,
		noCallbackObj = slot7,
		openCallbackObj = slot8,
		extra = {
			...
		}
	})
end

function slot0.showSystemMsgBoxByStr(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, ...)
	slot0._showQueue = {}
	slot0._isShowSystemMsgBox = true

	ViewMgr.instance:closeView(ViewName.MessageBoxView)
	ViewMgr.instance:openView(ViewName.TopMessageBoxView, {
		msg = slot1,
		msgBoxType = slot2,
		yesCallback = slot3,
		noCallback = slot4,
		openCallback = slot5,
		yesCallbackObj = slot6,
		noCallbackObj = slot7,
		openCallbackObj = slot8,
		extra = {
			...
		}
	})
end

function slot0.showSystemMsgBoxAndSetBtn(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9, slot10, slot11, slot12, ...)
	slot0._showQueue = {}
	slot0._isShowSystemMsgBox = true

	ViewMgr.instance:closeView(ViewName.MessageBoxView)
	ViewMgr.instance:openView(ViewName.TopMessageBoxView, {
		msg = MessageBoxConfig.instance:getMessage(slot1),
		msgBoxType = slot2,
		yesCallback = slot7,
		noCallback = slot8,
		openCallback = slot9,
		yesCallbackObj = slot10,
		noCallbackObj = slot11,
		openCallbackObj = slot12,
		yesStr = slot3,
		noStr = slot5,
		yesStrEn = slot4,
		noStrEn = slot6,
		extra = {
			...
		}
	})
end

function slot0.showMsgBoxAndSetBtn(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9, slot10, slot11, slot12, ...)
	if not ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		slot0._isShowSystemMsgBox = false
	end

	if not slot0._isShowSystemMsgBox then
		slot0:_internalShowMsgBox({
			messageBoxId = slot1,
			msg = MessageBoxConfig.instance:getMessage(slot1),
			msgBoxType = slot2,
			yesCallback = slot7,
			noCallback = slot8,
			openCallback = slot9,
			yesCallbackObj = slot10,
			noCallbackObj = slot11,
			openCallbackObj = slot12,
			yesStr = slot3,
			noStr = slot5,
			yesStrEn = slot4,
			noStrEn = slot6,
			extra = {
				...
			}
		})
	end
end

function slot0.showMsgBox(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, ...)
	if not ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		slot0._isShowSystemMsgBox = false
	end

	if not slot0._isShowSystemMsgBox then
		slot0:_internalShowMsgBox({
			messageBoxId = slot1,
			msg = MessageBoxConfig.instance:getMessage(slot1),
			msgBoxType = slot2,
			yesCallback = slot3,
			noCallback = slot4,
			openCallback = slot5,
			yesCallbackObj = slot6,
			noCallbackObj = slot7,
			openCallbackObj = slot8,
			extra = {
				...
			}
		})
	end
end

function slot0.showMsgBoxByStr(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	slot0:_internalShowMsgBox({
		msg = slot1,
		msgBoxType = slot2,
		yesCallback = slot3,
		noCallback = slot4,
		openCallback = slot5,
		yesCallbackObj = slot6,
		noCallbackObj = slot7,
		openCallbackObj = slot8
	})
end

function slot0._internalShowMsgBox(slot0, slot1)
	table.insert(slot0._showQueue, slot1)

	if ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		return
	end

	slot0:_showNextMsgBox()
end

function slot0._showNextMsgBox(slot0)
	slot0._isShowSystemMsgBox = nil

	if #slot0._showQueue > 0 then
		ViewMgr.instance:openView(ViewName.MessageBoxView, table.remove(slot0._showQueue, 1))

		return true
	end

	return false
end

function slot0.showOptionMsgBox(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9, ...)
	slot0._isShowSystemMsgBox = false

	ViewMgr.instance:openView(ViewName.MessageOptionBoxView, {
		msg = MessageBoxConfig.instance:getMessage(slot1),
		messageBoxId = slot1,
		msgBoxType = slot2,
		optionType = slot3,
		yesCallback = slot4,
		noCallback = slot5,
		openCallback = slot6,
		yesCallbackObj = slot7,
		noCallbackObj = slot8,
		openCallbackObj = slot9,
		extra = {
			...
		}
	})
end

function slot0.canShowMessageOptionBoxView(slot0, slot1, slot2)
	slot4 = true

	if slot2 == MsgBoxEnum.optionType.Daily then
		slot4 = TimeUtil.getDayFirstLoginRed(slot0:getOptionLocalKey(slot1, slot2))
	elseif slot2 == MsgBoxEnum.optionType.NotShow then
		slot4 = string.nilorempty(PlayerPrefsHelper.getString(slot3, ""))
	end

	return slot4
end

function slot0.getOptionLocalKey(slot0, slot1, slot2)
	return string.format("MessageOptionBoxView#%s#%s#%s", slot1, slot2, tostring(PlayerModel.instance:getPlayinfo().userId))
end

function slot0.clearOption(slot0, slot1, slot2)
	PlayerPrefsHelper.deleteKey(slot0:getOptionLocalKey(slot1, slot2))
end

slot0.instance = slot0.New()

return slot0
