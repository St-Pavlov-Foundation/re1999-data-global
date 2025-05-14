module("modules.logic.bossrush.view.V1a4_BossRush_EnemyInfoView", package.seeall)

local var_0_0 = class("V1a4_BossRush_EnemyInfoView", EnemyInfoView)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)
end

function var_0_0._refreshUI(arg_2_0)
	if not arg_2_0._battleId then
		logError("地方信息界面缺少战斗Id")

		return
	end

	var_0_0.super._refreshUI(arg_2_0)
end

function var_0_0._getBossId(arg_3_0, arg_3_1)
	local var_3_0 = FightController.instance:setFightParamByBattleId(arg_3_0._battleId)
	local var_3_1 = var_3_0 and var_3_0.monsterGroupIds and var_3_0.monsterGroupIds[arg_3_1]
	local var_3_2 = var_3_1 and lua_monster_group.configDict[var_3_1]

	return var_3_2 and not string.nilorempty(var_3_2.bossId) and var_3_2.bossId or nil
end

function var_0_0.onUpdateParam(arg_4_0)
	local var_4_0 = arg_4_0.viewParam.bossRushStage
	local var_4_1 = arg_4_0.viewParam.bossRushLayer

	arg_4_0._battleId = BossRushConfig.instance:getDungeonBattleId(var_4_0, var_4_1)

	arg_4_0:_refreshUI()
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickEnemyItem, arg_5_0._refreshInfo, arg_5_0)
	arg_5_0:onUpdateParam()
end

function var_0_0.onClose(arg_6_0)
	arg_6_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickEnemyItem, arg_6_0._refreshInfo, arg_6_0)
end

function var_0_0._doUpdateSelectIcon(arg_7_0, arg_7_1)
	arg_7_0.viewContainer:getBossRushViewRule():refreshUI(arg_7_1)
end

return var_0_0
