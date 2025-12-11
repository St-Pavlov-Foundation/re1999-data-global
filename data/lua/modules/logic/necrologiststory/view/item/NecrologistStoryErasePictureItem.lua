module("modules.logic.necrologiststory.view.item.NecrologistStoryErasePictureItem", package.seeall)

local var_0_0 = class("NecrologistStoryErasePictureItem", NecrologistStoryControlItem)

function var_0_0.onInit(arg_1_0)
	arg_1_0.anim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0.goTips = gohelper.findChild(arg_1_0.viewGO, "root/tips")
	arg_1_0.goErase = gohelper.findChild(arg_1_0.viewGO, "root/go_erase")
	arg_1_0.eraseComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0.goErase, NecrologistStoryErasePictureComp)

	arg_1_0.eraseComp:setCallback(arg_1_0.startDraw, arg_1_0.showRate, arg_1_0.endDraw, arg_1_0.finishDraw, arg_1_0)
end

function var_0_0.addEventListeners(arg_2_0)
	return
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0.onPlayStory(arg_4_0)
	arg_4_0.inPlayFinishing = false

	local var_4_0 = string.split(arg_4_0._controlParam, "#")
	local var_4_1 = tonumber(var_4_0[1])
	local var_4_2 = tonumber(var_4_0[2])
	local var_4_3 = ResUrl.getNecrologistStoryPicBg(var_4_0[3])

	arg_4_0.eraseComp:setEraseData(var_4_3, var_4_1, var_4_2)
	gohelper.setActive(arg_4_0.goTips, true)
	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.StartErasePic)
end

function var_0_0.startDraw(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_feichi_spray_loop)
	gohelper.setActive(arg_5_0.goTips, false)
end

function var_0_0.showRate(arg_6_0, arg_6_1)
	return
end

function var_0_0.endDraw(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.stop_ui_feichi_spray_loop)
end

function var_0_0.finishDraw(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.stop_ui_feichi_spray_loop)
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_qiutu_list_maintain)
	arg_8_0.anim:Play("finish", 0, 0)

	arg_8_0.inPlayFinishing = true

	TaskDispatcher.cancelTask(arg_8_0._delayFinish, arg_8_0)
	TaskDispatcher.runDelay(arg_8_0._delayFinish, arg_8_0, 0.8)
end

function var_0_0._delayFinish(arg_9_0)
	arg_9_0.inPlayFinishing = false

	arg_9_0:onPlayFinish()
end

function var_0_0.caleHeight(arg_10_0)
	return 400
end

function var_0_0.isDone(arg_11_0)
	if arg_11_0.inPlayFinishing then
		return false
	end

	return arg_11_0.eraseComp:isFinish()
end

function var_0_0.onDestroy(arg_12_0)
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.stop_ui_feichi_spray_loop)
	TaskDispatcher.cancelTask(arg_12_0._delayFinish, arg_12_0)
end

function var_0_0.getResPath()
	return "ui/viewres/dungeon/rolestory/necrologiststoryerasepictureitem.prefab"
end

return var_0_0
