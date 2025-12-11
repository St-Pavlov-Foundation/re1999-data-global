module("modules.logic.versionactivity3_1.gaosiniao.view.Activity210CorvusViewBaseContainer", package.seeall)

local var_0_0 = class("Activity210CorvusViewBaseContainer", Activity210ViewBaseContainer)

function var_0_0.actId(arg_1_0)
	return arg_1_0.viewParam and arg_1_0.viewParam.actId or GaoSiNiaoController.instance:actId()
end

function var_0_0.taskType(arg_2_0)
	return arg_2_0.viewParam and arg_2_0.viewParam.taskType or GaoSiNiaoController.instance:taskType()
end

function var_0_0.getPrefsKeyPrefix_episodeId(arg_3_0, arg_3_1)
	return arg_3_0:getPrefsKeyPrefix() .. tostring(arg_3_1)
end

function var_0_0.getEpisodeCOList(arg_4_0)
	return GaoSiNiaoConfig.instance:getEpisodeCOList()
end

function var_0_0.isEpisodeOpen(arg_5_0, ...)
	return GaoSiNiaoSysModel.instance:isEpisodeOpen(...)
end

function var_0_0.hasPassLevelAndStory(arg_6_0, ...)
	return GaoSiNiaoSysModel.instance:hasPassLevelAndStory(...)
end

function var_0_0.currentPassedEpisodeId(arg_7_0)
	return GaoSiNiaoSysModel.instance:currentPassedEpisodeId()
end

function var_0_0.currentEpisodeIdToPlay(arg_8_0)
	return GaoSiNiaoSysModel.instance:currentEpisodeIdToPlay()
end

function var_0_0.enterGame(arg_9_0, ...)
	GaoSiNiaoController.instance:enterGame(...)
end

function var_0_0.getPreEpisodeId(arg_10_0, ...)
	return GaoSiNiaoConfig.instance:getPreEpisodeId(...)
end

function var_0_0.isSpEpisodeOpen(arg_11_0, ...)
	return GaoSiNiaoSysModel.instance:isSpEpisodeOpen(...)
end

return var_0_0
