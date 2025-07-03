module("modules.logic.versionactivity2_5.challenge.view.dungeon.episode.Act183MainNormalEpisodeItem", package.seeall)

local var_0_0 = class("Act183MainNormalEpisodeItem", Act183BaseEpisodeItem)

function var_0_0.getItemParentPath(arg_1_0)
	return "root/middle/#go_episodecontainer/go_point" .. arg_1_0
end

function var_0_0.getItemTemplatePath(arg_2_0)
	return "root/middle/#go_episodecontainer/#go_normalepisode"
end

function var_0_0.init(arg_3_0, arg_3_1)
	var_0_0.super.init(arg_3_0, arg_3_1)

	arg_3_0._goinfo = gohelper.findChild(arg_3_0.go, "Info")
	arg_3_0._imagerule1 = gohelper.findChildImage(arg_3_0.go, "Info/rules/image_rule1")
	arg_3_0._gorepress1 = gohelper.findChild(arg_3_0.go, "Info/rules/image_rule1/go_repress1")
	arg_3_0._imagerule2 = gohelper.findChildImage(arg_3_0.go, "Info/rules/image_rule2")
	arg_3_0._gorepress2 = gohelper.findChild(arg_3_0.go, "Info/rules/image_rule2/go_repress2")
	arg_3_0._imageindex = gohelper.findChildImage(arg_3_0.go, "go_finish/image_index")
	arg_3_0._imagecondition = gohelper.findChildImage(arg_3_0.go, "Info/image_condition")
	arg_3_0._goescape1 = gohelper.findChild(arg_3_0.go, "Info/rules/image_rule1/go_repressbutterfly1")
	arg_3_0._goescape2 = gohelper.findChild(arg_3_0.go, "Info/rules/image_rule2/go_repressbutterfly2")
	arg_3_0._gostars = gohelper.findChild(arg_3_0.go, "go_finish/go_stars")
	arg_3_0._gostaritem = gohelper.findChild(arg_3_0.go, "go_finish/go_stars/stars/go_staritem")
	arg_3_0._animrepress1 = gohelper.onceAddComponent(arg_3_0._gorepress1, gohelper.Type_Animator)
	arg_3_0._animrepress2 = gohelper.onceAddComponent(arg_3_0._gorepress2, gohelper.Type_Animator)
	arg_3_0._animescape1 = gohelper.onceAddComponent(arg_3_0._goescape1, gohelper.Type_Animator)
	arg_3_0._animescape2 = gohelper.onceAddComponent(arg_3_0._goescape2, gohelper.Type_Animator)
	arg_3_0._animcondition = gohelper.onceAddComponent(arg_3_0._imagecondition, gohelper.Type_Animator)

	Act183Helper.setEpisodeConditionStar(arg_3_0._imagecondition, true)
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

	arg_6_0:refreshRules()
	arg_6_0:playRepressAnim()
end

function var_0_0.onUpdateMo(arg_7_0, arg_7_1)
	var_0_0.super.onUpdateMo(arg_7_0, arg_7_1)

	if arg_7_0._status == Act183Enum.EpisodeStatus.Finished then
		local var_7_0 = "v2a5_challenge_dungeon_level_" .. arg_7_1:getPassOrder()

		UISpriteSetMgr.instance:setChallengeSprite(arg_7_0._imageindex, var_7_0)
	end

	arg_7_0._isAllConditionPass = arg_7_0._episodeMo:isAllConditionPass()

	arg_7_0._animcondition:Play(arg_7_0._isAllConditionPass and "lighted" or "gray", 0, 0)
	arg_7_0:refreshRules()
	arg_7_0:refreshPassStarList(arg_7_0._gostaritem)
end

function var_0_0.refreshRules(arg_8_0)
	Act183Helper.setRuleIcon(arg_8_0._episodeId, 1, arg_8_0._imagerule1)
	Act183Helper.setRuleIcon(arg_8_0._episodeId, 2, arg_8_0._imagerule2)

	arg_8_0._rule1status = arg_8_0._episodeMo:getRuleStatus(1)
	arg_8_0._rule2status = arg_8_0._episodeMo:getRuleStatus(2)

	gohelper.setActive(arg_8_0._gorepress1, arg_8_0._rule1status == Act183Enum.RuleStatus.Repress)
	gohelper.setActive(arg_8_0._gorepress2, arg_8_0._rule2status == Act183Enum.RuleStatus.Repress)
	gohelper.setActive(arg_8_0._goescape1, arg_8_0._rule1status == Act183Enum.RuleStatus.Escape)
	gohelper.setActive(arg_8_0._goescape2, arg_8_0._rule2status == Act183Enum.RuleStatus.Escape)
end

function var_0_0.playFinishAnim(arg_9_0)
	var_0_0.super.playFinishAnim(arg_9_0)
	arg_9_0:playRepressAnim()
	arg_9_0:playAllConditionPassAnim()
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_EpisodeFinished_Star)
end

function var_0_0.playRepressAnim(arg_10_0)
	if arg_10_0._rule1status == Act183Enum.RuleStatus.Repress then
		arg_10_0._animrepress1:Play("in", 0, 0)
	else
		arg_10_0._animescape1:Play("in", 0, 0)
	end

	if arg_10_0._rule2status == Act183Enum.RuleStatus.Repress then
		arg_10_0._animrepress2:Play("in", 0, 0)
	else
		arg_10_0._animescape2:Play("in", 0, 0)
	end
end

function var_0_0.playAllConditionPassAnim(arg_11_0)
	if arg_11_0._isAllConditionPass then
		arg_11_0._animcondition:Play("light", 0, 0)
	end
end

return var_0_0
