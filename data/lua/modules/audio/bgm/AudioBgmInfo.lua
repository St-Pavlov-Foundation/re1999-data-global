module("modules.audio.bgm.AudioBgmInfo", package.seeall)

local var_0_0 = class("AudioBgmInfo")

function var_0_0.ctor(arg_1_0)
	arg_1_0._bgmDatas = {}
	arg_1_0._bgmUsageSceneMap = {}
	arg_1_0._bgmUsageViewMap = {}
	arg_1_0._bgmBindMap = {}

	arg_1_0:_initBgmDatas()
	arg_1_0:_initBgmUsage()
	arg_1_0:_initBgmBind()
end

function var_0_0._initBgmDatas(arg_2_0)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.Main, AudioEnum.UI.Resume_MainMusic, AudioEnum.UI.Pause_MainMusic)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.PushBox, AudioEnum.Bgm.PushBox, AudioEnum.Story.Stop_PlotMusic)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.Explore, AudioEnum.Bgm.play_ui_secretroom_music, AudioEnum.UI.Stop_UIMusic)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.Dungeon, AudioEnum.UI.Play_UI_Slippage_Music, AudioEnum.UI.Stop_UIMusic)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.Character, AudioEnum.UI.Play_UI_Unsatisfied_Music, AudioEnum.UI.Stop_UIMusic)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.LeiMiTeBei, AudioEnum.Bgm.LeiMiTeBeiBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.LeiMiTeBeiDungeon, AudioEnum.Bgm.LeiMiTeBeiDungeonBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.Bp, AudioEnum.Bgm.PlayPassPortMusic, AudioEnum.Bgm.StopPassPortMusic)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.DungeonWeekWalk, AudioEnum.WeekWalk.play_artificial_layer_type_1, AudioEnum.UI.Stop_UI_noise)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.ChessGame, AudioEnum.Bgm.ChessGameBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.Meilanni, AudioEnum.Bgm.play_activitymusic_humorousburglary_74bpm4_4, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.Season, AudioEnum.Bgm.LeiMiTeBeiDungeonBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.HandbookSkin, AudioEnum.Bgm.HandbookSkinBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.DungeonAmbientSound, 0, 0)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.WeekWalk, 0, 0)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.Summon, 0, 0)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.Fight, 0, 0)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_4MusicFree, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivityVideoView, 0, 0)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.Story, 0, 0)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_2Main, AudioEnum.Bgm.ActivityMainBgm1_2, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.JieXiKa, AudioEnum.Bgm.JieXiKaBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.YaXian, AudioEnum.Bgm.YaXianBgm1_2, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.Season1_2, AudioEnum.Bgm.Season1_2Bgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_3Main, AudioEnum.Bgm.ActivityMainBgm1_3, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_3DungeonAmbientSound, 0, 0)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.Season1_3, AudioEnum.Bgm.play_activitymusic_indiastargazing_theme_1_3, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_3ArmPipe, AudioEnum.Bgm.play_activitymusic_indialively_1_3, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_3Act307, AudioEnum.Bgm.play_activitymusic_indialively_1_3_2, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_3Act304, AudioEnum.Bgm.Activity1_3ChessMapViewBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_3Act120, AudioEnum.Bgm.play_activitymusic_indiastargazing_theme_1_3_act120, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.Season1_4, AudioEnum.Bgm.play_plot_music_comfortable, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.RoleStoryActivity, AudioEnum.Story.play_plot_music_dailyemotion, AudioEnum.Story.Stop_PlotMusic)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_4Main, AudioEnum.Bgm.play_activitymusic_themesong1_4, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.TokenStore, AudioEnum.Bgm.play_activitymusic_tokenstore1_4, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.TaskAndCollected, AudioEnum.Bgm.play_activitymusic_mission1_4, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_4Act130, AudioEnum.Bgm.Activity130LevelViewBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_4Act131, AudioEnum.Bgm.Activity131LevelViewBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_4Act136, AudioEnum.Bgm.Activity136ViewBgm, AudioEnum.UI.Stop_UIMusic)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.Season1_5, AudioEnum.Bgm.play_activitymusic_seasonmain_1_5, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_5Main, AudioEnum.Bgm.ActivityMainBgm1_5, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.Activity142, AudioEnum.Bgm.Activity142Bgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.V1a5AiZiLa, AudioEnum.Bgm.V1a5AiZiLaBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_6Main, AudioEnum.Bgm.Act1_6DungeonBgm1, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_6Dungeon, AudioEnum.Bgm.Act1_6DungeonBgm1, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.Act_QuNiang, AudioEnum.Bgm.role_activity_quniang, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.Act_GeTian, AudioEnum.Bgm.role_activity_getian, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.Cachot, AudioEnum.Bgm.CachotMainScene, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_7Main, AudioEnum.Bgm.Act1_7DungeonBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_8Main, AudioEnum.Bgm.Act1_8DungeonBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_8Dungeon, AudioEnum.Bgm.Act1_8DungeonBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_9Main, AudioEnum.Bgm.Act1_9DungeonBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.Act_Lucy, AudioEnum.Bgm.role_activity_lucy, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.Act_KaKaNia, AudioEnum.Bgm.role_activity_kakania, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_9SemmelWeisGift, AudioEnum.Bgm.SemmelWeisGift, AudioEnum.UI.Stop_UIMusic)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.ToughBattle, AudioEnum.Bgm.ToughBattle, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.FairyLand, AudioEnum.Bgm.FairyLand, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.HeroInvitation, AudioEnum.Bgm.HeroInvitation, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.RougeFavorite, AudioEnum.Bgm.RougeFavorite, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.RougeMain, AudioEnum.Bgm.RougeMain, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.RougeScene, 0, 0)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_0Main, AudioEnum.Bgm.Act2_0DungeonBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.Act_Joe, AudioEnum.Bgm.role_activity_joe, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.Act_Mercuria, AudioEnum.Bgm.role_activity_mercuria, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.V2a0_WarmUp, AudioEnum.Bgm.play_ui_feichi_noise_yure_20200116, AudioEnum.Bgm.stop_ui_feichi_noise_yure_20200117)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_1Main, AudioEnum.Bgm.Act2_1DungeonBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.V2a1_WarmUp, AudioEnum.Bgm.play_ui_preheat_2_1_music_20211601, AudioEnum.Bgm.stop_ui_preheat_2_1_music_20211602)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.Act_Aergusi, AudioEnum.Bgm.Act2_1_Aergusi, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.Act_LanShouPa, AudioEnum.Bgm.Act2_1_LanShouPa, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_2Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.InvestigateRoleStory, AudioEnum.Bgm.play_activitymusic_sadness, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.NormalBattleV2_2, AudioEnum.Bgm.play_battle_youyui_2_2_normalfight, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.BossBattleV2_2, AudioEnum.Bgm.play_battle_youyui_2_2_bossfight, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.InvestigateView, AudioEnum.VersionActivity2_2Investigate.play_ui_youyu_survey_scene_loop, AudioEnum.UI.Stop_UI_Bus)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_3Main, AudioEnum.Bgm.Act2_3DungeonBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.Tower, AudioEnum.TowerBgm.play_replay_music_towermain_2_3, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.LinkageActivity_FullView, AudioEnum.Bgm.ui_shenghuo_discovery_amb_20234001, AudioEnum.Bgm.stop_ui_bus_2000048)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.V2a3_WarmUp, AudioEnum.Bgm.play_ui_shenghuo_preheat_amb_20234003, AudioEnum.Bgm.stop_ui_bus_2000048)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_4Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_4Act178Game, AudioEnum.Act178.bgm_game, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_4WuErLiXi, AudioEnum.WuErLiXi.bgm_wuerliximap, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_4WuErLiXiGame, AudioEnum.WuErLiXi.bgm_wuerliximapgame, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_5Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.AutoChess, AudioEnum.Bgm.play_autochess, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_6Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_6_DiceHero, AudioEnum2_6.DiceHero.Bgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_6_DiceHero_Game, AudioEnum2_6.DiceHero.Bgm_Game, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_7Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_9Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_9Stealth, AudioEnum2_9.StealthGameBgm.StealthGameBgm, AudioEnum2_9.StealthGameBgm.StealthGameStopBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_8Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_8DungeonBoss, AudioEnum2_8.DungeonBgm.boss, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.SurvivalBGM, AudioEnum2_8.Survival.play_activitymusic_dl_state_2_8, AudioEnum2_8.Survival.stop_activitymusic_dl_state_2_8)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.ShelterBGM, AudioEnum2_8.Survival.play_activitymusic_dl_camp_2_8, AudioEnum2_8.Survival.stop_activitymusic_dl_camp_2_8)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity3_0Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.CommanStationEnterView, AudioEnum3_0.Bgm.play_ui_zhihuisuo_music, AudioEnum.UI.Stop_UIMusic)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity3_0MainAmbientSound, 0, 0)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.VersionActivity3_1Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	arg_2_0:_addBgmData(AudioBgmEnum.Layer.NecrologistStoryView, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
end

function var_0_0._initBgmUsage(arg_3_0)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.Main
	}, AudioBgmEnum.UsageType.Scene, {
		SceneType.Main
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.Explore
	}, AudioBgmEnum.UsageType.Scene, {
		SceneType.Explore
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.PushBox
	}, AudioBgmEnum.UsageType.Scene, {
		SceneType.PushBox
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.Fight
	}, AudioBgmEnum.UsageType.Scene, {
		SceneType.Fight
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.Cachot
	}, AudioBgmEnum.UsageType.Scene, {
		SceneType.Cachot
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.Story
	}, AudioBgmEnum.UsageType.View, {
		ViewName.StoryView
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.Dungeon
	}, AudioBgmEnum.UsageType.View, {
		ViewName.DungeonMapView
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.DungeonWeekWalk
	}, AudioBgmEnum.UsageType.View, {
		ViewName.WeekWalkLayerView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.Dungeon,
		AudioBgmEnum.Layer.DungeonWeekWalk
	}, AudioBgmEnum.UsageType.View, {
		ViewName.DungeonView
	}, DungeonController.queryBgm, nil)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivityVideoView
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivityVideoView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.Character
	}, AudioBgmEnum.UsageType.View, {
		ViewName.WeekWalkCharacterView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.Character
	}, AudioBgmEnum.UsageType.View, {
		ViewName.CharacterBackpackView,
		ViewName.CharacterView,
		ViewName.CharacterRankUpView,
		ViewName.CharacterTalentView,
		ViewName.CharacterExSkillView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.LeiMiTeBei
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivityEnterView,
		ViewName.VersionActivityExchangeView,
		ViewName.Permanent1_1EnterView
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.LeiMiTeBeiDungeon
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivityDungeonMapView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.Meilanni
	}, AudioBgmEnum.UsageType.View, {
		ViewName.MeilanniMainView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.Bp
	}, AudioBgmEnum.UsageType.View, {
		ViewName.BpView,
		ViewName.BpSPView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.Summon
	}, AudioBgmEnum.UsageType.View, {
		ViewName.SummonView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.ChessGame
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Activity109ChessEntry
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.WeekWalk
	}, AudioBgmEnum.UsageType.View, {
		ViewName.WeekWalkView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.Season
	}, AudioBgmEnum.UsageType.View, {
		ViewName.SeasonMainView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.HandbookSkin
	}, AudioBgmEnum.UsageType.View, {
		ViewName.HandbookSkinView
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_2Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity1_2EnterView,
		ViewName.VersionActivity1_2DungeonView,
		ViewName.Permanent1_2EnterView
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.YaXian
	}, AudioBgmEnum.UsageType.View, {
		ViewName.YaXianMapView
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.JieXiKa
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Activity114View
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.Season1_2
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Season1_2MainView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_3Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity1_3EnterView,
		ViewName.VersionActivity1_3DungeonMapView,
		ViewName.Permanent1_3EnterView
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.Season1_3
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Season1_3MainView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_3ArmPipe
	}, AudioBgmEnum.UsageType.View, {
		ViewName.ArmMainView,
		ViewName.ArmRewardView,
		ViewName.ArmPuzzlePipeView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_3Act307
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Activity1_3_119View
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_3Act304
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Activity1_3ChessMapView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_3Act120
	}, AudioBgmEnum.UsageType.View, {
		ViewName.JiaLaBoNaMapView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.Season1_4
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Season1_4MainView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.RoleStoryActivity
	}, AudioBgmEnum.UsageType.View, {
		ViewName.RoleStoryActivityMainView,
		ViewName.RoleStoryDispatchMainView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_4Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity1_4EnterView,
		ViewName.Permanent1_4EnterView
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.TokenStore
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Activity129View
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.TaskAndCollected
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity1_4TaskView,
		ViewName.Activity132CollectView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_4Act130
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Activity130LevelView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_4Act131
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Activity131LevelView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_4Act136
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Activity136View
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_5Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity1_5EnterView,
		ViewName.Permanent1_5EnterView
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.Season1_5
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Season1_5MainView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.Activity142
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Activity142MapView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.V1a5AiZiLa
	}, AudioBgmEnum.UsageType.View, {
		ViewName.AiZiLaMapView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_6Dungeon
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity1_6DungeonMapView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_6Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity1_6EnterView,
		ViewName.Permanent1_6EnterView
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.Act_QuNiang
	}, AudioBgmEnum.UsageType.View, {
		ViewName.ActQuNiangLevelView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.Act_GeTian
	}, AudioBgmEnum.UsageType.View, {
		ViewName.ActGeTianLevelView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_7Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity1_7EnterView,
		ViewName.Permanent1_7EnterView
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_8Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity1_8EnterView,
		ViewName.Permanent1_8EnterView
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_8Dungeon
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity1_8DungeonMapView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_9Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity1_9EnterView,
		ViewName.Permanent1_9EnterView
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.Act_Lucy
	}, AudioBgmEnum.UsageType.View, {
		ViewName.ActLucyLevelView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.Act_KaKaNia
	}, AudioBgmEnum.UsageType.View, {
		ViewName.ActKaKaNiaLevelView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_9SemmelWeisGift
	}, AudioBgmEnum.UsageType.View, {
		ViewName.SemmelWeisGiftView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.ToughBattle
	}, AudioBgmEnum.UsageType.View, {
		ViewName.ToughBattleEnterView,
		ViewName.ToughBattleActEnterView,
		ViewName.ToughBattleMapView,
		ViewName.ToughBattleActMapView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.FairyLand
	}, AudioBgmEnum.UsageType.View, {
		ViewName.FairyLandView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.HeroInvitation
	}, AudioBgmEnum.UsageType.View, {
		ViewName.HeroInvitationDungeonMapView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.RougeFavorite
	}, AudioBgmEnum.UsageType.View, {
		ViewName.RougeFavoriteView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.RougeMain
	}, AudioBgmEnum.UsageType.View, {
		ViewName.RougeMainView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.RougeScene
	}, AudioBgmEnum.UsageType.Scene, {
		SceneType.Rouge
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_0Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity2_0EnterView,
		ViewName.Permanent2_0EnterView
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.Act_Joe
	}, AudioBgmEnum.UsageType.View, {
		ViewName.ActJoeLevelView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.Act_Mercuria
	}, AudioBgmEnum.UsageType.View, {
		ViewName.ActMercuriaLevelView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.V2a0_WarmUp
	}, AudioBgmEnum.UsageType.View, {
		ViewName.V2a0_WarmUp
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_1Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity2_1EnterView,
		ViewName.Permanent2_1EnterView
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.V2a1_WarmUp
	}, AudioBgmEnum.UsageType.View, {
		ViewName.V2a1_WarmUp
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.Act_Aergusi
	}, AudioBgmEnum.UsageType.View, {
		ViewName.AergusiLevelView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.Act_LanShouPa
	}, AudioBgmEnum.UsageType.View, {
		ViewName.LanShouPaMapView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_2Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity2_2EnterView
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.InvestigateRoleStory
	}, AudioBgmEnum.UsageType.View, {
		ViewName.InvestigateRoleStoryView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.InvestigateView
	}, AudioBgmEnum.UsageType.View, {
		ViewName.InvestigateView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.NormalBattleV2_2,
		AudioBgmEnum.Layer.BossBattleV2_2
	}, AudioBgmEnum.UsageType.View, {
		ViewName.EliminateLevelView,
		ViewName.EliminateSelectRoleView,
		ViewName.EliminateSelectChessMenView
	}, EliminateLevelController.queryBgm, nil)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_3Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity2_3EnterView,
		ViewName.V2a3_ReactivityEnterview
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.Tower
	}, AudioBgmEnum.UsageType.View, {
		ViewName.TowerMainView,
		ViewName.TowerMainEntryView
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.LinkageActivity_FullView
	}, AudioBgmEnum.UsageType.View, {
		ViewName.LinkageActivity_FullView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.V2a3_WarmUp
	}, AudioBgmEnum.UsageType.View, {
		ViewName.V2a3_WarmUp
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_4MusicFree
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity2_4MusicFreeView,
		ViewName.VersionActivity2_4MusicBeatView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_4Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity2_4EnterView
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_4Act178Game
	}, AudioBgmEnum.UsageType.View, {
		ViewName.PinballGameView
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_4WuErLiXiGame
	}, AudioBgmEnum.UsageType.View, {
		ViewName.WuErLiXiGameView
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_4WuErLiXi
	}, AudioBgmEnum.UsageType.View, {
		ViewName.WuErLiXiLevelView
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_5Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity2_5EnterView
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.AutoChess
	}, AudioBgmEnum.UsageType.View, {
		ViewName.AutoChessMainView
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_6Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity2_6EnterView
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_6_DiceHero
	}, AudioBgmEnum.UsageType.View, {
		ViewName.DiceHeroMainView
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_6_DiceHero_Game
	}, AudioBgmEnum.UsageType.View, {
		ViewName.DiceHeroGameView
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_7Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity2_7EnterView
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_9Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity2_9EnterView
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_9Stealth
	}, AudioBgmEnum.UsageType.View, {
		ViewName.AssassinStealthGameView
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_8Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity2_8EnterView
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_8DungeonBoss
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity2_8BossStoryEnterView,
		ViewName.VersionActivity2_8BossActEnterView
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.SurvivalBGM
	}, AudioBgmEnum.UsageType.Scene, {
		SceneType.Survival
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.ShelterBGM
	}, AudioBgmEnum.UsageType.Scene, {
		SceneType.SurvivalShelter
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.ShelterBGM
	}, AudioBgmEnum.UsageType.Scene, {
		SceneType.SurvivalSummaryAct
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity3_0Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity3_0EnterView
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.CommanStationEnterView
	}, AudioBgmEnum.UsageType.View, {
		ViewName.CommandStationEnterView,
		ViewName.CommandStationMapView
	})
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity3_1Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity3_1EnterView
	}, nil, nil, true)
	arg_3_0:_addBgmUsage({
		AudioBgmEnum.Layer.NecrologistStoryView
	}, AudioBgmEnum.UsageType.View, {
		ViewName.NecrologistStoryView
	}, nil, nil, true)
