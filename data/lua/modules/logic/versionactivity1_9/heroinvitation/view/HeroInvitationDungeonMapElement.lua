module("modules.logic.versionactivity1_9.heroinvitation.view.HeroInvitationDungeonMapElement", package.seeall)

local var_0_0 = class("HeroInvitationDungeonMapElement", DungeonMapElement)

function var_0_0.setFinishAndDotDestroy(arg_1_0)
	if not arg_1_0._wenhaoGo then
		arg_1_0._waitFinishAndDotDestroy = true

		return
	end

	UIBlockHelper.instance:startBlock("DungeonMapSceneTweenPos", 1.6, ViewName.HeroInvitationDungeonMapView)
	arg_1_0:setWenHaoAnim("finish")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_elementdisappear)
end

function var_0_0._wenHaoAnimDone(arg_2_0)
	if arg_2_0._wenhaoAnimName == "finish" then
		arg_2_0._sceneElements:onRemoveElementFinish()

		if arg_2_0:getElementId() == 311114 then
			TaskDispatcher.runDelay(arg_2_0.delayFinish, arg_2_0, 1)
		end
	end
end

function var_0_0.delayFinish(arg_3_0)
	ViewMgr.instance:openView(ViewName.HeroInvitationView)
end

function var_0_0._onResLoaded(arg_4_0)
	var_0_0.super._onResLoaded(arg_4_0)

	if arg_4_0._waitFinishAndDotDestroy then
		arg_4_0._waitFinishAndDotDestroy = false

		arg_4_0:setFinishAndDotDestroy()
	end
end

function var_0_0.onDestroy(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.delayFinish, arg_5_0)
	var_0_0.super.onDestroy(arg_5_0)
end

return var_0_0
