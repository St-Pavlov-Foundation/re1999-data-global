module("modules.logic.fight.view.FightPlayerOperateMgr", package.seeall)

local var_0_0 = class("FightPlayerOperateMgr", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
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
end

function var_0_0.checkNeedPlayerOperate(arg_7_0)
	if FightDataHelper.fieldMgr:isDouQuQu() then
		return
	end

	if arg_7_0:_checkChangeHeroNeedUseSkill() then
		return
	end

	if arg_7_0:_checkBindContract() then
		return
	end

	arg_7_0:_checkHeroUpgrade()

	if not FightModel.instance:isFinish() then
		FightViewPartVisible.set(true, true, true, false, false)
	end
end

function var_0_0.sortEntity(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getMO()
	local var_8_1 = arg_8_1:getMO()

	if var_8_0 and var_8_1 then
		return var_8_0.position < var_8_1.position
	end

	return false
end

function var_0_0._checkHeroUpgrade(arg_9_0)
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

	local var_9_0 = var_0_0.detectUpgrade()

	if #var_9_0 > 0 then
		for iter_9_0 = #var_9_0, 1, -1 do
			local var_9_1 = var_9_0[iter_9_0]

			if lua_hero_upgrade.configDict[var_9_1.id].type == 1 then
				FightRpc.instance:sendUseClothSkillRequest(var_9_1.id, var_9_1.entityId, var_9_1.optionIds[1], FightEnum.ClothSkillType.HeroUpgrade)
				table.remove(var_9_0, iter_9_0)
			end
		end

		if #var_9_0 > 0 then
			arg_9_0._upgradeDataList = var_9_0

			ViewMgr.instance:openView(ViewName.FightSkillStrengthenView, var_9_0)
		end
	end
end

function var_0_0.detectUpgrade()
	if FightModel.instance:isFinish() then
		return {}
	end

	local var_10_0 = {}
	local var_10_1 = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide)

	table.sort(var_10_1, var_0_0.sortEntity)

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		local var_10_2 = iter_10_1:getMO()

		if var_10_2 and var_10_2.canUpgradeIds and tabletool.len(var_10_2.canUpgradeIds) > 0 then
			for iter_10_2, iter_10_3 in pairs(var_10_2.canUpgradeIds) do
				local var_10_3 = lua_hero_upgrade.configDict[iter_10_3]

				if var_10_3 then
					local var_10_4 = {}
					local var_10_5 = string.splitToNumber(var_10_3.options, "#")

					for iter_10_4, iter_10_5 in ipairs(var_10_5) do
						if not var_10_2.upgradedOptions[iter_10_5] then
							table.insert(var_10_4, iter_10_5)
						end
					end

					if #var_10_4 > 0 then
						local var_10_6 = {
							id = iter_10_3,
							entityId = var_10_2.id,
							optionIds = var_10_4
						}

						table.insert(var_10_0, var_10_6)
					end
				end
			end
		end
	end

	return var_10_0
end

function var_0_0._checkChangeHeroNeedUseSkill(arg_11_0)
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

	local var_11_0 = FightDataHelper.roundMgr:getRoundData()

	if not var_11_0 then
		return
	end

	local var_11_1 = FightDataHelper.entityMgr:getById(var_11_0.lastChangeHeroUid)

	if not var_11_1 then
		return
	end

	local var_11_2 = lua_skill.configDict[var_11_1.exSkill]

	if not var_11_2 then
		return
	end

	if FightEnum.ShowLogicTargetView[var_11_2.logicTarget] and var_11_2.targetLimit == FightEnum.TargetLimit.MySide then
		local var_11_3 = FightDataHelper.entityMgr:getMyNormalList()
		local var_11_4 = FightDataHelper.entityMgr:getSpList(FightEnum.EntitySide.MySide)

		if #var_11_3 + #var_11_4 == 0 then
			return
		end
	end

	ViewMgr.instance:openView(ViewName.FightChangeHeroSelectSkillTargetView, {
		skillConfig = var_11_2,
		fromId = var_11_1.id
	})

	return true
end

function var_0_0._checkBindContract(arg_12_0)
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

	local var_12_0 = FightModel.instance.notifyEntityId

	if string.nilorempty(var_12_0) then
		return
	end

	if not FightHelper.getEntity(var_12_0) then
		return
	end

	local var_12_1 = FightModel.instance.canContractList

	if not var_12_1 or #var_12_1 < 1 then
		return
	end

	FightDataHelper.stageMgr:enterOperateState(FightStageMgr.OperateStateType.BindContract)
	ViewMgr.instance:openView(ViewName.FightNaNaTargetView)

	return true
end

return var_0_0
