module("modules.logic.fight.view.FightPlayerOperateMgr", package.seeall)

local var_0_0 = class("FightPlayerOperateMgr", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	return
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_2_0._onRoundSequenceFinish, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, arg_2_0._onClothSkillRoundSequenceFinish, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, arg_2_0._onStartSequenceFinish, arg_2_0, LuaEventSystem.Low)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._onRoundSequenceFinish(arg_4_0)
	arg_4_0:checkNeedPlayerOperate()
end

function var_0_0._onClothSkillRoundSequenceFinish(arg_5_0)
	arg_5_0:checkNeedPlayerOperate()
end

function var_0_0._onStartSequenceFinish(arg_6_0)
	arg_6_0:checkNeedPlayerOperate()

	if arg_6_0.aiJiAoToId then
		FightDataHelper.tempMgr.aiJiAoFakeHpOffset = {}

		FightWorkEzioBigSkillDamage1000.fakeDecreaseHp(arg_6_0.aiJiAoToId, arg_6_0.aiJiAoTotalDamage)
		FightController.instance:dispatchEvent(FightEvent.AiJiAoFakeDecreaseHp, arg_6_0.aiJiAoToId)

		arg_6_0.aiJiAoToId = nil
		arg_6_0.aiJiAoTotalDamage = nil
	end
end

function var_0_0.checkNeedPlayerOperate(arg_7_0)
	if FightDataHelper.fieldMgr:isDouQuQu() then
		return
	end

	if arg_7_0:checkAiJiAoQte() then
		return
	else
		FightDataHelper.tempMgr.aiJiAoFakeHpOffset = {}
		FightDataHelper.tempMgr.aiJiAoQteCount = 0
		FightDataHelper.tempMgr.aiJiAoQteEndlessLoop = 0

		FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.AiJiAoQteIng)
	end

	if arg_7_0:_checkChangeHeroNeedUseSkill() then
		return
	end

	if arg_7_0:_checkBindContract() then
		return
	end

	arg_7_0:_checkHeroUpgrade()

	local var_7_0 = arg_7_0:com_registFlowSequence()

	var_7_0:registWork(FightWorkGuideAfterPlay)
	var_7_0:registWork(FightWorkFunction, arg_7_0.showUIPart, arg_7_0)
	var_7_0:start()
end

function var_0_0.showUIPart(arg_8_0)
	if not FightModel.instance:isFinish() then
		FightViewPartVisible.set(true, true, true, false, false)
	end
end

function var_0_0.sortEntity(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getMO()
	local var_9_1 = arg_9_1:getMO()

	if var_9_0 and var_9_1 then
		return var_9_0.position < var_9_1.position
	end

	return false
end

function var_0_0._checkHeroUpgrade(arg_10_0)
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return
	end

	if FightReplayModel.instance:isReplay() then
		return
	end

	if FightModel.instance:getCurStage() == FightEnum.Stage.AutoCard then
		return
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if FightModel.instance:isFinish() then
		return
	end

	local var_10_0 = var_0_0.detectUpgrade()

	if #var_10_0 > 0 then
		for iter_10_0 = #var_10_0, 1, -1 do
			local var_10_1 = var_10_0[iter_10_0]

			if lua_hero_upgrade.configDict[var_10_1.id].type == 1 then
				FightRpc.instance:sendUseClothSkillRequest(var_10_1.id, var_10_1.entityId, var_10_1.optionIds[1], FightEnum.ClothSkillType.HeroUpgrade)
				table.remove(var_10_0, iter_10_0)
			end
		end

		if #var_10_0 > 0 then
			arg_10_0._upgradeDataList = var_10_0

			ViewMgr.instance:openView(ViewName.FightSkillStrengthenView, var_10_0)
		end
	end
end

function var_0_0.detectUpgrade()
	if FightModel.instance:isFinish() then
		return {}
	end

	local var_11_0 = {}
	local var_11_1 = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide)

	table.sort(var_11_1, var_0_0.sortEntity)

	for iter_11_0, iter_11_1 in ipairs(var_11_1) do
		local var_11_2 = iter_11_1:getMO()

		if var_11_2 and var_11_2.canUpgradeIds and tabletool.len(var_11_2.canUpgradeIds) > 0 then
			for iter_11_2, iter_11_3 in pairs(var_11_2.canUpgradeIds) do
				local var_11_3 = lua_hero_upgrade.configDict[iter_11_3]

				if var_11_3 then
					local var_11_4 = {}
					local var_11_5 = string.splitToNumber(var_11_3.options, "#")

					for iter_11_4, iter_11_5 in ipairs(var_11_5) do
						if not var_11_2.upgradedOptions[iter_11_5] then
							table.insert(var_11_4, iter_11_5)
						end
					end

					if #var_11_4 > 0 then
						local var_11_6 = {
							id = iter_11_3,
							entityId = var_11_2.id,
							optionIds = var_11_4
						}

						table.insert(var_11_0, var_11_6)
					end
				end
			end
		end
	end

	return var_11_0
