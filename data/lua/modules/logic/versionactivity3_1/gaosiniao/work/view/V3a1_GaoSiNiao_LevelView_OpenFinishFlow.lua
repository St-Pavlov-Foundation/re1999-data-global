module("modules.logic.versionactivity3_1.gaosiniao.work.view.V3a1_GaoSiNiao_LevelView_OpenFinishFlow", package.seeall)

local var_0_0 = class("V3a1_GaoSiNiao_LevelView_OpenFinishFlow", GaoSiNiaoViewFlowBase)

function var_0_0.onStart(arg_1_0)
	arg_1_0:addWork(V3a1_GaoSiNiao_LevelViewWork_UnlockPathAnim.New())
	arg_1_0:addWork(V3a1_GaoSiNiao_LevelViewWork_DisactivePathAnim.New())
	arg_1_0:addWork(V3a1_GaoSiNiao_LevelViewWork_UnlockEndlessAnim.New())
end

return var_0_0
