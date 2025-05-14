module("modules.logic.scene.fight.comp.FightSceneDirector", package.seeall)

local var_0_0 = class("FightSceneDirector", BaseSceneComp)

var_0_0.MinTime = 2

function var_0_0.onInit(arg_1_0)
	arg_1_0._scene = arg_1_0:getCurScene()
end

function var_0_0.onSceneStart(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._sceneId = arg_2_1

	FightStrUtil.instance:init()
	FightSkillBehaviorMgr.instance:init()
	FightRenderOrderMgr.instance:init()
	FightNameMgr.instance:init()
	FightFloatMgr.instance:init()
	FightAudioMgr.instance:init()
	FightVideoMgr.instance:init()
	FightSkillMgr.instance:init()
	FightConfig.instance:_checkSkill()

	if PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewQuality, ModuleEnum.Performance.High) == ModuleEnum.Performance.High then
		SpineFpsMgr.instance:set(SpineFpsMgr.FightScene)
	end

	arg_2_0._hasLoadScene = false
	arg_2_0._hasPreload = false
	arg_2_0._fightLoadingView = true
	arg_2_0._startTime = Time.realtimeSinceStartup

	arg_2_0._scene.level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, arg_2_0._onLevelLoaded, arg_2_0)
	arg_2_0._scene.preloader:registerCallback(FightSceneEvent.OnPreloadFinish, arg_2_0._onPreloadFinish, arg_2_0)
	arg_2_0._scene.preloader:startPreload(false)

	arg_2_0._sceneStartTime = Time.time
end

function var_0_0.registRespBeginFight(arg_3_0)
	FightController.instance:registerCallback(FightEvent.RespBeginFight, arg_3_0._respBeginFight, arg_3_0)
end

function var_0_0.onSceneClose(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayStart, arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayCloseFightLoadingView, arg_4_0)
	SpineFpsMgr.instance:remove(SpineFpsMgr.FightScene)
	arg_4_0._scene.level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, arg_4_0._onLevelLoaded, arg_4_0)
	arg_4_0._scene.preloader:unregisterCallback(FightSceneEvent.OnPreloadFinish, arg_4_0._onPreloadFinish, arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.RespBeginFight, arg_4_0._respBeginFight, arg_4_0)
	arg_4_0._scene.preloader:unregisterCallback(FightSceneEvent.OnPreloadFinish, arg_4_0._onPrepareFinish, arg_4_0)
end

function var_0_0._onLevelLoaded(arg_5_0, arg_5_1)
	arg_5_0._scene.level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, arg_5_0._onLevelLoaded, arg_5_0)

	arg_5_0._hasLoadScene = true

	arg_5_0:_log("场景")

	if GuideController.instance:isForbidGuides() or GuideModel.instance:isGuideFinish(GuideController.FirstGuideId) then
		module_views_preloader.FightLoadingView(function()
			ViewMgr.instance:openView(ViewName.FightLoadingView, arg_5_0._sceneId, true)
			GameSceneMgr.instance:hideLoading(SceneType.Fight)

			arg_5_0._fightLoadingView = false

			local var_6_0 = Time.time - arg_5_0._sceneStartTime + 0.6
			local var_6_1 = var_0_0.MinTime - var_6_0
			local var_6_2 = var_6_1 > 0 and var_6_1 or 0.1

			TaskDispatcher.runDelay(arg_5_0._delayCloseFightLoadingView, arg_5_0, var_6_2)
		end)
	end

	arg_5_0:_checkPrepared()
end

function var_0_0._delayCloseFightLoadingView(arg_7_0)
	arg_7_0._fightLoadingView = true

	arg_7_0:_checkPrepared()
end

function var_0_0._onPreloadFinish(arg_8_0)
	arg_8_0._scene.preloader:unregisterCallback(FightSceneEvent.OnPreloadFinish, arg_8_0._onPreloadFinish, arg_8_0)

	arg_8_0._hasPreload = true

	arg_8_0:_log("资源")
	arg_8_0:_checkPrepared()