end

function var_0_0._checkChangeHeroNeedUseSkill(arg_12_0)
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return
	end

	if FightReplayModel.instance:isReplay() then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.Season2AutoChangeHero) then
		return
	end

	if FightModel.instance:getCurStage() == FightEnum.Stage.AutoCard then
		return
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if FightModel.instance:isFinish() then
		return
	end

	local var_12_0 = FightDataHelper.roundMgr:getRoundData()

	if not var_12_0 then
		return
	end

	local var_12_1 = FightDataHelper.entityMgr:getById(var_12_0.lastChangeHeroUid)

	if not var_12_1 then
		return
	end

	local var_12_2 = lua_skill.configDict[var_12_1.exSkill]

	if not var_12_2 then
		return
	end

	if FightEnum.ShowLogicTargetView[var_12_2.logicTarget] and var_12_2.targetLimit == FightEnum.TargetLimit.MySide then
		local var_12_3 = FightDataHelper.entityMgr:getMyNormalList()
		local var_12_4 = FightDataHelper.entityMgr:getSpList(FightEnum.EntitySide.MySide)

		if #var_12_3 + #var_12_4 == 0 then
			return
		end
	end

	ViewMgr.instance:openView(ViewName.FightChangeHeroSelectSkillTargetView, {
		skillConfig = var_12_2,
		fromId = var_12_1.id
	})

	return true
end

function var_0_0._checkBindContract(arg_13_0)
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return
	end

	if FightReplayModel.instance:isReplay() then
		return
	end

	if FightModel.instance:getCurStage() == FightEnum.Stage.AutoCard then
		return
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if FightModel.instance:isFinish() then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		logNormal("打开娜娜锲约界面，但是还在指引ing")

		return
	end

	local var_13_0 = FightModel.instance.notifyEntityId

	if string.nilorempty(var_13_0) then
		return
	end

	if not FightHelper.getEntity(var_13_0) then
		return
	end

	local var_13_1 = FightModel.instance.canContractList

	if not var_13_1 or #var_13_1 < 1 then
		return
	end

	FightDataHelper.stageMgr:enterOperateState(FightStageMgr.OperateStateType.BindContract)
	ViewMgr.instance:openView(ViewName.FightNaNaTargetView)

	return true
end

