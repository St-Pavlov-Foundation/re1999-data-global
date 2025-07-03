module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonRepressResultComp", package.seeall)

local var_0_0 = class("Act183DungeonRepressResultComp", Act183DungeonBaseComp)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._gohasrepress = gohelper.findChild(arg_1_0.go, "#go_hasrepress")
	arg_1_0._gounrepress = gohelper.findChild(arg_1_0.go, "#go_unrepress")
	arg_1_0._gorepressruleitem = gohelper.findChild(arg_1_0.go, "#go_repressrules/#go_repressruleitem")
	arg_1_0._gorepressheropos = gohelper.findChild(arg_1_0.go, "#go_hasrepress/#go_repressheropos")
	arg_1_0._repressRuleItemTab = arg_1_0:getUserDataTb_()
end

function var_0_0.addEventListeners(arg_2_0)
	return
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0.updateInfo(arg_4_0, arg_4_1)
	var_0_0.super.updateInfo(arg_4_0, arg_4_1)

	arg_4_0._baseRules = Act183Config.instance:getEpisodeAllRuleDesc(arg_4_0._episodeId)
end

function var_0_0.checkIsVisible(arg_5_0)
	local var_5_0 = arg_5_0._status == Act183Enum.EpisodeStatus.Finished
	local var_5_1 = arg_5_0._episodeType == Act183Enum.EpisodeType.Sub
	local var_5_2 = Act183Helper.isLastPassEpisodeInType(arg_5_0._episodeMo)

	return var_5_0 and var_5_1 and not var_5_2
end

function var_0_0.show(arg_6_0)
	var_0_0.super.show(arg_6_0)
	gohelper.setActive(arg_6_0._gohasrepress, false)
	gohelper.setActive(arg_6_0._gounrepress, true)
	arg_6_0:createObjList(arg_6_0._baseRules, arg_6_0._repressRuleItemTab, arg_6_0._gorepressruleitem, arg_6_0._initRepressRuleItemFunc, arg_6_0._refreshRepressResultFunc, arg_6_0._defaultItemFreeFunc)
end

function var_0_0._initRepressRuleItemFunc(arg_7_0, arg_7_1)
	arg_7_1.txtdesc = gohelper.findChildText(arg_7_1.go, "txt_desc")
	arg_7_1.imageicon = gohelper.findChildImage(arg_7_1.go, "image_icon")
	arg_7_1.godisable = gohelper.findChild(arg_7_1.go, "image_icon/go_disable")
	arg_7_1.goescape = gohelper.findChild(arg_7_1.go, "image_icon/go_escape")
	arg_7_1.gorepressbg = gohelper.findChild(arg_7_1.go, "#go_Disable")

	SkillHelper.addHyperLinkClick(arg_7_1.txtdesc)
end

function var_0_0._refreshRepressResultFunc(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_0._episodeMo:getRuleStatus(arg_8_3) == Act183Enum.RuleStatus.Repress

	arg_8_1.txtdesc.text = SkillHelper.buildDesc(arg_8_2)

	gohelper.setActive(arg_8_1.godisable, var_8_0)
	gohelper.setActive(arg_8_1.gorepressbg, var_8_0)
	gohelper.setActive(arg_8_1.goescape, not var_8_0)
	Act183Helper.setRuleIcon(arg_8_0._episodeId, arg_8_3, arg_8_1.imageicon)

	if var_8_0 then
		local var_8_1 = arg_8_0._episodeMo:getRepressHeroMo():getHeroId()

		if not arg_8_0._repressHeroItem then
			arg_8_0._repressHeroItem = IconMgr.instance:getCommonHeroIconNew(arg_8_0._gorepressheropos)

			arg_8_0._repressHeroItem:isShowLevel(false)
		end

		arg_8_0._repressHeroItem:onUpdateHeroId(var_8_1)
		gohelper.setActive(arg_8_0._gohasrepress, true)
		gohelper.setActive(arg_8_0._gounrepress, false)
	end
end

function var_0_0.onDestroy(arg_9_0)
	var_0_0.super.onDestroy(arg_9_0)
end

return var_0_0
