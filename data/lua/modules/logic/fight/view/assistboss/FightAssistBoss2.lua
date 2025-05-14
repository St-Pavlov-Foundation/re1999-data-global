module("modules.logic.fight.view.assistboss.FightAssistBoss2", package.seeall)

local var_0_0 = class("FightAssistBoss2", FightAssistBossBase)

function var_0_0.setPrefabPath(arg_1_0)
	arg_1_0.prefabPath = "ui/viewres/assistboss/boss2.prefab"
end

var_0_0.MaxPower = 6

function var_0_0.initView(arg_2_0)
	var_0_0.super.initView(arg_2_0)

	arg_2_0.goPowerList = arg_2_0:getUserDataTb_()

	for iter_2_0 = 1, var_0_0.MaxPower do
		table.insert(arg_2_0.goPowerList, gohelper.findChild(arg_2_0.viewGo, string.format("go_energy/%s/light", iter_2_0)))
	end
end

function var_0_0.refreshPower(arg_3_0)
	var_0_0.super.refreshPower(arg_3_0)

	local var_3_0 = FightDataHelper.paTaMgr:getAssistBossPower()

	for iter_3_0 = 1, var_0_0.MaxPower do
		gohelper.setActive(arg_3_0.goPowerList[iter_3_0], iter_3_0 <= var_3_0)
	end
end

function var_0_0.onPowerChange(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	var_0_0.super.onPowerChange(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)

	if arg_4_3 < arg_4_4 then
		FightAudioMgr.instance:playAudio(20232001)
	end
end

return var_0_0