end

function var_0_0._respBeginFight(arg_9_0)
	FightController.instance:unregisterCallback(FightEvent.RespBeginFight, arg_9_0._respBeginFight, arg_9_0)

	if FightModel.instance:getFightParam().isReplay then
		FightReplayController.instance:reqReplay(arg_9_0._continuePreload, arg_9_0)
	else
		arg_9_0:_continuePreload()
	end
end

function var_0_0._continuePreload(arg_10_0)
	arg_10_0._scene.preloader:registerCallback(FightSceneEvent.OnPreloadFinish, arg_10_0._onPrepareFinish, arg_10_0)

	arg_10_0._startTime = Time.realtimeSinceStartup

	arg_10_0._scene.preloader:startPreload(true)
end

function var_0_0._checkPrepared(arg_11_0)
	if arg_11_0._hasPreload and arg_11_0._hasLoadScene and arg_11_0._fightLoadingView then
		local var_11_0 = FightModel.instance:getFightParam()

		if var_11_0.preload then
			arg_11_0._scene.previewEntityMgr:spawnEntity()

			local var_11_1 = DungeonConfig.instance:getEpisodeCO(var_11_0.episodeId)

			if SeasonFightHandler.checkSeasonAndOpenGroupFightView(var_11_0, var_11_1) then
				-- block empty
			elseif var_11_1.type == DungeonEnum.EpisodeType.Cachot then
				V1a6_CachotHeroGroupController.instance:openGroupFightView(var_11_0.battleId, var_11_0.episodeId)
			elseif var_11_1.type == DungeonEnum.EpisodeType.Rouge then
				RougeHeroGroupController.instance:openGroupFightView(var_11_0.battleId, var_11_0.episodeId)
			else
				HeroGroupController.instance:openGroupFightView(var_11_0.battleId, var_11_0.episodeId, var_11_0.adventure)
			end

			arg_11_0:registRespBeginFight()
		else
			if var_11_0.fightActType == FightEnum.FightActType.Act174 then
				arg_11_0:registRespBeginFight()
				arg_11_0:dispatchEvent(FightSceneEvent.OnPrepareFinish)

				local var_11_2 = FightMsgMgr.sendMsg(FightMsgId.PlayDouQuQu)

				return
			end

			if var_11_0.isReplay or FightReplayModel.instance:isReconnectReplay() then
				FightReplayController.instance:reqReplay(function()
					arg_11_0._scene:onPrepared()
				end)
				FightReplayModel.instance:setReconnectReplay(false)
			else
				arg_11_0._scene:onPrepared()
			end
		end

		arg_11_0:dispatchEvent(FightSceneEvent.OnPrepareFinish)
	end
end

function var_0_0._onPrepareFinish(arg_13_0)
	arg_13_0._scene.preloader:unregisterCallback(FightSceneEvent.OnPreloadFinish, arg_13_0._onPrepareFinish, arg_13_0)
	arg_13_0:_log("资源2")
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnHeroGroupExit)
	arg_13_0._scene.previewEntityMgr:destroyEntity()
	TaskDispatcher.runDelay(arg_13_0._delayStart, arg_13_0, 0.4)
end

function var_0_0._delayStart(arg_14_0)
	arg_14_0._scene:onPrepared()
end

function var_0_0._log(arg_15_0, arg_15_1)
	local var_15_0 = FightModel.instance:getFightParam()
	local var_15_1 = var_15_0 and var_15_0.episodeId
	local var_15_2 = var_15_1 and lua_episode.configDict[var_15_1]
	local var_15_3 = var_15_2 and var_15_2.name or ""

	logNormal(string.format("%s 战斗%s加载完成了，耗时%.3fs", var_15_3, arg_15_1, Time.realtimeSinceStartup - arg_15_0._startTime))
end

return var_0_0
