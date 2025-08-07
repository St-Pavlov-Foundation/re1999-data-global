module("modules.logic.fight.view.FightProgressConquerBattleView", package.seeall)

local var_0_0 = class("FightProgressConquerBattleView", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.player = gohelper.findChild(arg_1_0.viewGO, "Root/playerHp")
	arg_1_0.enemy = gohelper.findChild(arg_1_0.viewGO, "Root/enemyHp")
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.onOpen(arg_3_0)
	arg_3_0.progressDic = FightDataHelper.fieldMgr.progressDic

	for iter_3_0, iter_3_1 in pairs(arg_3_0.progressDic) do
		if iter_3_1.showId == 5 then
			arg_3_0:com_openSubView(FightNewProgressView5, arg_3_0.player, nil, iter_3_1)
		elseif iter_3_1.showId == 6 then
			arg_3_0:com_openSubView(FightNewProgressView6, arg_3_0.enemy, nil, iter_3_1)
		end
	end
end

return var_0_0
