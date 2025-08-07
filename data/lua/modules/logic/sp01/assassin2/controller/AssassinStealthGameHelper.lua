module("modules.logic.sp01.assassin2.controller.AssassinStealthGameHelper", package.seeall)

local var_0_0 = _M

function var_0_0.getSelectedHeroPointType()
	local var_1_0
	local var_1_1 = AssassinStealthGameModel.instance:getSelectedHeroGameMo()

	if var_1_1 then
		local var_1_2 = AssassinStealthGameModel.instance:getMapId()
		local var_1_3, var_1_4 = var_1_1:getPos()

		var_1_0 = AssassinConfig.instance:getGridPointType(var_1_2, var_1_3, var_1_4)
	end

	return var_1_0
end

function var_0_0.getSelectedHeroMoveActId(arg_2_0, arg_2_1)
	local var_2_0 = AssassinStealthGameModel.instance:getSelectedHeroGameMo()

	if not var_2_0 then
		return
	end

	local var_2_1
	local var_2_2 = var_2_0:getPos()
	local var_2_3 = var_2_0:getStatus()
	local var_2_4 = var_0_0.getSelectedHeroPointType() == AssassinEnum.StealthGamePointType.Tower
	local var_2_5 = var_2_2 == arg_2_0

	if arg_2_1 then
		local var_2_6 = AssassinStealthGameModel.instance:getMapId()
		local var_2_7 = AssassinConfig.instance:getGridPointType(var_2_6, arg_2_0, arg_2_1)
		local var_2_8 = var_2_7 == AssassinEnum.StealthGamePointType.HayStack
		local var_2_9 = var_2_7 == AssassinEnum.StealthGamePointType.Garden
		local var_2_10 = var_2_7 == AssassinEnum.StealthGamePointType.Tower

		if var_2_4 then
			if var_2_8 then
				var_2_1 = AssassinEnum.HeroAct.Jump
			end
		elseif var_2_10 then
			if AssassinConfig.instance:getTowerGridDict(var_2_6, arg_2_0, arg_2_1)[var_2_2] then
				var_2_1 = AssassinEnum.HeroAct.ClimbTower
			end
		elseif var_2_5 and (var_2_8 or var_2_9) and var_2_3 == AssassinEnum.HeroStatus.Stealth then
			var_2_1 = AssassinEnum.HeroAct.Hide
		end
	elseif var_2_4 then
		var_2_1 = AssassinEnum.HeroAct.LeaveTower
	elseif var_2_5 then
		if var_2_3 == AssassinEnum.HeroStatus.Hide then
			var_2_1 = AssassinEnum.HeroAct.LeaveHide
		end
	else
		var_2_1 = AssassinEnum.HeroAct.Move
	end

	return var_2_1
end

function var_0_0.getSelectedHeroAttackActId(arg_3_0)
	local var_3_0 = AssassinStealthGameModel.instance:getSelectedHeroGameMo()
	local var_3_1

	if arg_3_0 then
		var_3_1 = AssassinStealthGameModel.instance:getEnemyMo(arg_3_0, true)
	else
		var_3_1 = AssassinStealthGameModel.instance:getSelectedEnemyGameMo()
	end

	if not var_3_0 or not var_3_1 then
		return
	end

	if var_0_0.getSelectedHeroPointType() == AssassinEnum.StealthGamePointType.Tower then
		return
	end

	local var_3_2 = var_3_0:getPos()

	if var_3_2 ~= var_3_1:getPos() then
		return
	end

	local var_3_3
	local var_3_4
	local var_3_5 = var_3_0:getStatus()
	local var_3_6 = var_3_5 == AssassinEnum.HeroStatus.Stealth
	local var_3_7 = var_3_5 == AssassinEnum.HeroStatus.Expose

	if var_3_6 then
		var_3_3 = AssassinEnum.HeroAct.Ambush
	elseif var_3_7 then
		var_3_3 = AssassinEnum.HeroAct.Attack
	end

	if var_3_6 or var_3_7 then
		local var_3_8 = var_3_0:getUid()
		local var_3_9 = AssassinStealthGameModel.instance:getGridEntityIdList(var_3_2, false, var_3_8)

		if #var_3_9 > 0 then
			local var_3_10 = AssassinStealthGameModel.instance:getMapId()

			for iter_3_0, iter_3_1 in ipairs(var_3_9) do
				local var_3_11 = AssassinStealthGameModel.instance:getHeroMo(iter_3_1, true)
				local var_3_12, var_3_13 = var_3_11:getPos()

				if AssassinConfig.instance:getGridPointType(var_3_10, var_3_2, var_3_13) ~= AssassinEnum.StealthGamePointType.Tower then
					local var_3_14 = var_3_11:getStatus()

					if var_3_14 == AssassinEnum.HeroStatus.Stealth then
						var_3_4 = AssassinEnum.HeroAct.AmbushTogether

						break
					elseif var_3_14 == AssassinEnum.HeroStatus.Expose then
						if var_3_6 then
							var_3_4 = AssassinEnum.HeroAct.AmbushTogether

							break
						else
							var_3_4 = AssassinEnum.HeroAct.AttackTogether
						end
					end
				end
			end
		end
	end

	return var_3_3, var_3_4
