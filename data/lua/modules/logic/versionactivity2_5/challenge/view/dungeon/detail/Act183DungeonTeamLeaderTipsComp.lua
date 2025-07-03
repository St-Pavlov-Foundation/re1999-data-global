module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonTeamLeaderTipsComp", package.seeall)

local var_0_0 = class("Act183DungeonTeamLeaderTipsComp", Act183DungeonBaseComp)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._txtleadertips = gohelper.findChildText(arg_1_0.go, "txt_LeaderTips")

	SkillHelper.addHyperLinkClick(arg_1_0._txtleadertips.gameObject)
end

function var_0_0.addEventListeners(arg_2_0)
	return
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0.checkIsVisible(arg_4_0)
	return Act183Helper.isEpisodeHasTeamLeader(arg_4_0._episodeId)
end

function var_0_0.show(arg_5_0)
	var_0_0.super.show(arg_5_0)
	arg_5_0:refreshLeaderTips()
end

function var_0_0.refreshLeaderTips(arg_6_0)
	local var_6_0 = Act183Config.instance:getLeaderSkillDesc(arg_6_0._episodeId)

	arg_6_0._txtleadertips.text = SkillHelper.buildDesc(var_6_0)
end

function var_0_0.onDestroy(arg_7_0)
	var_0_0.super.onDestroy(arg_7_0)
end

return var_0_0
