module("modules.logic.versionactivity2_5.challenge.view.dungeon.episode.Act183MainBossEpisodeItem", package.seeall)

local var_0_0 = class("Act183MainBossEpisodeItem", Act183BaseEpisodeItem)

function var_0_0.getItemParentPath(arg_1_0)
	return "root/middle/#go_episodecontainer/go_pointboss"
end

function var_0_0.getItemTemplatePath()
	return "root/middle/#go_episodecontainer/#go_bossepisode"
end

function var_0_0.init(arg_3_0, arg_3_1)
	var_0_0.super.init(arg_3_0, arg_3_1)

	arg_3_0._gostars = gohelper.findChild(arg_3_0.go, "go_finish/go_stars")
	arg_3_0._gostaritem = gohelper.findChild(arg_3_0.go, "go_finish/go_stars/stars/go_staritem")
	arg_3_0._animunlock = gohelper.onceAddComponent(arg_3_0._gounlock, gohelper.Type_Animator)

	arg_3_0:addEventCb(Act183Controller.instance, Act183Event.OnInitDungeonDone, arg_3_0._onInitDungeonDone, arg_3_0)
end

function var_0_0.onUpdateMo(arg_4_0, arg_4_1)
	var_0_0.super.onUpdateMo(arg_4_0, arg_4_1)
	arg_4_0:refreshPassStarList(arg_4_0._gostaritem)
end

function var_0_0._onInitDungeonDone(arg_5_0)
	arg_5_0:_checkPlayNewUnlockAnim()
end

function var_0_0._checkPlayNewUnlockAnim(arg_6_0)
	if arg_6_0._status ~= Act183Enum.EpisodeStatus.Unlocked then
		return
	end

	if Act183Model.instance:isEpisodeNewUnlock(arg_6_0._episodeId) then
		arg_6_0._animunlock:Play("unlock", 0, 0)
	end
end

function var_0_0.playFinishAnim(arg_7_0)
	var_0_0.super.playFinishAnim(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_EpisodeFinished_Star)
end

return var_0_0
