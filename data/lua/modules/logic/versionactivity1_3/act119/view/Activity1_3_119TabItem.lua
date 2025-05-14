module("modules.logic.versionactivity1_3.act119.view.Activity1_3_119TabItem", package.seeall)

local var_0_0 = class("Activity1_3_119TabItem")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1
	arg_1_0.index = arg_1_2
	arg_1_0.co = Activity119Config.instance:getConfig(VersionActivity1_3Enum.ActivityId.Act307, arg_1_2)

	arg_1_0:onInitView()
	arg_1_0:addEvents()
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._btn = gohelper.findButtonWithAudio(arg_2_0._go)
	arg_2_0._txtTabName = gohelper.findChildText(arg_2_0._go, "#txt_TabName")
	arg_2_0._txtTabNum = gohelper.findChildText(arg_2_0._go, "#txt_TabName/#txt_TabNum")
	arg_2_0._goSelected = gohelper.findChild(arg_2_0._go, "#go_Selected")
	arg_2_0._imageSelected = gohelper.findChildImage(arg_2_0._go, "#go_Selected/#image_Selected")
	arg_2_0._txtTabNameSelected = gohelper.findChildText(arg_2_0._go, "#go_Selected/#txt_TabName")
	arg_2_0._txtTabNumSelected = gohelper.findChildText(arg_2_0._go, "#go_Selected/#txt_TabName/#txt_TabNum")
	arg_2_0._txtLockedTips = gohelper.findChildText(arg_2_0._go, "#go_Locked/#txt_LockedTips")
	arg_2_0._goLocked = gohelper.findChild(arg_2_0._go, "#go_Locked")
	arg_2_0._goFinished = gohelper.findChild(arg_2_0._go, "#go_Finished")
	arg_2_0._txtTabNum.text = string.format("TRAINING NO.%s", arg_2_0.index)
	arg_2_0._txtTabName.text = arg_2_0.co.normalCO.name
	arg_2_0._txtTabNumSelected.text = string.format("TRAINING NO.%s", arg_2_0.index)
	arg_2_0._txtTabNameSelected.text = arg_2_0.co.normalCO.name
	arg_2_0._goRedPoint = gohelper.findChild(arg_2_0._go, "redPoint")

	RedDotController.instance:addRedDot(arg_2_0._goRedPoint, RedDotEnum.DotNode.ActivityDreamTailTask, arg_2_0.index)
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
			gohelper.setActive(arg_4_0._goLocked, true)

			arg_4_0._txtLockedTips.text = formatLuaLang("versionactivity_1_2_119_unlock", var_4_0)
		else
			gohelper.setActive(arg_4_0._goLocked, false)

			arg_4_0._txtTabName.text = luaLang("versionactivity_1_2_119_unlock1")
			arg_4_0._txtTabNum.text = "UNLOCK"
		end
	else
		gohelper.setActive(arg_4_0._goLocked, false)

		arg_4_0._txtTabNum.text = string.format("TRAINING NO.%s", arg_4_0.co.normalCO.tabId)
		arg_4_0._txtTabName.text = arg_4_0.co.normalCO.name
	end
end

function var_0_0.updateFinishView(arg_5_0)
	local var_5_0 = arg_5_0.co.taskList
	local var_5_1 = true

	for iter_5_0 = 1, #var_5_0 do
		local var_5_2 = TaskModel.instance:getTaskById(var_5_0[iter_5_0].id)

		if var_5_2 and not (var_5_2.finishCount > 0) then
			var_5_1 = false

			break
		end
	end

	gohelper.setActive(arg_5_0._goFinished, var_5_1)
end

function var_0_0.playUnLockAnim(arg_6_0)
	return
end

function var_0_0.changeSelect(arg_7_0, arg_7_1)
	if arg_7_1 and arg_7_0._isLock and not arg_7_0._isPlayingUnLock then
		ToastController.instance:showToast(3401)

		return
	end

	gohelper.setActive(arg_7_0._goSelected, arg_7_1)

	arg_7_0._isSelect = arg_7_1

	if arg_7_1 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_detailed_tabs_click)
		Activity119Controller.instance:dispatchEvent(Activity119Event.TabChange, arg_7_0.index)
	end
end

function var_0_0.removeEvents(arg_8_0)
	arg_8_0._btn:RemoveClickListener()
end

function var_0_0.dispose(arg_9_0)
	arg_9_0:removeEvents()

	arg_9_0._go = nil
	arg_9_0.index = nil
	arg_9_0._btn = nil
	arg_9_0._goSelected = nil
	arg_9_0._txtTabNum = nil
	arg_9_0._txtTabNumSelected = nil
	arg_9_0._txtTabName = nil
	arg_9_0._txtTabNameSelected = nil
	arg_9_0._goLocked = nil
end

return var_0_0
