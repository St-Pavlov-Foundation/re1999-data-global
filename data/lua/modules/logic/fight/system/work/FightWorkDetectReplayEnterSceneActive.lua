module("modules.logic.fight.system.work.FightWorkDetectReplayEnterSceneActive", package.seeall)

local var_0_0 = class("FightWorkDetectReplayEnterSceneActive", BaseWork)

function var_0_0.onStart(arg_1_0)
	if FightReplayModel.instance:isReplay() then
		local var_1_0 = FightModel.instance:getBattleId()
		local var_1_1 = lua_fight_replay_enter_scene_root_active.configDict[var_1_0]

		if var_1_1 then
			local var_1_2 = var_1_1[FightModel.instance:getCurWaveId()]

			if var_1_2 then
				local var_1_3 = GameSceneMgr.instance:getCurScene()

				if var_1_3 then
					local var_1_4 = var_1_3.level:getSceneGo()

					if var_1_4 then
						local var_1_5 = var_1_4.transform.childCount

						for iter_1_0 = 0, var_1_5 - 1 do
							local var_1_6 = var_1_4.transform:GetChild(iter_1_0)

							gohelper.setActive(var_1_6.gameObject, var_1_6.name == var_1_2.activeRootName)
						end
					end

					if not string.nilorempty(var_1_2.switch) then
						var_1_3.bgm._cur_switch = var_1_2.switch

						var_1_3.bgm:_switchMonsterGroup()
					end
				end
			end
		end
	end

	arg_1_0:onDone(true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
