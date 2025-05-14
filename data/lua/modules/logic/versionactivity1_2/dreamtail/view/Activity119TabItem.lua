module("modules.logic.versionactivity1_2.dreamtail.view.Activity119TabItem", package.seeall)

local var_0_0 = class("Activity119TabItem")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.go = arg_1_1
	arg_1_0.index = arg_1_2
	arg_1_0.co = Activity119Config.instance:getConfig(VersionActivity1_2Enum.ActivityId.DreamTail, arg_1_2)

	arg_1_0:onInitView()
	arg_1_0:addEvents()
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._btn = gohelper.findButtonWithAudio(arg_2_0.go)
	arg_2_0._goselect = gohelper.findChild(arg_2_0.go, "go_select")
	arg_2_0._txtindex = gohelper.findChildText(arg_2_0.go, "txt_index")
	arg_2_0._txtname = gohelper.findChildTextMesh(arg_2_0.go, "txt_name")
	arg_2_0._golock = gohelper.findChild(arg_2_0.go, "go_lock")
	arg_2_0._txtunlock = gohelper.findChildTextMesh(arg_2_0.go, "go_lock/txt_unlock")
	arg_2_0._anim = ZProj.ProjAnimatorPlayer.Get(arg_2_0.go)
	arg_2_0._goredPoint = gohelper.findChild(arg_2_0.go, "redPoint")
	arg_2_0._txtindex.text = string.format("TRAINING NO.%s", arg_2_0.index)
	arg_2_0._txtname.text = arg_2_0.co.normalCO.name

	RedDotController.instance:addRedDot(arg_2_0._goredPoint, RedDotEnum.DotNode.ActivityDreamTailTask, arg_2_0.index)
	arg_2_0:changeSelect(false)
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btn:AddClickListener(arg_3_0.changeSelect, arg_3_0, true)
end

function var_0_0.updateLock(arg_4_0, arg_4_1)
	arg_4_0.nowDay = arg_4_1

	local var_4_0 = arg_4_0.co.normalCO.openDay - arg_4_1

	arg_4_0._isLock = false

	if var_4_0 > 0 then
		arg_4_0._isLock = true

		if var_4_0 == 1 then
			gohelper.setActive(arg_4_0._golock, true)

			arg_4_0._txtunlock.text = formatLuaLang("versionactivity_1_2_119_unlock", var_4_0)

			SLFramework.UGUI.GuiHelper.SetColor(arg_4_0._txtindex, "#20202099")
			SLFramework.UGUI.GuiHelper.SetColor(arg_4_0._txtname, "#20202099")
		else
			gohelper.setActive(arg_4_0._golock, false)

			arg_4_0._txtname.text = luaLang("versionactivity_1_2_119_unlock1")
			arg_4_0._txtindex.text = "UNLOCK"

			SLFramework.UGUI.GuiHelper.SetColor(arg_4_0._txtindex, "#20202066")
			SLFramework.UGUI.GuiHelper.SetColor(arg_4_0._txtname, "#20202066")
		end
	else
		gohelper.setActive(arg_4_0._golock, false)

		arg_4_0._txtindex.text = string.format("TRAINING NO.%s", arg_4_0.index)
		arg_4_0._txtname.text = arg_4_0.co.normalCO.name

		if arg_4_0._isSelect then
			SLFramework.UGUI.GuiHelper.SetColor(arg_4_0._txtindex, "#ffffffb2")
			SLFramework.UGUI.GuiHelper.SetColor(arg_4_0._txtname, "#ffffffb2")
		else
			SLFramework.UGUI.GuiHelper.SetColor(arg_4_0._txtindex, "#202020b2")
			SLFramework.UGUI.GuiHelper.SetColor(arg_4_0._txtname, "#202020b2")
		end
	end
end

function var_0_0.playUnLockAnim(arg_5_0)
	return
end

function var_0_0.onUnLockEnd(arg_6_0)
	return
end

function var_0_0.changeSelect(arg_7_0, arg_7_1)
	if arg_7_1 and arg_7_0._isLock and not arg_7_0._isPlayingUnLock then
		ToastController.instance:showToast(3401)

		return
	end

	gohelper.setActive(arg_7_0._goselect, arg_7_1)

	arg_7_0._isSelect = arg_7_1

	if arg_7_1 then
		SLFramework.UGUI.GuiHelper.SetColor(arg_7_0._txtindex, "#ffffffb2")
		SLFramework.UGUI.GuiHelper.SetColor(arg_7_0._txtname, "#ffffffb2")
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_detailed_tabs_click)
		Activity119Controller.instance:dispatchEvent(Activity119Event.TabChange, arg_7_0.index)
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_7_0._txtindex, "#202020b2")
		SLFramework.UGUI.GuiHelper.SetColor(arg_7_0._txtname, "#202020b2")
	end
end

function var_0_0.removeEvents(arg_8_0)
	arg_8_0._btn:RemoveClickListener()
end

function var_0_0.dispose(arg_9_0)
	arg_9_0:removeEvents()

	arg_9_0.go = nil
	arg_9_0.index = nil
	arg_9_0._btn = nil
	arg_9_0._goselect = nil
	arg_9_0._txtindex = nil
	arg_9_0._txtname = nil
	arg_9_0._golock = nil
	arg_9_0._txtunlock = nil
end

return var_0_0
