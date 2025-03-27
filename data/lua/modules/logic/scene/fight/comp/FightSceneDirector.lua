module("modules.logic.scene.fight.comp.FightSceneDirector", package.seeall)

slot0 = class("FightSceneDirector", BaseSceneComp)
slot0.MinTime = 2

function slot0.onInit(slot0)
	slot0._scene = slot0:getCurScene()
end

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0._sceneId = slot1

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

	slot0._hasLoadScene = false
	slot0._hasPreload = false
	slot0._fightLoadingView = true
	slot0._startTime = Time.realtimeSinceStartup

	slot0._scene.level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, slot0._onLevelLoaded, slot0)
	slot0._scene.preloader:registerCallback(FightSceneEvent.OnPreloadFinish, slot0._onPreloadFinish, slot0)
	slot0._scene.preloader:startPreload(false)

	slot0._sceneStartTime = Time.time
end

function slot0.registRespBeginFight(slot0)
	FightController.instance:registerCallback(FightEvent.RespBeginFight, slot0._respBeginFight, slot0)
end

function slot0.onSceneClose(slot0)
	TaskDispatcher.cancelTask(slot0._delayStart, slot0)
	TaskDispatcher.cancelTask(slot0._delayCloseFightLoadingView, slot0)
	SpineFpsMgr.instance:remove(SpineFpsMgr.FightScene)
	slot0._scene.level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, slot0._onLevelLoaded, slot0)
	slot0._scene.preloader:unregisterCallback(FightSceneEvent.OnPreloadFinish, slot0._onPreloadFinish, slot0)
	FightController.instance:unregisterCallback(FightEvent.RespBeginFight, slot0._respBeginFight, slot0)
	slot0._scene.preloader:unregisterCallback(FightSceneEvent.OnPreloadFinish, slot0._onPrepareFinish, slot0)
end

function slot0._onLevelLoaded(slot0, slot1)
	slot0._scene.level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, slot0._onLevelLoaded, slot0)

	slot0._hasLoadScene = true

	slot0:_log("场景")

	if GuideController.instance:isForbidGuides() or GuideModel.instance:isGuideFinish(GuideController.FirstGuideId) then
		module_views_preloader.FightLoadingView(function ()
			ViewMgr.instance:openView(ViewName.FightLoadingView, uv0._sceneId, true)
			GameSceneMgr.instance:hideLoading(SceneType.Fight)

			uv0._fightLoadingView = false

			TaskDispatcher.runDelay(uv0._delayCloseFightLoadingView, uv0, uv1.MinTime - (Time.time - uv0._sceneStartTime + 0.6) > 0 and slot1 or 0.1)
		end)
	end

	slot0:_checkPrepared()
end

function slot0._delayCloseFightLoadingView(slot0)
	slot0._fightLoadingView = true

	slot0:_checkPrepared()
end

function slot0._onPreloadFinish(slot0)
	slot0._scene.preloader:unregisterCallback(FightSceneEvent.OnPreloadFinish, slot0._onPreloadFinish, slot0)

	slot0._hasPreload = true

	slot0:_log("资源")
	slot0:_checkPrepared()
end

function slot0._respBeginFight(slot0)
	FightController.instance:unregisterCallback(FightEvent.RespBeginFight, slot0._respBeginFight, slot0)

	if FightModel.instance:getFightParam().isReplay then
		FightReplayController.instance:reqReplay(slot0._continuePreload, slot0)
	else
		slot0:_continuePreload()
	end
end

function slot0._continuePreload(slot0)
	slot0._scene.preloader:registerCallback(FightSceneEvent.OnPreloadFinish, slot0._onPrepareFinish, slot0)

	slot0._startTime = Time.realtimeSinceStartup

	slot0._scene.preloader:startPreload(true)
end

function slot0._checkPrepared(slot0)
	if slot0._hasPreload and slot0._hasLoadScene and slot0._fightLoadingView then
		if FightModel.instance:getFightParam().preload then
			slot0._scene.previewEntityMgr:spawnEntity()

			if SeasonFightHandler.checkSeasonAndOpenGroupFightView(slot1, DungeonConfig.instance:getEpisodeCO(slot1.episodeId)) then
				-- Nothing
			elseif slot2.type == DungeonEnum.EpisodeType.Cachot then
				V1a6_CachotHeroGroupController.instance:openGroupFightView(slot1.battleId, slot1.episodeId)
			elseif slot2.type == DungeonEnum.EpisodeType.Rouge then
				RougeHeroGroupController.instance:openGroupFightView(slot1.battleId, slot1.episodeId)
			else
				HeroGroupController.instance:openGroupFightView(slot1.battleId, slot1.episodeId, slot1.adventure)
			end

			slot0:registRespBeginFight()
		else
			if slot1.fightActType == FightEnum.FightActType.Act174 then
				slot0:registRespBeginFight()
				slot0:dispatchEvent(FightSceneEvent.OnPrepareFinish)

				slot2 = FightMsgMgr.sendMsg(FightMsgId.PlayDouQuQu)

				return
			end

			if slot1.isReplay or FightReplayModel.instance:isReconnectReplay() then
				FightReplayController.instance:reqReplay(function ()
					uv0._scene:onPrepared()
				end)
				FightReplayModel.instance:setReconnectReplay(false)
			else
				slot0._scene:onPrepared()
			end
		end

		slot0:dispatchEvent(FightSceneEvent.OnPrepareFinish)
	end
end

function slot0._onPrepareFinish(slot0)
	slot0._scene.preloader:unregisterCallback(FightSceneEvent.OnPreloadFinish, slot0._onPrepareFinish, slot0)
	slot0:_log("资源2")
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnHeroGroupExit)
	slot0._scene.previewEntityMgr:destroyEntity()
	TaskDispatcher.runDelay(slot0._delayStart, slot0, 0.4)
end

function slot0._delayStart(slot0)
	slot0._scene:onPrepared()
end

function slot0._log(slot0, slot1)
	slot3 = FightModel.instance:getFightParam() and slot2.episodeId
	slot4 = slot3 and lua_episode.configDict[slot3]

	logNormal(string.format("%s 战斗%s加载完成了，耗时%.3fs", slot4 and slot4.name or "", slot1, Time.realtimeSinceStartup - slot0._startTime))
end

return slot0
