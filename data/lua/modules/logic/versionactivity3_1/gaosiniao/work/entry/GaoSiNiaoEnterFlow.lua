module("modules.logic.versionactivity3_1.gaosiniao.work.entry.GaoSiNiaoEnterFlow", package.seeall)

local var_0_0 = class("GaoSiNiaoEnterFlow", GaoSiNiaoEntryFlowBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0:episodeId()

	arg_1_0:addWork(GaoSiNiaoWork_PlayStory.s_create(arg_1_0:preStoryId()))

	if arg_1_0:gameId() == 0 then
		arg_1_0:addWork(GaoSiNiaoWork_JustCompleteGame.s_create(var_1_0))
	else
		arg_1_0:addWork(GaoSiNiaoWork_EnterGameView.s_create(ViewName.V3a1_GaoSiNiao_GameView))
	end
end

return var_0_0
