module("modules.logic.versionactivity2_8.dungeonboss.view.VersionActivity2_8BossActDungeonMapView", package.seeall)

local var_0_0 = class("VersionActivity2_8BossActDungeonMapView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goroot = gohelper.findChild(arg_1_0.viewGO, "#go_mapenter")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0.onOpenView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0.onCloseViewFinish, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, arg_2_0.setEpisodeListVisible, arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_2_0.onRefreshActivityState, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_2_0._onUpdateDungeonInfo, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, arg_2_0._loadSceneFinish, arg_2_0)
end

function var_0_0._loadSceneFinish(arg_3_0, arg_3_1)
	arg_3_0.mapCfg = arg_3_1[1]
	arg_3_0.sceneGo = arg_3_1[2]
	arg_3_0.mapScene = arg_3_1[3]

	arg_3_0:_onRainEffectLoaded()
end

function var_0_0._initRainEffect(arg_4_0)
	if arg_4_0.chapterId ~= DungeonEnum.ChapterId.Main1_10 then
		return
	end

	if arg_4_0._rainEffectLoader then
		arg_4_0:_onRainEffectLoaded()

		return
	end

	arg_4_0._rainEffectLoader = MultiAbLoader.New()

	local var_4_0 = "scenes/common/vx_prefabs/vx_v2a8_rain.prefab"

	arg_4_0._rainEffectLoader:addPath(var_4_0)
	arg_4_0._rainEffectLoader:startLoad(arg_4_0._onRainEffectLoaded, arg_4_0)
end

function var_0_0._onRainEffectLoaded(arg_5_0)
	if not arg_5_0._rainEffectLoader or arg_5_0._rainEffectLoader.isLoading or gohelper.isNil(arg_5_0.sceneGo) then
		return
	end

	if not (arg_5_0.mapCfg.id >= VersionActivity2_8BossEnum.RainMap.minId) or not (arg_5_0.mapCfg.id <= VersionActivity2_8BossEnum.RainMap.maxId) then
		return
	end

	if not DungeonModel.instance:hasPassLevelAndStory(VersionActivity2_8BossEnum.RainEffectEpisodeId) then
		return
	end

	local var_5_0 = gohelper.findChild(arg_5_0.sceneGo, "SceneEffect")
	local var_5_1 = "vx_v2a8_rain"
	local var_5_2 = var_5_0.transform
	local var_5_3 = var_5_2.childCount

	for iter_5_0 = 1, var_5_3 do
		if var_5_2:GetChild(iter_5_0 - 1).name == var_5_1 then
			return
		end
	end

	local var_5_4 = arg_5_0._rainEffectLoader:getFirstAssetItem():GetResource()

	gohelper.clone(var_5_4, var_5_0, var_5_1)
end

function var_0_0.removeEvents(arg_6_0)
	return
end

function var_0_0._initBtn(arg_7_0)
	if arg_7_0._loader then
		return
	end

	local var_7_0 = "ui/viewres/versionactivity_2_8/v2a8_dungeon/v2a8_dungeonmapenteritem.prefab"

	arg_7_0._loader = PrefabInstantiate.Create(arg_7_0._goroot)

	arg_7_0._loader:startLoad(var_7_0, arg_7_0._onResLoaded, arg_7_0)
end

function var_0_0._onResLoaded(arg_8_0)
	arg_8_0._btnGo = arg_8_0._loader:getInstGO()
	arg_8_0._btnEnter = gohelper.findChildButtonWithAudio(arg_8_0._btnGo, "#btn_enter")

	arg_8_0._btnEnter:AddClickListener(arg_8_0.onClickEnter, arg_8_0)

	arg_8_0._gored = gohelper.findChild(arg_8_0._btnGo, "#btn_enter/#go_reddot")
	arg_8_0._anim = arg_8_0._btnGo:GetComponent("Animator")

	arg_8_0:refreshView()
end

function var_0_0.refreshView(arg_9_0)
	arg_9_0.chapterId = arg_9_0.viewParam.chapterId

	arg_9_0:onActStateChange()

	if arg_9_0._gored then
		RedDotController.instance:addRedDot(arg_9_0._gored, RedDotEnum.DotNode.V2a8DungeonBossAct)
	end

	if ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView) then
		arg_9_0:_playAnim("close", 0, 1)
	else
		arg_9_0:_playAnim("open", 0, 0)
	end
end

