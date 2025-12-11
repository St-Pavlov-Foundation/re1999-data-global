module("modules.logic.versionactivity3_1.gaosiniao.work.view.V3a1_GaoSiNiao_LevelViewFlow_WorkBase", package.seeall)

local var_0_0 = class("V3a1_GaoSiNiao_LevelViewFlow_WorkBase", GaoSiNiaoWorkBase)

function var_0_0.viewObj(arg_1_0)
	return arg_1_0.root:viewObj()
end

function var_0_0.baseViewContainer(arg_2_0)
	return arg_2_0.root:baseViewContainer()
end

function var_0_0.currentPassedEpisodeId(arg_3_0)
	return arg_3_0:baseViewContainer():currentPassedEpisodeId()
end

function var_0_0.currentEpisodeIdToPlay(arg_4_0)
	return arg_4_0:baseViewContainer():currentEpisodeIdToPlay()
end

function var_0_0.getEpisodeCO_disactiveEpisodeInfoDict(arg_5_0, ...)
	return arg_5_0:baseViewContainer():getEpisodeCO_disactiveEpisodeInfoDict(...)
end

function var_0_0.isSpEpisodeOpen(arg_6_0, ...)
	return arg_6_0:baseViewContainer():isSpEpisodeOpen(...)
end

function var_0_0.getPreEpisodeId(arg_7_0, ...)
	return arg_7_0:baseViewContainer():getPreEpisodeId(...)
end

function var_0_0.saveHasPlayedUnlockedAnimPath(arg_8_0, ...)
	return arg_8_0:baseViewContainer():saveHasPlayedUnlockedAnimPath(...)
end

function var_0_0.hasPlayedUnlockedAnimPath(arg_9_0, ...)
	return arg_9_0:baseViewContainer():hasPlayedUnlockedAnimPath(...)
end

function var_0_0.saveHasPlayedDisactiveAnimPath(arg_10_0, ...)
	return arg_10_0:baseViewContainer():saveHasPlayedDisactiveAnimPath(...)
end

function var_0_0.hasPlayedDisactiveAnimPath(arg_11_0, ...)
	return arg_11_0:baseViewContainer():hasPlayedDisactiveAnimPath(...)
end

function var_0_0.saveHasPlayedUnlockedEndless(arg_12_0, ...)
	return arg_12_0:baseViewContainer():saveHasPlayedUnlockedEndless(...)
end

function var_0_0.hasPlayedUnlockedEndless(arg_13_0, ...)
	return arg_13_0:baseViewContainer():hasPlayedUnlockedEndless(...)
end

return var_0_0
