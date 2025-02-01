module("modules.logic.versionactivity1_2.dreamtail.view.Activity119TabItem", package.seeall)

slot0 = class("Activity119TabItem")

function slot0.init(slot0, slot1, slot2)
	slot0.go = slot1
	slot0.index = slot2
	slot0.co = Activity119Config.instance:getConfig(VersionActivity1_2Enum.ActivityId.DreamTail, slot2)

	slot0:onInitView()
	slot0:addEvents()
end

function slot0.onInitView(slot0)
	slot0._btn = gohelper.findButtonWithAudio(slot0.go)
	slot0._goselect = gohelper.findChild(slot0.go, "go_select")
	slot0._txtindex = gohelper.findChildText(slot0.go, "txt_index")
	slot0._txtname = gohelper.findChildTextMesh(slot0.go, "txt_name")
	slot0._golock = gohelper.findChild(slot0.go, "go_lock")
	slot0._txtunlock = gohelper.findChildTextMesh(slot0.go, "go_lock/txt_unlock")
	slot0._anim = ZProj.ProjAnimatorPlayer.Get(slot0.go)
	slot0._goredPoint = gohelper.findChild(slot0.go, "redPoint")
	slot0._txtindex.text = string.format("TRAINING NO.%s", slot0.index)
	slot0._txtname.text = slot0.co.normalCO.name

	RedDotController.instance:addRedDot(slot0._goredPoint, RedDotEnum.DotNode.ActivityDreamTailTask, slot0.index)
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
			gohelper.setActive(slot0._golock, true)

			slot0._txtunlock.text = formatLuaLang("versionactivity_1_2_119_unlock", slot2)

			SLFramework.UGUI.GuiHelper.SetColor(slot0._txtindex, "#20202099")
			SLFramework.UGUI.GuiHelper.SetColor(slot0._txtname, "#20202099")
		else
			gohelper.setActive(slot0._golock, false)

			slot0._txtname.text = luaLang("versionactivity_1_2_119_unlock1")
			slot0._txtindex.text = "UNLOCK"

			SLFramework.UGUI.GuiHelper.SetColor(slot0._txtindex, "#20202066")
			SLFramework.UGUI.GuiHelper.SetColor(slot0._txtname, "#20202066")
		end
	else
		gohelper.setActive(slot0._golock, false)

		slot0._txtindex.text = string.format("TRAINING NO.%s", slot0.index)
		slot0._txtname.text = slot0.co.normalCO.name

		if slot0._isSelect then
			SLFramework.UGUI.GuiHelper.SetColor(slot0._txtindex, "#ffffffb2")
			SLFramework.UGUI.GuiHelper.SetColor(slot0._txtname, "#ffffffb2")
		else
			SLFramework.UGUI.GuiHelper.SetColor(slot0._txtindex, "#202020b2")
			SLFramework.UGUI.GuiHelper.SetColor(slot0._txtname, "#202020b2")
		end
	end
end

function slot0.playUnLockAnim(slot0)
end

function slot0.onUnLockEnd(slot0)
end

function slot0.changeSelect(slot0, slot1)
	if slot1 and slot0._isLock and not slot0._isPlayingUnLock then
		ToastController.instance:showToast(3401)

		return
	end

	gohelper.setActive(slot0._goselect, slot1)

	slot0._isSelect = slot1

	if slot1 then
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtindex, "#ffffffb2")
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtname, "#ffffffb2")
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_detailed_tabs_click)
		Activity119Controller.instance:dispatchEvent(Activity119Event.TabChange, slot0.index)
	else
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtindex, "#202020b2")
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtname, "#202020b2")
	end
end

function slot0.removeEvents(slot0)
	slot0._btn:RemoveClickListener()
end

function slot0.dispose(slot0)
	slot0:removeEvents()

	slot0.go = nil
	slot0.index = nil
	slot0._btn = nil
	slot0._goselect = nil
	slot0._txtindex = nil
	slot0._txtname = nil
	slot0._golock = nil
	slot0._txtunlock = nil
end

return slot0