end

function var_0_0.getSelectedHeroAssassinateActId(arg_4_0)
	local var_4_0 = true
	local var_4_1 = AssassinStealthGameModel.instance:getSelectedHeroGameMo()
	local var_4_2

	if arg_4_0 then
		var_4_2 = AssassinStealthGameModel.instance:getEnemyMo(arg_4_0, true)
	else
		var_4_2 = AssassinStealthGameModel.instance:getSelectedEnemyGameMo()
	end

	if var_4_2 then
		local var_4_3 = var_4_2:getMonsterId()

		var_4_0 = AssassinConfig.instance:getEnemyIsBoss(var_4_3)
	end

	if not var_4_1 or var_4_0 then
		return
	end

	local var_4_4
	local var_4_5 = var_4_1:getStatus()

	if var_4_5 == AssassinEnum.HeroStatus.Stealth then
		var_4_4 = AssassinEnum.HeroAct.Assassinate

		local var_4_6 = AssassinStealthGameModel.instance:getMapId()
		local var_4_7, var_4_8 = var_4_1:getPos()
		local var_4_9 = AssassinConfig.instance:getGridPointType(var_4_6, var_4_7, var_4_8)
		local var_4_10 = AssassinConfig.instance:getGridType(var_4_6, var_4_7)
		local var_4_11 = var_4_2:getPos()

		if not (AssassinConfig.instance:getGridType(var_4_6, var_4_11) == AssassinEnum.StealthGameGridType.Roof) and (var_4_10 == AssassinEnum.StealthGameGridType.Roof or var_4_9 == AssassinEnum.StealthGamePointType.Tower) then
			var_4_4 = AssassinEnum.HeroAct.AirAssassinate
		end
	elseif var_4_5 == AssassinEnum.HeroStatus.Hide then
		var_4_4 = AssassinEnum.HeroAct.HideAssassinate
	end

	return var_4_4
end

function var_0_0.checkHero(arg_5_0)
	local var_5_0 = AssassinEnum.HeroStatus.Dead
	local var_5_1

	if arg_5_0 then
		var_5_1 = AssassinStealthGameModel.instance:getHeroMo(arg_5_0)
	else
		var_5_1 = AssassinStealthGameModel.instance:getSelectedHeroGameMo()
	end

	if var_5_1 then
		var_5_0 = var_5_1:getStatus()
	end

	return var_5_0 ~= AssassinEnum.HeroStatus.Dead
end

function var_0_0.isDeadEnemy(arg_6_0)
	local var_6_0 = true
	local var_6_1 = AssassinStealthGameModel.instance:getEnemyMo(arg_6_0)

	if var_6_1 then
		var_6_0 = var_6_1:getIsDead()
	end

	return var_6_0
end

function var_0_0.isCanSelectHero(arg_7_0)
	if not var_0_0.checkHero(arg_7_0) then
		return false
	end

	if AssassinStealthGameModel.instance:getSelectedSkillProp() then
		return false
	end

	return (AssassinStealthGameModel.instance:isPlayerTurn())
end

