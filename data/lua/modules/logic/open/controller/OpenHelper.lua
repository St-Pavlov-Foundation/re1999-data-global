module("modules.logic.open.controller.OpenHelper", package.seeall)

local var_0_0 = class("OpenHelper")

function var_0_0.getToastIdAndParam(arg_1_0)
	local var_1_0 = OpenConfig.instance:getOpenCo(arg_1_0)
	local var_1_1 = var_1_0.dec

	return (var_0_0.ToastId2FuncDict[var_1_1] or var_0_0.defaultGetToast)(var_1_0)
end

function var_0_0.defaultGetToast(arg_2_0)
	return arg_2_0 and arg_2_0.dec
end

function var_0_0.getDungeonToast(arg_3_0)
	local var_3_0 = arg_3_0.dec
	local var_3_1 = VersionValidator.instance:isInReviewing() and arg_3_0.verifingEpisodeId or arg_3_0.episodeId

	if not var_3_1 or var_3_1 == 0 then
		return var_3_0
	end

	local var_3_2 = DungeonConfig.instance:getEpisodeDisplay(var_3_1)

	return var_3_0, {
		var_3_2
	}
end

function var_0_0.getActivityDungeonToast(arg_4_0)
	local var_4_0 = arg_4_0.dec
	local var_4_1 = DungeonConfig.instance:getEpisodeCO(arg_4_0.episodeId)
	local var_4_2 = DungeonConfig.instance:getChapterCO(var_4_1 and var_4_1.chapterId)
	local var_4_3 = ActivityConfig.instance:getActivityCo(var_4_2 and var_4_2.actId)
	local var_4_4 = DungeonConfig.instance:getEpisodeDisplay(arg_4_0.episodeId)

	return var_4_0, {
		var_4_3 and var_4_3.name,
		var_4_4
	}
end

function var_0_0.getActivityDungeon1Toast(arg_5_0)
	local var_5_0 = arg_5_0.dec
	local var_5_1 = DungeonConfig.instance:getEpisodeDisplay(arg_5_0.episodeId)

	return var_5_0, {
		luaLang("v1a2_enterview_activitytip"),
		var_5_1
	}
end

function var_0_0.getActivityUnlockTxt(arg_6_0)
	local var_6_0 = OpenConfig.instance:getOpenCo(arg_6_0)
	local var_6_1 = DungeonConfig.instance:getEpisodeDisplay(var_6_0.episodeId)

	return string.format(luaLang("versionactivity1_3_hardlocktip"), var_6_1)
end

var_0_0.ToastId2FuncDict = {
	[ToastEnum.DungeonMapLevel] = var_0_0.getDungeonToast,
	[ToastEnum.ActivityDungeon] = var_0_0.getActivityDungeonToast,
	[ToastEnum.ActivityDungeon1] = var_0_0.getActivityDungeon1Toast
}

return var_0_0
