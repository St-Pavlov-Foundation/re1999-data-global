module("modules.logic.versionactivity2_5.challenge.view.dungeon.episode.Act183EpisodeItemRuleComp", package.seeall)

local var_0_0 = class("Act183EpisodeItemRuleComp", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._goinfo = gohelper.findChild(arg_1_0.go, "Info")
	arg_1_0._imagerule1 = gohelper.findChildImage(arg_1_0.go, "Info/rules/image_rule1")
	arg_1_0._gorepress1 = gohelper.findChild(arg_1_0.go, "Info/rules/image_rule1/go_repress1")
	arg_1_0._imagerule2 = gohelper.findChildImage(arg_1_0.go, "Info/rules/image_rule2")
	arg_1_0._gorepress2 = gohelper.findChild(arg_1_0.go, "Info/rules/image_rule2/go_repress2")
	arg_1_0._goescape1 = gohelper.findChild(arg_1_0.go, "Info/rules/image_rule1/go_repressbutterfly1")
	arg_1_0._goescape2 = gohelper.findChild(arg_1_0.go, "Info/rules/image_rule2/go_repressbutterfly2")
	arg_1_0._animrepress1 = gohelper.onceAddComponent(arg_1_0._gorepress1, gohelper.Type_Animator)
	arg_1_0._animrepress2 = gohelper.onceAddComponent(arg_1_0._gorepress2, gohelper.Type_Animator)
	arg_1_0._animescape1 = gohelper.onceAddComponent(arg_1_0._goescape1, gohelper.Type_Animator)
	arg_1_0._animescape2 = gohelper.onceAddComponent(arg_1_0._goescape2, gohelper.Type_Animator)
end

function var_0_0.addEventListeners(arg_2_0)
	return
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0.onUpdateMo(arg_4_0, arg_4_1)
	arg_4_0._episodeMo = arg_4_1
	arg_4_0._episodeId = arg_4_1:getEpisodeId()
	arg_4_0._hasRules = Act183Helper.isEpisodeHasRule(arg_4_0._episodeId)

	arg_4_0:refreshRules()
end

function var_0_0.refreshRules(arg_5_0)
	gohelper.setActive(arg_5_0._goinfo, arg_5_0._hasRules)

	if not arg_5_0._hasRules then
		return
	end

	Act183Helper.setRuleIcon(arg_5_0._episodeId, 1, arg_5_0._imagerule1)
	Act183Helper.setRuleIcon(arg_5_0._episodeId, 2, arg_5_0._imagerule2)

	arg_5_0._rule1status = arg_5_0._episodeMo:getRuleStatus(1)
	arg_5_0._rule2status = arg_5_0._episodeMo:getRuleStatus(2)

	gohelper.setActive(arg_5_0._gorepress1, arg_5_0._rule1status == Act183Enum.RuleStatus.Repress)
	gohelper.setActive(arg_5_0._gorepress2, arg_5_0._rule2status == Act183Enum.RuleStatus.Repress)
	gohelper.setActive(arg_5_0._goescape1, arg_5_0._rule1status == Act183Enum.RuleStatus.Escape)
	gohelper.setActive(arg_5_0._goescape2, arg_5_0._rule2status == Act183Enum.RuleStatus.Escape)
end

function var_0_0.playRepressAnim(arg_6_0)
	if not arg_6_0._hasRules then
		return
	end

	if arg_6_0._rule1status == Act183Enum.RuleStatus.Repress then
		arg_6_0._animrepress1:Play("in", 0, 0)
	else
		arg_6_0._animescape1:Play("in", 0, 0)
	end

	if arg_6_0._rule2status == Act183Enum.RuleStatus.Repress then
		arg_6_0._animrepress2:Play("in", 0, 0)
	else
		arg_6_0._animescape2:Play("in", 0, 0)
	end
end

function var_0_0.playFakeRepressAnim(arg_7_0)
	if not arg_7_0._hasRules then
		return
	end

	arg_7_0._animescape1:Play("in", 0, 0)
	arg_7_0._animescape2:Play("in", 0, 0)
	gohelper.setActive(arg_7_0._goescape1, true)
	gohelper.setActive(arg_7_0._goescape2, true)
end

return var_0_0
