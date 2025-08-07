﻿module("modules.logic.fight.view.FightNewProgressView", package.seeall)

local var_0_0 = class("FightNewProgressView", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.fightRoot = gohelper.findChild(arg_1_0.viewGO, "root")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registMsg(FightMsgId.FightMaxProgressValueChange, arg_2_0.onFightMaxProgressValueChange)
end

function var_0_0.onFightMaxProgressValueChange(arg_3_0, arg_3_1)
	if arg_3_1 == 0 then
		return
	end

	local var_3_0 = arg_3_0.progressDic[arg_3_1]

	if not var_3_0 then
		return
	end

	arg_3_0:showProgress(var_3_0)
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0.progressDic = FightDataHelper.fieldMgr.progressDic

	if not arg_4_0.progressDic then
		return
	end

	for iter_4_0, iter_4_1 in pairs(arg_4_0.progressDic) do
		arg_4_0:showProgress(iter_4_1)
	end
end

function var_0_0.showProgress(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.showId

	if var_5_0 == 5 then
		arg_5_0:showFightConquerBattleProgress()
	elseif var_5_0 == 6 then
		arg_5_0:showFightConquerBattleProgress()
	end
end

function var_0_0.showFightConquerBattleProgress(arg_6_0)
	local var_6_0 = false
	local var_6_1 = false

	for iter_6_0, iter_6_1 in pairs(arg_6_0.progressDic) do
		if iter_6_1.showId == 5 then
			var_6_0 = true
		elseif iter_6_1.showId == 6 then
			var_6_1 = true
		end
	end

	if var_6_0 and var_6_1 then
		if arg_6_0.progress56View then
			return
		end

		local var_6_2 = "ui/viewres/fight/fightassassinhpview.prefab"

		arg_6_0.progress56View = arg_6_0:com_openSubView(FightProgressConquerBattleView, var_6_2, arg_6_0.fightRoot)
	end
end

return var_0_0
