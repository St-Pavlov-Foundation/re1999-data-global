module("modules.logic.versionactivity3_1.gaosiniao.work.entry.GaoSiNiaoExitFlow", package.seeall)

local var_0_0 = class("GaoSiNiaoExitFlow", GaoSiNiaoEntryFlowBase)

function var_0_0.onStart(arg_1_0)
	arg_1_0:addWork(GaoSiNiaoWork_PlayStory.s_create(arg_1_0:postStoryId()))
	arg_1_0:addWork(GaoSiNiaoWork_OpenView.s_create(ViewName.V3a1_GaoSiNiao_LevelView))
	arg_1_0:addWork(GaoSiNiaoWork_CloseView.s_create(ViewName.V3a1_GaoSiNiao_GameView))
	arg_1_0:addWork(GaoSiNiaoWork_WaitCloseView.s_create(ViewName.StoryBackgroundView))
	arg_1_0:addWork(GaoSiNiaoWork_WaitViewOnTheTop.s_create(ViewName.V3a1_GaoSiNiao_LevelView))
	arg_1_0:addWork(GaoSiNiaoWork_ExitedRetop_V3a1_GaoSiNiao_LevelView.New())
end

return var_0_0
