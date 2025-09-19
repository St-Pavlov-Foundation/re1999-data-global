module("modules.logic.versionactivity2_5.challenge.define.Act183Event", package.seeall)

local var_0_0 = _M
local var_0_1 = 1

local function var_0_2(arg_1_0)
	assert(var_0_0[arg_1_0] == nil, "[Act183Event] error redefined Act183Event." .. arg_1_0)

	var_0_0[arg_1_0] = var_0_1
	var_0_1 = var_0_1 + 1
end

var_0_2("OnClickEpisode")
var_0_2("OnUpdateGroupInfo")
var_0_2("OnUpdateRepressInfo")
var_0_2("OnUpdateBadgeNum")
var_0_2("OnClickSwitchGroup")
var_0_2("OnCreateHeroItemDone")
var_0_2("RefreshMedalReddot")
var_0_2("OnInitDungeonDone")
var_0_2("ClickToGetReward")
var_0_2("OnGroupAllTaskFinished")
var_0_2("OnUpdateSelectBadgeNum")
var_0_2("OnUpdateBadgeDetailVisible")
var_0_2("EpisodeStartPlayFinishAnim")
var_0_2("FightBossIfSubUnfinish")
var_0_2("OnPlayEffectDoneIfSubUnfinish")

return var_0_0
