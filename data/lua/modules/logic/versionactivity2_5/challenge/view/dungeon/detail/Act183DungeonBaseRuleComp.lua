module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonBaseRuleComp", package.seeall)

local var_0_0 = class("Act183DungeonBaseRuleComp", Act183DungeonBaseComp)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._gobaseruleitem = gohelper.findChild(arg_1_0.go, "#go_baseruleitem")
	arg_1_0._baseRuleItemTab = arg_1_0:getUserDataTb_()
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
	return arg_5_0._baseRules and #arg_5_0._baseRules > 0
end

function var_0_0.show(arg_6_0)
	var_0_0.super.show(arg_6_0)
	arg_6_0:createObjList(arg_6_0._baseRules, arg_6_0._baseRuleItemTab, arg_6_0._gobaseruleitem, arg_6_0._initBaseRuleItemFunc, arg_6_0._refreshBaseRuleItemFunc, arg_6_0._defaultItemFreeFunc)
end

function var_0_0._initBaseRuleItemFunc(arg_7_0, arg_7_1)
	arg_7_1.txtdesc = gohelper.findChildText(arg_7_1.go, "txt_desc")
	arg_7_1.imageicon = gohelper.findChildImage(arg_7_1.go, "image_icon")

	SkillHelper.addHyperLinkClick(arg_7_1.txtdesc)
end

function var_0_0._refreshBaseRuleItemFunc(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_1.txtdesc.text = SkillHelper.buildDesc(arg_8_2)

	Act183Helper.setRuleIcon(arg_8_0._episodeId, arg_8_3, arg_8_1.imageicon)
end

function var_0_0.onDestroy(arg_9_0)
	var_0_0.super.onDestroy(arg_9_0)
end

return var_0_0
