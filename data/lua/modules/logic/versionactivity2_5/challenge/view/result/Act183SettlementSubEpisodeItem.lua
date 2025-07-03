module("modules.logic.versionactivity2_5.challenge.view.result.Act183SettlementSubEpisodeItem", package.seeall)

local var_0_0 = class("Act183SettlementSubEpisodeItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._imageindex = gohelper.findChildImage(arg_1_1, "image_index")
	arg_1_0._imagestar = gohelper.findChildImage(arg_1_1, "image_star")
	arg_1_0._gobadgebg = gohelper.findChild(arg_1_1, "mask")
	arg_1_0._txtbadgenum = gohelper.findChildText(arg_1_1, "txt_badgenum")
	arg_1_0._imageruleicon1 = gohelper.findChildImage(arg_1_1, "rules/go_rule1/image_icon")
	arg_1_0._gorepress1 = gohelper.findChild(arg_1_1, "rules/go_rule1/go_repress")
	arg_1_0._goescape1 = gohelper.findChild(arg_1_1, "rules/go_rule1/go_escape")
	arg_1_0._imageruleicon2 = gohelper.findChildImage(arg_1_1, "rules/go_rule2/image_icon")
	arg_1_0._gorepress2 = gohelper.findChild(arg_1_1, "rules/go_rule2/go_repress")
	arg_1_0._goescape2 = gohelper.findChild(arg_1_1, "rules/go_rule2/go_escape")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_1, "image_episode")
	arg_1_0._goherocontainer = gohelper.findChild(arg_1_1, "heros")
	arg_1_0._gorules1 = gohelper.findChild(arg_1_1, "rules")
	arg_1_0._gorules2 = gohelper.findChild(arg_1_1, "rules2")
	arg_1_0._gorepress1_v2 = gohelper.findChild(arg_1_1, "rules2/go_rule1/go_repress")
	arg_1_0._goescape1_v2 = gohelper.findChild(arg_1_1, "rules2/go_rule1/go_escape")
	arg_1_0._imageruleicon2_v2 = gohelper.findChildImage(arg_1_1, "rules2/go_rule2/image_icon")
	arg_1_0._gorepress2_v2 = gohelper.findChild(arg_1_1, "rules2/go_rule2/go_repress")
	arg_1_0._goepisodestaritem = gohelper.findChild(arg_1_1, "episodestars/go_episodestaritem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._herogroupComp = MonoHelper.addLuaComOnceToGo(arg_4_0._goherocontainer, Act183SettlementSubEpisodeHeroComp)
end

function var_0_0.setHeroTemplate(arg_5_0, arg_5_1)
	if arg_5_0._herogroupComp then
		arg_5_0._herogroupComp:setHeroTemplate(arg_5_1)
	end
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_2:isAllConditionPass()
	local var_6_1 = arg_6_2:getUseBadgeNum()

	UISpriteSetMgr.instance:setChallengeSprite(arg_6_0._imageindex, "v2a5_challenge_result_level_" .. arg_6_2:getPassOrder())

	arg_6_0._txtbadgenum.text = var_6_1

	gohelper.setActive(arg_6_0._txtbadgenum.gameObject, var_6_1 > 0)
	gohelper.setActive(arg_6_0._gobadgebg, var_6_1 > 0)

	local var_6_2 = arg_6_2:getEpisodeId()

	Act183Helper.setRuleIcon(var_6_2, 1, arg_6_0._imageruleicon1)
	Act183Helper.setRuleIcon(var_6_2, 2, arg_6_0._imageruleicon2)
	Act183Helper.setSubEpisodeResultIcon(var_6_2, arg_6_0._imageicon)
	arg_6_0:refreshRepressIcon(arg_6_2)
	arg_6_0:refreshHeroGroup(arg_6_2)
	arg_6_0:refreshEpisodeStars(arg_6_2)
	Act183Helper.setEpisodeConditionStar(arg_6_0._imagestar, var_6_0, nil)
	gohelper.setActive(arg_6_0.go, true)
end

function var_0_0.refreshRepressIcon(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:getRuleStatus(1)
	local var_7_1 = arg_7_1:getRuleStatus(2)
	local var_7_2 = arg_7_1:getHeroMos()
	local var_7_3 = (var_7_2 and #var_7_2 or 0) == 5

	if var_7_3 then
		gohelper.setActive(arg_7_0._gorepress1_v2, var_7_0 == Act183Enum.RuleStatus.Repress)
		gohelper.setActive(arg_7_0._gorepress2_v2, var_7_1 == Act183Enum.RuleStatus.Repress)
		gohelper.setActive(arg_7_0._goescape1_v2, var_7_0 == Act183Enum.RuleStatus.Escape)
		gohelper.setActive(arg_7_0._goescape2_v2, var_7_1 == Act183Enum.RuleStatus.Escape)
	else
		gohelper.setActive(arg_7_0._gorepress1, var_7_0 == Act183Enum.RuleStatus.Repress)
		gohelper.setActive(arg_7_0._gorepress2, var_7_1 == Act183Enum.RuleStatus.Repress)
		gohelper.setActive(arg_7_0._goescape1, var_7_0 == Act183Enum.RuleStatus.Escape)
		gohelper.setActive(arg_7_0._goescape2, var_7_1 == Act183Enum.RuleStatus.Escape)
	end

	gohelper.setActive(arg_7_0._gorules1, not var_7_3)
	gohelper.setActive(arg_7_0._gorules2, var_7_3)
end

function var_0_0.refreshEpisodeStars(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getTotalStarCount()
	local var_8_1 = arg_8_1:getFinishStarCount()

	for iter_8_0 = 1, var_8_0 do
		local var_8_2 = gohelper.cloneInPlace(arg_8_0._goepisodestaritem, "star_" .. iter_8_0)
		local var_8_3 = gohelper.onceAddComponent(var_8_2, gohelper.Type_Image)
		local var_8_4 = iter_8_0 <= var_8_1 and "#F77040" or "#87898C"

		UISpriteSetMgr.instance:setCommonSprite(var_8_3, "zhuxianditu_pt_xingxing_001", true)
		SLFramework.UGUI.GuiHelper.SetColor(var_8_3, var_8_4)
		gohelper.setActive(var_8_2, true)
	end
end

function var_0_0.refreshHeroGroup(arg_9_0, arg_9_1)
	if arg_9_0._herogroupComp then
		arg_9_0._herogroupComp:onUpdateMO(arg_9_1)
	end
end

function var_0_0.onDestroy(arg_10_0)
	return
end

return var_0_0
