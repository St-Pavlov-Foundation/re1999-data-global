module("modules.audio.bgm.AudioBgmInfo", package.seeall)

slot0 = class("AudioBgmInfo")

function slot0.ctor(slot0)
	slot0._bgmDatas = {}
	slot0._bgmUsageSceneMap = {}
	slot0._bgmUsageViewMap = {}
	slot0._bgmBindMap = {}

	slot0:_initBgmDatas()
	slot0:_initBgmUsage()
	slot0:_initBgmBind()
end

function slot0._initBgmDatas(slot0)
	slot0:_addBgmData(AudioBgmEnum.Layer.Main, AudioEnum.UI.Resume_MainMusic, AudioEnum.UI.Pause_MainMusic)
	slot0:_addBgmData(AudioBgmEnum.Layer.PushBox, AudioEnum.Bgm.PushBox, AudioEnum.Story.Stop_PlotMusic)
	slot0:_addBgmData(AudioBgmEnum.Layer.Explore, AudioEnum.Bgm.play_ui_secretroom_music, AudioEnum.UI.Stop_UIMusic)
	slot0:_addBgmData(AudioBgmEnum.Layer.Dungeon, AudioEnum.UI.Play_UI_Slippage_Music, AudioEnum.UI.Stop_UIMusic)
	slot0:_addBgmData(AudioBgmEnum.Layer.Character, AudioEnum.UI.Play_UI_Unsatisfied_Music, AudioEnum.UI.Stop_UIMusic)
	slot0:_addBgmData(AudioBgmEnum.Layer.LeiMiTeBei, AudioEnum.Bgm.LeiMiTeBeiBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.LeiMiTeBeiDungeon, AudioEnum.Bgm.LeiMiTeBeiDungeonBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.Bp, AudioEnum.Bgm.PlayPassPortMusic, AudioEnum.Bgm.StopPassPortMusic)
	slot0:_addBgmData(AudioBgmEnum.Layer.DungeonWeekWalk, AudioEnum.WeekWalk.play_artificial_layer_type_1, AudioEnum.UI.Stop_UI_noise)
	slot0:_addBgmData(AudioBgmEnum.Layer.ChessGame, AudioEnum.Bgm.ChessGameBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.Meilanni, AudioEnum.Bgm.play_activitymusic_humorousburglary_74bpm4_4, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.Season, AudioEnum.Bgm.LeiMiTeBeiDungeonBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.DungeonAmbientSound, 0, 0)
	slot0:_addBgmData(AudioBgmEnum.Layer.WeekWalk, 0, 0)
	slot0:_addBgmData(AudioBgmEnum.Layer.Summon, 0, 0)
	slot0:_addBgmData(AudioBgmEnum.Layer.Fight, 0, 0)
	slot0:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_4MusicFree, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.VersionActivityVideoView, 0, 0)
	slot0:_addBgmData(AudioBgmEnum.Layer.Story, 0, 0)
	slot0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_2Main, AudioEnum.Bgm.ActivityMainBgm1_2, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.JieXiKa, AudioEnum.Bgm.JieXiKaBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.YaXian, AudioEnum.Bgm.YaXianBgm1_2, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.Season1_2, AudioEnum.Bgm.Season1_2Bgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_3Main, AudioEnum.Bgm.ActivityMainBgm1_3, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_3DungeonAmbientSound, 0, 0)
	slot0:_addBgmData(AudioBgmEnum.Layer.Season1_3, AudioEnum.Bgm.play_activitymusic_indiastargazing_theme_1_3, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_3ArmPipe, AudioEnum.Bgm.play_activitymusic_indialively_1_3, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_3Act307, AudioEnum.Bgm.play_activitymusic_indialively_1_3_2, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_3Act304, AudioEnum.Bgm.Activity1_3ChessMapViewBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_3Act120, AudioEnum.Bgm.play_activitymusic_indiastargazing_theme_1_3_act120, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.Season1_4, AudioEnum.Bgm.play_plot_music_comfortable, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.RoleStoryActivity, AudioEnum.Story.play_plot_music_dailyemotion, AudioEnum.Story.Stop_PlotMusic)
	slot0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_4Main, AudioEnum.Bgm.play_activitymusic_themesong1_4, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.TokenStore, AudioEnum.Bgm.play_activitymusic_tokenstore1_4, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.TaskAndCollected, AudioEnum.Bgm.play_activitymusic_mission1_4, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_4Act130, AudioEnum.Bgm.Activity130LevelViewBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_4Act131, AudioEnum.Bgm.Activity131LevelViewBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_4Act136, AudioEnum.Bgm.Activity136ViewBgm, AudioEnum.UI.Stop_UIMusic)
	slot0:_addBgmData(AudioBgmEnum.Layer.Season1_5, AudioEnum.Bgm.play_activitymusic_seasonmain_1_5, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_5Main, AudioEnum.Bgm.ActivityMainBgm1_5, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.Activity142, AudioEnum.Bgm.Activity142Bgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.V1a5AiZiLa, AudioEnum.Bgm.V1a5AiZiLaBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_6Main, AudioEnum.Bgm.Act1_6DungeonBgm1, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_6Dungeon, AudioEnum.Bgm.Act1_6DungeonBgm1, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.Act_QuNiang, AudioEnum.Bgm.role_activity_quniang, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.Act_GeTian, AudioEnum.Bgm.role_activity_getian, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.Cachot, AudioEnum.Bgm.CachotMainScene, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_7Main, AudioEnum.Bgm.Act1_7DungeonBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_8Main, AudioEnum.Bgm.Act1_8DungeonBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_8Dungeon, AudioEnum.Bgm.Act1_8DungeonBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_9Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_9SemmelWeisGift, AudioEnum.Bgm.SemmelWeisGift, AudioEnum.UI.Stop_UIMusic)
	slot0:_addBgmData(AudioBgmEnum.Layer.ToughBattle, AudioEnum.Bgm.ToughBattle, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.FairyLand, AudioEnum.Bgm.FairyLand, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.HeroInvitation, AudioEnum.Bgm.HeroInvitation, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.RougeFavorite, AudioEnum.Bgm.RougeFavorite, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.RougeMain, AudioEnum.Bgm.RougeMain, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.RougeScene, 0, 0)
	slot0:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_0Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.V2a0_WarmUp, AudioEnum.Bgm.play_ui_feichi_noise_yure_20200116, AudioEnum.Bgm.stop_ui_feichi_noise_yure_20200117)
	slot0:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_1Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.V2a1_WarmUp, AudioEnum.Bgm.play_ui_preheat_2_1_music_20211601, AudioEnum.Bgm.stop_ui_preheat_2_1_music_20211602)
	slot0:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_2Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.InvestigateRoleStory, AudioEnum.Bgm.play_activitymusic_sadness, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.NormalBattleV2_2, AudioEnum.Bgm.play_battle_youyui_2_2_normalfight, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.BossBattleV2_2, AudioEnum.Bgm.play_battle_youyui_2_2_bossfight, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.InvestigateView, AudioEnum.VersionActivity2_2Investigate.play_ui_youyu_survey_scene_loop, AudioEnum.UI.Stop_UI_Bus)
	slot0:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_3Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.Tower, AudioEnum.TowerBgm.play_replay_music_towermain_2_3, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.LinkageActivity_FullView, AudioEnum.Bgm.ui_shenghuo_discovery_amb_20234001, AudioEnum.Bgm.stop_ui_bus_2000048)
	slot0:_addBgmData(AudioBgmEnum.Layer.V2a3_WarmUp, AudioEnum.Bgm.play_ui_shenghuo_preheat_amb_20234003, AudioEnum.Bgm.stop_ui_bus_2000048)
	slot0:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_4Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_4Act178Game, AudioEnum.Act178.bgm_game, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_4WuErLiXi, AudioEnum.WuErLiXi.bgm_wuerliximap, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_4WuErLiXiGame, AudioEnum.WuErLiXi.bgm_wuerliximapgame, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	slot0:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_5Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
