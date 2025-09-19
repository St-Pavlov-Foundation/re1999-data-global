module("modules.logic.versionactivity2_5.challenge.view.dungeon.episode.Act183DailyEpisodeItem", package.seeall)

local var_0_0 = class("Act183DailyEpisodeItem", Act183BaseEpisodeItem)

function var_0_0.getItemParentPath(arg_1_0)
	return "root/middle/#go_episodecontainer/go_dailypoint" .. arg_1_0
end

function var_0_0.getItemTemplatePath(arg_2_0)
	return "root/middle/#go_episodecontainer/#go_dailyepisode"
end

function var_0_0.init(arg_3_0, arg_3_1)
	var_0_0.super.init(arg_3_0, arg_3_1)

	arg_3_0._goinfo = gohelper.findChild(arg_3_0.go, "Info")
	arg_3_0._imageindex = gohelper.findChildImage(arg_3_0.go, "go_finish/image_index")
	arg_3_0._ruleComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_3_1, Act183EpisodeItemRuleComp)
end

function var_0_0.addEventListeners(arg_4_0)
	var_0_0.super.addEventListeners(arg_4_0)
	arg_4_0:addEventCb(Act183Controller.instance, Act183Event.OnUpdateRepressInfo, arg_4_0._onUpdateRepressInfo, arg_4_0)
end

function var_0_0.removeEventListeners(arg_5_0)
	var_0_0.super.removeEventListeners(arg_5_0)
end

function var_0_0._onUpdateRepressInfo(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0._episodeId ~= arg_6_1 then
		return
	end

	arg_6_0._ruleComp:onUpdateMo(arg_6_2)
end

function var_0_0.onUpdateMo(arg_7_0, arg_7_1)
	var_0_0.super.onUpdateMo(arg_7_0, arg_7_1)

	if arg_7_0._status == Act183Enum.EpisodeStatus.Finished then
		local var_7_0 = "v2a5_challenge_dungeon_level_" .. arg_7_1:getPassOrder()

		UISpriteSetMgr.instance:setChallengeSprite(arg_7_0._imageindex, var_7_0)
	end

	arg_7_0._ruleComp:onUpdateMo(arg_7_1)
end

function var_0_0.playFinishAnim(arg_8_0)
	var_0_0.super.playFinishAnim(arg_8_0)
	arg_8_0._ruleComp:playRepressAnim()
end

function var_0_0.playFakeRepressAnim(arg_9_0)
	arg_9_0._ruleComp:playFakeRepressAnim()
end

return var_0_0
