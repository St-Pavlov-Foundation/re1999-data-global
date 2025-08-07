module("modules.logic.sp01.assassin2.controller.AssassinStealthGameController", package.seeall)

local var_0_0 = class("AssassinStealthGameController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:_clearEnemyFlow()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:_clearEnemyFlow()
end

function var_0_0.pickAssassinHeroItemInHeroView(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if not arg_3_1 or not arg_3_2 then
		return true
	end

	if AssassinStealthGameModel.instance:getHeroPickIndex(arg_3_2) then
		if not AssassinHeroModel.instance:isRequiredAssassin(arg_3_2) then
			AssassinStealthGameModel.instance:removeHeroPick(arg_3_2)
		end
	else
		local var_3_0 = 0

		if arg_3_3 then
			local var_3_1 = AssassinConfig.instance:getQuestParam(arg_3_1)
			local var_3_2 = tonumber(var_3_1)
			local var_3_3 = var_3_2 and lua_episode.configDict[var_3_2]
			local var_3_4 = var_3_3 and lua_battle.configDict[var_3_3.battleId]

			var_3_0 = var_3_4 and var_3_4.playerMax or ModuleEnum.HeroCountInGroup
		else
			local var_3_5 = AssassinConfig.instance:getQuestParam(arg_3_1)

			var_3_0 = AssassinConfig.instance:getStealthMapNeedHeroCount(tonumber(var_3_5))
		end

		if var_3_0 <= AssassinStealthGameModel.instance:getPickHeroCount() then
			GameFacade.showToast(ToastEnum.AssassinStealthHeroFull)

			return false
		end

		AssassinStealthGameModel.instance:addHeroPick(arg_3_2)
	end

	return true
end

function var_0_0.startStealthGame(arg_4_0, arg_4_1)
	local var_4_0 = AssassinConfig.instance:getQuestParam(arg_4_1)
	local var_4_1 = tonumber(var_4_0)

	if not var_4_1 then
		return
	end

	if AssassinStealthGameModel.instance:getPickHeroCount() < AssassinConfig.instance:getStealthMapNeedHeroCount(var_4_1) then
		return
	end

	local var_4_2 = AssassinStealthGameModel.instance:getPickHeroList()

	AssassinSceneRpc.instance:sendEnterAssassinSceneRequest(arg_4_1, var_4_2, arg_4_0._realStartStealthGame, arg_4_0)
end

function var_0_0._realStartStealthGame(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_2 ~= 0 then
		return
	end

	arg_5_0._gameStartTime = UnityEngine.Time.realtimeSinceStartup

	arg_5_0:_initGameData(arg_5_3.scene)
	AssassinStealthGameModel.instance:setIsFightReturn()
	AssassinStealthGameModel.instance:setMapPosRecordOnFight()
	AssassinStealthGameModel.instance:setMapPosRecordOnTurn()
	AssassinStealthGameModel.instance:setIsShowHeroHighlight(true)
	ViewMgr.instance:openView(ViewName.AssassinStealthGameView)
end

function var_0_0._initGameData(arg_6_0, arg_6_1)
	AssassinStealthGameModel.instance:initGameSceneData(arg_6_1)
end

function var_0_0.checkGameState(arg_7_0)
	local var_7_0 = AssassinStealthGameModel.instance:getGameState()

	if var_7_0 == AssassinEnum.GameState.Win or var_7_0 == AssassinEnum.GameState.Fail then
		AssassinController.instance:openAssassinStealthGameResultView()
	end

	return var_7_0 ~= AssassinEnum.GameState.InProgress
end

function var_0_0.checkGameRequest(arg_8_0)
	local var_8_0 = AssassinStealthGameModel.instance:getNeedChangingMap()
	local var_8_1 = AssassinStealthGameModel.instance:getBattleGridIds()
	local var_8_2 = AssassinStealthGameModel.instance:getNeedNextRound()

	AssassinStealthGameModel.instance:setGameRequestData()

	if AssassinStealthGameModel.instance:getGameState() ~= AssassinEnum.GameState.InProgress then
		if not AssassinStealthGameModel.instance:isPlayerTurn() then
			arg_8_0:checkGameState()
		end

		return
	end

	if var_8_0 and var_8_0 ~= 0 then
		arg_8_0:changeMap(var_8_0)

		return
	end

	local var_8_3 = var_8_1 and var_8_1[1]

	if var_8_3 then
		arg_8_0:enterBattleGrid(var_8_3)

		return
	end

	if var_8_2 and var_8_2 ~= 0 then
		arg_8_0:_beginNewRound()

		return
	end
end

function var_0_0.initBaseMap(arg_9_0, arg_9_1)
	AssassinStealthGameEffectMgr.instance:init()
	AssassinStealthGameEntityMgr.instance:onInitBaseMap(arg_9_1)
end

function var_0_0.updateGrids(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_1 then
		return
	end

	local var_10_0 = {}

	AssassinStealthGameModel.instance:setGridDataByList(arg_10_1)

	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		local var_10_1 = iter_10_1.gridId

		var_10_0[var_10_1] = var_10_1

		AssassinStealthGameEntityMgr.instance:refreshGrid(var_10_1, arg_10_2)
	end

	arg_10_0:dispatchEvent(AssassinEvent.OnGridUpdate, var_10_0)
end

function var_0_0.updateGrid(arg_11_0, arg_11_1)
	if not arg_11_1 then
		return
	end

	local var_11_0 = arg_11_1.gridId

	AssassinStealthGameModel.instance:setGridData(arg_11_1)
	AssassinStealthGameEntityMgr.instance:refreshGrid(var_11_0)
	arg_11_0:dispatchEvent(AssassinEvent.OnGridUpdate, {
		gridId = var_11_0
	})
end

function var_0_0.updateHeroes(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_1 then
		return
	end

	local var_12_0 = {}

	AssassinStealthGameModel.instance:updateHeroDataByList(arg_12_1)

	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		local var_12_1 = iter_12_1.uid

		var_12_0[var_12_1] = var_12_1

		AssassinStealthGameEntityMgr.instance:refreshHeroEntity(var_12_1, arg_12_2)
	end

	arg_12_0:dispatchEvent(AssassinEvent.OnHeroUpdate, var_12_0)
end

function var_0_0.updateHero(arg_13_0, arg_13_1, arg_13_2)
	if not arg_13_1 then
		return
	end

	local var_13_0 = arg_13_1.uid

	AssassinStealthGameModel.instance:updateHeroData(arg_13_1)
	AssassinStealthGameEntityMgr.instance:refreshHeroEntity(var_13_0, arg_13_2)
	arg_13_0:dispatchEvent(AssassinEvent.OnHeroUpdate, {
		[var_13_0] = var_13_0
	})
end

function var_0_0.updateEnemies(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_1 then
		return
	end

	local var_14_0 = {}

	AssassinStealthGameModel.instance:updateEnemyDataByList(arg_14_1)

	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		local var_14_1 = iter_14_1.uid

		var_14_0[var_14_1] = var_14_1

		AssassinStealthGameEntityMgr.instance:refreshEnemyEntity(var_14_1, arg_14_2)
	end

	arg_14_0:dispatchEvent(AssassinEvent.OnEnemyUpdate, var_14_0)
end

function var_0_0.updateEnemy(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_1 then
		return
	end

	local var_15_0 = arg_15_1.uid

	AssassinStealthGameModel.instance:updateEnemyData(arg_15_1)
	AssassinStealthGameEntityMgr.instance:refreshEnemyEntity(var_15_0, arg_15_2)
	arg_15_0:dispatchEvent(AssassinEvent.OnEnemyUpdate, {
		uid = var_15_0
	})
end

function var_0_0.clickHeroEntity(arg_16_0, arg_16_1, arg_16_2)
	if AssassinStealthGameHelper.isSelectedHeroCanUseSkillPropToHero(arg_16_1) then
		arg_16_0:_useSkillProp(arg_16_1)

		return
	end

	if AssassinStealthGameHelper.isCanSelectHero(arg_16_1) then
		arg_16_0:selectHero(arg_16_1, arg_16_2)
	end
end

function var_0_0.selectHero(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = AssassinStealthGameModel.instance:getSelectedHero()

	if var_17_0 and var_17_0 == arg_17_1 then
		arg_17_1 = nil
	end

	AssassinStealthGameModel.instance:setIsShowHeroHighlight(false)
	AssassinStealthGameModel.instance:setSelectedHero(arg_17_1)
	arg_17_0:selectEnemy()
	arg_17_0:selectSkillProp()
	AssassinStealthGameEntityMgr.instance:refreshAllHeroEntities()
	AssassinStealthGameEntityMgr.instance:refreshAllGrid()
	arg_17_0:dispatchEvent(AssassinEvent.OnStealthGameSelectHero, {
		lastSelectedHeroUid = var_17_0,
		needFocus = arg_17_2
	})
end

function var_0_0.clickEnemyEntity(arg_18_0, arg_18_1)
	if AssassinStealthGameHelper.isSelectedHeroCanUseSkillPropToEnemy(arg_18_1) then
		arg_18_0:_useSkillProp(arg_18_1)

		return
	end

	if AssassinStealthGameHelper.isSelectedHeroCanRemoveEnemyBody(arg_18_1) then
		arg_18_0:_handleEnemyBody(arg_18_1)

		return
	end

	if AssassinStealthGameHelper.isSelectedHeroCanSelectEnemy(arg_18_1) then
		arg_18_0:selectEnemy(arg_18_1)
	end
end

function var_0_0.selectEnemy(arg_19_0, arg_19_1)
	local var_19_0 = AssassinStealthGameModel.instance:getSelectedEnemy()

	if var_19_0 and var_19_0 == arg_19_1 then
		arg_19_1 = nil
	end

	AssassinStealthGameModel.instance:setSelectedEnemy(arg_19_1)

	if arg_19_1 then
		AssassinStealthGameEntityMgr.instance:refreshEnemyEntity(arg_19_1)
	end

	arg_19_0:dispatchEvent(AssassinEvent.OnStealthGameSelectEnemy, var_19_0)
end

function var_0_0.clickGridItem(arg_20_0, arg_20_1, arg_20_2)
	if AssassinStealthGameHelper.isSelectedHeroCanUseSkillPropToGrid(arg_20_1) then
		arg_20_0:_useSkillProp(arg_20_1)

		return
	end

	if AssassinStealthGameHelper.isSelectedHeroCanMoveTo(arg_20_1, arg_20_2) then
		arg_20_0:_heroMove(arg_20_1, arg_20_2)

		return
	end
end

function var_0_0.clickSkillProp(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = AssassinStealthGameModel.instance:getSelectedHero()

	if not AssassinStealthGameHelper.isCanUseSkillProp(var_21_0, arg_21_1, arg_21_2) then
		return
	end

	if AssassinConfig.instance:getSkillPropTargetType(arg_21_1, arg_21_2) ~= AssassinEnum.SkillPropTargetType.None then
		arg_21_0:selectSkillProp(arg_21_1, arg_21_2)
	else
		arg_21_0:_useSkillProp(nil, arg_21_1, arg_21_2)
	end
end

function var_0_0.selectSkillProp(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0, var_22_1 = AssassinStealthGameModel.instance:getSelectedSkillProp()

	if var_22_0 == arg_22_1 and arg_22_2 == var_22_1 then
		arg_22_1 = nil
		arg_22_2 = nil
	end

	AssassinStealthGameModel.instance:setSelectedSkillProp(arg_22_1, arg_22_2)
	AssassinStealthGameEntityMgr.instance:refreshAllGrid()
	AssassinStealthGameEntityMgr.instance:refreshAllHeroEntities()
	AssassinStealthGameEntityMgr.instance:refreshAllEnemyEntities()
	arg_22_0:dispatchEvent(AssassinEvent.OnSelectSkillProp, arg_22_3)
end

function var_0_0.heroInteract(arg_23_0)
	local var_23_0 = AssassinStealthGameModel.instance:getSelectedHeroGameMo()

	if not var_23_0 then
		return
	end

	local var_23_1 = var_23_0:getActionPoint()
	local var_23_2 = var_23_0:getPos()
	local var_23_3 = AssassinStealthGameModel.instance:getGridInteractId(var_23_2)

	if var_23_1 < AssassinConfig.instance:getInteractApCost(var_23_3) then
		GameFacade.showToast(ToastEnum.AssassinStealthApNotEnough)

		return
	end

	local var_23_4 = var_23_0:getUid()

	AssassinSceneRpc.instance:sendHeroInteractiveRequest(var_23_4, var_23_3, arg_23_0._onHeroInteract, arg_23_0)
end

function var_0_0.playerEndTurn(arg_24_0)
	if not AssassinStealthGameModel.instance:isPlayerTurn() then
		return
	end

	AssassinStealthGameModel.instance:setIsPlayerTurn(false)

	local var_24_0 = AssassinStealthGameModel.instance:getRound()

	AssassinSceneRpc.instance:sendFinishUserTurnRequest(var_24_0, arg_24_0._onEndPlayerTurn, arg_24_0)
end

function var_0_0._useSkillProp(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0
	local var_25_1
	local var_25_2 = AssassinStealthGameModel.instance:getSelectedHero()

	if arg_25_1 then
		var_25_0, var_25_1 = AssassinStealthGameModel.instance:getSelectedSkillProp()
	else
		arg_25_1 = var_25_2
		var_25_0 = arg_25_2
		var_25_1 = arg_25_3
	end

	if var_25_1 then
		AssassinSceneRpc.instance:sendAssassinUseSkillRequest(var_25_2, arg_25_1, arg_25_0._onUseSkill, arg_25_0)
	else
		AssassinSceneRpc.instance:sendUseAssassinItemRequest(var_25_2, var_25_0, arg_25_1, arg_25_0._onUseItem, arg_25_0)
	end

	arg_25_0:selectSkillProp()
end

function var_0_0._onUseSkill(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	if arg_26_2 ~= 0 then
		return
	end

	local var_26_0 = false
	local var_26_1 = AssassinStealthGameModel.instance:getHeroMo(arg_26_3.uid, true)
	local var_26_2 = var_26_1 and var_26_1:getActiveSkillId()
	local var_26_3 = AssassinConfig.instance:getAssassinSkillTargetEff(var_26_2)
	local var_26_4 = arg_26_3.grid

	if var_26_2 == AssassinEnum.Skill.LightGrid then
		if var_26_4 and #var_26_4 > 0 then
			var_26_0 = true

			arg_26_0:updateGrids(var_26_4, var_26_3)
		end
	else
		arg_26_0:updateGrids(var_26_4)
	end

	if var_26_2 == AssassinEnum.Skill.CureAll then
		var_26_0 = true

		arg_26_0:updateHeroes(arg_26_3.hero, var_26_3)
	else
		arg_26_0:updateHeroes(arg_26_3.hero)
	end

	if var_26_2 == AssassinEnum.Skill.Petrifaction then
		var_26_0 = true

		arg_26_0:updateEnemies(arg_26_3.monster, var_26_3)
	else
		arg_26_0:updateEnemies(arg_26_3.monster)
	end

	arg_26_0:changeAlertLevel(arg_26_3.alertLevel)

	local var_26_5 = arg_26_3.delMonsterUid

	if var_26_5 then
		for iter_26_0, iter_26_1 in ipairs(var_26_5) do
			if iter_26_1 and iter_26_1 > 0 then
				AssassinStealthGameModel.instance:removeEnemyData(iter_26_1)
				AssassinStealthGameEntityMgr.instance:removeEnemyEntity(iter_26_1)
			end
		end
	end

	AssassinStealthGameEntityMgr.instance:refreshAllGrid()
	AssassinStealthGameEntityMgr.instance:refreshAllEnemyEntities()

	if not var_26_0 then
		local var_26_6 = arg_26_3.targetId
		local var_26_7 = AssassinConfig.instance:getSkillPropTargetType(var_26_2, true)

		if var_26_7 == AssassinEnum.SkillPropTargetType.None or var_26_7 == AssassinEnum.SkillPropTargetType.Hero then
			AssassinStealthGameEntityMgr.instance:playHeroEff(var_26_6, var_26_3)
		elseif var_26_7 == AssassinEnum.SkillPropTargetType.Enemy then
			AssassinStealthGameEntityMgr.instance:playEnemyEff(var_26_6, var_26_3)
		elseif var_26_7 == AssassinEnum.SkillPropTargetType.Grid then
			if var_26_2 == AssassinEnum.Skill.Transfer then
				AssassinStealthGameEntityMgr.instance:playHeroEff(arg_26_3.uid, var_26_3)
			else
				AssassinStealthGameEntityMgr.instance:playGridEff(var_26_6, var_26_3)
			end
		end
	end

	arg_26_0:dispatchEvent(AssassinEvent.OnUseSkillProp)
end

function var_0_0._onUseItem(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	if arg_27_2 ~= 0 then
		return
	end

	local var_27_0 = false
	local var_27_1 = arg_27_3.itemId
	local var_27_2 = AssassinConfig.instance:getAssassinItemTargetEff(var_27_1)
	local var_27_3 = AssassinConfig.instance:getAssassinItemType(var_27_1)

	arg_27_0:updateGrid(arg_27_3.grid)
	arg_27_0:updateHeroes(arg_27_3.hero)

	if var_27_3 == AssassinEnum.ItemType.PoisonKnife then
		var_27_0 = true

		arg_27_0:updateEnemies(arg_27_3.monster, var_27_2)
	else
		arg_27_0:updateEnemies(arg_27_3.monster)
	end

	AssassinStealthGameEntityMgr.instance:refreshAllGrid()
	AssassinStealthGameEntityMgr.instance:refreshAllEnemyEntities()

	if not var_27_0 then
		local var_27_4 = arg_27_3.targetId
		local var_27_5 = AssassinConfig.instance:getSkillPropTargetType(var_27_1)

		if var_27_5 == AssassinEnum.SkillPropTargetType.None or var_27_5 == AssassinEnum.SkillPropTargetType.Hero then
			AssassinStealthGameEntityMgr.instance:playHeroEff(var_27_4, var_27_2)
		elseif var_27_5 == AssassinEnum.SkillPropTargetType.Enemy then
			AssassinStealthGameEntityMgr.instance:playEnemyEff(var_27_4, var_27_2)
		elseif var_27_5 == AssassinEnum.SkillPropTargetType.Grid then
			AssassinStealthGameEntityMgr.instance:playHeroEff(arg_27_3.uid, var_27_2)
		end
	end

	arg_27_0:dispatchEvent(AssassinEvent.OnUseSkillProp)
end

function var_0_0._onHeroInteract(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	if arg_28_2 ~= 0 then
		return
	end

	arg_28_0:updateHero(arg_28_3.hero)
	AssassinStealthGameModel.instance:setFinishedInteractive(arg_28_3.interactiveId)
	AssassinStealthGameEntityMgr.instance:refreshAllGrid()
	AssassinStealthGameEntityMgr.instance:refreshAllEnemyEntities()
	arg_28_0:dispatchEvent(AssassinEvent.OnQTEInteractUpdate)
end

function var_0_0._onEndPlayerTurn(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	if arg_29_2 ~= 0 then
		return
	end

	arg_29_0:changeAlertLevel(arg_29_3.alertLevel)
	AssassinStealthGameModel.instance:setGridDataByList(arg_29_3.grid)
	AssassinStealthGameModel.instance:setEnemyOperationData(arg_29_3)
	arg_29_0:_startEnemyOperationFlow()
	arg_29_0:dispatchEvent(AssassinEvent.OnPlayerEndTurn)
end

function var_0_0._heroMove(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = AssassinStealthGameModel.instance:getSelectedHero()
	local var_30_1 = AssassinStealthGameHelper.getSelectedHeroMoveActId(arg_30_1, arg_30_2)
	local var_30_2 = arg_30_1
	local var_30_3 = var_30_1 == AssassinEnum.HeroAct.LeaveHide

	if var_30_1 == AssassinEnum.HeroAct.Hide or var_30_3 then
		if var_30_3 then
			var_30_2 = AssassinStealthGameModel.instance:getGridEmptyPointIndex(arg_30_1)

			if not var_30_2 then
				return
			end
		else
			var_30_2 = arg_30_2
		end
	elseif var_30_1 == AssassinEnum.HeroAct.ClimbTower or var_30_1 == AssassinEnum.HeroAct.Jump then
		var_30_2 = string.format("%s#%s", arg_30_1, arg_30_2)
	end

	arg_30_0:dispatchEvent(AssassinEvent.ShowHeroActImg, var_30_1, {
		actId = var_30_1,
		selectedHeroUid = var_30_0,
		param = tostring(var_30_2 or "")
	})
end

function var_0_0.heroAttack(arg_31_0, arg_31_1)
	if not arg_31_1 then
		return
	end

	local var_31_0 = AssassinStealthGameModel.instance:getSelectedHeroGameMo()

	if not var_31_0 then
		return
	end

	if var_31_0:getActionPoint() < AssassinConfig.instance:getAssassinActPower(arg_31_1) then
		GameFacade.showToast(ToastEnum.AssassinStealthApNotEnough)

		return
	end

	local var_31_1 = var_31_0:getUid()
	local var_31_2 = AssassinStealthGameModel.instance:getSelectedEnemy()

	arg_31_0:selectEnemy()
	arg_31_0:dispatchEvent(AssassinEvent.ShowHeroActImg, arg_31_1, {
		actId = arg_31_1,
		heroUid = var_31_1,
		enemyUid = var_31_2
	})
end

function var_0_0.heroAssassinate(arg_32_0, arg_32_1)
	if not arg_32_1 then
		return
	end

	local var_32_0 = AssassinStealthGameModel.instance:getSelectedHeroGameMo()
	local var_32_1 = AssassinStealthGameModel.instance:getSelectedEnemyGameMo()

	if not var_32_0 or not var_32_1 then
		return
	end

	if var_32_0:getActionPoint() < AssassinConfig.instance:getAssassinActPower(arg_32_1) then
		GameFacade.showToast(ToastEnum.AssassinStealthApNotEnough)

		return
	end

	local var_32_2 = var_32_1:getUid()
	local var_32_3 = var_32_0:getUid()
	local var_32_4 = tostring(var_32_2)

	if arg_32_1 == AssassinEnum.HeroAct.AirAssassinate then
		local var_32_5 = var_32_1:getPos()

		var_32_4 = string.format("%s#%s", var_32_5, var_32_2)
	end

	arg_32_0:selectEnemy()
	arg_32_0:dispatchEvent(AssassinEvent.ShowHeroActImg, arg_32_1, {
		actId = arg_32_1,
		heroUid = var_32_3,
		param = var_32_4
	})
end

function var_0_0._handleEnemyBody(arg_33_0, arg_33_1)
	local var_33_0 = AssassinStealthGameModel.instance:getSelectedHero()

	arg_33_0:dispatchEvent(AssassinEvent.ShowHeroActImg, AssassinEnum.HeroAct.HandleBody, {
		actId = AssassinEnum.HeroAct.HandleBody,
		selectedHeroUid = var_33_0,
		param = tostring(arg_33_1)
	})
end

function var_0_0.showActImgFinish(arg_34_0, arg_34_1, arg_34_2)
	if not arg_34_1 or not arg_34_2 then
		return
	end

	local var_34_0 = AssassinEnum.HeroAct

	if arg_34_1 == var_34_0.Move or arg_34_1 == var_34_0.Hide or arg_34_1 == var_34_0.LeaveHide or arg_34_1 == var_34_0.ClimbTower or arg_34_1 == var_34_0.LeaveTower or arg_34_1 == var_34_0.Jump then
		AssassinSceneRpc.instance:sendHeroMoveRequest(arg_34_2.selectedHeroUid, arg_34_1, arg_34_2.param, arg_34_0._onHeroMove, arg_34_0)
	elseif arg_34_1 == var_34_0.Attack or arg_34_1 == var_34_0.AttackTogether or arg_34_1 == var_34_0.Ambush or arg_34_1 == var_34_0.AmbushTogether then
		local var_34_1, var_34_2 = AssassinConfig.instance:getAssassinActEffect(arg_34_1)

		AssassinStealthGameEntityMgr.instance:playEnemyEff(arg_34_2.enemyUid, var_34_2, arg_34_0._afterAttackEffect, arg_34_0, arg_34_2, AssassinEnum.BlockKey.PlayAttackEff)
	elseif arg_34_1 == var_34_0.Assassinate or arg_34_1 == var_34_0.AirAssassinate or arg_34_1 == var_34_0.HideAssassinate then
		AssassinSceneRpc.instance:sendHeroAssassinRequest(arg_34_2.heroUid, arg_34_1, arg_34_2.param, arg_34_0._onHeroAssassinate, arg_34_0)
	elseif arg_34_1 == var_34_0.HandleBody then
		AssassinSceneRpc.instance:sendHeroAssassinRequest(arg_34_2.selectedHeroUid, arg_34_1, arg_34_2.param, arg_34_0._onHandleEnemyBody, arg_34_0)
	else
		logError(string.format("AssassinStealthGameController:showActImgFinish error, not support act:%s", arg_34_1))
	end
end

function var_0_0._afterAttackEffect(arg_35_0, arg_35_1)
	AssassinSceneRpc.instance:sendHeroAttackRequest(arg_35_1.heroUid, arg_35_1.actId, arg_35_1.enemyUid, arg_35_0._onHeroAttack, arg_35_0)
end

function var_0_0._onHeroMove(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	if arg_36_2 ~= 0 then
		return
	end

	local var_36_0 = AssassinConfig.instance:getAssassinActEffect(arg_36_3.actId)
	local var_36_1 = arg_36_3.hero.uid
	local var_36_2 = arg_36_3.hero.gridId
	local var_36_3 = AssassinStealthGameModel.instance:getHeroMo(var_36_1, true)
	local var_36_4 = var_36_3 and var_36_3:getStatus()

	arg_36_0:updateHero(arg_36_3.hero, var_36_0)

	if arg_36_3.actId == AssassinEnum.HeroAct.Move then
		AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_heromove)
	end

	AssassinStealthGameModel.updateEnemyDataByList(arg_36_3.monster)

	for iter_36_0, iter_36_1 in ipairs(arg_36_3.moves) do
		local var_36_5 = iter_36_1.path[1]

		arg_36_0:enemyMove(iter_36_1.uid, var_36_5.gridId, var_36_5.pos)
	end

	AssassinStealthGameEntityMgr.instance:refreshAllEnemyEntities()
	AssassinStealthGameModel.instance:setGridDataByList(arg_36_3.grid)
	AssassinStealthGameEntityMgr.instance:refreshAllGrid()
	arg_36_0:changeAlertLevel(arg_36_3.alertLevel)

	if AssassinStealthGameHelper.isHeroCanBeScan(var_36_1, var_36_4, arg_36_3.actId) and AssassinStealthGameHelper.isGridEnemyWillScan(var_36_2) then
		local var_36_6 = var_36_3:getStatus()

		if var_36_6 == AssassinEnum.HeroStatus.Expose and var_36_4 ~= var_36_6 then
			AssassinStealthGameEntityMgr.instance:playGridScanEff(var_36_2, arg_36_0._playScanEffFinish, arg_36_0, {
				var_36_1
			})
		else
			AssassinStealthGameEntityMgr.instance:playGridScanEff(var_36_2, arg_36_0._playScanEffFinish, arg_36_0)
		end

		AssassinHelper.lockScreen(AssassinEnum.BlockKey.EnemyScanEffPlaying, true)
	end

	arg_36_0:dispatchEvent(AssassinEvent.OnHeroMove)
end

function var_0_0._playScanEffFinish(arg_37_0, arg_37_1)
	if arg_37_1 then
		arg_37_0:heroBeExposed(arg_37_1)
	end

	AssassinHelper.lockScreen(AssassinEnum.BlockKey.EnemyScanEffPlaying, false)
end

function var_0_0._onHeroAttack(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	if arg_38_2 ~= 0 then
		return
	end

	arg_38_0:_enterFight(arg_38_2, arg_38_3)
end

function var_0_0._onHeroAssassinate(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	if arg_39_2 ~= 0 then
		return
	end

	local var_39_0, var_39_1 = AssassinConfig.instance:getAssassinActEffect(arg_39_3.actId)

	arg_39_0:updateHero(arg_39_3.hero, var_39_0)
	arg_39_0:updateEnemies(arg_39_3.monster, var_39_1)

	local var_39_2 = arg_39_3.delMonsterUid

	if var_39_2 then
		for iter_39_0, iter_39_1 in ipairs(var_39_2) do
			if iter_39_1 and iter_39_1 > 0 then
				AssassinStealthGameModel.instance:removeEnemyData(iter_39_1)
				AssassinStealthGameEntityMgr.instance:removeEnemyEntity(iter_39_1)
			end
		end
	end

	AssassinStealthGameEntityMgr.instance:refreshAllGrid()
	AssassinStealthGameEntityMgr.instance:refreshAllEnemyEntities()
	arg_39_0:dispatchEvent(AssassinEvent.TriggerGuideAfterHeroAssassinate)
end

function var_0_0._onHandleEnemyBody(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	if arg_40_2 ~= 0 then
		return
	end

	arg_40_0:updateHero(arg_40_3.hero)
	arg_40_0:updateEnemies(arg_40_3.monster)

	local var_40_0 = arg_40_3.delMonsterUid

	if var_40_0 then
		for iter_40_0, iter_40_1 in ipairs(var_40_0) do
			if iter_40_1 and iter_40_1 > 0 then
				AssassinStealthGameModel.instance:removeEnemyData(iter_40_1)
				AssassinStealthGameEntityMgr.instance:removeEnemyEntity(iter_40_1)
			end
		end
	end
end

function var_0_0._clearEnemyFlow(arg_41_0)
	if arg_41_0._enemyOperationFlow then
		arg_41_0._enemyOperationFlow:unregisterDoneListener(arg_41_0._enemyOperationFlowDone, arg_41_0)
		arg_41_0._enemyOperationFlow:destroy()
	end

	arg_41_0._enemyOperationFlow = nil

	AssassinStealthGameModel.instance:setEnemyOperationData()
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.EnemyOperation, false)
end

function var_0_0._startEnemyOperationFlow(arg_42_0)
	if arg_42_0._enemyOperationFlow then
		logError("AssassinStealthGameController:_startEnemyOperationFlow error, already have flow")

		return
	end

	AssassinHelper.lockScreen(AssassinEnum.BlockKey.EnemyOperation, true)

	arg_42_0._enemyOperationFlow = FlowSequence.New()

	arg_42_0._enemyOperationFlow:addWork(StealthEnemyTurnBeginWork.New())
	arg_42_0._enemyOperationFlow:addWork(StealthEnemyBornWork.New())
	arg_42_0._enemyOperationFlow:addWork(StealthEnemyArcheryWork.New())
	arg_42_0._enemyOperationFlow:addWork(StealthEnemyMoveWork.New())
	arg_42_0._enemyOperationFlow:addWork(StealthEnemyDetectsWork.New())
	arg_42_0._enemyOperationFlow:addWork(StealthEnemyFightWork.New())
	arg_42_0._enemyOperationFlow:addWork(StealthEnemyTurnEndWork.New())
	arg_42_0._enemyOperationFlow:registerDoneListener(arg_42_0._enemyOperationFlowDone, arg_42_0)
	arg_42_0._enemyOperationFlow:start()
end

function var_0_0.enemyBornByList(arg_43_0, arg_43_1)
	for iter_43_0, iter_43_1 in ipairs(arg_43_1) do
		arg_43_0:enemyBorn(iter_43_1, true)
	end
end

function var_0_0.enemyBorn(arg_44_0, arg_44_1)
	AssassinStealthGameModel.instance:addEnemyData(arg_44_1)
	AssassinStealthGameEntityMgr.instance:addEnemyEntity(arg_44_1.uid)
end

function var_0_0.enemyMove(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
	AssassinStealthGameModel.instance:updateEnemyPos(arg_45_1, arg_45_2, arg_45_3)
	AssassinStealthGameEntityMgr.instance:refreshEnemyEntity(arg_45_1)
	AssassinStealthGameEntityMgr.instance:refreshGrid(arg_45_2)
end

function var_0_0.heroBeExposed(arg_46_0, arg_46_1)
	if not arg_46_1 or #arg_46_1 <= 0 then
		return
	end

	arg_46_0:dispatchEvent(AssassinEvent.ShowExposeTip, arg_46_1)
end

function var_0_0._enemyOperationFlowDone(arg_47_0, arg_47_1)
	arg_47_0:_clearEnemyFlow()

	if arg_47_0:checkGameState() then
		return
	end

	if arg_47_1 then
		arg_47_0:_beginNewRound()
	end

	AssassinStealthGameEntityMgr.instance:refreshAllGrid()
end

function var_0_0._beginNewRound(arg_48_0)
	local var_48_0 = AssassinStealthGameModel.instance:getRound()

	AssassinSceneRpc.instance:sendNextRoundRequest(var_48_0, arg_48_0._onBeginNewRound, arg_48_0)
end

function var_0_0.finishMission(arg_49_0)
	local var_49_0 = AssassinStealthGameModel.instance:getMissionId()

	AssassinSceneRpc.instance:sendFinishMissionRequest(var_49_0, arg_49_0._onFinishMission, arg_49_0)
end

function var_0_0.returnAssassinStealthGame(arg_50_0, arg_50_1, arg_50_2)
	if AssassinConfig.instance:getQuestType(arg_50_1) ~= AssassinEnum.QuestType.Stealth then
		logError(string.format("AssassinStealthGameOverView:returnAssassinStealthGame error, quest is not stealth, questId:%s", arg_50_1))

		return
	end

	local var_50_0

	if arg_50_1 then
		local var_50_1 = AssassinConfig.instance:getQuestParam(arg_50_1)

		var_50_0 = tonumber(var_50_1)
	else
		var_50_0 = AssassinStealthGameModel.instance:getMapId()
	end

	AssassinStealthGameModel.instance:setIsFightReturn(arg_50_2)
	AssassinSceneRpc.instance:sendReturnAssassinSceneRequest(var_50_0, arg_50_0._onReturnAssassinStealthGame, arg_50_0)
end

function var_0_0.recoverAssassinStealthGame(arg_51_0)
	local var_51_0 = AssassinStealthGameModel.instance:getMapId()

	if var_51_0 then
		AssassinSceneRpc.instance:sendRecoverSceneRequest(var_51_0, arg_51_0._onRecoverAssassinStealthGame, arg_51_0)
	end
end

function var_0_0.changeMap(arg_52_0, arg_52_1)
	AssassinSceneRpc.instance:sendAssassinChangeMapRequest(arg_52_1, arg_52_0._onChangeMap, arg_52_0)
end

function var_0_0.enterBattleGrid(arg_53_0, arg_53_1)
	if AssassinStealthGameModel.instance:getGameState() ~= AssassinEnum.GameState.InProgress then
		return
	end

	AssassinSceneRpc.instance:sendEnterBattleGridRequest(arg_53_1, arg_53_0._onEnterBattleGrid, arg_53_0)
end

function var_0_0.resetGame(arg_54_0)
	local var_54_0 = AssassinStealthGameModel.instance:getMapId()

	AssassinSceneRpc.instance:sendRestartAssassinSceneRequest(var_54_0, arg_54_0._onResetGame, arg_54_0)
end

function var_0_0.abandonGame(arg_55_0)
	local var_55_0 = AssassinStealthGameModel.instance:getMapId()

	AssassinSceneRpc.instance:sendGiveUpAssassinSceneRequest(var_55_0, arg_55_0._onAbandonGame, arg_55_0)
end

function var_0_0.exitGame(arg_56_0)
	ViewMgr.instance:closeView(ViewName.AssassinStealthGameView)
end

function var_0_0.changeAlertLevel(arg_57_0, arg_57_1)
	if not arg_57_1 then
		return
	end

	AssassinStealthGameModel.instance:setAlertLevel(arg_57_1)
	AssassinStealthGameEntityMgr.instance:refreshAllGrid()
	arg_57_0:dispatchEvent(AssassinEvent.OnChangeAlertLevel)
end

function var_0_0._onBeginNewRound(arg_58_0, arg_58_1, arg_58_2, arg_58_3)
	if arg_58_2 ~= 0 then
		return
	end

	AssassinStealthGameModel.instance:updateGameSceneDataOnNewRound(arg_58_3.scene)
	AssassinStealthGameModel.instance:setIsPlayerTurn(true)
	AssassinStealthGameEntityMgr.instance:refreshAllGrid()
	AssassinStealthGameEntityMgr.instance:refreshAllHeroEntities()
	AssassinStealthGameEntityMgr.instance:refreshAllEnemyEntities()
	arg_58_0:dispatchEvent(AssassinEvent.OnBeginNewRound)
end

function var_0_0._onFinishMission(arg_59_0, arg_59_1, arg_59_2, arg_59_3)
	if arg_59_2 ~= 0 then
		return
	end

	AssassinStealthGameModel.instance:setMissionData(arg_59_3.mission)
	AssassinStealthGameEntityMgr.instance:refreshAllGrid()
	AssassinStealthGameEntityMgr.instance:refreshAllEnemyEntities()
	arg_59_0:dispatchEvent(AssassinEvent.OnMissionChange)
end

function var_0_0._onReturnAssassinStealthGame(arg_60_0, arg_60_1, arg_60_2, arg_60_3)
	if arg_60_2 ~= 0 then
		return
	end

	local var_60_0 = AssassinStealthGameModel.instance:getIsFightReturn()

	AssassinStealthGameModel.instance:setIsFightReturn()

	local var_60_1, var_60_2, var_60_3 = AssassinStealthGameModel.instance:getMapPosRecordOnFight()

	AssassinStealthGameModel.instance:setMapPosRecordOnFight()
	arg_60_0:_initGameData(arg_60_3.scene)

	local var_60_4 = AssassinStealthGameModel.instance:getNeedNextRound()

	if var_60_4 and var_60_4 ~= 0 then
		var_60_1, var_60_2, var_60_3 = AssassinStealthGameModel.instance:getMapPosRecordOnTurn()

		AssassinStealthGameModel.instance:setMapPosRecordOnTurn()
	end

	ViewMgr.instance:openView(ViewName.AssassinStealthGameView, {
		fightReturn = var_60_0,
		mapPosX = var_60_1,
		mapPosY = var_60_2,
		mapScale = var_60_3
	})
end

function var_0_0._onRecoverAssassinStealthGame(arg_61_0, arg_61_1, arg_61_2, arg_61_3)
	if arg_61_2 ~= 0 then
		return
	end

	arg_61_0:sendSettleTrack(StatEnum.Result2Cn[StatEnum.Result.BackTrace], true)
	arg_61_0:_initGameData(arg_61_3.scene)
	AssassinStealthGameEntityMgr.instance:setupMap()
	arg_61_0:dispatchEvent(AssassinEvent.OnGameSceneRecover)
end

function var_0_0._onChangeMap(arg_62_0, arg_62_1, arg_62_2, arg_62_3)
	if arg_62_2 ~= 0 then
		return
	end

	arg_62_0:_clearEnemyFlow()
	arg_62_0:_initGameData(arg_62_3.scene)
	AssassinStealthGameEntityMgr.instance:setupMap()
	arg_62_0:dispatchEvent(AssassinEvent.OnGameChangeMap)
end

function var_0_0._onEnterBattleGrid(arg_63_0, arg_63_1, arg_63_2, arg_63_3)
	if arg_63_2 ~= 0 then
		return
	end

	arg_63_0:_enterFight(arg_63_2, arg_63_3)
end

function var_0_0._enterFight(arg_64_0, arg_64_1, arg_64_2)
	arg_64_0:dispatchEvent(AssassinEvent.BeforeEnterFight)

	local var_64_0 = arg_64_2.fight.episodeId
	local var_64_1 = DungeonConfig.instance:getEpisodeCO(var_64_0).chapterId

	DungeonModel.instance:SetSendChapterEpisodeId(var_64_1, var_64_0)
	FightController.instance:setFightParamByEpisodeId(var_64_0):setDungeon(var_64_1, var_64_0)
	DungeonFightController.instance:onReceiveStartDungeonReply(arg_64_1, arg_64_2)
end

function var_0_0._onResetGame(arg_65_0, arg_65_1, arg_65_2, arg_65_3)
	if arg_65_2 ~= 0 then
		return
	end

	arg_65_0:sendSettleTrack(StatEnum.Result2Cn[StatEnum.Result.Reset], true)
	arg_65_0:_initGameData(arg_65_3.scene)
	AssassinStealthGameEntityMgr.instance:setupMap()
	arg_65_0:dispatchEvent(AssassinEvent.OnGameSceneRestart)
end

function var_0_0._onAbandonGame(arg_66_0, arg_66_1, arg_66_2, arg_66_3)
	if arg_66_2 ~= 0 then
		return
	end

	arg_66_0:sendSettleTrack(StatEnum.Result2Cn[StatEnum.Result.Abort])
	arg_66_0:exitGame()
end

function var_0_0.onGameViewDestroy(arg_67_0)
	arg_67_0:_clearEnemyFlow()
	AssassinStealthGameEffectMgr.instance:dispose()
	AssassinStealthGameEntityMgr.instance:clearAll()
	AssassinStealthGameModel.instance:clearAll()
	AssassinController.instance:getAssassinOutsideInfo()
end

function var_0_0.sendSettleTrack(arg_68_0, arg_68_1, arg_68_2)
	if not arg_68_0._gameStartTime then
		return
	end

	local var_68_0 = AssassinStealthGameModel.instance:getMapId()
	local var_68_1 = AssassinConfig.instance:getStealthMapTitle(var_68_0)
	local var_68_2 = AssassinStealthGameModel.instance:getRound()
	local var_68_3 = {}
	local var_68_4 = {}
	local var_68_5 = AssassinStealthGameModel.instance:getHeroUidList()

	for iter_68_0, iter_68_1 in ipairs(var_68_5) do
		local var_68_6 = AssassinStealthGameModel.instance:getHeroMo(iter_68_1, true)

		if var_68_6 then
			local var_68_7 = var_68_6:getHeroId()
			local var_68_8 = AssassinHeroModel.instance:getAssassinHeroName(var_68_7)

			var_68_3[#var_68_3 + 1] = var_68_8

			local var_68_9 = {
				name = var_68_8,
				career = var_68_6:getCareerId(),
				item = var_68_6:getItemIdList(),
				remaining_hp = var_68_6:getHp()
			}

			var_68_4[#var_68_4 + 1] = var_68_9
		end
	end

	local var_68_10 = {}
	local var_68_11 = AssassinOutsideModel.instance:getBuildingMapMo()

	if var_68_11 then
		for iter_68_2, iter_68_3 in pairs(AssassinEnum.BuildingType) do
			local var_68_12 = var_68_11:getBuildingMo(iter_68_3)

			if var_68_12 then
				local var_68_13 = var_68_12:getConfig()
				local var_68_14 = {
					name = var_68_13 and var_68_13.title or "",
					level = var_68_12:getLv()
				}

				var_68_10[#var_68_10 + 1] = var_68_14
			end
		end
	end

	StatController.instance:track(StatEnum.EventName.S01StealthGame, {
		[StatEnum.EventProperties.MapId] = tostring(var_68_0),
		[StatEnum.EventProperties.MapName] = var_68_1,
		[StatEnum.EventProperties.Result] = arg_68_1,
		[StatEnum.EventProperties.TotalRound] = var_68_2,
		[StatEnum.EventProperties.UseTime] = UnityEngine.Time.realtimeSinceStartup - arg_68_0._gameStartTime,
		[StatEnum.EventProperties.StealthGame_HeroGroup] = var_68_3,
		[StatEnum.EventProperties.StealthGame_HeroGroupArray] = var_68_4,
		[StatEnum.EventProperties.StealthGame_BuildingInfo] = var_68_10
	})

	if arg_68_2 then
		arg_68_0._gameStartTime = UnityEngine.Time.realtimeSinceStartup
	else
		arg_68_0._gameStartTime = nil
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