end

function slot0._initBgmUsage(slot0)
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.Main
	}, AudioBgmEnum.UsageType.Scene, {
		SceneType.Main
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.Explore
	}, AudioBgmEnum.UsageType.Scene, {
		SceneType.Explore
	}, nil, , true)
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.PushBox
	}, AudioBgmEnum.UsageType.Scene, {
		SceneType.PushBox
	}, nil, , true)
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.Fight
	}, AudioBgmEnum.UsageType.Scene, {
		SceneType.Fight
	}, nil, , true)
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.Cachot
	}, AudioBgmEnum.UsageType.Scene, {
		SceneType.Cachot
	}, nil, , true)
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.Story
	}, AudioBgmEnum.UsageType.View, {
		ViewName.StoryView
	}, nil, , true)
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.Dungeon
	}, AudioBgmEnum.UsageType.View, {
		ViewName.DungeonMapView
	}, nil, , true)
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.DungeonWeekWalk
	}, AudioBgmEnum.UsageType.View, {
		ViewName.WeekWalkLayerView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.Dungeon,
		AudioBgmEnum.Layer.DungeonWeekWalk
	}, AudioBgmEnum.UsageType.View, {
		ViewName.DungeonView
	}, DungeonController.queryBgm, nil)
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivityVideoView
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivityVideoView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.Character
	}, AudioBgmEnum.UsageType.View, {
		ViewName.WeekWalkCharacterView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.Character
	}, AudioBgmEnum.UsageType.View, {
		ViewName.CharacterBackpackView,
		ViewName.CharacterView,
		ViewName.CharacterRankUpView,
		ViewName.CharacterTalentView,
		ViewName.CharacterExSkillView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.LeiMiTeBei
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivityEnterView,
		ViewName.VersionActivityExchangeView,
		ViewName.Permanent1_1EnterView
	}, nil, , true)
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.LeiMiTeBeiDungeon
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivityDungeonMapView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.Meilanni
	}, AudioBgmEnum.UsageType.View, {
		ViewName.MeilanniMainView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.Bp
	}, AudioBgmEnum.UsageType.View, {
		ViewName.BpView,
		ViewName.BpSPView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.Summon
	}, AudioBgmEnum.UsageType.View, {
		ViewName.SummonView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.ChessGame
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Activity109ChessEntry
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.WeekWalk
	}, AudioBgmEnum.UsageType.View, {
		ViewName.WeekWalkView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.Season
	}, AudioBgmEnum.UsageType.View, {
		ViewName.SeasonMainView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_2Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity1_2EnterView,
		ViewName.VersionActivity1_2DungeonView,
		ViewName.Permanent1_2EnterView
	}, nil, , true)
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.YaXian
	}, AudioBgmEnum.UsageType.View, {
		ViewName.YaXianMapView
	}, nil, , true)
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.JieXiKa
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Activity114View
	}, nil, , true)
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.Season1_2
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Season1_2MainView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_3Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity1_3EnterView,
		ViewName.VersionActivity1_3DungeonMapView,
		ViewName.Permanent1_3EnterView
	}, nil, , true)
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.Season1_3
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Season1_3MainView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_3ArmPipe
	}, AudioBgmEnum.UsageType.View, {
		ViewName.ArmMainView,
		ViewName.ArmRewardView,
		ViewName.ArmPuzzlePipeView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_3Act307
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Activity1_3_119View
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_3Act304
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Activity1_3ChessMapView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_3Act120
	}, AudioBgmEnum.UsageType.View, {
		ViewName.JiaLaBoNaMapView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.Season1_4
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Season1_4MainView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.RoleStoryActivity
	}, AudioBgmEnum.UsageType.View, {
		ViewName.RoleStoryActivityMainView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_4Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity1_4EnterView,
		ViewName.Permanent1_4EnterView
	}, nil, , true)
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.TokenStore
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Activity129View
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.TaskAndCollected
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity1_4TaskView,
		ViewName.Activity132CollectView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_4Act130
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Activity130LevelView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_4Act131
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Activity131LevelView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_4Act136
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Activity136View
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_5Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity1_5EnterView,
		ViewName.Permanent1_5EnterView
	}, nil, , true)
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.Season1_5
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Season1_5MainView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.Activity142
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Activity142MapView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.V1a5AiZiLa
	}, AudioBgmEnum.UsageType.View, {
		ViewName.AiZiLaMapView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_6Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity1_6EnterView
	}, nil, , true)
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_6Dungeon
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity1_6DungeonMapView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.Act_QuNiang
	}, AudioBgmEnum.UsageType.View, {
		ViewName.ActQuNiangLevelView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.Act_GeTian
	}, AudioBgmEnum.UsageType.View, {
		ViewName.ActGeTianLevelView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_7Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity1_7EnterView,
		ViewName.Permanent1_7EnterView
	}, nil, , true)
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_8Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity1_8EnterView,
		ViewName.Permanent1_8EnterView
	}, nil, , true)
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_8Dungeon
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity1_8DungeonMapView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_9Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity1_9EnterView
	}, nil, , true)
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_9SemmelWeisGift
	}, AudioBgmEnum.UsageType.View, {
		ViewName.SemmelWeisGiftView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.ToughBattle
	}, AudioBgmEnum.UsageType.View, {
		ViewName.ToughBattleEnterView,
		ViewName.ToughBattleActEnterView,
		ViewName.ToughBattleMapView,
		ViewName.ToughBattleActMapView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.FairyLand
	}, AudioBgmEnum.UsageType.View, {
		ViewName.FairyLandView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.HeroInvitation
	}, AudioBgmEnum.UsageType.View, {
		ViewName.HeroInvitationDungeonMapView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.RougeFavorite
	}, AudioBgmEnum.UsageType.View, {
		ViewName.RougeFavoriteView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.RougeMain
	}, AudioBgmEnum.UsageType.View, {
		ViewName.RougeMainView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.RougeScene
	}, AudioBgmEnum.UsageType.Scene, {
		SceneType.Rouge
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_0Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity2_0EnterView
	}, nil, , true)
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.V2a0_WarmUp
	}, AudioBgmEnum.UsageType.View, {
		ViewName.V2a0_WarmUp
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_1Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity2_1EnterView
	}, nil, , true)
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.V2a1_WarmUp
	}, AudioBgmEnum.UsageType.View, {
		ViewName.V2a1_WarmUp
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_2Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity2_2EnterView
	}, nil, , true)
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.InvestigateRoleStory
	}, AudioBgmEnum.UsageType.View, {
		ViewName.InvestigateRoleStoryView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.InvestigateView
	}, AudioBgmEnum.UsageType.View, {
		ViewName.InvestigateView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.NormalBattleV2_2,
		AudioBgmEnum.Layer.BossBattleV2_2
	}, AudioBgmEnum.UsageType.View, {
		ViewName.EliminateLevelView,
		ViewName.EliminateSelectRoleView,
		ViewName.EliminateSelectChessMenView
	}, EliminateLevelController.queryBgm, nil)
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_3Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity2_3EnterView
	}, nil, , true)
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.Tower
	}, AudioBgmEnum.UsageType.View, {
		ViewName.TowerMainView,
		ViewName.TowerMainEntryView
	}, nil, , true)
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.LinkageActivity_FullView
	}, AudioBgmEnum.UsageType.View, {
		ViewName.LinkageActivity_FullView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.V2a3_WarmUp
	}, AudioBgmEnum.UsageType.View, {
		ViewName.V2a3_WarmUp
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_4MusicFree
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity2_4MusicFreeView,
		ViewName.VersionActivity2_4MusicBeatView
	})
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_4Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity2_4EnterView
	}, nil, , true)
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_4Act178Game
	}, AudioBgmEnum.UsageType.View, {
		ViewName.PinballGameView
	}, nil, , true)
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_4WuErLiXiGame
	}, AudioBgmEnum.UsageType.View, {
		ViewName.WuErLiXiGameView
	}, nil, , true)
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_4WuErLiXi
	}, AudioBgmEnum.UsageType.View, {
		ViewName.WuErLiXiLevelView
	}, nil, , true)
	slot0:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_5Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity2_5EnterView
	}, nil, , true)
