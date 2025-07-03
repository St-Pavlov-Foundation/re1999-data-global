module("modules.logic.versionactivity2_5.challenge.view.task.Act183TaskBaseItem", package.seeall)

local var_0_0 = class("Act183TaskBaseItem", MixScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_1_0.go)
end

function var_0_0.onUpdateMO(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0._mo = arg_2_1

	arg_2_0:playAnim()
end

function var_0_0.playAnim(arg_3_0)
	local var_3_0 = UnityEngine.Time.frameCount - Act183TaskListModel.instance.startFrameCount < 10

	arg_3_0._animName = var_3_0 and UIAnimationName.Open or UIAnimationName.Idle

	gohelper.setActive(arg_3_0.go, false)
	TaskDispatcher.cancelTask(arg_3_0._playAnimByName, arg_3_0)

	if var_3_0 then
		TaskDispatcher.runDelay(arg_3_0._playAnimByName, arg_3_0, (arg_3_0._index - 1) * 0.03)

		return
	end

	arg_3_0:_playAnimByName()
end

function var_0_0._playAnimByName(arg_4_0)
	gohelper.setActive(arg_4_0.go, true)

	if not arg_4_0._animName or not arg_4_0.go.activeInHierarchy then
		return
	end

	arg_4_0._animatorPlayer:Play(arg_4_0._animName, arg_4_0._onPlayAnimDone, arg_4_0)
end

function var_0_0._onPlayAnimDone(arg_5_0)
	return
end

function var_0_0.onDestroy(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._playAnimByName, arg_6_0)
	arg_6_0:setBlock(false)
end

function var_0_0.setBlock(arg_7_0, arg_7_1)
	if arg_7_1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("Act183TaskBaseItem_ReceiveReward")
	else
		UIBlockMgrExtend.setNeedCircleMv(true)
		UIBlockMgr.instance:endBlock("Act183TaskBaseItem_ReceiveReward")
	end
end

return var_0_0