function var_0_0._playAnim(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_0._anim then
		arg_10_0._anim:Play(arg_10_1, arg_10_2, arg_10_3)
	end
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0:refreshView()
	arg_11_0:_openBgm()
	arg_11_0:_initRainEffect()
end

function var_0_0.onUpdateParam(arg_12_0)
	arg_12_0:refreshView()
end

function var_0_0.onOpenView(arg_13_0, arg_13_1)
	if arg_13_1 == ViewName.DungeonMapLevelView then
		arg_13_0:_playAnim("close", 0, 0)
	end
end

function var_0_0.onCloseViewFinish(arg_14_0, arg_14_1)
	if arg_14_1 == ViewName.DungeonMapLevelView then
		arg_14_0:_playAnim("open", 0, 0)
	end
end

function var_0_0.setEpisodeListVisible(arg_15_0, arg_15_1)
	if arg_15_1 and arg_15_0._showRoot then
		arg_15_0:_playAnim("open", 0, 0)
	else
		arg_15_0:_playAnim("close", 0, 0)
	end
end

function var_0_0.onRefreshActivityState(arg_16_0)
	arg_16_0:_checkShowRoot()
end

function var_0_0._checkShowRoot(arg_17_0)
	arg_17_0._showRoot = arg_17_0:_isShowRoot()

	if arg_17_0._showRoot then
		arg_17_0:_initBtn()
		gohelper.setActive(arg_17_0._goroot, true)
	else
		gohelper.setActive(arg_17_0._goroot, false)
	end
end

function var_0_0._isShowRoot(arg_18_0)
	if arg_18_0.chapterId ~= DungeonEnum.ChapterId.Main1_10 then
		return false
	end

	if not (ActivityHelper.getActivityStatus(VersionActivity2_8Enum.ActivityId.DungeonBoss) == ActivityEnum.ActivityStatus.Normal) then
		return false
	end

	return OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.V2a8BossAct)
end

function var_0_0.onActStateChange(arg_19_0)
	arg_19_0:_checkShowRoot()
end

function var_0_0.onClickEnter(arg_20_0)
	ViewMgr.instance:openView(ViewName.VersionActivity2_8BossActEnterView)
end

function var_0_0.onClose(arg_21_0)
	if arg_21_0._loader then
		arg_21_0._loader:dispose()

		arg_21_0._loader = nil
	end

	if arg_21_0._rainEffectLoader then
		arg_21_0._rainEffectLoader:dispose()

		arg_21_0._rainEffectLoader = nil
	end

	if arg_21_0._btnEnter then
		arg_21_0._btnEnter:RemoveClickListener()
	end

	arg_21_0:_closeBgm()
end

function var_0_0._onUpdateDungeonInfo(arg_22_0)
	arg_22_0:_onRainEffectLoaded()

	if arg_22_0._isFinishChapter then
		return
	end

	arg_22_0:_checkShowRoot()

	if DungeonModel.instance:chapterIsPass(DungeonEnum.ChapterId.Main1_10) then
		arg_22_0:_openBgm()
	end
end

function var_0_0._openBgm(arg_23_0)
	if arg_23_0.chapterId ~= DungeonEnum.ChapterId.Main1_10 then
		return
	end

	arg_23_0._isFinishChapter = DungeonModel.instance:chapterIsPass(DungeonEnum.ChapterId.Main1_10)

	if arg_23_0._isFinishChapter then
		AudioBgmManager.instance:setSwitchData(AudioBgmEnum.Layer.Dungeon, "music_vocal_filter", "accompaniment")

		if not AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.Dungeon, AudioEnum2_8.DungeonBgm.dungeonMapView_2) and AudioBgmManager.instance:getCurPlayingId() == AudioEnum2_8.DungeonBgm.dungeonMapView_2 and arg_23_0._isFinishChapter then
			AudioBgmManager.instance:setSwitch(AudioBgmEnum.Layer.Dungeon)
		end

		AudioBgmManager.instance:setStopId(AudioBgmEnum.Layer.Dungeon, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)

		return
	end

	AudioBgmManager.instance:setSwitchData(AudioBgmEnum.Layer.Dungeon)
	AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.Dungeon, AudioEnum2_8.DungeonBgm.dungeonMapView_1)
	AudioBgmManager.instance:setStopId(AudioBgmEnum.Layer.Dungeon, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
end

function var_0_0._closeBgm(arg_24_0)
	if arg_24_0.chapterId ~= DungeonEnum.ChapterId.Main1_10 then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.VersionActivity2_8EnterView) and not ViewMgr.instance:isOpen(ViewName.DungeonView) then
		if DungeonModel.instance:chapterIsPass(DungeonEnum.ChapterId.Main1_10) then
			AudioBgmManager.instance:setSwitchData(AudioBgmEnum.Layer.Dungeon, "music_vocal_filter", "original")
			AudioBgmManager.instance:setSwitch(AudioBgmEnum.Layer.Dungeon)
		end

		return
	end

	AudioBgmManager.instance:setSwitchData(AudioBgmEnum.Layer.Dungeon)
	AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.Dungeon, AudioEnum.UI.Play_UI_Slippage_Music)
	AudioBgmManager.instance:setStopId(AudioBgmEnum.Layer.Dungeon, AudioEnum.UI.Stop_UIMusic)
end

return var_0_0