function var_0_0.isSelectedHeroCanMoveTo(arg_8_0, arg_8_1)
	if not var_0_0.checkHero() then
		return false
	end

	if AssassinStealthGameModel.instance:getSelectedSkillProp() then
		return false
	end

	local var_8_0 = AssassinStealthGameModel.instance:getMapId()

	if not AssassinConfig.instance:isShowGrid(var_8_0, arg_8_0) then
		return false
	end

	if arg_8_1 then
		if AssassinStealthGameModel.instance:getGridPointEntity(arg_8_0, arg_8_1) then
			return false
		end
	elseif not AssassinStealthGameModel.instance:getGridEmptyPointIndex(arg_8_0) then
		return false
	end

	local var_8_1 = AssassinStealthGameModel.instance:getSelectedHeroGameMo()
	local var_8_2, var_8_3 = var_8_1:getPos()

	if var_0_0.getSelectedHeroPointType() == AssassinEnum.StealthGamePointType.Tower then
		if not AssassinConfig.instance:getTowerGridDict(var_8_0, var_8_2, var_8_3)[arg_8_0] then
			return false
		end
	else
		local var_8_4 = var_8_1:getStatus() == AssassinEnum.HeroStatus.Hide

		if (arg_8_1 and AssassinConfig.instance:getGridPointType(var_8_0, arg_8_0, arg_8_1)) == AssassinEnum.StealthGamePointType.Tower then
			local var_8_5 = AssassinConfig.instance:getTowerGridDict(var_8_0, arg_8_0, arg_8_1)

			if var_8_4 or not var_8_5[var_8_2] then
				return false
			end
		else
			local var_8_6 = var_8_4 and AssassinEnum.StealthConst.HideMoveDis or AssassinEnum.StealthConst.MoveDis
			local var_8_7, var_8_8 = AssassinConfig.instance:getGridPos(var_8_0, var_8_2)
			local var_8_9, var_8_10 = AssassinConfig.instance:getGridPos(var_8_0, arg_8_0)
			local var_8_11 = var_8_7 - var_8_9
			local var_8_12 = var_8_8 - var_8_10

			if var_8_6 * var_8_6 < var_8_11 * var_8_11 + var_8_12 * var_8_12 then
				return false
			end
		end
	end

	if var_0_0.isHasWallBetweenGrid(var_8_2, arg_8_0) then
		return false
	end

	local var_8_13 = var_0_0.getSelectedHeroMoveActId(arg_8_0, arg_8_1)

	if not var_8_13 then
		return false
	end

	return var_8_1:getActionPoint() >= AssassinConfig.instance:getAssassinActPower(var_8_13)
end

function var_0_0.isAdjacentGrid(arg_9_0, arg_9_1)
	local var_9_0 = AssassinStealthGameModel.instance:getMapId()
	local var_9_1, var_9_2 = AssassinConfig.instance:getGridPos(var_9_0, arg_9_0)
	local var_9_3, var_9_4 = AssassinConfig.instance:getGridPos(var_9_0, arg_9_1)

	if not var_9_1 or not var_9_2 or not var_9_3 or not var_9_4 then
		return false
	end

	return math.abs(var_9_1 - var_9_3) + math.abs(var_9_2 - var_9_4) == AssassinEnum.StealthConst.AdjacentDis
end

function var_0_0.isHasWallBetweenGrid(arg_10_0, arg_10_1)
	if not var_0_0.isAdjacentGrid(arg_10_0, arg_10_1) then
		return false
	end

	local var_10_0
	local var_10_1 = AssassinStealthGameModel.instance:getMapId()
	local var_10_2, var_10_3 = AssassinConfig.instance:getGridPos(var_10_1, arg_10_0)
	local var_10_4, var_10_5 = AssassinConfig.instance:getGridPos(var_10_1, arg_10_1)

	if var_10_2 ~= var_10_4 then
		local var_10_6 = var_10_2 < var_10_4 and var_10_2 or var_10_4

		var_10_0 = string.format("%s%s%s", AssassinEnum.StealthConst.VerWallSign, var_10_6, var_10_3)
	else
		local var_10_7 = var_10_3 < var_10_5 and var_10_3 or var_10_5

		var_10_0 = string.format("%s%s%s", AssassinEnum.StealthConst.HorWallSign, var_10_2, var_10_7)
	end

	return (AssassinConfig.instance:isShowWall(var_10_1, tonumber(var_10_0)))
end

