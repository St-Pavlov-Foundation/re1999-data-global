module("modules.logic.survival.controller.work.SurvivalSettleWeekPushWork", package.seeall)

local var_0_0 = class("SurvivalSettleWeekPushWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._msg = arg_1_1
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	SurvivalModel.instance:setSurvivalSettleInfo(arg_2_0._msg)

	local var_2_0 = SurvivalShelterModel.instance:getWeekInfo()

	if var_2_0 and var_2_0.intrudeBox and var_2_0.intrudeBox.fight and arg_2_0._msg.win then
		local var_2_1 = var_2_0.intrudeBox.fight
		local var_2_2 = var_2_1:isFighting()

		var_2_1:setWin()

		if var_2_2 then
			SurvivalShelterModel.instance:setNeedShowFightSuccess(true, var_2_1.fightId)
		end
	end

	UIBlockHelper.instance:endBlock(SurvivalEnum.SurvivalIntrudeAbandonBlock)

	local var_2_3 = GameSceneMgr.instance:getCurSceneType()
	local var_2_4 = GameSceneMgr.instance:getCurScene()

	if var_2_3 == SceneType.Fight then
		GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, arg_2_0._onEnterOneSceneFinish, arg_2_0)
	elseif var_2_3 == SceneType.SurvivalShelter then
		if GameSceneMgr.instance:isLoading() then
			GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, arg_2_0._onEnterOneSceneFinish, arg_2_0)
		else
			arg_2_0:_onEnterOneSceneFinish(var_2_3)
		end
	else
		arg_2_0:showSettle(true)
	end
end

function var_0_0._onEnterOneSceneFinish(arg_3_0, arg_3_1)
	if arg_3_1 ~= SceneType.SurvivalShelter then
		arg_3_0:showResultPanel(false)

		return
	end

	GameUtil.setActiveUIBlock("SurvivalSettleWeekPushWork", true, false)

	local var_3_0, var_3_1 = SurvivalShelterModel.instance:getNeedShowFightSuccess()

	if var_3_0 then
		SurvivalController.instance:registerCallback(SurvivalEvent.BossPerformFinish, arg_3_0._bossPerformFinish, arg_3_0)
	else
		arg_3_0:_bossPerformFinish()
	end
end

function var_0_0._bossPerformFinish(arg_4_0)
	SurvivalMapHelper.instance:hideUnitVisible(SurvivalEnum.ShelterUnitType.Npc, false)
	SurvivalMapHelper.instance:hideUnitVisible(SurvivalEnum.ShelterUnitType.Monster, false)
	SurvivalMapHelper.instance:refreshPlayerEntity()
	SurvivalMapHelper.instance:stopShelterPlayerMove()
	TaskDispatcher.runDelay(arg_4_0._tweenToPlayerPos, arg_4_0, 0.5)
end

function var_0_0._tweenToPlayerPos(arg_5_0)
	local var_5_0 = GameSceneMgr.instance:getCurScene()
	local var_5_1 = var_5_0 and var_5_0.unit and var_5_0.unit:getPlayer()

	if not var_5_1 then
		arg_5_0:showResultPanel(false)

		return
	end

	SurvivalController.instance:dispatchEvent(SurvivalEvent.ChangeCameraScale, 1, true)
	var_5_1:focusEntity(1, arg_5_0.playEntityAnim, arg_5_0)
end

function var_0_0.playEntityAnim(arg_6_0)
	local var_6_0 = GameSceneMgr.instance:getCurScene()
	local var_6_1 = var_6_0 and var_6_0.unit and var_6_0.unit:getPlayer()

	if not var_6_1 then
		arg_6_0:showResultPanel(false)

		return
	end

	local var_6_2 = SurvivalModel.instance:getSurvivalSettleInfo()

	if var_6_2 and var_6_2.win or false then
		var_6_1:playAnim("jump2")
		TaskDispatcher.runDelay(arg_6_0.onPlayerAnimFinish, arg_6_0, 1)
	else
		var_6_1:playAnim("die")
		TaskDispatcher.runDelay(arg_6_0.onPlayerAnimFinish, arg_6_0, 2)
	end
end

function var_0_0.onPlayerAnimFinish(arg_7_0)
	local var_7_0 = GameSceneMgr.instance:getCurScene()
	local var_7_1 = var_7_0 and var_7_0.unit and var_7_0.unit:getPlayer()
	local var_7_2 = SurvivalModel.instance:getSurvivalSettleInfo()

	if var_7_1 and (var_7_2 and var_7_2.win or false) then
		var_7_1:playAnim("idle")
	end

	if arg_7_0:isHideEnding() then
		local var_7_3 = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.StoryHiddenEnding)
		local var_7_4

		var_7_4 = tonumber(var_7_3) or 0

		if var_7_4 > 0 and not StoryModel.instance:isStoryFinished(var_7_4) then
			GameUtil.setActiveUIBlock("SurvivalSettleWeekPushWork", false, true)
			StoryController.instance:playStory(var_7_4, nil, arg_7_0._onStoryEnd, arg_7_0)
		else
			arg_7_0:showResultPanel(true)
		end

		return
	end

	arg_7_0:showResultPanel(true)
end

function var_0_0._onStoryEnd(arg_8_0)
	arg_8_0:showResultPanel(true)
end

function var_0_0.isHideEnding(arg_9_0)
	local var_9_0 = arg_9_0._msg.report

	if string.nilorempty(var_9_0) then
		return false
	end

	local var_9_1 = cjson.decode(var_9_0).endId
	local var_9_2 = lua_survival_end.configDict[var_9_1]

	return var_9_2 and var_9_2.type == 3
end

function var_0_0.showSettle(arg_10_0, arg_10_1)
	GameUtil.setActiveUIBlock("SurvivalSettleWeekPushWork", false, true)
	SurvivalController.instance:enterSurvivalSettle()
	arg_10_0:onDone(arg_10_1)
end

function var_0_0.showResultPanel(arg_11_0, arg_11_1)
	GameUtil.setActiveUIBlock("SurvivalSettleWeekPushWork", false, true)

	local var_11_0 = SurvivalModel.instance:getSurvivalSettleInfo()
	local var_11_1 = var_11_0 and var_11_0.win

	ViewMgr.instance:openView(ViewName.SurvivalShelterResultPanelView, {
		isWin = var_11_1
	})
	arg_11_0:onDone(arg_11_1)
end

function var_0_0.clearWork(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._tweenToPlayerPos, arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0.onPlayerAnimFinish, arg_12_0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, arg_12_0._onEnterOneSceneFinish, arg_12_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.BossPerformFinish, arg_12_0._bossPerformFinish, arg_12_0)
	SurvivalShelterModel.instance:setNeedShowFightSuccess(nil, nil)
end

return var_0_0
