module("modules.logic.versionactivity2_5.challenge.view.Act183DailyEpisodeItem", package.seeall)

local var_0_0 = class("Act183DailyEpisodeItem", Act183BaseEpisodeItem)
local var_0_1 = {
	{
		-1.9,
		0,
		0,
		0,
		6.53
	},
	{
		0,
		0,
		0,
		0,
		0
	},
	{
		0,
		0,
		0,
		0,
		0
	}
}
local var_0_2 = {
	{
		-8.76,
		-77.2,
		0,
		0,
		0
	},
	{
		112.7,
		-119.5,
		0,
		0,
		0
	},
	{
		124.6,
		-126.3,
		0,
		0,
		0
	}
}
local var_0_3 = {
	{
		-163.3,
		79.5,
		0,
		0,
		10.13
	},
	{
		-173.3,
		100.8,
		0,
		0,
		5.01
	},
	{
		-166.4,
		92.9,
		0,
		0,
		1.42
	}
}
local var_0_4 = {
	{
		122.1,
		110,
		0,
		0,
		0
	},
	{
		169.7,
		98.1,
		0,
		0,
		0
	},
	{
		153.1,
		110,
		0,
		0,
		0
	}
}

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._goinfo = gohelper.findChild(arg_1_0.go, "Info")
	arg_1_0._imagerule1 = gohelper.findChildImage(arg_1_0.go, "Info/rules/image_rule1")
	arg_1_0._gorepress1 = gohelper.findChild(arg_1_0.go, "Info/rules/image_rule1/go_repress1")
	arg_1_0._imagerule2 = gohelper.findChildImage(arg_1_0.go, "Info/rules/image_rule2")
	arg_1_0._gorepress2 = gohelper.findChild(arg_1_0.go, "Info/rules/image_rule2/go_repress2")
	arg_1_0._imageindex = gohelper.findChildImage(arg_1_0.go, "go_finish/image_index")
	arg_1_0._goescape1 = gohelper.findChild(arg_1_0.go, "Info/rules/image_rule1/go_repressbutterfly1")
	arg_1_0._goescape2 = gohelper.findChild(arg_1_0.go, "Info/rules/image_rule2/go_repressbutterfly2")
	arg_1_0._animrepress1 = gohelper.onceAddComponent(arg_1_0._gorepress1, gohelper.Type_Animator)
	arg_1_0._animrepress2 = gohelper.onceAddComponent(arg_1_0._gorepress2, gohelper.Type_Animator)
	arg_1_0._animescape1 = gohelper.onceAddComponent(arg_1_0._goescape1, gohelper.Type_Animator)
	arg_1_0._animescape2 = gohelper.onceAddComponent(arg_1_0._goescape2, gohelper.Type_Animator)
end

function var_0_0.addEventListeners(arg_2_0)
	var_0_0.super.addEventListeners(arg_2_0)
	arg_2_0:addEventCb(Act183Controller.instance, Act183Event.OnUpdateRepressInfo, arg_2_0._onUpdateRepressInfo, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	var_0_0.super.removeEventListeners(arg_3_0)
end

function var_0_0._onUpdateRepressInfo(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0._episodeId ~= arg_4_1 then
		return
	end

	arg_4_0:refreshRules()
end

function var_0_0.onUpdateMo(arg_5_0, arg_5_1)
	var_0_0.super.onUpdateMo(arg_5_0, arg_5_1)

	if arg_5_0._status == Act183Enum.EpisodeStatus.Finished then
		local var_5_0 = "v2a5_challenge_dungeon_level_" .. arg_5_1:getPassOrder()

		UISpriteSetMgr.instance:setChallengeSprite(arg_5_0._imageindex, var_5_0)
	end

	arg_5_0:refreshRules()
	arg_5_0:setIconPositionAndRotation()
	arg_5_0:setInfoPositionAndRotation()
	arg_5_0:setIndexPositionAndRotation()
end

function var_0_0.refreshRules(arg_6_0)
	Act183Helper.setRuleIcon(arg_6_0._episodeId, 1, arg_6_0._imagerule1)
	Act183Helper.setRuleIcon(arg_6_0._episodeId, 2, arg_6_0._imagerule2)

	arg_6_0._rule1status = arg_6_0._episodeMo:getRuleStatus(1)
	arg_6_0._rule2status = arg_6_0._episodeMo:getRuleStatus(2)

	gohelper.setActive(arg_6_0._gorepress1, arg_6_0._rule1status == Act183Enum.RuleStatus.Repress)
	gohelper.setActive(arg_6_0._gorepress2, arg_6_0._rule2status == Act183Enum.RuleStatus.Repress)
	gohelper.setActive(arg_6_0._goescape1, arg_6_0._rule1status == Act183Enum.RuleStatus.Escape)
	gohelper.setActive(arg_6_0._goescape2, arg_6_0._rule2status == Act183Enum.RuleStatus.Escape)
end

function var_0_0.playFinishAnim(arg_7_0)
	var_0_0.super.playFinishAnim(arg_7_0)
	arg_7_0:playRepressAnim()
end

function var_0_0.playRepressAnim(arg_8_0)
	if arg_8_0._rule1status == Act183Enum.RuleStatus.Repress then
		arg_8_0._animrepress1:Play("in", 0, 0)
	else
		arg_8_0._animescape1:Play("in", 0, 0)
	end

	if arg_8_0._rule2status == Act183Enum.RuleStatus.Repress then
		arg_8_0._animrepress2:Play("in", 0, 0)
	else
		arg_8_0._animescape2:Play("in", 0, 0)
	end
end

function var_0_0.setIconPositionAndRotation(arg_9_0)
	local var_9_0 = arg_9_0:getConfigOrder()

	Act183Helper.setTranPositionAndRotation(arg_9_0._episodeId, var_9_0, var_0_1, arg_9_0._simageicon.transform)
end

function var_0_0.setInfoPositionAndRotation(arg_10_0)
	local var_10_0 = arg_10_0:getConfigOrder()

	Act183Helper.setTranPositionAndRotation(arg_10_0._episodeId, var_10_0, var_0_2, arg_10_0._goinfo.transform)
end

function var_0_0.setIndexPositionAndRotation(arg_11_0)
	local var_11_0 = arg_11_0:getConfigOrder()

	Act183Helper.setTranPositionAndRotation(arg_11_0._episodeId, var_11_0, var_0_3, arg_11_0._imageindex.transform)
end

function var_0_0._getCheckIconPosAndRotConfig(arg_12_0, arg_12_1)
	return var_0_4 and var_0_4[arg_12_1]
end

return var_0_0
