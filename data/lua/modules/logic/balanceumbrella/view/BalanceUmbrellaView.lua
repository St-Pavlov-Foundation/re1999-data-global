module("modules.logic.balanceumbrella.view.BalanceUmbrellaView", package.seeall)

slot0 = class("BalanceUmbrellaView", BaseView)

function slot0.onInitView(slot0)
	slot0._gonofull = gohelper.findChild(slot0.viewGO, "#simage_title_normal")
	slot0._gofull = gohelper.findChild(slot0.viewGO, "#simage_title_finished")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
	slot0._clues = slot0:getUserDataTb_()
	slot0._lines = slot0:getUserDataTb_()
	slot0._points = slot0:getUserDataTb_()

	for slot5 = 0, gohelper.findChild(slot0.viewGO, "Clue").transform.childCount - 1 do
		if string.match(slot1:GetChild(slot5).name, "clue([0-9]+)") then
			slot7 = tonumber(slot7)
			slot0._clues[slot7] = slot6:GetComponent(typeof(UnityEngine.Animator))

			slot0:addClickCb(gohelper.findChildButtonWithAudio(slot6.gameObject, ""), slot0._showDetail, slot0, slot7)
		end
	end

	for slot6 = 0, gohelper.findChild(slot0.viewGO, "Line").transform.childCount - 1 do
		slot8, slot9 = string.match(slot2:GetChild(slot6).name, "line([0-9]+)_([0-9]+)")

		if slot8 then
			slot0._lines[slot7.name] = {
				anim = slot7:GetComponent(typeof(UnityEngine.Animator)),
				startIndex = tonumber(slot8),
				endIndex = tonumber(slot9)
			}
		end

		if string.match(slot7.name, "point([0-9]+)") then
			slot0._points[tonumber(slot10)] = slot7
		end
	end
end

function slot0._showDetail(slot0, slot1)
	ViewMgr.instance:openView(ViewName.BalanceUmbrellaClueView, {
		id = slot1
	})
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_unlock)

	slot1 = BalanceUmbrellaModel.instance:isGetAllClue()

	gohelper.setActive(slot0._gofull, slot1)
	gohelper.setActive(slot0._gonofull, not slot1)

	slot0._newIds = BalanceUmbrellaModel.instance:getAllNoPlayIds()
	slot5 = 999
	slot6 = slot0.viewName

	UIBlockHelper.instance:startBlock("BalanceUmbrellaView_playclue", slot5, slot6)
	UIBlockMgrExtend.setNeedCircleMv(false)

	for slot5, slot6 in pairs(slot0._clues) do
		if BalanceUmbrellaModel.instance:isClueUnlock(slot5) and not tabletool.indexOf(slot0._newIds, slot5) then
			gohelper.setActive(slot6, true)
		else
			gohelper.setActive(slot6, false)
		end
	end

	for slot5, slot6 in pairs(slot0._points) do
		if BalanceUmbrellaModel.instance:isClueUnlock(slot5) and not tabletool.indexOf(slot0._newIds, slot5) then
			gohelper.setActive(slot6, true)
		else
			gohelper.setActive(slot6, false)
		end
	end

	for slot5, slot6 in pairs(slot0._lines) do
		slot8 = slot6.endIndex

		if BalanceUmbrellaModel.instance:isClueUnlock(slot6.startIndex) and not tabletool.indexOf(slot0._newIds, slot7) and BalanceUmbrellaModel.instance:isClueUnlock(slot8) and not tabletool.indexOf(slot0._newIds, slot8) then
			gohelper.setActive(slot6.anim, true)
		else
			gohelper.setActive(slot6.anim, false)
		end
	end

	slot0:beginPlayNew()
	BalanceUmbrellaModel.instance:markAllNoPlayIds()
end

function slot0.beginPlayNew(slot0)
	if table.remove(slot0._newIds, 1) then
		slot0._playingId = slot1

		slot0:playLineAnim(slot1)
	else
		slot0:endPlayNew()
	end
end

function slot0.playLineAnim(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(slot0._lines) do
		if slot7.endIndex == slot1 then
			gohelper.setActive(slot7.anim, true)
			table.insert(slot2, slot7)
		end
	end

	if #slot2 > 0 then
		slot0._newLines = slot2

		for slot6, slot7 in pairs(slot0._newLines) do
			slot7.anim:Play("open", 0, 0)
		end

		TaskDispatcher.runDelay(slot0._onFinishLineAnim, slot0, 0.667)
	else
		slot0:playImgAnim(slot1)
	end
end

function slot0._onFinishLineAnim(slot0)
	slot0:playImgAnim(slot0._playingId)
end

function slot0.playImgAnim(slot0, slot1)
	gohelper.setActive(slot0._clues[slot1], true)
	slot0._clues[slot1]:Play("open", 0, 0)
	TaskDispatcher.runDelay(slot0._imageAnimEnd, slot0, 0.667)
end

function slot0._imageAnimEnd(slot0)
	gohelper.setActive(slot0._points[slot0._playingId], true)
	slot0:beginPlayNew()
end

function slot0.endPlayNew(slot0)
	slot0._playingId = nil

	TaskDispatcher.cancelTask(slot0._onFinishLineAnim, slot0)
	TaskDispatcher.cancelTask(slot0._imageAnimEnd, slot0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockHelper.instance:endBlock("BalanceUmbrellaView_playclue")
end

function slot0.onClose(slot0)
	slot0:endPlayNew()
end

return slot0
