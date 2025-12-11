module("modules.logic.fight.system.work.FightWorkCheckUseAiJiAoQte", package.seeall)

local var_0_0 = class("FightWorkCheckUseAiJiAoQte", FightWorkItem)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightDataHelper.entityMgr.entityDataDic
	local var_1_1 = FightEnum.BuffFeature.EzioBigSkill
	local var_1_2 = FightDataHelper.stateMgr:getIsAuto()

	for iter_1_0, iter_1_1 in pairs(var_1_0) do
		if iter_1_1.side == FightEnum.EntitySide.MySide then
			local var_1_3, var_1_4 = iter_1_1:hasBuffFeature(var_1_1)

			if var_1_3 then
				local var_1_5 = var_1_4.actCommonParams
				local var_1_6 = string.split(var_1_5, "|")

				for iter_1_2, iter_1_3 in ipairs(var_1_6) do
					local var_1_7 = string.split(iter_1_3, "#")
					local var_1_8 = tonumber(var_1_7[1])
					local var_1_9 = lua_buff_act.configDict[var_1_8]

					if var_1_9 and var_1_9.type == var_1_1 then
						local var_1_10 = string.split(var_1_7[2], ",")
						local var_1_11 = tonumber(var_1_10[1]) or 0
						local var_1_12 = tonumber(var_1_10[2])
						local var_1_13 = var_1_10[3]

						if var_1_11 and var_1_11 > 0 then
							if var_1_11 == FightDataHelper.tempMgr.aiJiAoQteCount then
								local var_1_14 = (FightDataHelper.tempMgr.aiJiAoQteEndlessLoop or 0) + 1

								FightDataHelper.tempMgr.aiJiAoQteEndlessLoop = var_1_14

								if var_1_14 > 2 then
									local var_1_15 = FightHelper.getEntity(iter_1_0)

									if var_1_15 then
										local var_1_16 = FightStepData.New(FightDef_pb.FightStep())

										var_1_16.isFakeStep = true
										var_1_16.fromId = var_1_15.id
										var_1_16.toId = var_1_15:isMySide() and FightEntityScene.EnemySideId or FightEntityScene.MySideId
										var_1_16.actType = FightEnum.ActType.SKILL

										var_1_15.skill:registTimelineWork("aijiao_312301_unique_direct_exit", var_1_16):start()
									end

									arg_1_0:onDone(true)

									return false
								end
							end

							FightDataHelper.tempMgr.aiJiAoQteCount = var_1_11

							if var_1_13 == "0" then
								FightDataHelper.tempMgr.playAiJiAoPreTimeline = true

								local var_1_17 = FightAiJiAoQteSelectView.getTargetLimit(229002, iter_1_0)

								if #var_1_17 == 0 then
									arg_1_0:onDone(true)

									return false
								end

								local var_1_18 = {
									mustSelect = true,
									skillId = 229002,
									fromId = iter_1_0,
									callback = arg_1_0.afterAiJiAoSelectToId,
									handle = arg_1_0,
									targetLimit = var_1_17
								}

								arg_1_0.aiJiAoFromId = iter_1_0

								local var_1_19 = arg_1_0:com_registFlowSequence()

								if var_1_2 then
									local var_1_20 = FightHelper.getEntity(iter_1_0)
									local var_1_21 = FightDataHelper.operationDataMgr.curSelectEntityId

									var_1_21 = (not var_1_21 or var_1_21 ~= 0) and var_1_21

									if not var_1_21 then
										local var_1_22 = FightHelper.getCurBossId()

										for iter_1_4, iter_1_5 in ipairs(var_1_17) do
											local var_1_23 = FightDataHelper.entityMgr:getById(iter_1_5)

											if var_1_23 and FightHelper.isBossId(var_1_22, var_1_23.modelId) then
												var_1_21 = iter_1_5

												break
											end
										end

										var_1_21 = var_1_21 or var_1_17[1]
									end

									var_1_19:registWork(Work2FightWork, FightWorkPlayTimeline, var_1_20, "aijiao_312301_unique_pre", var_1_21)
									var_1_19:registWork(FightWorkFunction, FightAiJiAoQteView.autoQte, iter_1_0, var_1_21)
									var_1_19:start()
									arg_1_0:cancelFightWorkSafeTimer()

									return true
								end

								local var_1_24 = FightMsgMgr.sendMsg(FightMsgId.ShowAiJiAoExpointEffectBeforeUniqueSkill, iter_1_0)

								if var_1_24 then
									AudioMgr.instance:trigger(20305032)
									var_1_19:registWork(FightWorkPlayAnimator, var_1_24, "dazhao")
								end

								var_1_19:registWork(FightWorkFunction, arg_1_0.openFightAiJiAoQteSelectView, arg_1_0, var_1_18)
								var_1_19:start()
							else
								local var_1_25 = {
									fromId = iter_1_0,
									toId = var_1_13
								}
								local var_1_26 = arg_1_0:com_registFlowSequence()

								if not FightDataHelper.tempMgr.playAiJiAoPreTimeline then
									FightDataHelper.tempMgr.playAiJiAoPreTimeline = true
									FightDataHelper.tempMgr.aiJiAoFakeHpDic = {}
									FightDataHelper.tempMgr.aiJiAoFakeShieldDic = {}

									FightWorkEzioBigSkillDamage1000.fakeDecreaseHp(var_1_13, var_1_12)
									FightController.instance:dispatchEvent(FightEvent.AiJiAoFakeDecreaseHp, var_1_13)

									local var_1_27 = FightHelper.getEntity(iter_1_0)

									var_1_26:registWork(Work2FightWork, FightWorkPlayTimeline, var_1_27, "aijiao_312301_unique_pre", var_1_13)
								end

								if var_1_2 then
									var_1_26:registWork(FightWorkFunction, FightAiJiAoQteView.autoQte, iter_1_0, var_1_13)
									var_1_26:start()
									arg_1_0:cancelFightWorkSafeTimer()

									return true
								end

								var_1_26:registWork(FightWorkFunction, arg_1_0.openAiJiAoQteView, arg_1_0, var_1_25)
								var_1_26:start()
							end

							arg_1_0:cancelFightWorkSafeTimer()

							return true
						end
					end
				end
			end
		end
	end

	arg_1_0:onDone(true)
end

function var_0_0.openFightAiJiAoQteSelectView(arg_2_0, arg_2_1)
	ViewMgr.instance:openView(ViewName.FightAiJiAoQteSelectView, arg_2_1)
end

function var_0_0.afterAiJiAoSelectToId(arg_3_0, arg_3_1)
	local var_3_0 = {
		fromId = arg_3_0.aiJiAoFromId,
		toId = arg_3_1
	}
	local var_3_1 = arg_3_0:com_registFlowSequence()
	local var_3_2 = FightHelper.getEntity(arg_3_0.aiJiAoFromId)

	var_3_1:registWork(Work2FightWork, FightWorkPlayTimeline, var_3_2, "aijiao_312301_unique_pre", arg_3_1)
	var_3_1:registWork(FightWorkFunction, arg_3_0.openAiJiAoQteView, arg_3_0, var_3_0)
	var_3_1:start()
end

function var_0_0.openAiJiAoQteView(arg_4_0, arg_4_1)
	ViewMgr.instance:openView(ViewName.FightAiJiAoQteView, arg_4_1)
end

return var_0_0