function var_0_0.isSelectedHeroCanInteract()
	if not var_0_0.checkHero() then
		return false
	end

	local var_11_0 = AssassinStealthGameModel.instance:getSelectedHeroGameMo():getPos()

	return (AssassinStealthGameModel.instance:isQTEInteractGrid(var_11_0))
end

function var_0_0.isSelectedHeroCanSelectEnemy(arg_12_0)
	if not var_0_0.checkHero() then
		return false
	end

	if var_0_0.isDeadEnemy(arg_12_0) then
		return false
	end

	local var_12_0 = false
	local var_12_1 = AssassinStealthGameModel.instance:getSelectedHeroGameMo()
	local var_12_2 = AssassinStealthGameModel.instance:getEnemyMo(arg_12_0)
	local var_12_3, var_12_4 = var_12_1:getPos()
	local var_12_5 = var_12_2:getPos()

	if var_12_5 ~= var_12_3 then
		local var_12_6 = AssassinStealthGameModel.instance:getMapId()
		local var_12_7 = AssassinConfig.instance:getGridType(var_12_6, var_12_5) == AssassinEnum.StealthGameGridType.Roof
		local var_12_8 = var_12_2:getMonsterId()

		if not AssassinConfig.instance:getEnemyIsBoss(var_12_8) and not var_12_7 then
			local var_12_9 = AssassinConfig.instance:getGridType(var_12_6, var_12_3)
			local var_12_10 = var_0_0.getSelectedHeroPointType()

			if var_12_9 == AssassinEnum.StealthGameGridType.Roof then
				if var_0_0.isAdjacentGrid(var_12_3, var_12_5) then
					var_12_0 = true
				end
			elseif var_12_10 == AssassinEnum.StealthGamePointType.Tower and AssassinConfig.instance:getTowerGridDict(var_12_6, var_12_3, var_12_4)[var_12_5] then
				var_12_0 = true
			end
		end
	else
		var_12_0 = true
	end

	if var_12_0 then
		local var_12_11 = var_0_0.getSelectedHeroAssassinateActId(arg_12_0)
		local var_12_12, var_12_13 = var_0_0.getSelectedHeroAttackActId(arg_12_0)

		if var_12_11 or var_12_12 or var_12_13 then
			return true
		end
	end

	return false
end

function var_0_0.isSelectedHeroCanRemoveEnemyBody(arg_13_0)
	if not var_0_0.checkHero() then
		return false
	end

	if AssassinStealthGameModel.instance:getSelectedSkillProp() then
		return false
	end

	if var_0_0.getSelectedHeroPointType() == AssassinEnum.StealthGamePointType.Tower then
		return false
	end

	if not var_0_0.isDeadEnemy(arg_13_0) then
		return false
	end

	local var_13_0 = AssassinStealthGameModel.instance:getEnemyMo(arg_13_0)

	if not var_13_0 then
		return
	end

	local var_13_1 = AssassinStealthGameModel.instance:getSelectedHeroGameMo()
	local var_13_2 = var_13_0:getPos()
	local var_13_3 = var_13_1:getPos()

	if var_13_2 ~= var_13_3 then
		return false
	end

	if AssassinStealthGameModel.instance:isHasAliveEnemy(var_13_3) then
		return false
	end

	return var_13_1:getActionPoint() >= AssassinConfig.instance:getAssassinActPower(AssassinEnum.HeroAct.HandleBody)
end

