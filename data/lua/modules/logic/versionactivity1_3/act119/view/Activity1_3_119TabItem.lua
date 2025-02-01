module("modules.logic.versionactivity1_3.act119.view.Activity1_3_119TabItem", package.seeall)

slot0 = class("Activity1_3_119TabItem")

function slot0.init(slot0, slot1, slot2)
	slot0._go = slot1
	slot0.index = slot2
	slot0.co = Activity119Config.instance:getConfig(VersionActivity1_3Enum.ActivityId.Act307, slot2)

	slot0:onInitView()
	slot0:addEvents()
end

function slot0.onInitView(slot0)
	slot0._btn = gohelper.findButtonWithAudio(slot0._go)
	slot0._txtTabName = gohelper.findChildText(slot0._go, "#txt_TabName")
	slot0._txtTabNum = gohelper.findChildText(slot0._go, "#txt_TabName/#txt_TabNum")
	slot0._goSelected = gohelper.findChild(slot0._go, "#go_Selected")
	slot0._imageSelected = gohelper.findChildImage(slot0._go, "#go_Selected/#image_Selected")
	slot0._txtTabNameSelected = gohelper.findChildText(slot0._go, "#go_Selected/#txt_TabName")
	slot0._txtTabNumSelected = gohelper.findChildText(slot0._go, "#go_Selected/#txt_TabName/#txt_TabNum")
	slot0._txtLockedTips = gohelper.findChildText(slot0._go, "#go_Locked/#txt_LockedTips")
	slot0._goLocked = gohelper.findChild(slot0._go, "#go_Locked")
	slot0._goFinished = gohelper.findChild(slot0._go, "#go_Finished")
	slot0._txtTabNum.text = string.format("TRAINING NO.%s", slot0.index)
	slot0._txtTabName.text = slot0.co.normalCO.name
	slot0._txtTabNumSelected.text = string.format("TRAINING NO.%s", slot0.index)
	slot0._txtTabNameSelected.text = slot0.co.normalCO.name
	slot0._goRedPoint = gohelper.findChild(slot0._go, "redPoint")

	RedDotController.instance:addRedDot(slot0._goRedPoint, RedDotEnum.DotNode.ActivityDreamTailTask, slot0.index)
	slot0:changeSelect(false)
end

function slot0.addEvents(slot0)
	slot0._btn:AddClickListener(slot0.changeSelect, slot0, true)
end

function slot0.updateLock(slot0, slot1)
	slot0.nowDay = slot1
	slot0._isLock = false

	if slot0.co.normalCO.openDay - slot1 > 0 then
		slot0._isLock = true

		if slot2 == 1 then
			gohelper.setActive(slot0._goLocked, true)

			slot0._txtLockedTips.text = formatLuaLang("versionactivity_1_2_119_unlock", slot2)
		else
			gohelper.setActive(slot0._goLocked, false)

			slot0._txtTabName.text = luaLang("versionactivity_1_2_119_unlock1")
			slot0._txtTabNum.text = "UNLOCK"
		end
	else
		gohelper.setActive(slot0._goLocked, false)

		slot0._txtTabNum.text = string.format("TRAINING NO.%s", slot0.co.normalCO.tabId)
		slot0._txtTabName.text = slot0.co.normalCO.name
	end
end

function slot0.updateFinishView(slot0)
	slot3 = true

	for slot7 = 1, #slot0.co.taskList do
		if TaskModel.instance:getTaskById(slot2[slot7].id) and slot8.finishCount <= 0 then
			slot3 = false

			break
		end
	end

	gohelper.setActive(slot0._goFinished, slot3)
end

function slot0.playUnLockAnim(slot0)
end

function slot0.changeSelect(slot0, slot1)
	if slot1 and slot0._isLock and not slot0._isPlayingUnLock then
		ToastController.instance:showToast(3401)

		return
	end

	gohelper.setActive(slot0._goSelected, slot1)

	slot0._isSelect = slot1

	if slot1 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_detailed_tabs_click)
		Activity119Controller.instance:dispatchEvent(Activity119Event.TabChange, slot0.index)
	end
end

function slot0.removeEvents(slot0)
	slot0._btn:RemoveClickListener()
end

function slot0.dispose(slot0)
	slot0:removeEvents()

	slot0._go = nil
	slot0.index = nil
	slot0._btn = nil
	slot0._goSelected = nil
	slot0._txtTabNum = nil
	slot0._txtTabNumSelected = nil
	slot0._txtTabName = nil
	slot0._txtTabNameSelected = nil
	slot0._goLocked = nil
end

return slot0