end

function var_0_0._initBgmBind(arg_4_0)
	arg_4_0:_addBgmBind(AudioBgmEnum.Layer.Dungeon, {
		AudioBgmEnum.Layer.DungeonAmbientSound
	})
	arg_4_0:_addBgmBind(AudioBgmEnum.Layer.VersionActivity1_3Main, {
		AudioBgmEnum.Layer.VersionActivity1_3DungeonAmbientSound
	})
	arg_4_0:_addBgmBind(AudioBgmEnum.Layer.VersionActivity3_0Main, {
		AudioBgmEnum.Layer.VersionActivity3_0MainAmbientSound
	})
end

function var_0_0._addBgmBind(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._bgmBindMap[arg_5_1] = arg_5_2
end

function var_0_0._addBgmUsage(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6)
	local var_6_0 = AudioBgmUsage.New()

	var_6_0.layerList = arg_6_1
	var_6_0.type = arg_6_2
	var_6_0.typeParam = arg_6_3
	var_6_0.queryFunc = arg_6_4
	var_6_0.queryFuncTarget = arg_6_5
	var_6_0.clearPauseBgm = arg_6_6

	local var_6_1

	if arg_6_2 == AudioBgmEnum.UsageType.Scene then
		var_6_1 = arg_6_0._bgmUsageSceneMap
	elseif arg_6_2 == AudioBgmEnum.UsageType.View then
		var_6_1 = arg_6_0._bgmUsageViewMap
	end

	for iter_6_0, iter_6_1 in ipairs(arg_6_3) do
		if var_6_1[iter_6_1] then
			logError(string.format("AudioBgmInfo:_addBgmUsage typeParam:%s 重复设置了", iter_6_1))
		end

		var_6_1[iter_6_1] = var_6_0
	end

	return var_6_0
end

function var_0_0._addBgmData(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6, arg_7_7)
	if not arg_7_0._bgmDatas[arg_7_1] then
		local var_7_0 = AudioBgmData.New()

		arg_7_0._bgmDatas[arg_7_1] = var_7_0
		var_7_0.layer = arg_7_1
		var_7_0.playId = arg_7_2
		var_7_0.stopId = arg_7_3
		var_7_0.pauseId = arg_7_5
		var_7_0.resumeId = arg_7_4
		var_7_0.switchGroup = arg_7_6
		var_7_0.switchState = arg_7_7

		if AudioMgr.instance:useDefaultBGM() and var_7_0.layer ~= AudioBgmEnum.Layer.Fight then
			var_7_0.playId = AudioEnum.Default_UI_Bgm
			var_7_0.stopId = AudioEnum.Default_UI_Bgm_Stop
		end
	end
end

function var_0_0.modifyBgmData(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6, arg_8_7)
	local var_8_0 = arg_8_0._bgmDatas[arg_8_1]

	if not var_8_0 then
		var_8_0 = AudioBgmData.New()
		arg_8_0._bgmDatas[arg_8_1] = var_8_0
	end

	var_8_0.playId = arg_8_2
	var_8_0.stopId = arg_8_3
	var_8_0.resumeId = arg_8_4
	var_8_0.pauseId = arg_8_5
	var_8_0.switchGroup = arg_8_6
	var_8_0.switchState = arg_8_7
end

function var_0_0.modifyBgmAudioId(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0._bgmDatas[arg_9_1]

	if not var_9_0 or var_9_0.playId == arg_9_2 then
		return false
	end

	var_9_0.playId = arg_9_2

	return true
end

function var_0_0.removeBgm(arg_10_0, arg_10_1)
	arg_10_0._bgmDatas[arg_10_1] = nil
end

function var_0_0.clearBgm(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._bgmDatas[arg_11_1]

	if not var_11_0 then
		return
	end

	var_11_0:clear()
end

function var_0_0.getBgmData(arg_12_0, arg_12_1)
	return arg_12_0._bgmDatas[arg_12_1]
end

function var_0_0.getViewBgmUsage(arg_13_0, arg_13_1)
	return arg_13_0._bgmUsageViewMap[arg_13_1]
end

function var_0_0.getSceneBgmUsage(arg_14_0, arg_14_1)
	return arg_14_0._bgmUsageSceneMap[arg_14_1]
end

function var_0_0.getBindList(arg_15_0, arg_15_1)
	return arg_15_0._bgmBindMap[arg_15_1]
end

return var_0_0