function var_0_0.isCanUseSkillProp(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = false
	local var_14_1 = AssassinStealthGameModel.instance:getHeroMo(arg_14_0, true)

	if var_14_1 then
		var_14_0 = var_14_1:hasSkillProp(arg_14_1, arg_14_2, true)
	end

	if not var_14_0 then
		return false
	end

	local var_14_2 = AssassinStealthGameModel.instance:getMapId()
	local var_14_3, var_14_4 = var_14_1:getPos()
	local var_14_5 = AssassinConfig.instance:getGridType(var_14_2, var_14_3)

	if arg_14_2 then
		if var_14_5 == AssassinEnum.StealthGameGridType.Water then
			return false
		end
	elseif AssassinConfig.instance:getAssassinItemType(arg_14_1) == AssassinEnum.ItemType.AirCraft and var_14_5 ~= AssassinEnum.StealthGameGridType.Roof and AssassinConfig.instance:getGridPointType(var_14_2, var_14_3, var_14_4) ~= AssassinEnum.StealthGamePointType.Tower then
		return false
	end

	if not var_0_0._checkSkillPropUseLimit(arg_14_0, arg_14_1, arg_14_2) then
		return false
	end

	if not var_0_0._checkSkillPropCost(arg_14_0, arg_14_1, arg_14_2) then
		return false
	end

	return true
end

function var_0_0._checkSkillPropUseLimit(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = 0
	local var_15_1 = 0

	if arg_15_2 then
		var_15_0 = AssassinConfig.instance:getAssassinSkillRoundLimit(arg_15_1)
		var_15_1 = AssassinConfig.instance:getAssassinSkillTimesLimit(arg_15_1)
	else
		var_15_0 = AssassinConfig.instance:getAssassinItemRoundLimit(arg_15_1)
	end

	local var_15_2 = AssassinStealthGameModel.instance:getHeroMo(arg_15_0, true)
	local var_15_3 = var_15_2:getSkillPropRoundUseCount(arg_15_1, arg_15_2)
	local var_15_4 = var_15_2:getSkillPropTotalUseCount(arg_15_1, arg_15_2)
	local var_15_5 = var_15_0 ~= 0 and var_15_0 <= var_15_3
	local var_15_6 = var_15_1 ~= 0 and var_15_1 <= var_15_4

	return not var_15_5 and not var_15_6
end

function var_0_0._checkSkillPropCost(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = 0

	if arg_16_2 then
		local var_16_1, var_16_2 = AssassinConfig.instance:getAssassinSkillCost(arg_16_1)

		if var_16_1 == AssassinEnum.SkillCostType.AP then
			var_16_0 = var_16_2
		else
			logError(string.format("AssassinStealthGameHelper._checkSkillPropCost error, not support cost type:%s", var_16_1))

			return false
		end
	else
		var_16_0 = AssassinConfig.instance:getAssassinItemCostPoint(arg_16_1)
	end

	return var_16_0 <= AssassinStealthGameModel.instance:getHeroMo(arg_16_0, true):getActionPoint()
end

function var_0_0.isSelectedHeroCanUseSkillPropToHero(arg_17_0)
	if not var_0_0.checkHero() then
		return false
	end

	local var_17_0 = AssassinStealthGameModel.instance:getHeroMo(arg_17_0, true)

	if not var_17_0 then
		return false
	end

	local var_17_1, var_17_2 = AssassinStealthGameModel.instance:getSelectedSkillProp()

	if not var_17_1 then
		return false
	end

	local var_17_3 = AssassinConfig.instance:getSkillPropTargetType(var_17_1, var_17_2)

	if var_17_3 ~= AssassinEnum.SkillPropTargetType.Hero then
		return false
	end

	if not var_0_0._skillPropTargetCheck(var_17_1, var_17_2, var_17_3, arg_17_0) then
		return false
	end

	local var_17_4 = AssassinStealthGameModel.instance:getSelectedHeroGameMo():getPos()
	local var_17_5 = var_17_0:getPos()

	if not var_0_0._checkSkillPropRange(var_17_1, var_17_2, var_17_4, var_17_5) then
		return false
	end

	if var_17_2 then
		local var_17_6 = false

		if var_17_1 ~= AssassinEnum.Skill.Cure and var_17_1 ~= AssassinEnum.Skill.CureAll then
			local var_17_7 = AssassinStealthGameModel.instance:getHeroMo(arg_17_0, true)

			if var_17_7 then
				var_17_6 = var_17_7:getStatus() == AssassinEnum.HeroStatus.Dead
			else
				var_17_6 = true
			end
		end

		if var_17_6 then
			return false
		end

		if var_17_1 == AssassinEnum.Skill.AddAp and arg_17_0 == AssassinStealthGameModel.instance:getSelectedHero() then
			return false
		end
	end

	return true
end

function var_0_0.isSelectedHeroCanUseSkillPropToEnemy(arg_18_0)
	if not var_0_0.checkHero() then
		return false
	end

	local var_18_0, var_18_1 = AssassinStealthGameModel.instance:getSelectedSkillProp()

	if not var_18_0 then
		return false
	end

	local var_18_2 = AssassinConfig.instance:getSkillPropTargetType(var_18_0, var_18_1)

	if var_18_2 ~= AssassinEnum.SkillPropTargetType.Enemy then
		return false
	end

	local var_18_3 = AssassinStealthGameModel.instance:getEnemyMo(arg_18_0)
	local var_18_4 = var_18_3:getMonsterId()

	if AssassinConfig.instance:getEnemyIsBoss(var_18_4) then
		return false
	end

	if not var_18_1 and AssassinConfig.instance:getAssassinItemType(var_18_0) == AssassinEnum.ItemType.ThrowingKnife and AssassinConfig.instance:getEnemyType(var_18_4) == AssassinEnum.EnemyType.Heavy then
		return false
	end

	if var_0_0.isDeadEnemy(arg_18_0) then
		return false
	end

	if not var_0_0._skillPropTargetCheck(var_18_0, var_18_1, var_18_2, arg_18_0) then
		return false
	end

	local var_18_5 = AssassinStealthGameModel.instance:getSelectedHeroGameMo():getPos()
	local var_18_6 = var_18_3:getPos()

	if not var_0_0._checkSkillPropRange(var_18_0, var_18_1, var_18_5, var_18_6) then
		return false
	end

	return true
end

function var_0_0.isSelectedHeroCanUseSkillPropToGrid(arg_19_0)
	local var_19_0 = AssassinStealthGameModel.instance:getMapId()

	if not AssassinConfig.instance:isShowGrid(var_19_0, arg_19_0) then
		return false
	end

	if not var_0_0.checkHero() then
		return false
	end

	local var_19_1, var_19_2 = AssassinStealthGameModel.instance:getSelectedSkillProp()

	if not var_19_1 then
		return false
	end

	local var_19_3 = AssassinConfig.instance:getSkillPropTargetType(var_19_1, var_19_2)

	if var_19_3 ~= AssassinEnum.SkillPropTargetType.Grid then
		return false
	end

	if not var_0_0._skillPropTargetCheck(var_19_1, var_19_2, var_19_3, arg_19_0) then
		return false
	end

	local var_19_4 = AssassinStealthGameModel.instance:getSelectedHeroGameMo():getPos()

	if not var_0_0._checkSkillPropRange(var_19_1, var_19_2, var_19_4, arg_19_0) then
		return false
	end

	return true
end

function var_0_0._skillPropTargetCheck(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = true
	local var_20_1 = arg_20_3

	if arg_20_2 == AssassinEnum.SkillPropTargetType.Hero then
		local var_20_2 = AssassinStealthGameModel.instance:getHeroMo(arg_20_3, true)

		var_20_1 = var_20_2 and var_20_2:getPos()
	elseif arg_20_2 == AssassinEnum.SkillPropTargetType.Enemy then
		local var_20_3 = AssassinStealthGameModel.instance:getEnemyMo(arg_20_3, true)

		var_20_1 = var_20_3 and var_20_3:getPos()
	end

	local var_20_4
	local var_20_5

	if arg_20_1 then
		var_20_4, var_20_5 = AssassinConfig.instance:getAssassinSkillTargetCheck(arg_20_0)
	else
		var_20_4, var_20_5 = AssassinConfig.instance:getAssassinItemTargetCheck(arg_20_0)
	end

	if var_20_4 then
		if var_20_4 == AssassinEnum.SkillPropTargetCheckType.GridType then
			local var_20_6 = AssassinStealthGameModel.instance:getMapId()

			var_20_0 = AssassinConfig.instance:getGridType(var_20_6, var_20_1) == var_20_5
		elseif var_20_4 == AssassinEnum.SkillPropTargetCheckType.EnemyRefreshPoint then
			local var_20_7 = AssassinStealthGameModel.instance:getMissionId()
			local var_20_8 = AssassinStealthGameModel.instance:isAlertBellRing()
			local var_20_9, var_20_10 = AssassinConfig.instance:getStealthMissionRefresh(var_20_7)
			local var_20_11 = var_20_8 and var_20_10 or var_20_9

			if var_20_11 and var_20_11 > 0 then
				local var_20_12 = false
				local var_20_13 = AssassinConfig.instance:getEnemyRefreshPositionList(var_20_11)

				for iter_20_0, iter_20_1 in ipairs(var_20_13) do
					if var_20_1 == iter_20_1[1] then
						var_20_12 = true

						break
					end
				end

				var_20_0 = var_20_12
			end
		else
			var_20_0 = false

			logError(string.format("AssassinStealthGameHelper._skillPropTargetCheck error, not support check type:%s", var_20_4))
		end
	end

	return var_20_0
end

function var_0_0._checkSkillPropRange(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = true
	local var_21_1
	local var_21_2

	if arg_21_1 then
		var_21_1, var_21_2 = AssassinConfig.instance:getAssassinSkillRange(arg_21_0)
	else
		var_21_1, var_21_2 = AssassinConfig.instance:getAssassinItemRange(arg_21_0)
	end

	if var_21_1 then
		local var_21_3 = AssassinStealthGameModel.instance:getMapId()

		if var_21_1 == AssassinEnum.RangeType.StraightLine then
			local var_21_4, var_21_5 = AssassinConfig.instance:getGridPos(var_21_3, arg_21_2)
			local var_21_6, var_21_7 = AssassinConfig.instance:getGridPos(var_21_3, arg_21_3)
			local var_21_8 = var_21_4 - var_21_6
			local var_21_9 = var_21_5 - var_21_7

			if var_21_2 * var_21_2 < var_21_8 * var_21_8 + var_21_9 * var_21_9 then
				return false
			end
		else
			var_21_0 = false

			logError(string.format("AssassinStealthGameHelper._checkSkillPropRange error, not support range type:%s", var_21_1))
		end
	end

	return var_21_0
end

function var_0_0.getEffectUrl(arg_22_0)
	return string.format("ui/viewres/sp01/assassin2/assassinstealth_skill/%s.prefab", arg_22_0)
end

function var_0_0.isHeroCanBeScan(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = false
	local var_23_1 = AssassinStealthGameModel.instance:getEventId()
	local var_23_2 = AssassinConfig.instance:getEventType(var_23_1)
	local var_23_3 = AssassinStealthGameModel.instance:getHeroMo(arg_23_0, true)

	if var_23_2 ~= AssassinEnum.EventType.NotExpose and var_23_3 then
		if arg_23_2 and arg_23_2 ~= AssassinEnum.HeroAct.Move then
			if arg_23_2 == AssassinEnum.HeroAct.LeaveHide or arg_23_2 == AssassinEnum.HeroAct.LeaveTower then
				var_23_0 = true
			end
		else
			local var_23_4 = AssassinStealthGameModel.instance:getMapId()
			local var_23_5, var_23_6 = var_23_3:getPos()
			local var_23_7 = AssassinConfig.instance:getGridPointType(var_23_4, var_23_5, var_23_6) == AssassinEnum.StealthGamePointType.Tower
			local var_23_8 = (arg_23_1 or var_23_3:getStatus()) == AssassinEnum.HeroStatus.Stealth

			if not var_23_7 and var_23_8 then
				var_23_0 = true
			end
		end
	end

	return var_23_0
end

function var_0_0.isGridEnemyWillScan(arg_24_0)
	local var_24_0 = AssassinStealthGameModel.instance:getMapId()

	if not AssassinConfig.instance:isShowGrid(var_24_0, arg_24_0) then
		return false
	end

	local var_24_1 = false
	local var_24_2 = AssassinStealthGameModel.instance:getGridMo(arg_24_0)
	local var_24_3 = var_24_2 and var_24_2:hasTrapType(AssassinEnum.StealGameTrapType.Smog)

	if var_24_2 and not var_24_3 then
		local var_24_4 = AssassinStealthGameModel.instance:getGridEntityIdList(arg_24_0, true)

		for iter_24_0, iter_24_1 in ipairs(var_24_4) do
			local var_24_5 = AssassinStealthGameModel.instance:getEnemyMo(iter_24_1, true)
			local var_24_6 = var_24_5 and var_24_5:getIsDead()
			local var_24_7 = var_24_5 and var_24_5:hasBuffType(AssassinEnum.StealGameBuffType.Petrifaction)

			if var_24_5 and not var_24_6 and not var_24_7 then
				var_24_1 = true

				break
			end
		end
	end

	return var_24_1
end

return var_0_0
