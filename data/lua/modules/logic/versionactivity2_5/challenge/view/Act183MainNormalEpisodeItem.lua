module("modules.logic.versionactivity2_5.challenge.view.Act183MainNormalEpisodeItem", package.seeall)

local var_0_0 = class("Act183MainNormalEpisodeItem", Act183BaseEpisodeItem)
local var_0_1 = {
	{
		-8.76,
		-77.2,
		0,
		0,
		0
	},
	{
		-36.5,
		-136.6,
		0,
		0,
		0
	},
	{
		45.9,
		-107.4,
		0,
		0,
		-8.29
	},
	{
		-63.7,
		-111.71,
		0,
		0,
		0
	}
}
local var_0_2 = {
	{
		-229.5,
		40.9,
		9.9,
		0,
		0
	},
	{
		-229.4,
		23.2,
		0,
		0,
		0
	},
	{
		-191.5,
		57.2,
		0,
		0,
		-9.27
	},
	{
		-245,
		5,
		0,
		0,
		0
	}
}
local var_0_3 = {
	{
		-3.6,
		42.4,
		0,
		0,
		0
	},
	{
		47.4,
		34.2,
		0,
		0,
		0
	},
	{
		31,
		13.8,
		0,
		0,
		0
	},
	{
		4.4,
		-7.3,
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
	arg_1_0._imagecondition = gohelper.findChildImage(arg_1_0.go, "Info/image_condition")
	arg_1_0._goescape1 = gohelper.findChild(arg_1_0.go, "Info/rules/image_rule1/go_repressbutterfly1")
	arg_1_0._goescape2 = gohelper.findChild(arg_1_0.go, "Info/rules/image_rule2/go_repressbutterfly2")
	arg_1_0._animrepress1 = gohelper.onceAddComponent(arg_1_0._gorepress1, gohelper.Type_Animator)
	arg_1_0._animrepress2 = gohelper.onceAddComponent(arg_1_0._gorepress2, gohelper.Type_Animator)
	arg_1_0._animescape1 = gohelper.onceAddComponent(arg_1_0._goescape1, gohelper.Type_Animator)
	arg_1_0._animescape2 = gohelper.onceAddComponent(arg_1_0._goescape2, gohelper.Type_Animator)
	arg_1_0._animcondition = gohelper.onceAddComponent(arg_1_0._imagecondition, gohelper.Type_Animator)
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
	arg_4_0:playRepressAnim()
end

function var_0_0.onUpdateMo(arg_5_0, arg_5_1)
	var_0_0.super.onUpdateMo(arg_5_0, arg_5_1)

	if arg_5_0._status == Act183Enum.EpisodeStatus.Finished then
		local var_5_0 = "v2a5_challenge_dungeon_level_" .. arg_5_1:getPassOrder()

		UISpriteSetMgr.instance:setChallengeSprite(arg_5_0._imageindex, var_5_0)
	end

	arg_5_0._isAllConditionPass = arg_5_0._episodeMo:isAllConditionPass()

	arg_5_0._animcondition:Play(arg_5_0._isAllConditionPass and "lighted" or "gray", 0, 0)
	arg_5_0:refreshRules()
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

function var_0_0.setInfoPositionAndRotation(arg_7_0)
	local var_7_0 = arg_7_0:getConfigOrder()

	Act183Helper.setTranPositionAndRotation(arg_7_0._episodeId, var_7_0, var_0_1, arg_7_0._goinfo.transform)
end

function var_0_0.setIndexPositionAndRotation(arg_8_0)
	local var_8_0 = arg_8_0:getConfigOrder()

	Act183Helper.setTranPositionAndRotation(arg_8_0._episodeId, var_8_0, var_0_2, arg_8_0._imageindex.transform)
end

function var_0_0.playFinishAnim(arg_9_0)
	var_0_0.super.playFinishAnim(arg_9_0)
	arg_9_0:playRepressAnim()
	arg_9_0:playAllConditionPassAnim()
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

function var_0_0._getCheckIconPosAndRotConfig(arg_12_0, arg_12_1)
	return var_0_3 and var_0_3[arg_12_1]
end

return var_0_0
