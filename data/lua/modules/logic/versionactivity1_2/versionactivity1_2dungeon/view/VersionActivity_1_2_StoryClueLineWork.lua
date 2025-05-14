module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_StoryClueLineWork", package.seeall)

local var_0_0 = class("VersionActivity_1_2_StoryClueLineWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0._lineTransform = arg_1_1
	arg_1_0._toValue = arg_1_2
	arg_1_0._duration = arg_1_3
	arg_1_0._clueId = arg_1_4
end

function var_0_0.onStart(arg_2_0)
	VersionActivity1_2DungeonController.instance:registerCallback(VersionActivity1_2DungeonEvent.skipLineWork, arg_2_0._skipLineWork, arg_2_0)

	arg_2_0._tweenId = ZProj.TweenHelper.DOWidth(arg_2_0._lineTransform, arg_2_0._toValue, arg_2_0._duration, arg_2_0._onTweenEnd, arg_2_0)

	local var_2_0

	for iter_2_0 = 1, 4 do
		if VersionActivity_1_2_StoryCollectView._signTypeName[arg_2_0._clueId] == VersionActivity_1_2_StoryCollectView._signTypeName[iter_2_0] then
			var_2_0 = "play_ui_lvhu_clue_write_" .. iter_2_0
		end
	end

	if var_2_0 then
		AudioMgr.instance:trigger(AudioEnum.UI[var_2_0])
	end
end

function var_0_0._skipLineWork(arg_3_0)
	arg_3_0:onDone(true)
	recthelper.setWidth(arg_3_0._lineTransform, arg_3_0._toValue)
end

function var_0_0._onTweenEnd(arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	VersionActivity1_2DungeonController.instance:unregisterCallback(VersionActivity1_2DungeonEvent.skipLineWork, arg_5_0._skipLineWork, arg_5_0)

	if arg_5_0._tweenId then
		ZProj.TweenHelper.KillById(arg_5_0._tweenId)

		arg_5_0._tweenId = nil
	end
end

return var_0_0
