module("modules.logic.fight.system.work.FightWorkCheckLuXiHeroUpgrade", package.seeall)

local var_0_0 = class("FightWorkCheckLuXiHeroUpgrade", FightWorkItem)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightPlayerOperateMgr.detectUpgrade()

	if #var_1_0 > 0 then
		for iter_1_0 = #var_1_0, 1, -1 do
			local var_1_1 = var_1_0[iter_1_0]

			if lua_hero_upgrade.configDict[var_1_1.id].type == 1 then
				FightRpc.instance:sendUseClothSkillRequest(var_1_1.id, var_1_1.entityId, var_1_1.optionIds[1], FightEnum.ClothSkillType.HeroUpgrade)
				arg_1_0:cancelFightWorkSafeTimer()

				return
			end
		end

		if #var_1_0 > 0 then
			arg_1_0._upgradeDataList = var_1_0

			ViewMgr.instance:openView(ViewName.FightSkillStrengthenView, var_1_0)
			arg_1_0:cancelFightWorkSafeTimer()

			return
		end
	end

	arg_1_0:onDone(true)
end

return var_0_0