end

function slot0._initBgmBind(slot0)
	slot0:_addBgmBind(AudioBgmEnum.Layer.Dungeon, {
		AudioBgmEnum.Layer.DungeonAmbientSound
	})
	slot0:_addBgmBind(AudioBgmEnum.Layer.VersionActivity1_3Main, {
		AudioBgmEnum.Layer.VersionActivity1_3DungeonAmbientSound
	})
end

function slot0._addBgmBind(slot0, slot1, slot2)
	slot0._bgmBindMap[slot1] = slot2
end

function slot0._addBgmUsage(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7 = AudioBgmUsage.New()
	slot7.layerList = slot1
	slot7.type = slot2
	slot7.typeParam = slot3
	slot7.queryFunc = slot4
	slot7.queryFuncTarget = slot5
	slot7.clearPauseBgm = slot6
	slot8 = nil

	if slot2 == AudioBgmEnum.UsageType.Scene then
		slot8 = slot0._bgmUsageSceneMap
	elseif slot2 == AudioBgmEnum.UsageType.View then
		slot8 = slot0._bgmUsageViewMap
	end

	for slot12, slot13 in ipairs(slot3) do
		if slot8[slot13] then
			logError(string.format("AudioBgmInfo:_addBgmUsage typeParam:%s 重复设置了", slot13))
		end

		slot8[slot13] = slot7
	end

	return slot7
end

function slot0._addBgmData(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	if not slot0._bgmDatas[slot1] then
		slot8 = AudioBgmData.New()
		slot0._bgmDatas[slot1] = slot8
		slot8.layer = slot1
		slot8.playId = slot2
		slot8.stopId = slot3
		slot8.pauseId = slot5
		slot8.resumeId = slot4
		slot8.switchGroup = slot6
		slot8.switchState = slot7

		if AudioMgr.instance:useDefaultBGM() and slot8.layer ~= AudioBgmEnum.Layer.Fight then
			slot8.playId = AudioEnum.Default_UI_Bgm
			slot8.stopId = AudioEnum.Default_UI_Bgm_Stop
		end
	end
end

function slot0.modifyBgmData(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	if not slot0._bgmDatas[slot1] then
		slot0._bgmDatas[slot1] = AudioBgmData.New()
	end

	slot8.playId = slot2
	slot8.stopId = slot3
	slot8.resumeId = slot4
	slot8.pauseId = slot5
	slot8.switchGroup = slot6
	slot8.switchState = slot7
end

function slot0.modifyBgmAudioId(slot0, slot1, slot2)
	if not slot0._bgmDatas[slot1] or slot3.playId == slot2 then
		return false
	end

	slot3.playId = slot2

	return true
end

function slot0.removeBgm(slot0, slot1)
	slot0._bgmDatas[slot1] = nil
end

function slot0.clearBgm(slot0, slot1)
	if not slot0._bgmDatas[slot1] then
		return
	end

	slot2:clear()
end

function slot0.getBgmData(slot0, slot1)
	return slot0._bgmDatas[slot1]
end

function slot0.getViewBgmUsage(slot0, slot1)
	return slot0._bgmUsageViewMap[slot1]
end

function slot0.getSceneBgmUsage(slot0, slot1)
	return slot0._bgmUsageSceneMap[slot1]
end

function slot0.getBindList(slot0, slot1)
	return slot0._bgmBindMap[slot1]
end

return slot0
