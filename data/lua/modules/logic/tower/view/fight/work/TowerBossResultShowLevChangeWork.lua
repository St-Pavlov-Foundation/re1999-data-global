module("modules.logic.tower.view.fight.work.TowerBossResultShowLevChangeWork", package.seeall)

local var_0_0 = class("TowerBossResultShowLevChangeWork", BaseWork)
local var_0_1 = 2

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.goBossLevChange = arg_1_1
	arg_1_0.goBoss = arg_1_2
	arg_1_0.isBossLevChange = arg_1_3
end

function var_0_0.onStart(arg_2_0)
	gohelper.setActive(arg_2_0.goBossLevChange, true)
	gohelper.setActive(arg_2_0.goBoss, true)

	if not arg_2_0.isBossLevChange then
		arg_2_0:onDone(true)
	else
		TaskDispatcher.runDelay(arg_2_0._triggerAudio, arg_2_0, 0.8)
	end

	TaskDispatcher.runDelay(arg_2_0._delayFinish, arg_2_0, var_0_1)
end

function var_0_0._triggerAudio(arg_3_0)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_level_up)
end

function var_0_0._delayFinish(arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	gohelper.setActive(arg_5_0.goBossLevChange, false)
	TaskDispatcher.cancelTask(arg_5_0._delayFinish, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._triggerAudio, arg_5_0)
end

return var_0_0