function var_0_0.checkAiJiAoQte(arg_14_0)
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return
	end

	if FightReplayModel.instance:isReplay() then
		return
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card and FightModel.instance:getCurStage() ~= FightEnum.Stage.AutoCard then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if FightModel.instance:isFinish() then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		return
	end

	local var_14_0 = FightDataHelper.entityMgr.entityDataDic
	local var_14_1 = FightEnum.BuffFeature.EzioBigSkill
	local var_14_2 = FightDataHelper.stageMgr:inAutoFightState()

	for iter_14_0, iter_14_1 in pairs(var_14_0) do
		if iter_14_1.side == FightEnum.EntitySide.MySide then
			local var_14_3, var_14_4 = iter_14_1:hasBuffFeature(var_14_1)

			if var_14_3 then
				local var_14_5 = var_14_4.actCommonParams
				local var_14_6 = string.split(var_14_5, "|")

				for iter_14_2, iter_14_3 in ipairs(var_14_6) do
					local var_14_7 = string.split(iter_14_3, "#")
					local var_14_8 = tonumber(var_14_7[1])
					local var_14_9 = lua_buff_act.configDict[var_14_8]

					if var_14_9 and var_14_9.type == var_14_1 then
						local var_14_10 = string.split(var_14_7[2], ",")
						local var_14_11 = tonumber(var_14_10[1]) or 0
						local var_14_12 = tonumber(var_14_10[2])
						local var_14_13 = var_14_10[3]

						if var_14_11 and var_14_11 > 0 then
							if var_14_11 == FightDataHelper.tempMgr.aiJiAoQteCount then
								local var_14_14 = (FightDataHelper.tempMgr.aiJiAoQteEndlessLoop or 0) + 1

								FightDataHelper.tempMgr.aiJiAoQteEndlessLoop = var_14_14

								if var_14_14 > 2 then
									local var_14_15 = FightHelper.getEntity(iter_14_0)

									if var_14_15 then
										local var_14_16 = FightStepData.New(FightDef_pb.FightStep())

										var_14_16.isFakeStep = true
										var_14_16.fromId = var_14_15.id
										var_14_16.toId = var_14_15:isMySide() and FightEntityScene.EnemySideId or FightEntityScene.MySideId
										var_14_16.actType = FightEnum.ActType.SKILL

										var_14_15.skill:registTimelineWork("aijiao_312301_unique_direct_exit", var_14_16):start()
									end

									return false
								end
							end

							FightDataHelper.tempMgr.aiJiAoQteCount = var_14_11

							if var_14_13 == "0" then
								arg_14_0.playAiJiAoPreTimeline = true

								local var_14_17 = FightAiJiAoQteSelectView.getTargetLimit(229002, iter_14_0)

								if #var_14_17 == 0 then
									return false
								end

								local var_14_18 = {
									mustSelect = true,
									skillId = 229002,
									fromId = iter_14_0,
									callback = arg_14_0.afterAiJiAoSelectToId,
									handle = arg_14_0,
									targetLimit = var_14_17
								}

								arg_14_0.aiJiAoFromId = iter_14_0

								local var_14_19 = arg_14_0:com_registFlowSequence()

								if var_14_2 then
									local var_14_20 = FightHelper.getEntity(iter_14_0)
									local var_14_21 = FightDataHelper.operationDataMgr.curSelectEntityId

									var_14_21 = (not var_14_21 or var_14_21 ~= 0) and var_14_21

									if not FightHelper.getEntity(var_14_21) then
										var_14_21 = nil
									end

									if not var_14_21 then
										local var_14_22 = FightHelper.getCurBossId()

										for iter_14_4, iter_14_5 in ipairs(var_14_17) do
											local var_14_23 = FightDataHelper.entityMgr:getById(iter_14_5)

											if var_14_23 and FightHelper.isBossId(var_14_22, var_14_23.modelId) then
												var_14_21 = iter_14_5

												break
											end
										end

										var_14_21 = var_14_21 or var_14_17[1]
									end

									if not var_14_21 or not FightHelper.getEntity(var_14_21) then
										return false
									end

									var_14_19:registWork(Work2FightWork, FightWorkPlayTimeline, var_14_20, "aijiao_312301_unique_pre", var_14_21)
									var_14_19:registWork(FightWorkFunction, FightAiJiAoQteView.autoQte, iter_14_0, var_14_21)
									var_14_19:start()

									return true
								end

								local var_14_24 = FightMsgMgr.sendMsg(FightMsgId.ShowAiJiAoExpointEffectBeforeUniqueSkill, iter_14_0)

								if var_14_24 then
									AudioMgr.instance:trigger(20305032)
									var_14_19:registWork(FightWorkPlayAnimator, var_14_24, "dazhao")
								end

								var_14_19:registWork(FightWorkFunction, arg_14_0.openFightAiJiAoQteSelectView, arg_14_0, var_14_18)
								var_14_19:start()
							else
								arg_14_0.aiJiAoToId = var_14_13
								arg_14_0.aiJiAoTotalDamage = var_14_12

								local var_14_25 = {
									fromId = iter_14_0,
									toId = var_14_13
								}
								local var_14_26 = arg_14_0:com_registFlowSequence()

								if not arg_14_0.playAiJiAoPreTimeline then
									arg_14_0.playAiJiAoPreTimeline = true

									local var_14_27 = FightHelper.getEntity(iter_14_0)

									var_14_26:registWork(Work2FightWork, FightWorkPlayTimeline, var_14_27, "aijiao_312301_unique_pre", var_14_13)
								end

								if var_14_2 then
									var_14_26:registWork(FightWorkFunction, FightAiJiAoQteView.autoQte, iter_14_0, var_14_13)
									var_14_26:start()

									return true
								end

								var_14_26:registWork(FightWorkFunction, arg_14_0.openAiJiAoQteView, arg_14_0, var_14_25)
								var_14_26:start()
							end

							return true
						end
					end
				end
			end
		end
	end
end

function var_0_0.openFightAiJiAoQteSelectView(arg_15_0, arg_15_1)
	ViewMgr.instance:openView(ViewName.FightAiJiAoQteSelectView, arg_15_1)
end

function var_0_0.afterAiJiAoSelectToId(arg_16_0, arg_16_1)
	local var_16_0 = {
		fromId = arg_16_0.aiJiAoFromId,
		toId = arg_16_1
	}
	local var_16_1 = arg_16_0:com_registFlowSequence()
	local var_16_2 = FightHelper.getEntity(arg_16_0.aiJiAoFromId)

	var_16_1:registWork(Work2FightWork, FightWorkPlayTimeline, var_16_2, "aijiao_312301_unique_pre", arg_16_1)
	var_16_1:registWork(FightWorkFunction, arg_16_0.openAiJiAoQteView, arg_16_0, var_16_0)
	var_16_1:start()
end

function var_0_0.openAiJiAoQteView(arg_17_0, arg_17_1)
	ViewMgr.instance:openView(ViewName.FightAiJiAoQteView, arg_17_1)
end

return var_0_0
