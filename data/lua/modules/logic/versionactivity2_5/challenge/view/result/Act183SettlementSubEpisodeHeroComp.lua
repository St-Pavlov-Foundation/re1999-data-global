module("modules.logic.versionactivity2_5.challenge.view.result.Act183SettlementSubEpisodeHeroComp", package.seeall)

local var_0_0 = class("Act183SettlementSubEpisodeHeroComp", LuaCompBase)

var_0_0.HeroIconPosition = {
	{
		{
			0,
			0,
			1
		}
	},
	{
		{
			-61,
			0,
			1
		},
		{
			61,
			0,
			1
		}
	},
	{
		{
			0,
			38,
			1
		},
		{
			-61,
			-82,
			1
		},
		{
			61,
			-82,
			1
		}
	},
	{
		{
			-61,
			38,
			1
		},
		{
			61,
			38,
			1
		},
		{
			-61,
			-82,
			1
		},
		{
			61,
			-82,
			1
		}
	},
	{
		{
			-3,
			80,
			0.74
		},
		{
			84,
			80,
			0.74
		},
		{
			-87,
			-5,
			0.74
		},
		{
			-87,
			-89,
			0.74
		},
		{
			39,
			-46,
			1.58
		}
	}
}
var_0_0.TeamLeaderPosition = {
	1,
	2,
	3,
	4,
	5
}

local var_0_1 = {
	[Act183Enum.EpisodeType.Boss] = {
		-52,
		-52
	},
	[Act183Enum.EpisodeType.Sub] = {
		-52,
		-52
	}
}

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._gosimulate = gohelper.findChild(arg_1_1, "go_simulate")

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
	arg_4_0._heroIconTab = arg_4_0:getUserDataTb_()
end

function var_0_0.setHeroTemplate(arg_5_0, arg_5_1)
	arg_5_0._goherotemplate = arg_5_1
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0:refreshHeroGroup(arg_6_1)
end

function var_0_0.refreshHeroGroup(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	local var_7_0 = arg_7_1:isSimulate()

	gohelper.setActive(arg_7_0._gosimulate, var_7_0)

	if var_7_0 then
		return
	end

	local var_7_1 = arg_7_1:getEpisodeId()

	arg_7_0._episodeType = arg_7_1:getEpisodeType()
	arg_7_0._hasTeamLeader = Act183Helper.isEpisodeHasTeamLeader(var_7_1)

	local var_7_2 = arg_7_0:_setTeamLeaderPosition(arg_7_1)
	local var_7_3 = var_7_2 and #var_7_2 or 0
	local var_7_4 = arg_7_0.HeroIconPosition[var_7_3]

	for iter_7_0, iter_7_1 in ipairs(var_7_2) do
		local var_7_5 = gohelper.clone(arg_7_0._goherotemplate, arg_7_0.go, "hero_" .. iter_7_0)
		local var_7_6 = var_7_4 and var_7_4[iter_7_0]

		arg_7_0:refreshSingleHeroItem(var_7_5, iter_7_1, iter_7_0, var_7_6)
	end
end

function var_0_0._setTeamLeaderPosition(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getHeroMos()
	local var_8_1 = {}
	local var_8_2 = {}
	local var_8_3 = var_8_0 and #var_8_0 or 0

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		if arg_8_0._hasTeamLeader and iter_8_1:isTeamLeader() then
			table.insert(var_8_2, iter_8_1)
		else
			table.insert(var_8_1, iter_8_1)
		end
	end

	local var_8_4 = arg_8_0.TeamLeaderPosition[var_8_3]

	if not var_8_4 then
		var_8_4 = var_8_3

		logWarn(string.format("未配置队长显示位置(TeamLeaderPosition)!!!默认放队尾  episodeId = %s, heroCount = %s", arg_8_1:getEpisodeId(), var_8_3))
	end

	for iter_8_2, iter_8_3 in ipairs(var_8_2) do
		table.insert(var_8_1, var_8_4, iter_8_3)
	end

	return var_8_1
end

function var_0_0.refreshSingleHeroItem(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	gohelper.setActive(arg_9_1, true)

	local var_9_0 = gohelper.findChildSingleImage(arg_9_1, "simage_heroicon")
	local var_9_1 = arg_9_2:getHeroIconUrl()

	var_9_0:LoadImage(var_9_1)

	arg_9_0._heroIconTab[var_9_0] = true

	arg_9_0:refreshHeroPosition(arg_9_1, arg_9_4)

	local var_9_2 = gohelper.findChild(arg_9_1, "#go_LeaderFrame")
	local var_9_3 = arg_9_0._hasTeamLeader and arg_9_2:isTeamLeader()

	gohelper.setActive(var_9_2, var_9_3)

	if var_9_3 then
		arg_9_0:onRefreshTeamLeaderHero(arg_9_1)
	end
end

function var_0_0.refreshHeroPosition(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_2 and arg_10_2[1]
	local var_10_1 = arg_10_2 and arg_10_2[2]
	local var_10_2 = arg_10_2 and arg_10_2[3]

	transformhelper.setLocalScale(arg_10_1.transform, var_10_2 or 1, var_10_2 or 1, var_10_2 or 1)
	recthelper.setAnchor(arg_10_1.transform, var_10_0 or 0, var_10_1 or 0)
end

function var_0_0.onRefreshTeamLeaderHero(arg_11_0, arg_11_1)
	local var_11_0 = gohelper.findChild(arg_11_1, "#go_LeaderFrame/image_LeaderIcon")
	local var_11_1 = var_0_1[arg_11_0._episodeType]
	local var_11_2 = var_11_1 and var_11_1[1]
	local var_11_3 = var_11_1 and var_11_1[2]

	recthelper.setAnchor(var_11_0.transform, var_11_2 or 0, var_11_3 or 0)
end

function var_0_0.releaseAllSingleImage(arg_12_0)
	if arg_12_0._heroIconTab then
		for iter_12_0, iter_12_1 in pairs(arg_12_0._heroIconTab) do
			iter_12_0:UnLoadImage()
		end
	end
end

function var_0_0.onDestroy(arg_13_0)
	arg_13_0:releaseAllSingleImage()
end

return var_0_0
