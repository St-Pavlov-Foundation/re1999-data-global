local var_0_0 = {
	LawDescriptionView = {
		destroy = 0,
		container = "LawDescriptionViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/help/lawdescriptionview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	},
	DateOfBirthSelectionView = {
		destroy = 0,
		container = "DateOfBirthSelectionViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/minors/dateofbirthselectionview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	},
	DateOfBirthVerifyView = {
		destroy = 0,
		container = "DateOfBirthVerifyViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/minors/dateofbirthverifyview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	},
	ActivityGuestBindView = {
		destroy = 0,
		container = "ActivityGuestBindViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/activity/show/activityguestbindview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/activity/show/activityguestbindviewitem.prefab"
		}
	},
	ActivityGiftForTheVoyage = {
		destroy = 0,
		container = "ActivityGiftForTheVoyageContainer",
		mainRes = "ui/viewres/voyage/activitygiftforthevoyage.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	VoyagePopupRewardView = {
		destroy = 0,
		container = "VoyagePopupRewardViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/voyage/voyagepopuprewardview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	},
	V1a5_HarvestSeason_PanelSignView = {
		destroy = 0,
		container = "V1a5_HarvestSeason_PanelSignViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/activity/v1a5_harvestseason_panelsignview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/activity/v1a5_harvestseason_signitem.prefab"
		}
	},
	V1a5_HarvestSeason_FullSignView = {
		destroy = 0,
		container = "V1a5_HarvestSeason_FullSignViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/activity/v1a5_harvestseason_fullsignview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/activity/v1a5_harvestseason_signitem.prefab"
		}
	},
	ActivityWelfareView = {
		destroy = 0,
		container = "ActivityWelfareViewContainer",
		mainRes = "ui/viewres/activity/activitybeginnerview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			},
			{
				{
					"ui/viewres/newwelfare/newwelfarefullview.prefab"
				}
			}
		},
		otherRes = {
			[1] = "ui/viewres/activity/activitynormalcategoryitem.prefab"
		}
	},
	NewWelfareView = {
		destroy = 0,
		container = "NewWelfareViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/newwelfare/newwelfarefullview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	NewWelfarePanel = {
		destroy = 0,
		container = "NewWelfarePanelContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/newwelfare/newwelfarepanelview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	},
	V2a0_SummerSign_PanelView = {
		destroy = 0,
		container = "V2a0_SummerSign_PanelViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/activity/v2a0_summersign_panelview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/activity/v2a0_summersign_signitem.prefab"
		}
	},
	V2a0_SummerSign_FullView = {
		destroy = 0,
		container = "V2a0_SummerSign_FullViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/activity/v2a0_summersign_fullview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/activity/v2a0_summersign_signitem.prefab"
		}
	},
	V2a1_MoonFestival_PanelView = {
		destroy = 0,
		container = "V2a1_MoonFestival_PanelViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/activity/v2a1_moonfestival_panelview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/activity/v2a1_moonfestival_signitem.prefab"
		}
	},
	V2a1_MoonFestival_FullView = {
		destroy = 0,
		container = "V2a1_MoonFestival_FullViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/activity/v2a1_moonfestival_fullview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/activity/v2a1_moonfestival_signitem.prefab"
		}
	},
	LinkageActivity_PanelView = {
		destroy = 0,
		container = "LinkageActivity_PanelViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/activity/linkageactivity_panelview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	},
	LinkageActivity_FullView = {
		destroy = 0,
		container = "LinkageActivity_FullViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/activity/linkageactivity_fullview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	Activity181MainView = {
		destroy = 0,
		container = "Activity181MainViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/versionactivity_2_4/v2a4_actxmasview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	Activity181RewardView = {
		destroy = 0,
		container = "Activity181RewardViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/versionactivity_2_4/v2a4_actxmasrewardview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	V2a2_SpringFestival_FullView = {
		destroy = 0,
		container = "V2a2_SpringFestival_FullViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/activity/v2a2_springfestival_fullview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/activity/v2a2_springfestival_signitem.prefab"
		}
	},
	V2a2_SpringFestival_PanelView = {
		destroy = 0,
		container = "V2a2_SpringFestival_PanelViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/activity/v2a2_springfestival_panelview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/activity/v2a2_springfestival_signitem.prefab"
		}
	},
	ShortenAct_PanelView = {
		destroy = 0,
		container = "ShortenAct_PanelViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/activity/shortenact_panelview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/activity/shortenact_taskitem.prefab"
		}
	},
	ShortenAct_FullView = {
		destroy = 0,
		container = "ShortenAct_FullViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/activity/shortenact_fullview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/activity/shortenact_taskitem.prefab"
		}
	},
	V2a7_Labor_FullSignView = {
		destroy = 0,
		container = "V2a7_Labor_FullSignViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/activity/v2a7_labor_fullsignview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/activity/v2a7_labor_signitem.prefab"
		}
	},
	V2a7_Labor_PanelSignView = {
		destroy = 0,
		container = "V2a7_Labor_PanelSignViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/activity/v2a7_labor_panelsignview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/activity/v2a7_labor_signitem.prefab"
		}
	},
	TurnBackFullView = {
		destroy = 0,
		container = "TurnBackFullViewContainer",
		mainRes = "ui/viewres/activity/turnback_fullview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	SimulateLoginView = {
		destroy = 3,
		container = "SimulateLoginViewContainer",
		maskAlpha = 0,
		mainRes = "ui/viewres/login/simulateloginview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	},
	LoginView = {
		destroy = 0,
		container = "LoginViewContainer",
		mainRes = "ui/viewres/login/loginview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		otherRes = {
			[1] = "ui/viewres/login/loginbgtype.prefab",
			[2] = ResUrl.getLoginBg("bg_denglubeijing_b01")
		}
	},
	FixResTipView = {
		destroy = 0,
		container = "FixResTipViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/login/fixrestipview.prefab",
		layer = "MESSAGE",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/messagebox/messageboxview.prefab"
		}
	},
	SDKLoginVerifyView = {
		destroy = 0,
		container = "SDKLoginVerifyViewContainer",
		mainRes = "ui/viewres/sdk/sdkloginverifyview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	},
	SDKLoginRealNameView = {
		destroy = 0,
		container = "SDKLoginRealNameViewContainer",
		mainRes = "ui/viewres/sdk/sdkloginrealnameview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	},
	SDKLoginRealNameResultView = {
		destroy = 0,
		container = "SDKLoginRealNameResultViewContainer",
		mainRes = "ui/viewres/sdk/sdkloginrealnameresultview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	},
	SDKLoginAddPwdView = {
		destroy = 0,
		container = "SDKLoginAddPwdViewContainer",
		mainRes = "ui/viewres/sdk/sdkloginaddpwdview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	},
	SDKCommonTipView = {
		destroy = 0,
		container = "SDKCommonTipViewContainer",
		mainRes = "ui/viewres/sdk/sdkcommontipview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	},
	SDKWelcomeView = {
		destroy = 0,
		container = "SDKWelcomeViewContainer",
		mainRes = "ui/viewres/sdk/sdkwelcomeview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	},
	SDKExitGameView = {
		bgBlur = 1,
		container = "SDKExitGameViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/sdk/sdkexitgameview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	},
	SDKExitGameTopView = {
		bgBlur = 1,
		container = "SDKExitGameViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/sdk/sdkexitgameview.prefab",
		layer = "TOP",
		viewType = ViewType.Modal
	},
	SDKLoginUsualView = {
		destroy = 0,
		container = "SDKLoginUsualViewContainer",
		mainRes = "ui/viewres/sdk/sdkloginusualview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	},
	SDKSandboxPayView = {
		destroy = 0,
		container = "SDKSandboxPayViewContainer",
		mainRes = "ui/viewres/sdk/sdksandboxpayview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	},
	NicknameView = {
		destroy = 0,
		container = "NicknameViewContainer",
		mainRes = "ui/viewres/login/nicknameview.prefab",
		layer = "HUD",
		viewType = ViewType.Full,
		otherRes = {
			AvProMgrConfig.UrlNicknameVideo,
			AvProMgrConfig.UrlNicknameVideoCompatible
		}
	},
	NicknameConfirmView = {
		bgBlur = 3,
		container = "NicknameConfirmViewContainer",
		mainRes = "ui/viewres/login/nicknameconfirmview.prefab",
		destroy = 0,
		blurIterations = 2,
		blurFactor = 0.5,
		layer = "MESSAGE",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		desampleRate = PostProcessingMgr.DesamplingRate.x8,
		reduceRate = PostProcessingMgr.DesamplingRate.x1
	},
	ServerListView = {
		destroy = 3,
		container = "ServerListViewContainer",
		mainRes = "ui/viewres/login/serverlistview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		otherRes = {
			[1] = "ui/viewres/login/serverlistitem.prefab"
		}
	},
	SkinOffsetAdjustView = {
		destroy = 0,
		container = "SkinOffsetAdjustViewContainer",
		mainRes = "ui/viewres/skin/skinoffsetadjustview.prefab",
		layer = "MESSAGE",
		viewType = ViewType.Normal,
		otherRes = {
			[1] = "ui/viewres/skin/skinoffsetskinitem.prefab"
		}
	},
	FightFocusCameraAdjustView = {
		destroy = 0,
		container = "FightFocusCameraAdjustViewContainer",
		mainRes = "ui/viewres/fight/fightfocuscameraadjustview.prefab",
		layer = "MESSAGE",
		viewType = ViewType.Normal
	},
	MainSceneSkinMaterialTipView = {
		bgBlur = 1,
		container = "MainSceneSkinMaterialTipViewContainer",
		mainRes = "ui/viewres/mainsceneswitch/mainsceneskinmaterialtipview.prefab",
		destroy = 0,
		blurIterations = 3,
		blurFactor = 0.85,
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		desampleRate = PostProcessingMgr.DesamplingRate.x8,
		reduceRate = PostProcessingMgr.DesamplingRate.x8
	},
	MainSwitchView = {
		destroy = 0,
		container = "MainSwitchViewContainer",
		mainRes = "ui/viewres/main/mainswitchview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		otherRes = {
			[1] = "ui/viewres/main/mainswitchcategoryitem.prefab"
		},
		tabRes = {
			{
				{
					"ui/viewres/character/characterswitchview.prefab",
					"ui/viewres/character/characterswitchitem.prefab"
				},
				{
					"ui/viewres/mainsceneswitch/mainsceneswitchview.prefab",
					"ui/viewres/mainsceneswitch/mainsceneswitchitem.prefab"
				}
			},
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	MainSceneSwitchInfoView = {
		destroy = 0,
		container = "MainSceneSwitchInfoViewContainer",
		mainRes = "ui/viewres/mainsceneswitch/mainsceneswitchview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	MainSceneStoreShowView = {
		destroy = 0,
		container = "MainSceneStoreShowViewContainer",
		mainRes = "ui/viewres/mainsceneswitch/mainscenestoreshowview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full
	},
	MainView = {
		destroy = 0,
		container = "MainViewContainer",
		mainRes = "ui/viewres/main/mainview.prefab",
		layer = "HUD",
		viewType = ViewType.Normal,
		tabRes = {
			{
				{
					CurrencyView.prefabPath
				}
			}
		},
		otherRes = {
			[1] = "ui/spriteassets/main.asset",
			[2] = "ui/animations/dynamic/maincamera.controller"
		}
	},
	MainThumbnailView = {
		destroy = 0,
		container = "MainThumbnailViewContainer",
		mainRes = "ui/viewres/main/mainthumbnailview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		otherRes = {
			"ui/viewres/main/mainthumbnailselectitem.prefab",
			"ui/viewres/main/mainthumbnailbanneritem.prefab",
			"ui/animations/dynamic/mainthumbnailview_camera.controller",
			"ui/animations/dynamic/captureview.controller"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	FeedBackView = {
		destroy = 0,
		container = "FeedBackViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/main/feedbackview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	MessageBoxView = {
		destroy = 0,
		container = "MessageBoxViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/messagebox/messageboxview.prefab",
		layer = "MESSAGE",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		customAnimBg = {
			"#simage_tipbg"
		}
	},
	MessageOptionBoxView = {
		destroy = 0,
		container = "MessageOptionBoxViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/messagebox/messageoptionboxview.prefab",
		layer = "MESSAGE",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		customAnimBg = {
			"#simage_tipbg"
		}
	},
	TopMessageBoxView = {
		destroy = 0,
		container = "TopMessageBoxViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/messagebox/messageboxview.prefab",
		layer = "TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		customAnimBg = {
			"#simage_tipbg"
		}
	},
	FightQuitTipView = {
		destroy = 0,
		container = "FightQuitTipViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/fight/fightquittipview.prefab",
		layer = "POPUP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {
			weekwalkheart_star = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_star.prefab"
		}
	},
	ToastView = {
		destroy = 0,
		container = "ToastViewContainer",
		mainRes = "ui/viewres/toast/toastview.prefab",
		layer = "MESSAGE",
		viewType = ViewType.Normal
	},
	ToastTopView = {
		destroy = 0,
		container = "ToastViewContainer",
		mainRes = "ui/viewres/toast/toastview.prefab",
		layer = "TOP",
		viewType = ViewType.Normal
	},
	PowerView = {
		bgBlur = 1,
		container = "PowerViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/power/powerview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Internal,
		customAnimBg = {
			"bg"
		},
		tabRes = {
			{
				{
					CurrencyView.prefabPath
				}
			}
		}
	},
	PowerActChangeView = {
		destroy = 0,
		container = "PowerActChangeViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/power/poweractchangeview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					CurrencyView.prefabPath
				}
			}
		}
	},
	PowerBuyTipView = {
		bgBlur = 1,
		container = "PowerBuyTipViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/power/powerbuytipview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		customAnimBg = {
			"#simage_tipbg"
		},
		tabRes = {
			{
				{
					CurrencyView.prefabPath
				}
			}
		}
	},
	ExploreView = {
		destroy = 0,
		container = "ExploreViewContainer",
		mainRes = "ui/viewres/explore/exploreview.prefab",
		layer = "HUD",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	ExploreGuideView = {
		destroy = 0,
		container = "ExploreGuideViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/explore/exploreguideview.prefab",
		blurFactor = 0.3,
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	},
	ExploreEnterView = {
		destroy = 0,
		container = "ExploreEnterViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/explore/exploreloadingview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	ExploreArchivesDetailView = {
		destroy = 0,
		container = "ExploreArchivesDetailViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/explore/explorestoryeastereggview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	},
	ExploreBonusSceneRecordView = {
		destroy = 0,
		container = "ExploreBonusSceneRecordViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/explore/explorestoryeastereggtipsview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	},
	ExploreFinishView = {
		destroy = 0,
		container = "ExploreFinishViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/explore/explorefinishview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	ExploreMapView = {
		destroy = 0,
		container = "ExploreMapViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/explore/exploremapview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default
	},
	ExploreBlackView = {
		destroy = 1,
		container = "ExploreBlackViewContainer",
		mainRes = "ui/viewres/explore/exploreblackview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Internal
	},
	ExploreArchivesView = {
		bgBlur = 1,
		container = "ExploreArchivesViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/explore/explorearchivesview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		preloader = module_views_preloader
	},
	ExploreInteractView = {
		destroy = 0,
		container = "ExploreInteractViewContainer",
		mainRes = "ui/viewres/explore/exploreinteractview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		customAnimBg = {}
	},
	ExploreBonusSceneView = {
		destroy = 0,
		container = "ExploreBonusSceneViewContainer",
		mainRes = "ui/viewres/explore/exploreinteracteastereggview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	ExploreInteractOptionView = {
		destroy = 0,
		container = "ExploreInteractOptionViewContainer",
		mainRes = "ui/viewres/explore/exploreinteractoptionview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		customAnimBg = {}
	},
	ExploreGetItemView = {
		destroy = 0,
		container = "ExploreGetItemViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/explore/exploregetitemview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		customAnimBg = {
			"bg"
		}
	},
	ExploreBackpackView = {
		destroy = 0,
		container = "ExploreBackpackViewContainer",
		mainRes = "ui/viewres/explore/explorebackpackview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Internal,
		otherRes = {
			[1] = "ui/viewres/explore/explorebackpackpropitem.prefab"
		}
	},
	ExploreRewardView = {
		destroy = 0,
		container = "ExploreRewardViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/explore/explorerewardview2.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	ExploreBonusRewardView = {
		destroy = 0,
		container = "ExploreBonusRewardViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/explore/explorerewardview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	},
	ExploreGuideDialogueView = {
		destroy = 0,
		container = "ExploreGuideDialogueViewContainer",
		mainRes = "ui/viewres/explore/exploreinteractview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	FightView = {
		destroy = 0,
		container = "FightViewContainer",
		mainRes = "ui/viewres/fight/fightview.prefab",
		layer = "HUD",
		viewType = ViewType.Normal,
		otherRes = {
			"ui/viewres/fight/fightcarditem.prefab",
			"ui/viewres/fight/clothskill.prefab",
			"ui/viewres/fight/fightcarddeckbtnview.prefab"
		}
	},
	FightSuccView = {
		destroy = 0,
		container = "FightSuccViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/fight/fightsuccview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {
			weekwalkheart_star = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_star.prefab"
		}
	},
	FightFailTipsView = {
		destroy = 0,
		container = "FightFailTipsViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/fight/fightfailtipsview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	FightSpecialTipView = {
		destroy = 0,
		container = "FightSpecialTipViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/fight/fightspecialtipview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Internal
	},
	FightTechniqueView = {
		destroy = 0,
		container = "FightTechniqueViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/fight/fighttechniqueview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	FightCardPreDisPlayView = {
		destroy = 0,
		container = "FightCardPreDisPlayViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/fight/fightcardpredisplay.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	FightCardDeckView = {
		destroy = 0,
		container = "FightCardDeckViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/fight/fightcarddeckview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	FightWeekWalkEnemyTipsView = {
		destroy = 0,
		container = "FightWeekWalkEnemyTipsViewContainer",
		mainRes = "ui/viewres/fight/fightweekwalkenemytipsview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	FightGMDouQuQuTest = {
		destroy = 0,
		container = "FightGMDouQuQuTestContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/gm/fightgmdouququtest.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	FightCardDeckGMView = {
		destroy = 0,
		container = "FightCardDeckGMViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/fight/fightcarddeckview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	FightSkillStrengthenView = {
		destroy = 0,
		container = "FightSkillStrengthenViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/fight/skillstrengthenview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	FightChangeHeroSelectSkillTargetView = {
		destroy = 0,
		container = "FightChangeHeroSelectSkillTargetViewContainer",
		mainRes = "ui/viewres/fight/fightchangeheroselectskilltargetview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	FightSeasonChangeHeroSelectView = {
		destroy = 0,
		container = "FightSeasonChangeHeroSelectViewContainer",
		mainRes = "ui/viewres/fight/fightseasonchangeheroselectview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	FightTechniqueTipsView = {
		destroy = 0,
		container = "FightTechniqueTipsViewContainer",
		bgBlur = 3,
		mainRes = "ui/viewres/fight/fighttechniquetipsview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	FightFailView = {
		destroy = 0,
		container = "FightFailViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/fight/fightfailview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	},
	FightStatView = {
		destroy = 0,
		container = "FightStatViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/fight/fightstatview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		customAnimBg = {
			"imgBg",
			"Image"
		}
	},
	FightSkillTargetView = {
		destroy = 0,
		container = "FightSkillTargetViewContainer",
		bgBlur = 3,
		mainRes = "ui/viewres/fight/fightskilltargetview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/fight/fightskilltargetitem.prefab"
		}
	},
	FightNaNaTargetView = {
		destroy = 0,
		container = "FightNaNaTargetViewContainer",
		bgBlur = 3,
		mainRes = "ui/viewres/fight/fight_tianshinana_targetview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/fight/fight_tianshinana_targetitem.prefab"
		}
	},
	FightRoundView = {
		destroy = 0,
		container = "FightRoundViewContainer",
		mainRes = "ui/viewres/fight/fightroundview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		customAnimBg = {}
	},
	FightEditorStateView = {
		destroy = 0,
		container = "FightEditorStateViewContainer",
		mainRes = "ui/viewres/fight/fighteditorstateview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	FightCardIntroduceView = {
		destroy = 0,
		container = "FightCardIntroduceViewContainer",
		mainRes = "ui/viewres/fight/fightcardintroduceview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	FightCardMixIntroduceView = {
		destroy = 0,
		container = "FightCardMixIntroduceViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/fight/fightcardmixintroduceview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	FightCardDescView = {
		bgBlur = 1,
		container = "FightCardDescViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/fight/fightcarddescview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/fight/fightcarddescitem.prefab"
		},
		customAnimBg = {
			"bg"
		}
	},
	FightCareerIntroduceView = {
		destroy = 0,
		container = "FightCareerIntroduceViewContainer",
		mainRes = "ui/viewres/fight/fightcareerintroduceview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		customAnimBg = {
			"#go_blackbg"
		}
	},
	FightInspirationView = {
		destroy = 0,
		container = "FightInspirationViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/fight/fightinspirationview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	FightGuideView = {
		destroy = 0,
		container = "FightGuideViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/fight/fightguideview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		otherRes = {
			[1] = "ui/viewres/help/helpselectitem.prefab",
			[2] = "ui/viewres/fight/fightguideitem.prefab"
		}
	},
	FightFocusView = {
		bgBlur = 4,
		container = "FightFocusViewContainer",
		mainRes = "ui/viewres/fight/fightfocusview.prefab",
		destroy = 0,
		blurIterations = 2,
		blurFactor = 0.65,
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Internal,
		desampleRate = PostProcessingMgr.DesamplingRate.x1,
		reduceRate = PostProcessingMgr.DesamplingRate.x2,
		tabRes = {
			{
				{
					"ui/viewres/tips/skilltipview.prefab"
				}
			}
		},
		otherRes = {
			FightEntityResistanceComp.FightResistancePath
		}
	},
	FightActionBarPopView = {
		destroy = 0,
		container = "FightActionBarPopViewContainer",
		mainRes = "ui/viewres/fight/fightactionbarpopview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Internal
	},
	FightTechniqueGuideView = {
		bgBlur = 4,
		container = "FightTechniqueGuideViewContainer",
		mainRes = "ui/viewres/fight/fighttechniqueguideview.prefab",
		destroy = 0,
		blurIterations = 2,
		blurFactor = 0.65,
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Internal,
		desampleRate = PostProcessingMgr.DesamplingRate.x1,
		reduceRate = PostProcessingMgr.DesamplingRate.x2
	},
	FightLoadingView = {
		bgBlur = 1,
		container = "FightLoadingViewContainer",
		mainRes = "ui/viewres/fight/fightloadingview.prefab",
		destroy = 0,
		blurIterations = 2,
		blurFactor = 1,
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		customAnimFadeTime = {
			0,
			0
		},
		desampleRate = PostProcessingMgr.DesamplingRate.x8,
		reduceRate = PostProcessingMgr.DesamplingRate.x4
	},
	FightBuffTipsView = {
		destroy = 0,
		container = "FightBuffTipsViewContainer",
		mainRes = "ui/viewres/fight/fightbufftipsview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	},
	FightResistanceTipView = {
		destroy = 0,
		container = "FightResistanceTipViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/fight/fightresistancetipsview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	},
	FightSkillSelectView = {
		destroy = 0,
		container = "FightSkillSelectViewContainer",
		mainRes = "ui/viewres/fight/fightskillselectview.prefab",
		layer = "HUD",
		viewType = ViewType.Normal
	},
	FightDiceView = {
		destroy = 0,
		container = "FightDiceViewContainer",
		mainRes = "ui/viewres/fight/fightluckycasinoview.prefab",
		layer = "HUD",
		viewType = ViewType.Normal
	},
	FightSeasonDiceView = {
		destroy = 0,
		container = "FightSeasonDiceViewContainer",
		mainRes = "ui/viewres/fight/seasondiceview.prefab",
		layer = "HUD",
		viewType = ViewType.Normal
	},
	FightSkipTimelineView = {
		destroy = 0,
		container = "FightSkipTimelineViewContainer",
		mainRes = "ui/viewres/fight/fightskiptimelineview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	SkillEffectStatView = {
		destroy = 0,
		container = "SkillEffectStatViewContainer",
		mainRes = "ui/viewres/fight/skilleffectstatview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	SkillEditorView = {
		destroy = 0,
		container = "SkillEditorViewContainer",
		mainRes = "ui/viewres/fight/skilleditorview.prefab",
		layer = "TOP",
		viewType = ViewType.Normal
	},
	BackpackView = {
		container = "BackpackViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/backpack/backpackview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Internal,
		otherRes = {
			"ui/viewres/backpack/backpackpropitem.prefab",
			"ui/viewres/backpack/backpackcategoryitem.prefab",
			"ui/viewres/common/item/commonequipicon.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			},
			{
				{
					"ui/viewres/backpack/backpackpropview.prefab"
				},
				{
					"ui/viewres/character/characterbackpackequipview.prefab"
				},
				{
					"ui/viewres/antique/antiquebackpackview.prefab"
				}
			}
		},
		customAnimBg = {
			"bg"
		}
	},
	CurrencyExchangeView = {
		destroy = 0,
		container = "CurrencyExchangeViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/currency/currencyexchangeview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		customAnimBg = {
			"#simage_tipbg"
		},
		tabRes = {
			{
				{
					CurrencyView.prefabPath
				}
			}
		}
	},
	CurrencyDiamondExchangeView = {
		bgBlur = 1,
		container = "CurrencyDiamondExchangeViewContainer",
		mainRes = "ui/viewres/currency/currencydiamondexchangeview.prefab",
		destroy = 0,
		blurFactor = 0.6,
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		customAnimBg = {
			"bg"
		},
		tabRes = {
			{
				{
					CurrencyView.prefabPath
				}
			}
		}
	},
	SummonView = {
		destroy = 0,
		container = "SummonViewContainer",
		mainRes = "ui/viewres/summon/summonview.prefab",
		layer = "HUD",
		viewType = ViewType.Normal,
		tabRes = {
			{
				{
					"ui/viewres/summon/summoncharview.prefab"
				},
				{
					"ui/viewres/summon/summonequipview.prefab"
				}
			}
		}
	},
	SummonADView = {
		bgBlur = 0,
		container = "SummonMainViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/summon/summonmainview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		preloader = module_views_preloader,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			},
			{
				{
					CurrencyView.prefabPath
				}
			},
			{
				{
					"ui/viewres/summon/summonmaincharacterview.prefab"
				},
				{
					"ui/viewres/summon/summonmainequipview.prefab"
				},
				{
					"ui/viewres/summon/summonmaincharacternewbie.prefab"
				},
				{
					"ui/viewres/summon/summonmaincharacterprobup.prefab"
				},
				{
					"ui/viewres/summon/summonmainequipprobup.prefab"
				}
			}
		},
		otherRes = {
			[1] = "ui/viewres/summon/summonmaincategoryitem.prefab"
		}
	},
	SummonEquipGainView = {
		destroy = 0,
		container = "SummonEquipGainViewContainer",
		mainRes = "ui/viewres/equip/equipgetview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		customAnimBg = {
			"#go_bg"
		}
	},
	SummonResultView = {
		bgBlur = 1,
		container = "SummonResultViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/summon/summonresultview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		customAnimBg = {
			"#simage_bg"
		},
		otherRes = {
			"ui/viewres/summonresultview/r.prefab",
			"ui/viewres/summonresultview/sr.prefab",
			"ui/viewres/summonresultview/ssr.prefab"
		}
	},
	SummonHeroDetailView = {
		destroy = 0,
		container = "SummonHeroDetailViewContainer",
		mainRes = "ui/viewres/summon/summonherodetailview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		customAnimBg = {
			"bg"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	SummonPoolDetailView = {
		container = "SummonPoolDetailViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/summon/summonpooldetailview.prefab",
		destroy = 0,
		blurIterations = 3,
		blurFactor = 0.85,
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		desampleRate = PostProcessingMgr.DesamplingRate.x8,
		reduceRate = PostProcessingMgr.DesamplingRate.x8,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/summon/summonpooldetailcategoryitem.prefab"
		},
		tabRes = {
			{
				{
					"ui/viewres/summon/summonpooldetaildescview.prefab"
				},
				{
					"ui/viewres/summon/summonpooldetailprobabilityview.prefab"
				}
			}
		},
		customAnimBg = {
			"bg"
		}
	},
	SummonPoolHistoryView = {
		container = "SummonPoolHistoryViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/summon/summonpoolhistoryview.prefab",
		destroy = 0,
		blurIterations = 3,
		blurFactor = 0.85,
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		desampleRate = PostProcessingMgr.DesamplingRate.x8,
		reduceRate = PostProcessingMgr.DesamplingRate.x8,
		anim = ViewAnim.Default
	},
	SummonConfirmView = {
		bgBlur = 1,
		container = "SummonConfirmViewContainer",
		maskAlpha = 0,
		destroy = 0,
		mainRes = "ui/viewres/summon/summonconfirmview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		customAnimBg = {
			"bg"
		},
		tabRes = {
			{
				{
					CurrencyView.prefabPath
				}
			}
		}
	},
	SummonGetLuckyBag = {
		destroy = 0,
		container = "SummonGetLuckyBagViewContainer",
		mainRes = "ui/viewres/summon/luckybag/summongetluckybag.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	SummonLuckyBagChoice = {
		destroy = 0,
		container = "SummonLuckyBagChoiceContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/summon/luckybag/summonluckybagchoice.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	SummonLuckyBagDetailView = {
		container = "SummonLuckyBagDetailViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/summon/summonpooldetailview.prefab",
		destroy = 0,
		blurIterations = 3,
		blurFactor = 0.85,
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		desampleRate = PostProcessingMgr.DesamplingRate.x8,
		reduceRate = PostProcessingMgr.DesamplingRate.x8,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/summon/summonpooldetailcategoryitem.prefab"
		},
		tabRes = {
			{
				{
					"ui/viewres/summon/luckybag/summonluckybagdescview.prefab"
				},
				{
					"ui/viewres/summon/luckybag/summonluckybagdetailview.prefab"
				}
			}
		},
		customAnimBg = {
			"bg"
		}
	},
	SummonCustomPickChoice = {
		destroy = 0,
		container = "SummonCustomPickChoiceContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/summon/custompick/summoncustompickchoice.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	SummonCustomPickDetailView = {
		container = "SummonCustomPickDetailViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/summon/summonpooldetailview.prefab",
		destroy = 0,
		blurIterations = 3,
		blurFactor = 0.85,
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		desampleRate = PostProcessingMgr.DesamplingRate.x8,
		reduceRate = PostProcessingMgr.DesamplingRate.x8,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/summon/summonpooldetailcategoryitem.prefab"
		},
		tabRes = {
			{
				{
					"ui/viewres/summon/custompick/summoncustompickdescview.prefab"
				},
				{
					"ui/viewres/summon/custompick/summoncustompickdetailview.prefab"
				}
			}
		},
		customAnimBg = {
			"bg"
		}
	},
	SummonThreeCustomPickView = {
		destroy = 0,
		container = "SummonThreeCustomPickViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/summon/version_2_2/v2a2_versionsummonselfselectsixhalfview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	SummonNewCustomPickView = {
		destroy = 0,
		container = "SummonNewCustomPickViewContainer",
		mainRes = "ui/viewres/versionactivity_2_2/v2a2_selfselectcharacter/v2a2_selfselectcharacterfullview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	SummonNewCustomPickFullView = {
		destroy = 0,
		container = "SummonNewCustomPickFullViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_2_2/v2a2_selfselectcharacter/v2a2_selfselectcharacterview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	SummonNewCustomPickChoiceView = {
		destroy = 0,
		container = "SummonNewCustomPickChoiceViewContainer",
		mainRes = "ui/viewres/versionactivity_2_2/v2a2_selfselectcharacter/v2a2_selfselectcharacterchoiceview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	SummonNewCustomPickTipsView = {
		destroy = 0,
		container = "SummonNewCustomPickTipsViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_2_2/v2a2_selfselectcharacter/v2a2_selfselectcharactertipsview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	SummonSimulationResultView = {
		bgBlur = 1,
		container = "SummonSimulationResultViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/summonpick/summonpickresultview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		customAnimBg = {
			"#simage_bg"
		},
		otherRes = {
			"ui/viewres/summonresultview/r.prefab",
			"ui/viewres/summonresultview/sr.prefab",
			"ui/viewres/summonresultview/ssr.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	SummonSimulationPickView = {
		destroy = 0,
		container = "SummonSimulationPickViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/summonpick/summonpickview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/summonpick/summonpickitem.prefab"
		}
	},
	WeekWalkCharacterView = {
		container = "WeekWalkCharacterViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/weekwalk/weekwalkcharacterview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Internal,
		otherRes = {
			[1] = "ui/viewres/weekwalk/weekwalkcharacteritem.prefab",
			[2] = "ui/viewres/character/charactercategoryitem.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		customAnimBg = {
			"bg"
		}
	},
	WeekWalkTarotView = {
		bgBlur = 1,
		container = "WeekWalkTarotViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/weekwalk/weekwalktarotview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/weekwalk/weekwalktarotitem.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		customAnimBg = {
			"#simage_bg"
		}
	},
	WeekWalkSelectTarotView = {
		destroy = 0,
		container = "WeekWalkSelectTarotViewContainer",
		bgBlur = 4,
		mainRes = "ui/viewres/weekwalk/weekwalkselecttarotview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		customAnimBg = {}
	},
	WeekWalkBuffBindingView = {
		container = "WeekWalkBuffBindingViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/weekwalk/weekwalkbuffbindingview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/weekwalk/weekwalkbuffbindingheroitem.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		customAnimBg = {
			"bg"
		}
	},
	WeekWalkRespawnView = {
		bgBlur = 1,
		container = "WeekWalkRespawnViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/weekwalk/weekwalkrespawnview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/herogroup/herogroupedititem.prefab"
		},
		customAnimBg = {
			"bg"
		}
	},
	WeekWalkView = {
		destroy = 0,
		container = "WeekWalkViewContainer",
		mainRes = "ui/viewres/weekwalk/weekwalkview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Internal,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	WeekWalkReviveView = {
		destroy = 0,
		container = "WeekWalkReviveViewContainer",
		mainRes = "ui/viewres/weekwalk/weekwalkreviveview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	},
	WeekWalkShallowSettlementView = {
		destroy = 0,
		container = "WeekWalkShallowSettlementViewContainer",
		mainRes = "ui/viewres/weekwalk/weekwalkshallowsettlementview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Internal
	},
	WeekWalkDeepLayerNoticeView = {
		destroy = 0,
		container = "WeekWalkDeepLayerNoticeViewContainer",
		mainRes = "ui/viewres/weekwalk/weekwalkdeeplayernoticeview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	},
	WeekWalkRuleView = {
		destroy = 0,
		container = "WeekWalkRuleViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/weekwalk/weekwalkruleview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	WeekWalkDegradeView = {
		destroy = 0,
		container = "WeekWalkDegradeViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/weekwalk/weekwalkdegradeview.prefab",
		blurFactor = 0.3,
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	WeekWalkRewardView = {
		bgBlur = 1,
		container = "WeekWalkRewardViewContainer",
		mainRes = "ui/viewres/weekwalk/weekwalkrewardview.prefab",
		destroy = 0,
		blurFactor = 0.3,
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/weekwalk/weekwalkrewarditem.prefab",
			[2] = "ui/materials/dynamic/edgfade.mat"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	WeekWalkLayerRewardView = {
		bgBlur = 1,
		container = "WeekWalkLayerRewardViewContainer",
		mainRes = "ui/viewres/weekwalk/weekwalklayerrewardview.prefab",
		destroy = 0,
		blurFactor = 0.3,
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/weekwalk/weekwalklayerrewarditem.prefab"
		}
	},
	WeekWalkEnemyInfoView = {
		bgBlur = 1,
		container = "WeekWalkEnemyInfoViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/weekwalk/weekwalkenemyinfoview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		customAnimBg = {
			"#simage_bg",
			"#simage_rightbg"
		}
	},
	WeekWalkGuideView = {
		destroy = 0,
		container = "WeekWalkGuideViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/weekwalk/weekwalkguideview.prefab",
		blurFactor = 0.3,
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	},
	WeekWalkQuestionView = {
		destroy = 0,
		container = "WeekWalkQuestionViewContainer",
		mainRes = "ui/viewres/weekwalk/weekwalkquestionview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	WeekWalkResetView = {
		bgBlur = 1,
		container = "WeekWalkResetViewContainer",
		mainRes = "ui/viewres/weekwalk/weekwalkresetview.prefab",
		destroy = 0,
		blurFactor = 0.3,
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Internal,
		otherRes = {
			[1] = "ui/viewres/weekwalk/weekwalkresetbattleitem.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	WeekWalkLayerView = {
		destroy = 0,
		container = "WeekWalkLayerViewContainer",
		mainRes = "ui/viewres/weekwalk/weekwalklayerview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Internal,
		otherRes = {
			[1] = "ui/viewres/weekwalk/weekwalklayerpage.prefab",
			[2] = "ui/viewres/weekwalk/weekwalklayerpageitem.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	WeekWalkDialogView = {
		destroy = 0,
		container = "WeekWalkDialogViewContainer",
		mainRes = "ui/viewres/weekwalk/weekwalkdialogview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	WeekWalk_2HeartLayerView = {
		destroy = 0,
		container = "WeekWalk_2HeartLayerViewContainer",
		mainRes = "ui/viewres/weekwalk/weekwalkheart/weekwalkheartlayerview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Internal,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			"ui/viewres/weekwalk/weekwalkheart/weekwalkheartlayerpage.prefab",
			"ui/viewres/weekwalk/weekwalkheart/weekwalkheartlayerpageitem.prefab",
			weekwalkheart_star = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_star.prefab"
		}
	},
	WeekWalk_2HeartView = {
		destroy = 0,
		container = "WeekWalk_2HeartViewContainer",
		mainRes = "ui/viewres/weekwalk/weekwalkheart/weekwalkheartview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			weekwalkheart_star = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_star.prefab"
		}
	},
	WeekWalk_2HeartBuffView = {
		destroy = 0,
		container = "WeekWalk_2HeartBuffViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_buffview.prefab",
		blurFactor = 0.5,
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		otherRes = {
			[1] = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_buffitem.prefab"
		}
	},
	WeekWalk_2HeartResultView = {
		destroy = 0,
		container = "WeekWalk_2HeartResultViewContainer",
		mainRes = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_resultview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		otherRes = {
			weekwalkheart_star = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_star.prefab"
		}
	},
	WeekWalk_2ResetView = {
		bgBlur = 1,
		container = "WeekWalk_2ResetViewContainer",
		mainRes = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_resetview.prefab",
		destroy = 0,
		blurFactor = 0.3,
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Internal,
		otherRes = {
			[1] = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_resetbattleitem.prefab",
			weekwalkheart_star = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_star.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	WeekWalk_2LayerRewardView = {
		bgBlur = 1,
		container = "WeekWalk_2LayerRewardViewContainer",
		mainRes = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_layerrewardview.prefab",
		destroy = 0,
		blurFactor = 0.3,
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_layerrewarditem.prefab",
			weekwalkheart_star = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_star.prefab"
		}
	},
	WeekWalk_2RuleView = {
		destroy = 0,
		container = "WeekWalk_2RuleViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_ruleview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	WeekWalk_2DeepLayerNoticeView = {
		destroy = 0,
		container = "WeekWalk_2DeepLayerNoticeViewContainer",
		mainRes = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_deeplayernoticeview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	},
	MeilanniView = {
		destroy = 0,
		container = "MeilanniViewContainer",
		mainRes = "ui/viewres/meilanni/meilanniview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/meilanni/meilannieventitem.prefab",
			[2] = "ui/viewres/meilanni/meilannidialogitem.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	MeilanniEntrustView = {
		destroy = 0,
		container = "MeilanniEntrustViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/meilanni/meilannientrustview.prefab",
		blurFactor = 0.5,
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	MeilanniBossInfoView = {
		destroy = 0,
		container = "MeilanniBossInfoViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/meilanni/meilannibossinfoview.prefab",
		blurFactor = 0.5,
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	MeilanniSettlementView = {
		destroy = 0,
		container = "MeilanniSettlementViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/meilanni/meilannisettlementview.prefab",
		blurFactor = 0.5,
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	MeilanniMainView = {
		destroy = 0,
		container = "MeilanniMainViewContainer",
		mainRes = "ui/viewres/meilanni/meilannimainview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		otherRes = {},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	MeilanniTaskView = {
		destroy = 0,
		container = "MeilanniTaskViewContainer",
		mainRes = "ui/viewres/meilanni/meilannitaskview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/meilanni/meilannitaskitem.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	DungeonEquipGuideView = {
		destroy = 0,
		container = "DungeonEquipGuideViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/dungeon/dungeonequipguideview.prefab",
		blurFactor = 0.5,
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	},
	GuideTransitionBlackView = {
		destroy = 0,
		container = "LoadingBlackViewContainer",
		mainRes = "ui/viewres/scene/loadingblackview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	DungeonView = {
		container = "DungeonViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/dungeon/dungeonview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Internal,
		otherRes = {
			"ui/viewres/dungeon/dungeonchapteritem.prefab",
			"ui/viewres/dungeon/dungeonreschapteritem.prefab",
			"ui/viewres/dungeon/reappear/reappearitem.prefab",
			RoleStoryTank.prefabPath,
			mini_item = "ui/viewres/dungeon/dungeonchapterminiitem.prefab",
			section_item = "ui/viewres/dungeon/dungeonsectionitem.prefab",
			weekwalkheart_star = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_star.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			},
			{
				{
					DungeonEnum.dungeonweekwalkviewPath
				},
				{
					DungeonEnum.dungeonexploreviewPath
				},
				{
					"ui/viewres/dungeon/reappear/reappearview.prefab"
				},
				{
					DungeonEnum.dungeonweekwalk_2viewPath
				}
			}
		},
		preloader = module_views_preloader,
		customAnimBg = {
			"#go_story/#simage_bg",
			"#go_resource/#simage_resourcebg",
			"#go_resource/#simage_drawbg"
		}
	},
	DungeonMapView = {
		container = "DungeonMapViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/dungeon/dungeonmapview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		otherRes = {
			"ui/viewres/dungeon/chaptermap/chaptermapepisodeitem.prefab",
			"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
			"ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab",
			"ui/viewres/dungeon/chaptermap/dungeonmapinteractiveitem.prefab",
			"ui/viewres/dungeon/chaptermap/map_direction.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		preloader = module_views_preloader
	},
	DungeonHuaRongView = {
		destroy = 0,
		container = "DungeonHuaRongViewContainer",
		mainRes = "ui/viewres/dungeon/dungeonhuarongview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	DungeonMapTaskView = {
		destroy = 0,
		container = "DungeonMapTaskViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/dungeon/dungeonmaptaskview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	},
	DungeonMapLevelView = {
		destroy = 1,
		container = "DungeonMapLevelViewContainer",
		mainRes = "ui/viewres/dungeon/dungeonmaplevelview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		tabRes = {
			{
				{
					CurrencyView.prefabPath
				}
			},
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	DungeonChangeMapStatusView = {
		destroy = 0,
		container = "DungeonChangeMapStatusViewContainer",
		mainRes = "ui/viewres/dungeon/dungeonchangemapstatusview.prefab",
		layer = "TOP",
		viewType = ViewType.Normal
	},
	DungeonRewardTipView = {
		destroy = 0,
		container = "DungeonRewardTipViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/dungeon/dungeonrewardtipview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	},
	DungeonEquipEntryView = {
		destroy = 0,
		container = "DungeonEquipEntryViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/dungeon/dungeonequipentryview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		otherRes = {
			[1] = "ui/viewres/help/helpselectitem.prefab",
			[2] = "ui/viewres/dungeon/dungeonequipentryitem.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	DungeonCumulativeRewardsView = {
		destroy = 0,
		container = "DungeonCumulativeRewardsViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/dungeon/dungeoncumulativerewardsview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		otherRes = {
			[1] = "ui/viewres/dungeon/dungeoncumulativerewardsitem.prefab"
		}
	},
	DungeonCumulativeRewardPackView = {
		destroy = 0,
		container = "DungeonCumulativeRewardPackViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/dungeon/dungeoncumulativerewardpackview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	},
	DungeonFragmentInfoView = {
		destroy = 0,
		container = "DungeonFragmentInfoViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/dungeon/dungeonfragmentinfoview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	},
	DungeonMonsterView = {
		bgBlur = 1,
		container = "DungeonMonsterViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/dungeon/dungeonmonsterview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		customAnimBg = {
			"bg"
		}
	},
	DungeonRewardView = {
		destroy = 0,
		container = "DungeonRewardViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/dungeon/dungeonrewardview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		customAnimBg = {
			"#simage_bg"
		}
	},
	DungeonElementRewardView = {
		bgBlur = 1,
		container = "DungeonElementRewardViewContainer",
		mainRes = "ui/viewres/dungeon/dungeonelementrewardview.prefab",
		destroy = 0,
		blurFactor = 0.3,
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		customAnimBg = {
			"#simage_bg"
		}
	},
	DungeonStoryView = {
		destroy = 0,
		container = "DungeonStoryViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/dungeon/dungeonstoryview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	DungeonStoryEntranceView = {
		destroy = 0,
		container = "DungeonStoryEntranceViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/dungeon/dungeonstoryentranceview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Internal
	},
	ShareTipView = {
		destroy = 0,
		container = "ShareTipViewContainer",
		mainRes = "ui/viewres/share/sharetipview.prefab",
		layer = "TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	LoadingHeadsetView = {
		destroy = 0,
		container = "LoadingHeadsetViewContainer",
		mainRes = "ui/viewres/scene/loadingheadsetview.prefab",
		layer = "TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default
	},
	ShareEditorView = {
		destroy = 0,
		container = "ShareEditorViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/share/shareeditorview.prefab",
		layer = "TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	EquipView = {
		bgBlur = 0,
		container = "EquipViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/equip/equipview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		otherRes = {
			"ui/viewres/equip/equipcategoryitem.prefab",
			"ui/viewres/equip/equipstrengthencostitem.prefab",
			"ui/viewres/equip/equipenchantattritem.prefab",
			"ui/viewres/equip/equipchooseitem.prefab",
			"ui/viewres/equip/equipselecteditem.prefab",
			"ui/viewres/equip/equipbreakcostitem.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			},
			{
				{
					"ui/viewres/equip/equipinfoview.prefab"
				},
				{
					"ui/viewres/equip/equipstrengthenview.prefab"
				},
				{
					"ui/viewres/equip/equiprefineview.prefab"
				},
				{
					"ui/viewres/equip/equipstoryview.prefab"
				}
			},
			{
				{
					CurrencyView.prefabPath
				}
			}
		},
		customAnimBg = {
			"bg"
		}
	},
	AntiqueView = {
		destroy = 0,
		container = "AntiqueViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/antique/antiqueview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	EquipInfoTeamShowView = {
		bgBlur = 1,
		container = "EquipInfoTeamShowViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/equip/equipinfoteamshowview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Internal,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			[1] = "ui/viewres/equip/equipinfoteamshowitem.prefab"
		}
	},
	EquipTeamView = {
		bgBlur = 4,
		container = "EquipTeamViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/equip/equipteamview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Internal,
		otherRes = {
			"ui/viewres/common/item/commonequipicon.prefab",
			"ui/viewres/equip/equipteamitem.prefab",
			"ui/viewres/equip/equipteamattritem.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		customAnimBg = {
			"bg"
		}
	},
	EquipTeamShowView = {
		destroy = 0,
		container = "EquipTeamShowViewContainer",
		mainRes = "ui/viewres/equip/equipteamshowview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/equip/equipteamshowitem.prefab",
			[2] = "ui/viewres/equip/equipteamshowattritem.prefab"
		},
		customAnimBg = {
			"item1/#go_container/frame",
			"item2/#go_container/frame",
			"item3/#go_container/frame"
		}
	},
	EquipInfoTipsView = {
		destroy = 0,
		container = "EquipInfoTipsViewContainer",
		mainRes = "ui/viewres/equip/equipinfotipsview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	EquipChooseView = {
		destroy = 0,
		container = "EquipChooseViewContainer",
		mainRes = "ui/viewres/equip/equipchooseview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/common/item/commonequipicon.prefab"
		},
		customAnimBg = {
			"Image"
		}
	},
	EquipBreakResultView = {
		destroy = 0,
		container = "EquipBreakResultViewContainer",
		mainRes = "ui/viewres/equip/equipbreakresultview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		customAnimBg = {
			"bg"
		}
	},
	EquipSkillLevelUpView = {
		destroy = 0,
		container = "EquipSkillLevelUpViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/equip/equipskilllevelupview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	EquipComposeView = {
		bgBlur = 1,
		container = "EquipComposeViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/equip/equipcomposeview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/equip/equipcomposeitem.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		customAnimBg = {
			"bg/Image",
			"bg/frame"
		}
	},
	EquipSkillTipView = {
		bgBlur = 0,
		container = "EquipSkillTipViewContainer",
		maskAlpha = 0,
		destroy = 0,
		mainRes = "ui/viewres/equip/equipskilltipview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/equip/equipskillcharacteritem.prefab"
		},
		customAnimBg = {
			"#go_skill/bg",
			"#go_character/bg"
		}
	},
	EquipEnchantResultView = {
		bgBlur = 1,
		container = "EquipEnchantResultViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/equip/equipenchantresultview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/equip/equipenchantresultattritem.prefab"
		},
		customAnimBg = {
			"Image",
			"frame"
		}
	},
	EquipEnchantLookView = {
		bgBlur = 1,
		container = "EquipEnchantLookViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/equip/equipenchantlookview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/equip/equipenchantattritem.prefab"
		},
		customAnimBg = {
			"#btn_close",
			"frame"
		}
	},
	EquipStrengthenAlertView = {
		destroy = 0,
		container = "EquipStrengthenAlertViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/equip/equipstrengthenalertview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		customAnimBg = {
			"bg1",
			"bg2"
		}
	},
	EquipDecomposeView = {
		destroy = 0,
		container = "EquipDecomposeViewContainer",
		mainRes = "ui/viewres/equip/equipdecomposeview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Internal,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			[1] = "ui/viewres/equip/equipcomposeitem.prefab"
		}
	},
	TestUIView = {
		destroy = 0,
		container = "TestUIViewContainer",
		mainRes = "ui/viewres/test/testuiview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	CharacterView = {
		destroy = 0,
		container = "CharacterViewContainer",
		mainRes = "ui/viewres/character/characterview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Internal,
		otherRes = {
			[1] = "ui/spriteassets/characterget.asset"
		},
		customAnimBg = {
			"bgcanvas/bg"
		}
	},
	CharacterEquipSettingView = {
		destroy = 0,
		container = "CharacterEquipSettingViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/character/characterequipsettingview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/character/characterequipsettingitem.prefab"
		}
	},
	CharacterSkinView = {
		destroy = 0,
		container = "CharacterSkinViewContainer",
		mainRes = "ui/viewres/character/characterskinview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Internal,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	CharacterSkinTipView = {
		destroy = 0,
		container = "CharacterSkinTipViewContainer",
		mainRes = "ui/viewres/character/characterskinview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Internal,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	CharacterSkinTagView = {
		bgBlur = 4,
		container = "CharacterSkinTagViewContainer",
		maskAlpha = 0,
		destroy = 0,
		mainRes = "ui/viewres/character/characterskintagview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	},
	CharacterSwitchView = {
		destroy = 0,
		container = "CharacterSwitchViewContainer",
		mainRes = "ui/viewres/character/characterswitchview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Internal,
		otherRes = {
			[1] = "ui/viewres/character/characterswitchitem.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	CharacterSkinFullScreenView = {
		destroy = 0,
		container = "CharacterSkinFullScreenViewContainer",
		mainRes = "ui/viewres/character/characterskinfullscreenview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	CharacterSkinGainView = {
		destroy = 0,
		container = "CharacterSkinGainViewContainer",
		mainRes = "ui/viewres/character/characterskingainview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		customAnimBg = {
			"bg"
		}
	},
	CharacterGetView = {
		destroy = 0,
		container = "CharacterGetViewContainer",
		mainRes = "ui/viewres/character/charactergetview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		customAnimBg = {
			"#go_bg"
		}
	},
	CharacterSkinGetDetailView = {
		destroy = 0,
		container = "CharacterSkinGetDetailViewContainer",
		mainRes = "ui/viewres/character/characterskingetdetailview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	CharacterTipView = {
		bgBlur = 2,
		container = "CharacterTipViewContainer",
		maskAlpha = 0,
		destroy = 0,
		mainRes = "ui/viewres/character/charactertipview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		customAnimBg = {
			"#go_attributetip/bg",
			"#go_careertip/bg",
			"#go_skilltip/skilltip1/skillbg",
			"#go_skilltip/skilltip2/skillbg/bg",
			"#go_passiveskilltip/talentbg"
		}
	},
	CharacterBackpackView = {
		container = "CharacterBackpackViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/character/characterbackpackview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Internal,
		otherRes = {
			"ui/viewres/common/item/commonheroitemnew.prefab",
			"ui/viewres/character/charactercategoryitem.prefab",
			"ui/viewres/common/item/commonequipicon.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			},
			{
				{
					"ui/viewres/character/characterbackpackheroview.prefab"
				},
				{
					"ui/viewres/character/characterbackpackequipview.prefab"
				}
			}
		},
		preloader = module_views_preloader,
		customAnimBg = {
			"bg"
		}
	},
	CharacterBackpackSearchFilterView = {
		destroy = 0,
		container = "CharacterBackpackSearchFilterViewContainer",
		mainRes = "ui/viewres/character/characterbackpacksearchfilterview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	CharacterRankUpView = {
		destroy = 0,
		container = "CharacterRankUpViewContainer",
		mainRes = "ui/viewres/character/characterrankupview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/character/characterrankupitem.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			},
			{
				{
					CurrencyView.prefabPath
				}
			}
		}
	},
	CharacterRankUpResultView = {
		destroy = 0,
		container = "CharacterRankUpResultViewContainer",
		mainRes = "ui/viewres/character/characterrankupresultview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Internal,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	CharacterExSkillView = {
		container = "CharacterExSkillViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/character/characterexskillview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/character/characterskilldescripte.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		customAnimBg = {
			"bg"
		}
	},
	CharacterLevelUpView = {
		bgBlur = 2,
		container = "CharacterLevelUpViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/character/characterlevelupview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Internal,
		tabRes = {
			{
				{
					CurrencyView.prefabPath
				}
			}
		},
		customAnimBg = {
			"bg"
		}
	},
	CharacterTalentView = {
		destroy = 0,
		container = "CharacterTalentViewContainer",
		mainRes = "ui/viewres/character/charactertalentup/charactertalentview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Internal,
		otherRes = {
			[1] = "ui/spriteassets/charactertalentup.asset"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	CharacterGuideTalentView = {
		destroy = 0,
		container = "CharacterGuideTalentViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/character/characterguidetalentview.prefab",
		blurFactor = 0.3,
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	},
	CharacterTalentChessView = {
		destroy = 0,
		container = "CharacterTalentChessViewContainer",
		mainRes = "ui/viewres/character/charactertalentup/charactertalentchessview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Internal,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	CharacterTalentModifyNameView = {
		bgBlur = 3,
		container = "CharacterTalentModifyNameViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/character/charactertalentup/charactertalentmodifynameview.prefab",
		blurFactor = 0.4,
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	CharacterTalentLevelUpView = {
		destroy = 0,
		container = "CharacterTalentLevelUpViewContainer",
		mainRes = "ui/viewres/character/charactertalentup/charactertalentlevelupview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Internal,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			},
			{
				{
					CurrencyView.prefabPath
				}
			}
		}
	},
	CharacterTalentLevelUpPreview = {
		destroy = 0,
		container = "CharacterTalentLevelUpPreviewContainer",
		bgBlur = 2,
		mainRes = "ui/viewres/character/charactertalentup/charactertalentleveluppreview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	CharacterTalentLevelUpResultView = {
		destroy = 0,
		container = "CharacterTalentLevelUpResultViewContainer",
		mainRes = "ui/viewres/character/charactertalentup/charactertalentlevelupresultview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Internal,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	CharacterTalentTipView = {
		bgBlur = 2,
		container = "CharacterTalentTipViewContainer",
		maskAlpha = 0,
		destroy = 0,
		mainRes = "ui/viewres/character/charactertalentup/charactertalenttipview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		customAnimFadeTime = {
			0.2,
			0.25
		}
	},
	CharacterTalentStyleView = {
		destroy = 0,
		container = "CharacterTalentStyleViewContainer",
		mainRes = "ui/viewres/character/charactertalentup/charactertalentstyleview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			},
			{
				{
					CurrencyView.prefabPath
				}
			}
		}
	},
	CharacterTalentStatView = {
		destroy = 0,
		container = "CharacterTalentStatViewContainer",
		mainRes = "ui/viewres/character/charactertalentup/charactertalentstatview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	},
	CharacterTalentChessFilterView = {
		destroy = 0,
		container = "CharacterTalentChessFilterViewContainer",
		mainRes = "ui/viewres/character/charactertalentup/charactertalentchessfilterview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	},
	CharacterTalentChessCopyView = {
		destroy = 0,
		container = "CharacterTalentChessCopyViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/room/layout/roomlayoutcopyview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	},
	CharacterTalentUseLayoutView = {
		destroy = 0,
		container = "CharacterTalentUseLayoutViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/character/charactertalentup/charactertalentuselayoutview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	},
	CharacterDestinySlotView = {
		destroy = 0,
		container = "CharacterDestinySlotViewContainer",
		mainRes = "ui/viewres/character/characterdestiny/characterdestinyslotview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Nomal,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	CharacterDestinyStoneView = {
		destroy = 0,
		container = "CharacterDestinyStoneViewContainer",
		mainRes = "ui/viewres/character/characterdestiny/characterdestinystoneview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Nomal,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	GMToolView = {
		destroy = 0,
		container = "GMToolViewContainer",
		mainRes = "ui/viewres/gm/gmtoolview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	},
	GMToolView2 = {
		destroy = 0,
		container = "GMToolViewContainer",
		mainRes = "ui/viewres/gm/gmtoolview.prefab",
		layer = "TOP",
		viewType = ViewType.Modal
	},
	GMToolFastAddHeroView = {
		destroy = 0,
		container = "GMToolFastAddHeroViewContainer",
		mainRes = "ui/viewres/gm/gmtoolfastaddheroview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	},
	GMAudioBankView = {
		destroy = 0,
		container = "GMAudioBankViewContainer",
		mainRes = "ui/viewres/gm/gmaudiobankview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	},
	GMPostProcessView = {
		destroy = 0,
		container = "GMPostProcessViewContainer",
		mainRes = "ui/viewres/gm/gmpostprocess.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	},
	GMFightSimulateView = {
		destroy = 0,
		container = "GMFightSimulateViewContainer",
		mainRes = "ui/viewres/gm/gmfightsimulateview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	},
	GMGuideStatusView = {
		destroy = 0,
		container = "GMGuideStatusViewContainer",
		mainRes = "ui/viewres/gm/gmguidestatusview.prefab",
		layer = "TOP",
		viewType = ViewType.Normal
	},
	GMHelpViewBrowseView = {
		destroy = 0,
		container = "GMHelpViewBrowseViewContainer",
		mainRes = "ui/viewres/gm/gmhelpviewbrowseview.prefab",
		layer = "TOP",
		viewType = ViewType.Normal
	},
	GMResetCardsView = {
		destroy = 0,
		container = "GMResetCardsViewContainer",
		mainRes = "ui/viewres/gm/gmresetcardsview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		otherRes = {
			[1] = "ui/viewres/fight/fightcarditem.prefab"
		}
	},
	GMSummonView = {
		destroy = 0,
		container = "GMSummonViewContainer",
		mainRes = "ui/viewres/gm/gmsummonview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	},
	GMVideoList = {
		destroy = 0,
		container = "GMVideoListContainer",
		mainRes = "ui/viewres/gm/gmfightsimulateview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	},
	GMVideoPlayView = {
		destroy = 0,
		container = "GMVideoPlayViewContainer",
		mainRes = "ui/viewres/main/limitedroleview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	},
	GMLangTxtView = {
		destroy = 0,
		container = "GMLangTxtViewContainer",
		mainRes = "ui/viewres/gm/gmlangtxtview.prefab",
		layer = "TOP",
		viewType = ViewType.Normal
	},
	HierarchyView = {
		destroy = 0,
		container = "HierarchyViewContainer",
		mainRes = "ui/viewres/gm/runtimehierarchy.prefab",
		layer = "TOP",
		viewType = ViewType.Normal
	},
	CommonPropView = {
		destroy = 0,
		container = "CommonPropViewContainer",
		mainRes = "ui/viewres/common/commonpropview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/common/commonpropitem.prefab"
		},
		customAnimBg = {
			"blackbg"
		}
	},
	GiftMultipleChoiceView = {
		bgBlur = 1,
		container = "GiftMultipleChoiceViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/gift/giftmultiplechoiceview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/gift/giftmultiplechoiceitem.prefab"
		},
		customAnimBg = {
			"bg"
		}
	},
	OptionalGiftMultipleChoiceView = {
		bgBlur = 1,
		container = "OptionalGiftMultipleChoiceViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/gift/giftmultiplechoiceview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/gift/giftmultiplechoiceitem.prefab"
		},
		customAnimBg = {
			"bg"
		}
	},
	CustomPickChoiceView = {
		destroy = 0,
		container = "CustomPickChoiceViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/summon/custompick/summoncustompickchoice.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	NewbieCustomPickView = {
		destroy = 0,
		container = "NewbieCustomPickViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/store/storenewbiechoosepickchoice.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	SignInView = {
		bgBlur = 1,
		container = "SignInViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/signin/signinview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/signin/signinitem.prefab",
			[2] = SignInEnum.ResPath.lifecirclesignview,
			[3] = SignInEnum.ResPath.lifecirclesignrewardsitem
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	SignInDetailView = {
		destroy = 0,
		container = "SignInDetailViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/signin/signindetailview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	},
	ActivityNormalView = {
		bgBlur = 1,
		container = "ActivityNormalViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/activity/activitynormalview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Internal,
		otherRes = {
			[1] = "ui/viewres/activity/activitynormalcategoryitem.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		customAnimBg = {}
	},
	ActivityNorSignView = {
		bgBlur = 0,
		container = "ActivityNorSignViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/activity/activitynorsignview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/activity/activitynorsignitem.prefab"
		},
		customAnimBg = {}
	},
	ActivityBeginnerView = {
		bgBlur = 1,
		container = "ActivityBeginnerViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/activity/activitybeginnerview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/activity/activitynormalcategoryitem.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		customAnimBg = {}
	},
	ActivityNoviceSignView = {
		bgBlur = 0,
		container = "ActivityNoviceSignViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/activity/activitynovicesignview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/activity/activitynovicesignitem.prefab"
		},
		customAnimBg = {}
	},
	ActivityNoviceInsightView = {
		destroy = 0,
		container = "ActivityNoviceInsightViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/activity/activitynoviceinsightview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		customAnimBg = {}
	},
	ActivityTipView = {
		destroy = 0,
		container = "ActivityTipViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/activity/activitytipview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		customAnimBg = {
			"bg"
		}
	},
	MaterialTipView = {
		bgBlur = 1,
		container = "MaterialTipViewContainer",
		mainRes = "ui/viewres/tips/materialtipview.prefab",
		destroy = 0,
		blurIterations = 3,
		blurFactor = 0.85,
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		desampleRate = PostProcessingMgr.DesamplingRate.x8,
		reduceRate = PostProcessingMgr.DesamplingRate.x8,
		customAnimBg = {
			"bg"
		}
	},
	MaterialPackageTipView = {
		container = "MaterialPackageTipViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/tips/materialtipview.prefab",
		destroy = 0,
		blurIterations = 3,
		blurFactor = 0.85,
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		desampleRate = PostProcessingMgr.DesamplingRate.x8,
		reduceRate = PostProcessingMgr.DesamplingRate.x8,
		anim = ViewAnim.Default,
		customAnimBg = {
			"bg"
		}
	},
	RoomManufactureMaterialTipView = {
		destroy = 0,
		container = "RoomManufactureMaterialTipViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/room/critter/roomcrittermaterialtipview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	},
	HelpView = {
		bgBlur = 1,
		container = "HelpViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/help/helpview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {
			"ui/viewres/help/helpselectitem.prefab",
			"ui/viewres/help/helpcontentitem.prefab",
			"ui/viewres/help/vahelpcontentitem.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		customAnimBg = {}
	},
	HelpPageTabView = {
		bgBlur = 1,
		container = "HelpPageTabViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/help/helppagetabview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {
			"ui/viewres/help/helpselectitem.prefab",
			"ui/viewres/help/helpcontentitem.prefab",
			"ui/viewres/help/vahelpcontentitem.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			},
			{
				{
					"ui/viewres/help/helpview.prefab"
				}
			},
			{
				{
					"ui/viewres/help/helpcontentvideoitem.prefab"
				}
			}
		},
		customAnimBg = {}
	},
	LoadingView = {
		destroy = 999999,
		container = "LoadingViewContainer",
		mainRes = "ui/viewres/scene/loadingview.prefab",
		layer = "TOP",
		viewType = ViewType.Normal
	},
	LoadingBlackView = {
		destroy = 1,
		container = "LoadingBlackViewContainer",
		mainRes = "ui/viewres/scene/loadingblackview.prefab",
		layer = "TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	},
	LoadingBlackView2 = {
		destroy = 1,
		container = "LoadingBlackViewContainer",
		mainRes = "ui/viewres/scene/loadingblackview.prefab",
		layer = "TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		customAnimFadeTime = {
			0.3,
			0.2
		}
	},
	LoadingRoomView = {
		destroy = 1,
		container = "LoadingRoomViewContainer",
		mainRes = "ui/viewres/scene/loadingroomview.prefab",
		layer = "TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		customAnimFadeTime = {
			2,
			1.5
		}
	},
	LoadingDownloadView = {
		destroy = 1,
		container = "LoadingDownloadViewContainer",
		mainRes = "ui/viewres/scene/loadingdownloadview.prefab",
		layer = "TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "singlebg/loading/full/originbg.png"
		}
	},
	HeroGroupFightView = {
		bgBlur = 4,
		container = "HeroGroupFightViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/herogroup/herogroupview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Internal,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			},
			{
				{
					CurrencyView.prefabPath
				}
			}
		},
		otherRes = {
			[1] = "ui/viewres/fight/clothskill.prefab"
		}
	},
	HeroGroupFightRuleDescView = {
		destroy = 0,
		container = "HeroGroupFightRuleDescViewContainer",
		mainRes = "ui/viewres/herogroup/herogroupruledescview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
}

var_0_0.V1a2_HeroGroupFightView = tabletool.copy(var_0_0.HeroGroupFightView)
var_0_0.V1a2_HeroGroupFightView.container = "V1a2_HeroGroupFightViewContainer"
var_0_0.V1a2_HeroGroupFightView.mainRes = "ui/viewres/versionactivity_1_2/versionactivity_1_2_herogroupview.prefab"
var_0_0.V1a3_HeroGroupFightView = tabletool.copy(var_0_0.HeroGroupFightView)
var_0_0.V1a3_HeroGroupFightView.container = "V1a3_HeroGroupFightViewContainer"
var_0_0.V1a5_HeroGroupFightView = tabletool.copy(var_0_0.HeroGroupFightView)
var_0_0.V1a5_HeroGroupFightView.container = "V1a5_HeroGroupFightViewContainer"
var_0_0.V1a6_HeroGroupFightView = tabletool.copy(var_0_0.HeroGroupFightView)
var_0_0.V1a6_HeroGroupFightView.container = "V1a6_HeroGroupFightViewContainer"
var_0_0.HeroGroupFightWeekwalkView = tabletool.copy(var_0_0.HeroGroupFightView)
var_0_0.HeroGroupFightWeekwalkView.container = "HeroGroupFightWeekwalkViewContainer"
var_0_0.HeroGroupFightWeekwalk_2View = tabletool.copy(var_0_0.HeroGroupFightView)
var_0_0.HeroGroupFightWeekwalk_2View.otherRes.weekwalkheart_star = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_star.prefab"
var_0_0.HeroGroupFightWeekwalk_2View.container = "HeroGroupFightWeekwalk_2ViewContainer"
var_0_0.HeroGroupBalanceTipView = {
	destroy = 0,
	container = "HeroGroupBalanceTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/herogroup/herogroupbalancetipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.HeroGroupModifyNameView = {
	bgBlur = 3,
	container = "HeroGroupModifyNameViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/herogroup/herogroupmodifynameview.prefab",
	blurFactor = 0.4,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.HeroGroupRecommendView = {
	bgBlur = 1,
	container = "HeroGroupRecommendViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/herogroup/herogrouprecomendview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/herogroup/herogrouprecommendcharacter.prefab",
		[2] = "ui/viewres/herogroup/herogrouprecommendgroup.prefab"
	}
}
var_0_0.HeroGroupEditView = {
	container = "HeroGroupEditViewContainer",
	destroy = 5,
	mainRes = "ui/viewres/herogroup/herogroupeditview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/herogroup/herogroupedititem.prefab",
		[2] = "ui/viewres/herogroup/herogroupquickedititem.prefab"
	},
	customAnimBg = {
		"bg"
	}
}
var_0_0.HeroGroupCareerTipView = {
	destroy = 0,
	container = "HeroGroupCareerTipViewContainer",
	bgBlur = 2,
	mainRes = "ui/viewres/herogroup/herogroupcareertipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"#go_bg/bg"
	}
}
var_0_0.BaseEnemyInfoView = {
	bgBlur = 1,
	container = "BaseEnemyInfoViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/enemyinfo/baseenemyinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	customAnimBg = {
		"bg_container/#simage_bg",
		"bg_container/#simage_rightbg"
	},
	otherRes = {
		FightEntityResistanceComp.FightResistancePath
	}
}
var_0_0.WeekWalk_2EnemyInfoView = {
	bgBlur = 1,
	container = "BaseEnemyInfoViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/enemyinfo/baseenemyinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	customAnimBg = {
		"bg_container/#simage_bg",
		"bg_container/#simage_rightbg"
	},
	otherRes = {
		FightEntityResistanceComp.FightResistancePath,
		weekwalkheart_star = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_star.prefab"
	}
}
var_0_0.FightAttributeTipView = {
	destroy = 0,
	container = "FightAttributeTipViewContainer",
	mainRes = "ui/viewres/fight/fightattributetipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.SkillTipView = {
	destroy = 0,
	container = "SkillTipViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/tips/skilltipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"#go_newskilltip/skillbg"
	}
}
var_0_0.SkillTipView3 = {
	bgBlur = 1,
	container = "SkillTipViewContainer",
	maskAlpha = 0,
	destroy = 0,
	mainRes = "ui/viewres/tips/skilltipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"#go_newskilltip/skillbg"
	}
}
var_0_0.CommonBuffTipView = {
	destroy = 10,
	container = "CommonBuffTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/commonbufftipview/commonbufftipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.PlayerClothView = {
	bgBlur = 1,
	container = "PlayerClothViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/player/playerclothview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	customAnimBg = {
		"frame/imgBg",
		"titlebg"
	}
}
var_0_0.PlayerClothGuideView = {
	destroy = 0,
	container = "PlayerClothGuideViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/player/playerclothguideview.prefab",
	blurFactor = 0.3,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.MailView = {
	bgBlur = 1,
	container = "MailViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/mail/mailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/mail/mailcategoryitem.prefab",
		[2] = "ui/viewres/mail/mailrewarditem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	customAnimBg = {
		"mailtipview/bg/#simage_mailBg",
		"bg"
	}
}
var_0_0.StoryView = {
	destroy = 0,
	container = "StoryViewContainer",
	maskAlpha = 0,
	mainRes = "ui/viewres/story/storyview.prefab",
	layer = "POPUP_SECOND",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		AvProMgrConfig.UrlStoryVideo,
		AvProMgrConfig.UrlStoryVideoCompatible,
		[3] = "ui/viewres/story/storyslidedialog.prefab",
		[4] = AvProMgrConfig.UrlVideoDisable
	}
}
var_0_0.StoryLeadRoleSpineView = {
	destroy = 0,
	container = "StoryLeadRoleSpineViewContainer",
	maskAlpha = 0,
	mainRes = "ui/viewres/story/storyleadrolespineview.prefab",
	layer = "POPUPBlur",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {}
}
var_0_0.StoryLogView = {
	container = "StoryLogViewContainer",
	maskAlpha = 0,
	destroy = 0,
	mainRes = "ui/viewres/story/storylogview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/story/storylogitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.StoryBranchView = {
	destroy = 0,
	container = "StoryBranchViewContainer",
	mainRes = "ui/viewres/story/storybranchview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {}
}
var_0_0.StoryFrontView = {
	container = "StoryFrontViewContainer",
	maskAlpha = 0,
	destroy = 0,
	mainRes = "ui/viewres/story/storyfrontview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/story/storyshake.prefab"
	}
}
var_0_0.StoryBackgroundView = {
	destroy = 0.1,
	container = "StoryBackgroundViewContainer",
	mainRes = "ui/viewres/story/storybackgroundview.prefab",
	layer = "POPUP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/story/storyrightmove.prefab",
		[2] = "ui/viewres/story/storyleftmove.prefab"
	}
}
var_0_0.StoryHeroView = {
	destroy = 0,
	container = "StoryHeroViewContainer",
	mainRes = "ui/viewres/story/storyheroview.prefab",
	layer = "POPUP_SECOND",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.StorySceneView = {
	destroy = 0,
	container = "StorySceneViewContainer",
	mainRes = "ui/viewres/story/storysceneview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.StoryTyperView = {
	destroy = 0,
	container = "StoryTyperViewContainer",
	mainRes = "ui/viewres/story/storytyperview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.StoryPrologueSkipView = {
	destroy = 0,
	container = "StoryPrologueSkipViewContainer",
	mainRes = "ui/viewres/story/storyprologueskipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.ProtoTestView = {
	destroy = 0,
	container = "ProtoTestViewContainer",
	mainRes = "ui/viewres/gm/prototestview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.ProtoModifyView = {
	destroy = 0,
	container = "ProtoModifyViewContainer",
	mainRes = "ui/viewres/gm/protomodifyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.DungeonPuzzleChangeColorView = {
	destroy = 0,
	container = "DungeonPuzzleChangeColorViewContainer",
	mainRes = "ui/viewres/dungeon/puzzle/dungeonpuzzlechangecolorview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.PlayerView = {
	destroy = 0,
	container = "PlayerViewContainer",
	mainRes = "ui/viewres/player/playerview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	customAnimBg = {
		"bg"
	},
	otherRes = {
		[1] = "ui/viewres/achievement/achievementmainicon.prefab"
	}
}
var_0_0.PlayerChangeBgView = {
	destroy = 0,
	container = "PlayerChangeBgViewContainer",
	mainRes = "ui/viewres/player/playerchangebgview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.PlayerChangeBgListView = {
	destroy = 0,
	container = "PlayerChangeBgListViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/player/playerchangebglistview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.PlayerIdView = {
	bgBlur = 0,
	container = "PlayerIdViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/player/playeridview.prefab",
	viewType = ViewType.Normal,
	layer = UILayerName.IDCanvasPopUp,
	anim = ViewAnim.Default
}
var_0_0.ShowCharacterView = {
	container = "ShowCharacterViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/player/showcharacterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/player/showcharactercarditem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	customAnimBg = {
		"bg"
	}
}
var_0_0.IconTipView = {
	bgBlur = 1,
	container = "IconTipViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/player/icontipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/player/iconitem.prefab"
	},
	customAnimBg = {
		"window/FrameBg",
		"window/leftBg",
		"window/#simage_titleBg"
	}
}
var_0_0.CharacterDataView = {
	container = "CharacterDataViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/character/characterdata/characterdataview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/character/characterdata/characterdatatitleview.prefab"
			},
			{
				"ui/viewres/character/characterdata/characterdatavoiceview.prefab"
			},
			{
				"ui/viewres/character/characterdata/characterdataitemview.prefab"
			},
			{
				"ui/viewres/character/characterdata/characterdatacultureview.prefab"
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/character/characterdata/charactervoiceitem.prefab"
	},
	customAnimBg = {
		"bottom/#go_bottombg",
		"content1/1view/CharacterDataTitleView/bg"
	}
}
var_0_0.CharacterDataUttuView = {
	destroy = 0,
	container = "CharacterDataUttuViewContainer",
	mainRes = "ui/viewres/character/characterdata/characterdatauttuview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	customAnimBg = {
		"#simage_bg"
	}
}
var_0_0.CommonInputView = {
	destroy = 0,
	container = "CommonInputViewContainer",
	bgBlur = 2,
	mainRes = "ui/viewres/common/commoninputview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"imgBg",
		"imgBg2"
	}
}
var_0_0.TaskView = {
	bgBlur = 1,
	container = "TaskViewContainer",
	mainRes = "ui/viewres/task/taskview.prefab",
	destroy = 0,
	blurFactor = 0.4,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		"ui/viewres/task/taskcommonitem.prefab",
		"ui/viewres/task/tasknovicenormalitem.prefab",
		"ui/viewres/task/tasknovicegrowitem.prefab",
		"ui/viewres/task/tasknovicespitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/task/tasknoviceview.prefab"
			},
			{
				"ui/viewres/task/taskdailyview.prefab"
			},
			{
				"ui/viewres/task/taskweeklyview.prefab"
			}
		}
	},
	preloader = module_views_preloader
}
var_0_0.SettingsPCSystemView = {
	destroy = 0,
	container = "SettingsPCSystemViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/settings/settingspcsystemview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.SettingsView = {
	container = "SettingsViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/settings/settingsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	customAnimFadeTime = {
		0,
		0.14
	},
	otherRes = {
		[1] = "ui/viewres/settings/settingscategorylistitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/settings/settingspcview.prefab"
			},
			{
				"ui/viewres/settings/settingsaccountview.prefab"
			},
			{
				"ui/viewres/settings/settingsgraphicsview.prefab"
			},
			{
				"ui/viewres/settings/settingssoundview.prefab"
			},
			{
				"ui/viewres/settings/settingspushview.prefab"
			},
			{
				"ui/viewres/settings/settingslanguageview.prefab"
			},
			{
				"ui/viewres/settings/settingsgameview.prefab"
			}
		}
	},
	customAnimBg = {
		"bg"
	}
}
var_0_0.SettingsVoicePackageView = {
	bgBlur = 1,
	container = "SettingsVoicePackageViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/settings/settingsvoicepackageview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/settings/settingsvoicepackagelistitem.prefab"
	},
	customAnimBg = {
		"bg"
	}
}
var_0_0.SettingsVoiceDownloadView = {
	destroy = 0,
	container = "SettingsVoiceDownloadViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/settings/settingsvoicedownloadview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	}
}
var_0_0.SettingsVoicePackageTopView = {
	destroy = 0,
	container = "SettingsVoicePackageViewContainer",
	mainRes = "ui/viewres/settings/settingsvoicepackageview.prefab",
	layer = "TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/settings/settingsvoicepackagelistitem.prefab"
	},
	customAnimBg = {
		"bg"
	}
}
var_0_0.SettingsCdkeyView = {
	destroy = 0,
	container = "SettingsCdkeyViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/settings/settingscdkeyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	}
}
var_0_0.KeyMapAlertView = {
	destroy = 0,
	container = "KeyMapAlertViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/pc/pcbuttonconfirmview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.SettingsRoleVoiceView = {
	container = "SettingsRoleVoiceViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/herogroup/herovoiceeditview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/common/item/commonheroitemnew.prefab"
	},
	customAnimBg = {
		"bg"
	}
}
var_0_0.GuideView = {
	destroy = 100,
	container = "GuideViewContainer",
	mainRes = "ui/viewres/guide/guideview.prefab",
	layer = "GUIDE",
	viewType = ViewType.Normal,
	otherRes = {
		[1] = "ui/viewres/effect/edge/ui_edge_square_red.prefab",
		[2] = "ui/viewres/effect/edge/ui_edge_square_yellow.prefab"
	}
}
var_0_0.GuideView2 = {
	destroy = 0,
	container = "GuideViewContainer",
	mainRes = "ui/viewres/guide/guideview.prefab",
	layer = "MESSAGE",
	viewType = ViewType.Normal,
	otherRes = {
		[1] = "ui/viewres/effect/edge/ui_edge_square_red.prefab",
		[2] = "ui/viewres/effect/edge/ui_edge_square_yellow.prefab"
	}
}
var_0_0.GuideStepEditor = {
	destroy = 0,
	container = "GuideStepEditorContainer",
	mainRes = "ui/viewres/guide/guidestepeditor.prefab",
	layer = "MESSAGE",
	viewType = ViewType.Normal,
	otherRes = {
		[1] = "ui/viewres/effect/edge/ui_edge_square_red.prefab",
		[2] = "ui/viewres/effect/edge/ui_edge_square_red.prefab"
	}
}
var_0_0.StoreView = {
	container = "StoreViewContainer",
	monthCardRes = "ui/viewres/store/storemonthcardview.prefab",
	destroy = 0,
	mainRes = "ui/viewres/store/storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		},
		{
			{
				"ui/viewres/store/normalstoreview.prefab"
			},
			{
				"ui/viewres/store/chargestoreview.prefab"
			},
			{
				"ui/viewres/store/storeskinview.prefab"
			},
			{
				"ui/viewres/store/packagestoreview.prefab"
			},
			{
				"ui/viewres/store/recommendstoreview.prefab"
			},
			{
				"ui/viewres/store/roomstoreview.prefab"
			},
			{
				"ui/viewres/store/decoratestoreview.prefab"
			}
		},
		{
			{
				"ui/viewres/store/storemonthcardview.prefab"
			},
			{
				"ui/viewres/store/giftpacksview.prefab"
			},
			{
				"ui/viewres/battlepass/bpenterview.prefab"
			},
			{
				"ui/viewres/store/storenewbiechooseview.prefab"
			},
			{
				"ui/viewres/store/storeroleskinview.prefab"
			},
			{
				"ui/viewres/store/storeblockpackageview.prefab"
			},
			[8] = {
				"ui/viewres/store/v1a4_giftrecommendview2.prefab"
			},
			[9] = {
				"ui/viewres/store/storeseasoncardview.prefab"
			},
			[10] = {
				"ui/viewres/store/storeskinbagview.prefab"
			}
		},
		{
			{
				"ui/viewres/store/roomcritterstoreview.prefab"
			}
		},
		{
			{
				"ui/viewres/store/storesummonview.prefab"
			}
		}
	},
	otherRes = {
		"ui/viewres/store/normalstoregoodsitem.prefab",
		"ui/viewres/store/chargestoregoodsitem.prefab",
		"ui/viewres/store/storeskingoodsitem.prefab",
		"ui/viewres/store/packagestoregoodsitem.prefab",
		"ui/viewres/store/summonstoregoodsitem.prefab",
		"ui/viewres/store/decoratestoreitem.prefab",
		achieveitem = "ui/viewres/achievement/achievementmainicon.prefab"
	},
	customAnimBg = {
		"#go_store/bg"
	}
}
var_0_0.StoreSkinConfirmView = {
	bgBlur = 1,
	container = "StoreSkinConfirmViewContainer",
	maskAlpha = 0,
	destroy = 0,
	mainRes = "ui/viewres/store/storeskinconfirmview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.DecorateStoreDefaultShowView = {
	destroy = 0,
	container = "DecorateStoreDefaultShowViewContainer",
	mainRes = "ui/viewres/store/decoratestoredefaultshowview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
var_0_0.StoreTipView = {
	bgBlur = 1,
	container = "StoreTipViewContainer",
	maskAlpha = 0.5,
	mainRes = "ui/viewres/store/storetipview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	anim = ViewAnim.Default
}
var_0_0.StoreSkinPreviewView = {
	destroy = 0,
	container = "StoreSkinPreviewViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/character/characterskinview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.StoreSkinGoodsView = {
	bgBlur = 1,
	container = "StoreSkinGoodsViewContainer",
	mainRes = "ui/viewres/store/storeskingoodsview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.NormalStoreGoodsView = {
	container = "NormalStoreGoodsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/store/normalstoregoodsview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.ChargeStoreGoodsView = {
	destroy = 0,
	container = "ChargeStoreGoodsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/store/chargestoregoodsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	}
}
var_0_0.DecorateStoreGoodsView = {
	bgBlur = 1,
	container = "DecorateStoreGoodsViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/store/decoratestoregoodsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.PackageStoreGoodsView = {
	container = "PackageStoreGoodsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/store/packagestoregoodsview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.SummonStoreGoodsView = {
	container = "SummonStoreGoodsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/store/summonstoregoodsview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.SocialView = {
	bgBlur = 1,
	container = "SocialViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/social/socialview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	otherRes = {
		"ui/viewres/social/socialfrienditem.prefab",
		"ui/viewres/social/socialrequestitem.prefab",
		"ui/viewres/social/socialsearchitem.prefab",
		"ui/viewres/social/socialblacklistitem.prefab",
		"ui/viewres/social/socialmessageitem.prefab",
		"ui/viewres/social/socialheroitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/social/socialfriendsview.prefab"
			},
			{
				"ui/viewres/social/socialsearchview.prefab"
			},
			{
				"ui/viewres/social/socialrequestview.prefab"
			},
			{
				"ui/viewres/social/socialblacklistview.prefab"
			}
		}
	},
	customAnimBg = {
		"hasbg"
	}
}
var_0_0.SocialRemarkTipView = {
	destroy = 0,
	container = "SocialRemarkTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/social/socialremarktipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.InformPlayerTipView = {
	destroy = 0,
	container = "InformPlayerTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/tips/informplayertipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.PlayerInfoView = {
	destroy = 0,
	container = "PlayerInfoViewContainer",
	mainRes = "ui/viewres/social/playerinfoview2.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	}
}
var_0_0.NoticeView = {
	destroy = 0,
	container = "NoticeViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/notice/noticeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"#simage_bg"
	}
}
var_0_0.EffectStatView = {
	destroy = 0,
	container = "EffectStatViewContainer",
	mainRes = "ui/viewres/effect/effectstatview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.PlayerLevelUpView = {
	destroy = 0,
	container = "PlayerLevelUpViewContainer",
	maskAlpha = 0.5,
	mainRes = "ui/viewres/player/playerlevelupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"#simage_bgbar"
	}
}
var_0_0.Signature = {
	destroy = 0,
	container = "SignatureContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/player/signature.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"window"
	}
}
var_0_0.PlayerModifyNameView = {
	destroy = 0,
	container = "PlayerModifyNameViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/player/playermodifynameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"window"
	}
}
var_0_0.RoomView = {
	destroy = 0,
	container = "RoomViewContainer",
	mainRes = "ui/viewres/room/roomview.prefab",
	layer = "HUD",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/room/roombackblockview.prefab"
			},
			{
				"ui/viewres/room/roomwaterreformview.prefab"
			}
		},
		{
			{
				RoomViewConfirm.prefabPath
			}
		},
		{
			{
				"ui/viewres/room/layout/roomlayoutvisitplan.prefab"
			}
		}
	},
	otherRes = {
		"ui/viewres/room/debug/roomdebugbuildingitem.prefab",
		"ppassets/uixiaowumask.prefab",
		"ui/viewres/room/roomtopright.prefab",
		"ui/viewres/room/mainview/roomviewtaskitem.prefab",
		"ui/viewres/room/mainview/roomnavigatebubbleitem.prefab",
		"ui/viewres/room/debug/roomdebugplaceitem.prefab",
		"ui/viewres/room/debug/roomdebugpackageitem.prefab",
		"ui/viewres/room/sceneui/roomscenecharacterinteractionui.prefab",
		"ui/viewres/room/sceneui/roomscenecharacterui.prefab",
		"ui/viewres/room/sceneui/roomsceneproductionlineui.prefab",
		"ui/viewres/room/sceneui/roomscenemanufactureui.prefab",
		RoomViewUITransportSiteItem.prefabPath,
		RoomViewUICritterEventItem.prefabPath
	}
}
var_0_0.RoomDebugView = {
	destroy = 0,
	container = "RoomDebugViewContainer",
	mainRes = "ui/viewres/room/debug/roomdebugview.prefab",
	layer = "HUD",
	viewType = ViewType.Normal,
	otherRes = {
		"ui/viewres/room/debug/roomdebugbuildingitem.prefab",
		"ppassets/uixiaowumask.prefab",
		"ui/viewres/room/roomtopright.prefab",
		"ui/viewres/room/mainview/roomviewtaskitem.prefab",
		"ui/viewres/room/mainview/roomnavigatebubbleitem.prefab",
		"ui/viewres/room/debug/roomdebugplaceitem.prefab",
		"ui/viewres/room/debug/roomdebugpackageitem.prefab",
		"ui/viewres/room/sceneui/roomscenecharacterinteractionui.prefab",
		"ui/viewres/room/sceneui/roomscenecharacterui.prefab",
		"ui/viewres/room/sceneui/roomsceneproductionlineui.prefab"
	}
}
var_0_0.RoomDebugBuildingAreaView = {
	destroy = 0,
	container = "RoomDebugBuildingAreaViewContainer",
	mainRes = "ui/viewres/room/debug/roomdebugbuildingareaview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {}
}
var_0_0.RoomDebugBuildingCameraView = {
	destroy = 0,
	container = "RoomDebugBuildingCameraViewContainer",
	mainRes = "ui/viewres/room/debug/roomdebugbuildingcameraview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {}
}
var_0_0.RoomDebugThemeFilterView = {
	destroy = 0,
	container = "RoomDebugThemeFilterViewContainer",
	maskAlpha = 0,
	mainRes = "ui/viewres/room/debug/roomdebugthemefilterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.RoomBuildingInteractionView = {
	destroy = 0,
	container = "RoomBuildingInteractionViewContainer",
	mainRes = "ui/viewres/room/roombuildinginteractionview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {}
}
var_0_0.RoomInventorySelectView = {
	destroy = 0,
	container = "RoomInventorySelectViewContainer",
	mainRes = "ui/viewres/room/roominventoryselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				RoomViewBuilding.prefabPath
			}
		},
		{
			{
				RoomTransportPathFailTips.prefabPath
			}
		}
	}
}
var_0_0.RoomTipsView = {
	destroy = 0,
	container = "RoomTipsViewContainer",
	mainRes = "ui/viewres/room/roomtipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.RoomBlockPackageView = {
	bgBlur = 0,
	container = "RoomBlockPackageViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/room/roomblockpackageview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/room/roomtopright.prefab"
	}
}
var_0_0.RoomThemeTipView = {
	destroy = 0,
	container = "RoomThemeTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/roomthemetipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.RoomMaterialTipView = {
	bgBlur = 1,
	container = "RoomMaterialTipViewContainer",
	mainRes = "ui/viewres/room/roommaterialtipview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8
}
var_0_0.RoomStoreGoodsTipView = {
	bgBlur = 1,
	container = "RoomStoreGoodsTipViewContainer",
	mainRes = "ui/viewres/room/roommaterialtipview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.RoomInitBuildingView = {
	destroy = 0,
	container = "RoomInitBuildingViewContainer",
	mainRes = "ui/viewres/room/roominitbuildingview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/room/roomtopright.prefab",
		[2] = IconMgrConfig.UrlRoomGoodsItemIcon
	}
}
var_0_0.RoomLevelUpView = {
	destroy = 0,
	container = "RoomLevelUpViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/room/roomlevelupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.RoomLevelUpTipsView = {
	destroy = 0,
	container = "RoomLevelUpTipsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/roomleveluptipsview.prefab",
	blurFactor = 0.3,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.RoomBuildingFilterView = {
	destroy = 0,
	container = "RoomBuildingFilterViewContainer",
	maskAlpha = 0,
	mainRes = "ui/viewres/room/roombuildingfilterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.RoomThemeFilterView = {
	destroy = 0,
	container = "RoomThemeFilterViewContainer",
	maskAlpha = 0,
	mainRes = "ui/viewres/room/roomthemefilterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.RoomMiniMapView = {
	destroy = 0,
	container = "RoomMiniMapViewContainer",
	mainRes = "ui/viewres/room/roomminimapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.RoomFormulaView = {
	destroy = 0,
	container = "RoomFormulaViewContainer",
	bgBlur = 2,
	mainRes = "ui/viewres/room/roomformulaview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/room/roomformulaitem.prefab",
		[2] = "ui/viewres/room/roomtopright.prefab",
		[3] = IconMgrConfig.UrlRoomGoodsItemIcon
	}
}
var_0_0.RoomFormulaMsgBoxView = {
	destroy = 0,
	container = "RoomFormulaMsgBoxViewViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/roomformulaviewmsgboxview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.RoomProductLineLevelUpView = {
	destroy = 0,
	container = "RoomProductLineLevelUpViewContainer",
	maskAlpha = 0,
	bgBlur = 3,
	mainRes = "ui/viewres/room/roomproductlinelevelupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.RoomStrengthView = {
	destroy = 0,
	container = "RoomStrengthViewContainer",
	mainRes = "ui/viewres/room/roomstrengthview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal
}
var_0_0.RoomCommonStrengthView = {
	destroy = 0,
	container = "RoomCommonStrengthViewContainer",
	mainRes = "ui/viewres/room/roomcommonstrengthview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/room/roomtopright.prefab"
	}
}
var_0_0.RoomAccelerateView = {
	destroy = 0,
	container = "RoomAccelerateViewContainer",
	mainRes = "ui/viewres/room/roomaccelerateview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal
}
var_0_0.RoomCharacterPlaceView = {
	destroy = 0,
	container = "RoomCharacterPlaceViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/room/roomcharacterplaceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	otherRes = {
		[1] = "ui/viewres/room/roomcharacterplaceitem.prefab",
		[2] = "ui/viewres/room/roomtopright.prefab"
	}
}
var_0_0.RoomCharacterPlaceInfoView = {
	destroy = 0,
	container = "RoomCharacterPlaceInfoViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/roomcharacterplaceinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/room/roomcharacterplaceitem.prefab"
	}
}
var_0_0.RoomDebugEntranceView = {
	destroy = 0,
	container = "RoomDebugEntranceViewContainer",
	mainRes = "ui/viewres/room/debug/roomdebugentranceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.RoomDebugSelectPackageView = {
	destroy = 0,
	container = "RoomDebugSelectPackageViewContainer",
	mainRes = "ui/viewres/room/debug/roomdebugselectpackageview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.RoomOpenGuideView = {
	destroy = 0,
	container = "RoomOpenGuideViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/roomopenguideview.prefab",
	blurFactor = 0.3,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.RoomGuideView = {
	destroy = 0,
	container = "RoomGuideViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/critter/roomguideview.prefab",
	blurFactor = 0.3,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.RoomSceneTaskDetailView = {
	bgBlur = 1,
	container = "RoomSceneTaskDetailViewContainer",
	mainRes = "ui/viewres/room/roomtaskdetailview.prefab",
	destroy = 0,
	blurFactor = 0.3,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.RoomBlockPackageGetView = {
	bgBlur = 1,
	container = "RoomBlockPackageGetViewContainer",
	mainRes = "ui/viewres/room/roomblockpackagegetview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8
}
var_0_0.RoomBranchView = {
	destroy = 0,
	container = "RoomBranchViewContainer",
	mainRes = "ui/viewres/room/roombranchview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.RoomInformPlayerView = {
	destroy = 0,
	container = "RoomInformPlayerViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/roominformplayerview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				"ui/viewres/common/viewframe/commonwindow01.prefab"
			}
		}
	}
}
var_0_0.RoomLayoutView = {
	bgBlur = 1,
	container = "RoomLayoutViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/room/layout/roomlayoutview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		RoomLayoutItem.prefabUrl
	}
}
var_0_0.RoomLayoutItemTips = {
	destroy = 0,
	container = "RoomLayoutItemTipsContainer",
	mainRes = "ui/viewres/room/layout/roomlayoutitemtips.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.RoomLayoutBgSelectView = {
	destroy = 0,
	container = "RoomLayoutBgSelectViewContainer",
	mainRes = "ui/viewres/room/layout/roomlayoutbgselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.RoomLayoutCreateTipsView = {
	destroy = 0,
	container = "RoomLayoutCreateTipsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/layout/roomlayoutcreatetipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.RoomLayoutCopyView = {
	destroy = 0,
	container = "RoomLayoutCopyViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/layout/roomlayoutcopyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.RoomLayoutRenameView = {
	destroy = 0,
	container = "RoomLayoutRenameViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/layout/roomlayoutcopyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.RoomLayoutFindShareView = {
	destroy = 0,
	container = "RoomLayoutFindShareViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/layout/roomlayoutcopyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.RoomTransportPathView = {
	destroy = 0,
	container = "RoomTransportPathViewContainer",
	mainRes = "ui/viewres/room/transport/roomtransportpathview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				RoomTransportPathFailTips.prefabPath
			}
		}
	}
}
var_0_0.RoomTransportSiteView = {
	destroy = 0,
	container = "RoomTransportSiteViewContainer",
	mainRes = "ui/viewres/room/transport/roomtransportsiteview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		RoomTransportBuildingItem.prefabPath,
		RoomTransportBuildingSkinItem.prefabPath,
		RoomTransportCritterItem.prefabPath
	}
}
var_0_0.RoomInteractBuildingView = {
	destroy = 0,
	container = "RoomInteractBuildingViewContainer",
	mainRes = "ui/viewres/room/transport/roominteractbuildingview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		RoomInteractCharacterItem.prefabUrl
	}
}
var_0_0.RoomManufacturePlaceCostView = {
	destroy = 0,
	container = "RoomManufacturePlaceCostViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/manufacture/roommanufactureplacecostview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.HandbookView = {
	destroy = 0,
	container = "HandbookViewContainer",
	mainRes = "ui/viewres/handbook/handbookview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.HandbookStoryView = {
	destroy = 0,
	container = "HandbookStoryViewContainer",
	mainRes = "ui/viewres/handbook/handbookstoryview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/handbook/handbookstoryitem.prefab"
	}
}
var_0_0.HandbookCGView = {
	destroy = 0,
	container = "HandbookCGViewContainer",
	mainRes = "ui/viewres/handbook/handbookcgview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/handbook/handbookcgitem.prefab"
	}
}
var_0_0.HandbookCGDetailView = {
	destroy = 0,
	container = "HandbookCGDetailViewContainer",
	mainRes = "ui/viewres/handbook/handbookcgdetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.HandBookCharacterSwitchView = {
	destroy = 0,
	container = "HandBookCharacterSwitchViewContainer",
	mainRes = "ui/viewres/handbook/handbookcharacterswitchview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.HandbookEquipView = {
	destroy = 0,
	container = "HandbookEquipViewContainer",
	mainRes = "ui/viewres/handbook/handbookequipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.EquipFilterView = {
	destroy = 10,
	container = "EquipFilterViewContainer",
	mainRes = "ui/viewres/handbook/equipfilterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.HandbookWeekWalkView = {
	destroy = 0,
	container = "HandbookWeekWalkViewContainer",
	mainRes = "ui/viewres/handbook/handbookweekwalkview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.HandbookWeekWalkMapView = {
	destroy = 0,
	container = "HandbookWeekWalkMapViewContainer",
	mainRes = "ui/viewres/handbook/handbookweekwalkmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.TeachNoteView = {
	destroy = 0.5,
	container = "TeachNoteViewContainer",
	mainRes = "ui/viewres/teach/teachnoteview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/teach/teachnoterewarditem.prefab"
	}
}
var_0_0.TeachNoteDetailView = {
	destroy = 0,
	container = "TeachNoteDetailViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/teach/teachnotedetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.EndOfDreamView = {
	destroy = 0,
	container = "EndOfDreamViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/endofdream/endofdreamview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.DungeonPuzzlePipeView = {
	destroy = 0,
	container = "DungeonPuzzlePipeViewContainer",
	mainRes = "ui/viewres/dungeon/puzzle/dungeonpuzzlepipeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/dungeon/puzzle/dungeonpipeitem.prefab",
		[2] = "ui/viewres/dungeon/puzzle/dungeonpipeconnectitem.prefab"
	}
}
var_0_0.DungeonPuzzleCircuitView = {
	destroy = 0,
	container = "DungeonPuzzleCircuitViewContainer",
	mainRes = "ui/viewres/dungeon/puzzle/dungeonpuzzlecircuitview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {}
}
var_0_0.DungeonPuzzleQuestionView = {
	destroy = 0,
	container = "DungeonPuzzleQuestionViewContainer",
	mainRes = "ui/viewres/dungeon/puzzle/dungeonpuzzlequestionview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.DungeonPuzzleMazeDrawView = {
	destroy = 0,
	container = "DungeonPuzzleMazeDrawViewContainer",
	mainRes = "ui/viewres/dungeon/puzzle/dungeonpuzzlemazedrawview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/dungeon/puzzle/dungeonmazeitem.prefab",
		"ui/viewres/dungeon/puzzle/dungeonpuzzlemazepath.prefab",
		"ui/viewres/dungeon/puzzle/dungeonmazepawn.prefab"
	}
}
var_0_0.PutCubeGameView = {
	destroy = 0,
	container = "PutCubeGameViewContainer",
	mainRes = "ui/viewres/dungeon/puzzle/putcubegameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.PushBoxView = {
	destroy = 0,
	container = "PushBoxViewContainer",
	mainRes = "ui/viewres/pushbox/pushboxview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivityPushBoxLevelView = {
	destroy = 0,
	container = "VersionActivityPushBoxLevelViewContainer",
	mainRes = "ui/viewres/versionactivity/versionactivitypushboxlevelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivityPushBoxGameView = {
	destroy = 0,
	container = "VersionActivityPushBoxGameViewContainer",
	mainRes = "ui/viewres/versionactivity/versionactivitypushboxgameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivityPushBoxTaskView = {
	destroy = 0,
	container = "VersionActivityPushBoxTaskViewContainer",
	mainRes = "ui/viewres/versionactivity/versionactivitypushboxtaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.DungeonSeasonMainView = {
	destroy = 0,
	container = "DungeonSeasonMainViewContainer",
	mainRes = "ui/viewres/dungeon/season/dungeonSeasonMainView.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.VersionActivityEnterView = {
	destroy = 0,
	container = "VersionActivityEnterViewContainer",
	mainRes = "ui/viewres/versionactivity/versionactivityenterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	preloader = module_views_preloader
}
var_0_0.VersionActivityVideoView = {
	destroy = 0,
	container = "VersionActivityVideoViewContainer",
	mainRes = "ui/viewres/versionactivity/versionactivityvideoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
var_0_0.VersionActivityMainView = {
	bgBlur = 1,
	container = "VersionActivityMainViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity/versionactivitymainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivityTaskView = {
	bgBlur = 3,
	container = "VersionActivityTaskViewContainer",
	mainRes = "ui/viewres/versionactivity/versionactivitytaskview.prefab",
	destroy = 0,
	blurFactor = 0.64,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity/versionactivitytaskitem.prefab"
	}
}
var_0_0.VersionActivityNewsView = {
	destroy = 0,
	container = "VersionActivityNewsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity/versionactivitynewsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.VersionActivityStoreView = {
	destroy = 0,
	container = "VersionActivityStoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity/versionactivitystoreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivityNormalStoreGoodsView = {
	bgBlur = 1,
	container = "VersionActivityNormalStoreGoodsViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/store/normalstoregoodsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivityPuzzleView = {
	destroy = 0,
	container = "VersionActivityPuzzleViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity/versionactivitypuzzleview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.V1a6_CachotEnterView = {
	destroy = 0,
	container = "V1a6_CachotEnterViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.V1a6_CachotMainView = {
	destroy = 0,
	container = "V1a6_CachotMainViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_mainview.prefab",
	layer = "HUD",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.V1a6_CachotRoomView = {
	destroy = 0,
	container = "V1a6_CachotRoomViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_roomview.prefab",
	layer = "HUD",
	viewType = ViewType.Normal
}
var_0_0.V1a6_CachotCollectionView = {
	destroy = 0,
	container = "V1a6_CachotCollectionViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_collectionview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default
}
var_0_0.V1a6_CachotDifficultyView = {
	bgBlur = 1,
	container = "V1a6_CachotDifficultyViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_difficultyview.prefab",
	blurFactor = 0.4,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.V1a6_CachotResultView = {
	destroy = 0,
	container = "V1a6_CachotResultViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.V1a6_CachotFinishView = {
	destroy = 0,
	container = "V1a6_CachotFinishViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_finishview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.V1a6_CachotEndingView = {
	destroy = 0,
	container = "V1a6_CachotEndingViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_endingview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default
}
var_0_0.V1a6_CachotRewardView = {
	destroy = 0,
	container = "V1a6_CachotRewardViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_rewardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
var_0_0.V1a6_CachotTeamView = {
	destroy = 0,
	container = "V1a6_CachotTeamViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_teamview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_teampresetitem.prefab",
		[2] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_teamprepareitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.V1a6_CachotTeamPreView = {
	destroy = 0,
	container = "V1a6_CachotTeamPreViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_teampreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_teampresetitem.prefab",
		[2] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_teamprepareitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.V1a6_CachotHeroGroupFightView = {
	bgBlur = 4,
	container = "V1a6_CachotHeroGroupFightViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_herogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
var_0_0.V1a6_CachotHeroGroupEditView = {
	container = "V1a6_CachotHeroGroupEditViewContainer",
	destroy = 5,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_herogroupeditview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_herogroupedititem.prefab",
		[2] = "ui/viewres/herogroup/herogroupquickedititem.prefab"
	},
	customAnimBg = {
		"bg"
	}
}
var_0_0.V1a6_CachotLoadingView = {
	destroy = 0,
	container = "V1a6_CachotLoadingViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_loadingview.prefab",
	layer = "TOP",
	viewType = ViewType.Full
}
var_0_0.V1a6_CachotLayerChangeView = {
	bgBlur = 1,
	container = "V1a6_CachotLayerChangeViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_leveljumpview.prefab",
	blurFactor = 0.4,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.V1a6_CachotTipsView = {
	destroy = 0,
	container = "V1a6_CachotTipsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_tipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal
}
var_0_0.V1a6_CachotStoreView = {
	destroy = 0,
	container = "V1a6_CachotStoreViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
var_0_0.V1a6_CachotEpisodeView = {
	destroy = 0,
	container = "V1a6_CachotEpisodeViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/episode/v1a6_cachot_episodeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
var_0_0.V1a6_CachotNormalStoreGoodsView = {
	destroy = 0,
	container = "V1a6_CachotNormalStoreGoodsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_storegoodsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.V1a6_CachotCollectionView = {
	destroy = 0,
	container = "V1a6_CachotCollectionViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_collectionview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_collectionitem.prefab"
	}
}
var_0_0.V1a6_CachotCollectionBagView = {
	destroy = 0,
	container = "V1a6_CachotCollectionBagViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_collectionbagview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_collectionbagitem.prefab"
	}
}
var_0_0.V1a6_CachotCollectionGetView = {
	destroy = 0,
	container = "V1a6_CachotCollectionGetViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_collectiongetview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.V1a6_CachotCollectionSelectView = {
	destroy = 0,
	container = "V1a6_CachotCollectionSelectViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_collectionselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default
}
var_0_0.V1a6_CachotCollectionEnchantView = {
	destroy = 0,
	container = "V1a6_CachotCollectionEnchantViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_collectionenchantview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_collectionbagitem.prefab"
	}
}
var_0_0.V1a6_CachotCollectionUnlockedView = {
	destroy = 0,
	container = "V1a6_CachotCollectionUnlockedViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_collectionunlockedview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.V1a6_CachotCollectionOverView = {
	destroy = 0,
	container = "V1a6_CachotCollectionOverViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_collectionoverview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default
}
var_0_0.V1a6_CachotProgressView = {
	destroy = 0,
	container = "V1a6_CachotProgressViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_progressview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_progressitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.V1a6_CachotUpgradeView = {
	destroy = 0,
	container = "V1a6_CachotUpgradeViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_upgradeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_teampresetitem.prefab"
	}
}
var_0_0.V1a6_CachotUpgradeResultView = {
	destroy = 0,
	container = "V1a6_CachotUpgradeResultViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_upgraderesultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_teampresetitem.prefab"
	}
}
var_0_0.V1a6_CachotRoleRecoverView = {
	destroy = 0,
	container = "V1a6_CachotRoleRecoverViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_rolerecoverview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_teampresetitem.prefab",
		[2] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_teamprepareitem.prefab"
	}
}
var_0_0.V1a6_CachotRoleRecoverResultView = {
	destroy = 0,
	container = "V1a6_CachotRoleRecoverResultViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_rolerecoverresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_teampresetitem.prefab",
		[2] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_teamprepareitem.prefab"
	}
}
var_0_0.V1a6_CachotRoleRevivalView = {
	destroy = 0,
	container = "V1a6_CachotRoleRevivalViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_rolerevivalview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_teampresetitem.prefab",
		[2] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_teamprepareitem.prefab"
	}
}
var_0_0.V1a6_CachotRoleRevivalResultView = {
	destroy = 0,
	container = "V1a6_CachotRoleRevivalResultViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_rolerevivalresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_teampresetitem.prefab",
		[2] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_teamprepareitem.prefab"
	}
}
var_0_0.V1a6_CachotEquipInfoTeamShowView = {
	bgBlur = 1,
	container = "V1a6_CachotEquipInfoTeamShowViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_equipinfoteamshowview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/equip/equipinfoteamshowitem.prefab"
	}
}
var_0_0.VersionActivity1_3AstrologyView = {
	destroy = 0,
	container = "VersionActivity1_3AstrologyViewContainer",
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_astrologyview/v1a3_astrologyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_3/v1a3_astrologyview/v1a3_astrologyplanetitem.prefab",
		[2] = "ui/viewres/versionactivity_1_3/v1a3_astrologyview/v1a3_astrologyplateview.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_1_3/v1a3_astrologyview/v1a3_astrologyplateview.prefab"
			}
		},
		{
			{
				"ui/viewres/versionactivity_1_3/v1a3_astrologyview/v1a3_astrologyselectview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_3/v1a3_astrologyview/v1a3_astrologyresultview.prefab"
			}
		}
	}
}
var_0_0.VersionActivity1_3AstrologySuccessView = {
	destroy = 0,
	container = "VersionActivity1_3AstrologySuccessViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_astrologyview/v1a3_astrologysuccessview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.VersionActivity1_3AstrologyPropView = {
	destroy = 0,
	container = "VersionActivity1_3AstrologyPropViewContainer",
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_astrologyview/v1a3_astrologypropview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/common/commonpropitem.prefab"
	},
	customAnimBg = {
		"blackbg"
	}
}
var_0_0.VersionActivity1_3BuffView = {
	destroy = 0,
	container = "VersionActivity1_3BuffViewContainer",
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_buffview/v1a3_buffview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_3/v1a3_buffview/v1a3_buffview_bufficonitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity1_3BuffTipView = {
	destroy = 0,
	container = "VersionActivity1_3BuffTipViewContainer",
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_buffview/v1a3_buffviewtips.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.VersionActivity1_3FairyLandView = {
	destroy = 0,
	container = "VersionActivity1_3FairyLandViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_buffview/v1a3_fairylandview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_3/v1a3_buffview/v1a3_fairylanditem.prefab"
	}
}
var_0_0.VersionActivity1_3EnterView = {
	destroy = 0,
	container = "VersionActivity1_3EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_1_3/versionactivity_1_3_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity1_3DungeonMapView = {
	container = "VersionActivity1_3DungeonMapViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_3/map/versionactivity_1_3_dungeonmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/versionactivity_1_3/map/versionactivity_1_3_mapepisodeitem.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab",
		"ui/viewres/versionactivity_1_3/map/v1a3_dungeonmapinteractiveitem.prefab",
		"ui/viewres/versionactivity_1_3/map/v1a3_map_direction.prefab",
		"ui/viewres/versionactivity_1_3/map/v1a3_dungeon_change.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	preloader = module_views_preloader
}
var_0_0.VersionActivity1_3DungeonMapLevelView = {
	destroy = 0,
	container = "VersionActivity1_3DungeonMapLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_1_3/map/versionactivity_1_3_dungeonmaplevelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		},
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity1_3DungeonChangeView = {
	destroy = 0,
	container = "VersionActivity1_3DungeonChangeViewContainer",
	mainRes = "ui/viewres/versionactivity_1_3/map/v1a3_dungeon_change.prefab",
	layer = "TOP",
	viewType = ViewType.Normal
}
var_0_0.VersionActivity1_3StoreView = {
	destroy = 0,
	container = "VersionActivity1_3StoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_3/map/versionactivity_1_3_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity1_3NormalStoreGoodsView = {
	bgBlur = 1,
	container = "VersionActivity1_3NormalStoreGoodsViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/store/normalstoregoodsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity1_3TaskView = {
	destroy = 0,
	container = "VersionActivity1_3TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_1_3/map/v1a3_main_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_1_3/map/v1a3_main_taskitem.prefab"
	}
}
var_0_0.VersionActivityDungeonMapView = {
	container = "VersionActivityDungeonMapViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity/versionactivitydungeonmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/versionactivity/versionactivitymapepisodeitem.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab",
		"ui/viewres/dungeon/chaptermap/dungeonmapinteractiveitem.prefab",
		"ui/viewres/dungeon/chaptermap/map_direction.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	preloader = module_views_preloader
}
var_0_0.VersionActivityDungeonMapLevelView = {
	destroy = 0,
	container = "VersionActivityDungeonMapLevelViewContainer",
	mainRes = "ui/viewres/versionactivity/versionactivitydungeonmaplevelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		},
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivityExchangeView = {
	destroy = 0,
	container = "VersionActivityExchangeViewContainer",
	mainRes = "ui/viewres/versionactivity/versionactivityexchangeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivityTipsView = {
	destroy = 0,
	container = "VersionActivityTipsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity/versionactivitytipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.VersionActivityExchangeTaskView = {
	destroy = 0,
	container = "VersionActivityExchangeTaskViewContainer",
	mainRes = "ui/viewres/versionactivity/versionactivityexchangetaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.VersionActivity1_2EnterView = {
	destroy = 0,
	container = "VersionActivity1_2EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/versionactivity_1_2_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.WaterMarkView = {
	destroy = 0,
	container = "WaterMarkViewContainer",
	mainRes = "ui/viewres/player/watermarkview.prefab",
	viewType = ViewType.Normal,
	layer = UILayerName.IDCanvasPopUp,
	anim = ViewAnim.Default
}
var_0_0.SdkFitAgeTipView = {
	destroy = 0,
	container = "SdkFitAgeTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/sdk/sdkfitagetipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.SDKScoreJumpView = {
	destroy = 0,
	container = "SDKScoreJumpViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/sdk/sdkscorejumpview.prefab",
	blurFactor = 0.6,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.DungeonPuzzleOuijaView = {
	destroy = 0,
	container = "DungeonPuzzleOuijaViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/dungeon/puzzle/dungeonpuzzleouijaview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.ActivityWarmUpGameView = {
	destroy = 0,
	container = "ActivityWarmUpGameViewContainer",
	mainRes = "ui/viewres/activity/warmup/activitywarmupgameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.ActivityWarmUpView = {
	destroy = 0,
	container = "ActivityWarmUpViewContainer",
	mainRes = "ui/viewres/activity/warmup/activitywarmupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.ActivityWarmUpTask = {
	destroy = 0,
	container = "ActivityWarmUpTaskViewContainer",
	mainRes = "ui/viewres/activity/warmup/activitywarmuptask.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/activity/warmup/activitywarmuptaskitem.prefab"
	}
}
var_0_0.ActivityWarmUpTips = {
	destroy = 0,
	container = "ActivityWarmUpTipsContainer",
	mainRes = "ui/viewres/activity/warmup/activitywarmuptipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.ActivityWarmUpNews = {
	destroy = 0,
	container = "ActivityWarmUpNewsContainer",
	mainRes = "ui/viewres/activity/warmup/activitywarmupnews.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Activity109ChessEntry = {
	destroy = 0,
	container = "Activity109ChessEntryContainer",
	mainRes = "ui/viewres/activity/chessmap/activity109chessentryview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Activity109ChessMapList = {
	destroy = 0,
	container = "Activity109ChessMapListViewContainer",
	mainRes = "ui/viewres/activity/chessmap/activity109chessmaplistview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Activity109ChessTask = {
	destroy = 0,
	container = "Activity109ChessTaskViewContainer",
	mainRes = "ui/viewres/activity/chessmap/activity109chesstask.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Activity109ChessGameClear = {
	destroy = 0,
	container = "Activity109ChessGameClearContainer",
	mainRes = "ui/viewres/activity/chessmap/activity109chessentryview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.ActivityChessGame = {
	bgBlur = 4,
	container = "ActivityChessGameContainer",
	destroy = 0,
	mainRes = "ui/viewres/activity/chessmap/activitychessmapgame.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/activity/chessmap/activitychessmapbasetile.prefab",
		[2] = "ui/viewres/activity/chessmap/activitychessmapinteract.prefab"
	}
}
var_0_0.ActivityChessGameResultView = {
	destroy = 0,
	container = "ActivityChessGameResultViewContainer",
	mainRes = "ui/viewres/activity/chessmap/activitychessmapgameresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.ActivityChessGameRewardView = {
	destroy = 0,
	container = "ActivityChessGameRewardViewContainer",
	mainRes = "ui/viewres/activity/chessmap/activity109chessrewardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.BpView = {
	container = "BpViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/battlepass/bpview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	preloader = module_views_preloader,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/battlepass/bpbonusview.prefab"
			},
			{
				"ui/viewres/battlepass/bptaskview.prefab"
			}
		}
	},
	otherRes = {
		ResUrl.getBattlePassBg("full/img_bp_bg"),
		[2] = "ui/viewres/battlepass/bpbonusview.prefab",
		[3] = ResUrl.getBattlePassBg("img_reward_bg_shadow")
	}
}
var_0_0.BpSPView = {
	container = "BpSPViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/battlepass/bpspview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	preloader = module_views_preloader,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/battlepass/bpbonusview2.prefab"
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/battlepass/bpbonusview2.prefab",
		[2] = "ui/viewres/battlepass/bpsp_change.prefab"
	}
}
var_0_0.BpChangeView = {
	destroy = 0,
	container = "BpChangeViewContainer",
	mainRes = "ui/viewres/battlepass/bpsp_change.prefab",
	layer = "TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default
}
var_0_0.BPSPFaceView = {
	destroy = 0,
	container = "BPSPFaceViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/battlepass/bpspfaceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.BPFaceView = {
	destroy = 0,
	container = "BPFaceViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/battlepass/bpfaceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Activity119View = {
	destroy = 0,
	container = "Activity119ViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/dreamtail/versionactivity_1_2_dreamtailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Activity114View = {
	destroy = 0,
	container = "Activity114ViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/activity114/versionactivity_1_2_114view.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_1_2/activity114/versionactivity_1_2_114enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_2/activity114/versionactivity_1_2_114taskview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_2/activity114/versionactivity_1_2_114mainview.prefab"
			}
		}
	}
}
var_0_0.Activity114PhotoView = {
	destroy = 0,
	container = "Activity114PhotoViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/activity114/versionactivity_1_2_114photoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Activity114FullPhotoView = {
	bgBlur = 1,
	container = "Activity114FullPhotoViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_2/activity114/versionactivity_1_2_114photodetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Activity114FinishEventView = {
	bgBlur = 3,
	container = "Activity114FinishEventViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_2/activity114/versionactivity_1_2_114finisheventview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Activity114ScoreReportView = {
	destroy = 0,
	container = "Activity114ScoreReportViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/activity114/v1a2_114scorereportview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Activity114TransitionView = {
	destroy = 0,
	container = "Activity114TransitionViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/activity114/versionactivity_1_2_114transitionview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	customAnimFadeTime = {
		nil,
		0.5
	}
}
var_0_0.Activity114EmptyView = {
	destroy = 0,
	container = "BaseViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/activity114/v1a2_empty.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default
}
var_0_0.Activity114GetPhotoView = {
	destroy = 0,
	container = "Activity114GetPhotoViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/activity114/versionactivity_1_2_114getphotoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default
}
var_0_0.Activity114DiceView = {
	bgBlur = 3,
	container = "Activity114DiceViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_2/activity114/versionactivity_1_2_114diceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Activity114EventSelectView = {
	destroy = 0,
	container = "Activity114EventSelectViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/activity114/versionactivity_1_2_114eventselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Activity114MeetView = {
	destroy = 0,
	container = "Activity114MeetViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/activity114/versionactivity_1_2_114meetview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Activity114TravelView = {
	destroy = 0,
	container = "Activity114TravelViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/versionactivity_1_2/versionactivity_1_2_tripenterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.VersionActivity1_2StoreView = {
	destroy = 0,
	container = "VersionActivity1_2StoreViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/map/other/versionactivity_1_2_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity1_2TaskView = {
	destroy = 0,
	container = "VersionActivity1_2TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/map/other/versionactivity_1_2_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_1_2/map/other/versionactivity_1_2_taskitem.prefab"
	}
}
var_0_0.YaXianMapView = {
	destroy = 0,
	container = "YaXianMapViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/yaxian/versionactivity_1_2_yaxianmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"scenes/dynamic/yaxian/yaxiancurve.asset"
	}
}
var_0_0.YaXianRewardView = {
	destroy = 0,
	container = "YaXianRewardViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_2/yaxian/versionactivity_1_2_yaxianrewardsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/versionactivity_1_2/yaxian/versionactivity_1_2_yaxianrewardsitem.prefab"
	}
}
var_0_0.YaXianGameView = {
	destroy = 0,
	container = "YaXianGameContainer",
	mainRes = "ui/viewres/versionactivity_1_2/yaxian/versionactivity_1_2_yaxiangameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.YaXianGameResultView = {
	destroy = 0,
	container = "YaXianGameResultContainer",
	mainRes = "ui/viewres/versionactivity_1_2/yaxian/versionactivity_1_2_yaxiangameresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.YaXianGameTipView = {
	destroy = 0,
	container = "YaXianGameTipViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/yaxian/versionactivity_1_2_yaxiangametipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.YaXianFindToothView = {
	destroy = 0,
	container = "YaXianFindToothViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_2/yaxian/versionactivity_1_2_yaxianfindtoothview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.YaXianCollectView = {
	destroy = 0,
	container = "YaXianCollectViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_2/yaxian/versionactivity_1_2_yaxiancollectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.BpBuyView = {
	destroy = 0,
	container = "BpBuyViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/battlepass/bpbuyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.BpInformationView = {
	destroy = 0,
	container = "BpInformationViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/battlepass/bpinformationview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.BpSPInformationView = {
	destroy = 0,
	container = "BpInformationViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/battlepass/bpspinformationview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.BpLevelupTipView = {
	destroy = 0,
	container = "BpLevelupTipViewContainer",
	mainRes = "ui/viewres/battlepass/bpleveluptipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
var_0_0.BpRuleTipsView = {
	destroy = 0,
	container = "BpRuleTipsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/battlepass/bpruletipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.BpSPRuleTipsView = {
	destroy = 0,
	container = "BpRuleTipsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/battlepass/bpspruletipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.BpChargeView = {
	destroy = 0,
	container = "BpChargeViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/battlepass/bpchargeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.BpBonusSelectView = {
	destroy = 0,
	container = "BpBonusSelectViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/battlepass/bpbonusselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.BpPropView = {
	destroy = 0,
	container = "BpPropViewContainer",
	mainRes = "ui/viewres/battlepass/bppropview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/common/commonpropitem.prefab"
	},
	customAnimBg = {
		"blackbg"
	}
}
var_0_0.BpPropView2 = {
	bgBlur = 1,
	container = "BpPropView2Container",
	destroy = 0,
	mainRes = "ui/viewres/battlepass/bppropview2.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/common/commonpropitem.prefab"
	},
	customAnimBg = {
		"blackbg"
	}
}
var_0_0.BpVideoView = {
	destroy = 0,
	container = "BpVideoViewContainer",
	mainRes = "ui/viewres/battlepass/bpvideoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.VersionActivity_1_2_HeroGroupView = {
	bgBlur = 4,
	container = "VersionActivity_1_2_HeroGroupViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_2/versionactivity_1_2_herogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
var_0_0.VersionActivity_1_2_HeroGroupEditView = {
	container = "VersionActivity_1_2_HeroGroupEditViewContainer",
	destroy = 5,
	mainRes = "ui/viewres/versionactivity_1_2/versionactivity_1_2_herogroupeditview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/herogroup/herogroupedititem.prefab",
		[2] = "ui/viewres/herogroup/herogroupquickedititem.prefab"
	},
	customAnimBg = {
		"bg"
	}
}
var_0_0.VersionActivity_1_2_FacilityTipsView = {
	destroy = 0,
	container = "VersionActivity_1_2_FacilityTipsViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/versionactivity_1_2_facilitytipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal
}
var_0_0.Va_1_2_CharacterTipView = {
	bgBlur = 2,
	container = "Va_1_2_CharacterTipViewContainer",
	maskAlpha = 0,
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_2/va_1_2_charactertipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"#go_attributetip/bg",
		"#go_careertip/bg",
		"#go_skilltip/skilltip1/skillbg",
		"#go_skilltip/skilltip2/skillbg/bg",
		"#go_passiveskilltip/talentbg"
	}
}
var_0_0.VersionActivity1_2DungeonView = {
	container = "VersionActivity1_2DungeonViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_2/map/versionactivity_1_2_dungeonmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/versionactivity_1_2/map/versionactivity_1_2_mapepisodeitem.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab",
		"ui/viewres/dungeon/chaptermap/dungeonmapinteractiveitem.prefab",
		"ui/viewres/dungeon/chaptermap/map_directiongreen.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	preloader = module_views_preloader
}
var_0_0.VersionActivity1_2DungeonMapLevelView = {
	destroy = 0,
	container = "VersionActivity1_2DungeonMapLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/map/versionactivity_1_2_dungeonmaplevelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		},
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity_1_2_StoryCollectView = {
	destroy = 0,
	container = "VersionActivity_1_2_StoryCollectViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_2/versionactivity_1_2_storycollectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {}
}
var_0_0.VersionActivity_1_2_DungeonMapNoteView = {
	destroy = 0,
	container = "VersionActivity_1_2_DungeonMapNoteViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/versionactivity_1_2/map/versionactivity_1_2_dungeonmapnoteview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {}
}
var_0_0.ActivityTradeBargain = {
	destroy = 0,
	container = "ActivityTradeBargainViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/trade/versionactivity_1_2_tradeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_1_2/trade/versionactivity_1_2_tradequoteview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_2/trade/versionactivity_1_2_traderewardview.prefab"
			}
		}
	}
}
var_0_0.TestTaskView = {
	destroy = 0,
	container = "TestTaskViewContainer",
	mainRes = "ui/viewres/testtask/testtaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.ActivityStoryShowView = {
	destroy = 0,
	container = "ActivityStoryShowViewContainer",
	mainRes = "ui/viewres/activity/show/activitystoryshowview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.ActivityDreamShowView = {
	destroy = 0,
	container = "ActivityDreamShowViewContainer",
	mainRes = "ui/viewres/activity/show/activitydreamshowview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.ActivityClassShowView = {
	destroy = 0,
	container = "ActivityClassShowViewContainer",
	mainRes = "ui/viewres/activity/show/activityclassshowview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.SeasonMainView = {
	destroy = 0,
	container = "SeasonMainViewContainer",
	mainRes = "ui/viewres/season/seasonmainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	preloader = module_views_preloader
}
var_0_0.SeasonMarketView = {
	destroy = 0,
	container = "SeasonMarketViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/season/seasonmarketview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.SeasonSpecialMarketView = {
	destroy = 0,
	container = "SeasonSpecialMarketViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/season/seasonspecialmarketview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.SeasonRetailView = {
	destroy = 0,
	container = "SeasonRetailViewContainer",
	mainRes = "ui/viewres/season/seasonretailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.SeasonRetailLevelInfoView = {
	destroy = 0,
	container = "SeasonRetailLevelInfoViewContainer",
	mainRes = "ui/viewres/season/seasonretaillevelinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.SeasonTaskView = {
	destroy = 0,
	container = "SeasonTaskViewContainer",
	mainRes = "ui/viewres/season/seasontaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/season/seasontaskitem.prefab"
	}
}
var_0_0.SeasonSettlementView = {
	destroy = 0,
	container = "SeasonSettlementViewContainer",
	mainRes = "ui/viewres/season/seasonsettlementview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.SeasonCelebrityCardGetlView = {
	destroy = 0,
	container = "SeasonCelebrityCardGetlViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/season/seasoncelebritycardgetlview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.SeasonEquipView = {
	bgBlur = 0,
	container = "SeasonEquipViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/season/seasonequipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/season/seasonequipcarditem.prefab",
		[2] = "ui/viewres/season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.SeasonEquipHeroView = {
	bgBlur = 0,
	container = "SeasonEquipHeroViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/season/seasonequipheroview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/season/seasonequipcarditem.prefab",
		[2] = "ui/viewres/season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.SeasonFightFailView = {
	destroy = 0,
	container = "SeasonFightFailViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/season/seasonfightfailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.SeasonFightSuccView = {
	destroy = 0,
	container = "SeasonFightSuccViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/season/seasonfightsuccview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.SeasonStoreView = {
	destroy = 0,
	container = "SeasonStoreViewContainer",
	mainRes = "ui/viewres/season/seasonstoreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		itemPath = "ui/viewres/season/seasonstoreitem.prefab"
	}
}
var_0_0.SeasonEquipSelfChoiceView = {
	destroy = 0,
	container = "SeasonEquipSelfChoiceViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/season/seasonmulticardchoiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/season/seasonmulticardchoiceitem.prefab",
		[2] = "ui/viewres/season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.SeasonCelebrityCardTipView = {
	container = "SeasonCelebrityCardTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/season/seasoncelebritycardtipview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	otherRes = {
		[1] = "ui/viewres/season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.SeasonEquipComposeView = {
	bgBlur = 0,
	container = "SeasonEquipComposeViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/season/seasonequipcomposeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/season/seasonequipcomposeitem.prefab",
		[2] = "ui/viewres/season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.SeasonEquipBookView = {
	bgBlur = 0,
	container = "SeasonEquipBookViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/season/seasonequipbookview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/season/seasonequipbookitem.prefab",
		[2] = "ui/viewres/season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.SeasonFightRuleTipView = {
	destroy = 0,
	container = "SeasonFightRuleTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/season/seasonfightruletipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				"ui/viewres/season/seasonfightruleview.prefab"
			},
			{
				"ui/viewres/season/seasonfightcardview.prefab"
			}
		}
	}
}
var_0_0.SeasonHeroGroupFightView = {
	bgBlur = 0,
	container = "SeasonHeroGroupFightViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/season/seasonherogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
var_0_0.Season1_2MainView = {
	destroy = 0,
	container = "Season1_2MainViewContainer",
	mainRes = "ui/viewres/v1a2_season/seasonmainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	preloader = module_views_preloader
}
var_0_0.Season1_2MarketView = {
	destroy = 0,
	container = "Season1_2MarketViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/v1a2_season/seasonmarketview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season1_2SpecialMarketView = {
	destroy = 0,
	container = "Season1_2SpecialMarketViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/v1a2_season/seasonspecialmarketview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season1_2RetailView = {
	destroy = 0,
	container = "Season1_2RetailViewContainer",
	mainRes = "ui/viewres/v1a2_season/seasonretailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season1_2RetailLevelInfoView = {
	destroy = 0,
	container = "Season1_2RetailLevelInfoViewContainer",
	mainRes = "ui/viewres/v1a2_season/seasonretaillevelinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season1_2TaskView = {
	destroy = 0,
	container = "Season1_2TaskViewContainer",
	mainRes = "ui/viewres/v1a2_season/seasontaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a2_season/seasontaskitem.prefab"
	}
}
var_0_0.Season1_2SettlementView = {
	destroy = 0,
	container = "Season1_2SettlementViewContainer",
	mainRes = "ui/viewres/v1a2_season/seasonsettlementview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		itemRes = "ui/viewres/v1a2_season/seasonsettlementherogroupitem.prefab"
	}
}
var_0_0.Season1_2CelebrityCardGetlView = {
	destroy = 0,
	container = "Season1_2CelebrityCardGetlViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a2_season/seasoncelebritycardgetlview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Season1_2EquipView = {
	bgBlur = 0,
	container = "Season1_2EquipViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a2_season/seasonequipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a2_season/seasonequipcarditem.prefab",
		[2] = "ui/viewres/v1a2_season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.Season1_2EquipHeroView = {
	bgBlur = 0,
	container = "Season1_2EquipHeroViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a2_season/seasonequipheroview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a2_season/seasonequipcarditem.prefab",
		[2] = "ui/viewres/v1a2_season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.Season1_2FightFailView = {
	destroy = 0,
	container = "Season1_2FightFailViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a2_season/seasonfightfailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Season1_2FightSuccView = {
	destroy = 0,
	container = "Season1_2FightSuccViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a2_season/seasonfightsuccview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Season1_2StoreView = {
	destroy = 0,
	container = "Season1_2StoreViewContainer",
	mainRes = "ui/viewres/v1a2_season/seasonstoreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		itemPath = "ui/viewres/v1a2_season/seasonstoreitem.prefab"
	}
}
var_0_0.Season1_2EquipSelfChoiceView = {
	destroy = 0,
	container = "Season1_2EquipSelfChoiceViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a2_season/seasonmulticardchoiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/v1a2_season/seasonmulticardchoiceitem.prefab",
		[2] = "ui/viewres/v1a2_season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.Season1_2CelebrityCardTipView = {
	container = "Season1_2CelebrityCardTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a2_season/seasoncelebritycardtipview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	otherRes = {
		[1] = "ui/viewres/v1a2_season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.Season1_2EquipComposeView = {
	bgBlur = 0,
	container = "Season1_2EquipComposeViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a2_season/seasonequipcomposeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a2_season/seasonequipcomposeitem.prefab",
		[2] = "ui/viewres/v1a2_season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.Season1_2EquipBookView = {
	bgBlur = 0,
	container = "Season1_2EquipBookViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a2_season/seasonequipbookview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a2_season/seasonequipbookitem.prefab",
		[2] = "ui/viewres/v1a2_season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.Season1_2FightRuleTipView = {
	destroy = 0,
	container = "Season1_2FightRuleTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v1a2_season/seasonfightruletipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				"ui/viewres/v1a2_season/seasonfightruleview.prefab"
			},
			{
				"ui/viewres/v1a2_season/seasonfightcardview.prefab"
			}
		}
	}
}
var_0_0.Season1_2HeroGroupFightView = {
	bgBlur = 4,
	container = "Season1_2HeroGroupFightViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a2_season/seasonherogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
var_0_0.Season1_2AdditionRuleTipView = {
	destroy = 0,
	container = "Season1_2AdditionRuleTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v1a2_season/seasonadditionruletipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.SummerSignPart1View_1_2 = {
	destroy = 0,
	container = "SummerSignPart1ViewContainer_1_2",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/activitynorsignview_1_2.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/activitynorsignitem_1_2.prefab"
	}
}
var_0_0.SummerSignPart2View_1_2 = {
	destroy = 0,
	container = "SummerSignPart2ViewContainer_1_2",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/activitynorsignview_1_2.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/activitynorsignitem_1_2.prefab"
	}
}
var_0_0.Season1_3MainView = {
	destroy = 0,
	container = "Season1_3MainViewContainer",
	mainRes = "ui/viewres/v1a3_season/seasonmainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		role5 = "scenes/v1a3_m_s15_sjwf_1_3/perfab/m_s15_1_3_zongmaoshali_a.prefab",
		section4 = "scenes/v1a3_m_s15_sjwf_1_3/scene_prefab/m_s15_sj_1_3_section04.prefab",
		scene = "scenes/v1a3_m_s15_sjwf_1_3/scene_prefab/m_s15_sj_1_3_background_a.prefab",
		section1 = "scenes/v1a3_m_s15_sjwf_1_3/scene_prefab/m_s15_sj_1_3_section01.prefab",
		section6 = "scenes/v1a3_m_s15_sjwf_1_3/scene_prefab/m_s15_sj_1_3_section06.prefab",
		role3 = "scenes/v1a3_m_s15_sjwf_1_3/perfab/m_s15_1_3_kanjila_a.prefab",
		role6 = "scenes/v1a3_m_s15_sjwf_1_3/perfab/m_s15_1_3_zongmaoshali_b.prefab",
		section3 = "scenes/v1a3_m_s15_sjwf_1_3/scene_prefab/m_s15_sj_1_3_section03.prefab",
		role1 = "scenes/v1a3_m_s15_sjwf_1_3/perfab/m_s15_1_3_jialabona_a.prefab",
		role4 = "scenes/v1a3_m_s15_sjwf_1_3/perfab/m_s15_1_3_kanjila_b.prefab",
		section5 = "scenes/v1a3_m_s15_sjwf_1_3/scene_prefab/m_s15_sj_1_3_section05.prefab",
		section2 = "scenes/v1a3_m_s15_sjwf_1_3/scene_prefab/m_s15_sj_1_3_section02.prefab",
		role2 = "scenes/v1a3_m_s15_sjwf_1_3/perfab/m_s15_1_3_jialabona_b.prefab"
	},
	preloader = module_views_preloader
}
var_0_0.Season1_3MarketView = {
	destroy = 0,
	container = "Season1_3MarketViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/v1a3_season/seasonmarketview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season1_3SpecialMarketView = {
	destroy = 0,
	container = "Season1_3SpecialMarketViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/v1a3_season/seasonspecialmarketview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season1_3RetailView = {
	destroy = 0,
	container = "Season1_3RetailViewContainer",
	mainRes = "ui/viewres/v1a3_season/seasonretailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season1_3RetailLevelInfoView = {
	destroy = 0,
	container = "Season1_3RetailLevelInfoViewContainer",
	mainRes = "ui/viewres/v1a3_season/seasonretaillevelinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season1_3TaskView = {
	destroy = 0,
	container = "Season1_3TaskViewContainer",
	mainRes = "ui/viewres/v1a3_season/seasontaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a3_season/seasontaskitem.prefab"
	}
}
var_0_0.Season1_3SettlementView = {
	destroy = 0,
	container = "Season1_3SettlementViewContainer",
	mainRes = "ui/viewres/v1a3_season/seasonsettlementview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		itemRes = "ui/viewres/v1a3_season/seasonsettlementherogroupitem.prefab"
	}
}
var_0_0.Season1_3CelebrityCardGetlView = {
	destroy = 0,
	container = "Season1_3CelebrityCardGetlViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a3_season/seasoncelebritycardgetlview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Season1_3EquipView = {
	bgBlur = 0,
	container = "Season1_3EquipViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a3_season/seasonequipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a3_season/seasonequipcarditem.prefab",
		[2] = "ui/viewres/v1a3_season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.Season1_3EquipHeroView = {
	bgBlur = 0,
	container = "Season1_3EquipHeroViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a3_season/seasonequipheroview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a3_season/seasonequipcarditem.prefab",
		[2] = "ui/viewres/v1a3_season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.Season1_3FightFailView = {
	destroy = 0,
	container = "Season1_3FightFailViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a3_season/seasonfightfailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Season1_3FightSuccView = {
	destroy = 0,
	container = "Season1_3FightSuccViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a3_season/seasonfightsuccview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Season1_3StoreView = {
	destroy = 0,
	container = "Season1_3StoreViewContainer",
	mainRes = "ui/viewres/v1a3_season/seasonstoreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		itemPath = "ui/viewres/v1a3_season/seasonstoreitem.prefab"
	}
}
var_0_0.Season1_3EquipSelfChoiceView = {
	destroy = 0,
	container = "Season1_3EquipSelfChoiceViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a3_season/seasonmulticardchoiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/v1a3_season/seasonmulticardchoiceitem.prefab",
		[2] = "ui/viewres/v1a3_season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.Season1_3CelebrityCardTipView = {
	container = "Season1_3CelebrityCardTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a3_season/seasoncelebritycardtipview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	otherRes = {
		[1] = "ui/viewres/v1a3_season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.Season1_3EquipComposeView = {
	bgBlur = 0,
	container = "Season1_3EquipComposeViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a3_season/seasonequipcomposeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a3_season/seasonequipcomposeitem.prefab",
		[2] = "ui/viewres/v1a3_season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.Season1_3EquipBookView = {
	bgBlur = 0,
	container = "Season1_3EquipBookViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a3_season/seasonequipbookview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a3_season/seasonequipbookitem.prefab",
		[2] = "ui/viewres/v1a3_season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.Season1_3FightRuleTipView = {
	destroy = 0,
	container = "Season1_3FightRuleTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v1a3_season/seasonfightruletipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				"ui/viewres/v1a3_season/seasonfightruleview.prefab"
			},
			{
				"ui/viewres/v1a3_season/seasonfightcardview.prefab"
			}
		}
	}
}
var_0_0.Season1_3HeroGroupFightView = {
	bgBlur = 4,
	container = "Season1_3HeroGroupFightViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a3_season/seasonherogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
var_0_0.Season1_3AdditionRuleTipView = {
	destroy = 0,
	container = "Season1_3AdditionRuleTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v1a3_season/seasonadditionruletipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.ActivityTradeSuccessView = {
	destroy = 0,
	container = "ActivityTradeSuccessViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_2/trade/versionactivity_1_2_tradesuccessview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Va3ChessGameScene = {
	destroy = 0,
	container = "Va3ChessGameSceneContainer",
	mainRes = "ui/viewres/versionactivity_1_3/va3chess/va3chessgamescene.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
var_0_0.JiaLaBoNaGameResultView = {
	destroy = 0,
	container = "JiaLaBoNaGameResultViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_jialabona/v1a3_jialabonagameresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.JiaLaBoNaMapView = {
	bgBlur = 0,
	container = "JiaLaBoNaMapViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_jialabona/v1a3_jialabonamapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		JiaLaBoNaMapViewStageItem.prefabPath,
		JiaLaBoNaEnum.MapSceneRes[JiaLaBoNaEnum.Chapter.One],
		JiaLaBoNaEnum.MapSceneRes[JiaLaBoNaEnum.Chapter.Two]
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.JiaLaBoNaGameView = {
	bgBlur = 0,
	container = "JiaLaBoNaGameViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_jialabona/v1a3_jialabonagameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_1_3/va3chess/va3chessgamescene.prefab"
			}
		}
	}
}
var_0_0.JiaLaBoNaTaskView = {
	bgBlur = 0,
	container = "JiaLaBoNaTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_jialabona/v1a3_jialabonataskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		JiaLaBoNaTaskItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.JiaLaBoNaStoryView = {
	bgBlur = 3,
	container = "JiaLaBoNaStoryViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_jialabona/v1a3_jialabonastoryview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		JiaLaBoNaStoryViewItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity1_3RadioView = {
	destroy = 0,
	container = "VersionActivity1_3RadioViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_radio/v1a3_radio.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.Activity1_3ChessMapView = {
	destroy = 0,
	container = "Activity1_3ChessMapViewContainer",
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_role2/v1a3_role2_mapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		Activity1_3ChessMapNodeItem.prefabPath,
		Activity1_3ChessEnum.MapSceneResPath[1],
		Activity1_3ChessEnum.MapSceneResPath[2]
	}
}
var_0_0.Activity1_3ChessTaskView = {
	destroy = 0,
	container = "Activity1_3ChessTaskViewContainer",
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_role2/v1a3_role2_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		Activity1_3ChessTaskItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Activity1_3ChessGameView = {
	destroy = 0,
	container = "Activity1_3ChessGameViewContainer",
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_role2/v1a3_role2_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_1_3/v1a3_role2/v1a3_role2_chessgamescene.prefab"
			}
		}
	}
}
var_0_0.Activity1_3ChessResultView = {
	destroy = 0,
	container = "Activity1_3ChessResultContainer",
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_role2/v1a3_role2_gameresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.Activity1_3ChessStoryView = {
	bgBlur = 1,
	container = "Activity1_3ChessStoryViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_role2/v1a3_role2_storyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		Activity1_3ChessStoryViewItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.ArmMainView = {
	destroy = 0,
	container = "ArmMainViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_arm/v1a3_armmainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.ArmRewardView = {
	bgBlur = 0,
	container = "ArmRewardViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_arm/v1a3_armrewardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		ArmRewardViewTaskItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.ArmPuzzlePipeView = {
	bgBlur = 3,
	container = "ArmPuzzlePipeViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_arm/v1a3_armpuzzlepipeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		ArmPuzzlePipeItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Activity1_3_119View = {
	destroy = 0,
	container = "Activity1_3_119ViewContainer",
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_bookview/v1a3_bookview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season123EntryView = {
	destroy = 0,
	container = "Season123EntryViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/seasonver/act123/season123mainview.prefab",
	layer = "POPUP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season123EntryOverview = {
	destroy = 0,
	container = "Season123EntryOverviewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act123/season123entryoverview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season123RetailView = {
	destroy = 0,
	container = "Season123RetailViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/seasonver/act123/season123retaillevelinfoview.prefab",
	layer = "POPUP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.Season123HeroGroupFightView = {
	bgBlur = 4,
	container = "Season123HeroGroupFightViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/seasonver/act123/season123herogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
var_0_0.Season123EpisodeListView = {
	destroy = 0,
	container = "Season123EpisodeListViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/seasonver/act123/season123episodelistview.prefab",
	layer = "POPUP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season123EpisodeLoadingView = {
	destroy = 0,
	container = "Season123EpisodeLoadingViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act123/season123episodeloadingview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
var_0_0.Season123EpisodeDetailView = {
	destroy = 0,
	container = "Season123EpisodeDetailViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/seasonver/act123/season123marketview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season123PickAssistView = {
	destroy = 0,
	container = "Season123PickAssistViewContainer",
	mainRes = "ui/viewres/seasonver/act123/season123pickassistview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/act123/season123pickassistitem.prefab"
	}
}
var_0_0.Season123HeroGroupEditView = {
	container = "Season123HeroGroupEditViewContainer",
	destroy = 5,
	mainRes = "ui/viewres/seasonver/act123/season123herogroupeditview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/act123/season123herogroupedititem.prefab",
		[2] = "ui/viewres/seasonver/act123/season123herogroupquickedititem.prefab"
	},
	customAnimBg = {
		"bg"
	}
}
var_0_0.Season123PickHeroEntryView = {
	destroy = 0,
	container = "Season123PickHeroEntryViewContainer",
	mainRes = "ui/viewres/seasonver/act123/season123pickheroentryview.prefab",
	layer = "POPUP",
	viewType = ViewType.Normal,
	otherRes = {
		[1] = "ui/viewres/seasonver/act123/season123celebritycarditem.prefab"
	}
}
var_0_0.Season123PickHeroView = {
	destroy = 0,
	container = "Season123PickHeroViewContainer",
	mainRes = "ui/viewres/seasonver/act123/season123pickheroview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/act123/season123pickheroitem.prefab"
	}
}
var_0_0.Season123StageLoadingView = {
	destroy = 0,
	container = "Season123StageLoadingViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act123/season123loadingview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.Season123StageFinishView = {
	destroy = 0,
	container = "Season123StageFinishViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act123/season123stagefinishview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.Season123ShowHeroView = {
	destroy = 0,
	container = "Season123ShowHeroViewContainer",
	mainRes = "ui/viewres/seasonver/act123/season123showheroview.prefab",
	layer = "POPUP",
	viewType = ViewType.Normal,
	otherRes = {
		[1] = "ui/viewres/seasonver/act123/season123celebritycarditem.prefab"
	}
}
var_0_0.Season123EquipHeroView = {
	bgBlur = 0,
	container = "Season123EquipHeroViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/seasonver/act123/season123equipheroview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/act123/season123equipcarditem.prefab",
		[2] = "ui/viewres/seasonver/act123/season123celebritycarditem.prefab"
	}
}
var_0_0.Season123EquipView = {
	bgBlur = 0,
	container = "Season123EquipViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/seasonver/act123/season123equipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/act123/season123equipcarditem.prefab",
		[2] = "ui/viewres/seasonver/act123/season123celebritycarditem.prefab"
	}
}
var_0_0.Season123EnemyView = {
	bgBlur = 1,
	container = "Season123EnemyViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/seasonver/act123/season123enemyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	customAnimBg = {
		"#simage_bg",
		"#simage_rightbg"
	}
}
var_0_0.Season123StoreView = {
	destroy = 0,
	container = "Season123StoreViewContainer",
	mainRes = "ui/viewres/seasonver/act123/season123storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/act123/season123storeitem.prefab"
	}
}
var_0_0.Season123TaskView = {
	destroy = 0,
	container = "Season123TaskViewContainer",
	mainRes = "ui/viewres/seasonver/act123/season123taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/act123/season123taskitem.prefab"
	}
}
var_0_0.Season123EquipBookView = {
	bgBlur = 0,
	container = "Season123EquipBookViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/seasonver/act123/season123equipbookview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/act123/season123equipbookitem.prefab",
		[2] = "ui/viewres/seasonver/act123/season123celebritycarditem.prefab"
	}
}
var_0_0.Season123BatchDecomposeView = {
	bgBlur = 0,
	container = "Season123BatchDecomposeViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/seasonver/act123/season123batchdecomposeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/act123/season123decomposeitem.prefab",
		[2] = "ui/viewres/seasonver/act123/season123celebritycarditem.prefab"
	}
}
var_0_0.Season123DecomposeFilterView = {
	destroy = 10,
	container = "Season123DecomposeFilterViewContainer",
	mainRes = "ui/viewres/seasonver/act123/season123decomposefilterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.Season123DecomposeView = {
	container = "Season123DecomposeViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act123/season123decomposeview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/seasonver/act123/season123celebritycarditem.prefab"
	}
}
var_0_0.Season123CelebrityCardTipView = {
	container = "Season123CelebrityCardTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act123/season123celebritycardtipview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	otherRes = {
		[1] = "ui/viewres/seasonver/act123/season123celebritycarditem.prefab"
	}
}
var_0_0.Season123CelebrityCardGetView = {
	destroy = 0,
	container = "Season123CelebrityCardGetViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act123/season123celebritycardgetview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Season123CardPackageView = {
	bgBlur = 1,
	container = "Season123CardPackageViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/seasonver/act123/season123cardpackageview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/act123/season123cardpackageitem.prefab",
		[2] = "ui/viewres/seasonver/act123/season123celebritycarditem.prefab"
	}
}
var_0_0.Season123StoryView = {
	destroy = 0,
	container = "Season123StoryViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act123/season123storyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season123StoryPagePopView = {
	destroy = 0,
	container = "Season123StoryPagePopViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act123/season123storypagepopview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Season123RecordWindow = {
	destroy = 0,
	container = "Season123RecordWindowContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act123/season123recordwindow.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Season123FightSuccView = {
	destroy = 0,
	container = "Season123FightSuccViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act123/season123fightsuccview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Season123FightFailView = {
	destroy = 0,
	container = "Season123FightFailViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act123/season123fightfailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Season123SettlementView = {
	destroy = 0,
	container = "Season123SettlementViewContainer",
	mainRes = "ui/viewres/seasonver/act123/season123settlementview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		itemRes = "ui/viewres/seasonver/act123/season123settlementherogroupitem.prefab"
	}
}
var_0_0.Season123AdditionRuleTipView = {
	destroy = 0,
	container = "Season123AdditionRuleTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/seasonver/act123/season123additionruletipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Season123FightRuleTipView = {
	destroy = 0,
	container = "Season123FightRuleTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/seasonver/act123/season123fightruletipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				"ui/viewres/seasonver/act123/season123fightruleview.prefab"
			},
			{
				"ui/viewres/seasonver/act123/season123fightcardview.prefab"
			}
		}
	}
}
var_0_0.Season123ResetView = {
	destroy = 0,
	container = "Season123ResetViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act123/season123resetview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity1_4EnterView = {
	destroy = 0,
	container = "VersionActivity1_4EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_1_4/versionactivity_1_4_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Activity132CollectView = {
	destroy = 0,
	container = "Activity132CollectViewContainer",
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_collect/v1a4_collectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Activity132CollectDetailView = {
	destroy = 0,
	container = "Activity132CollectDetailViewContainer",
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_collect/v1a4_collectdetail.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Activity136ChoiceView = {
	destroy = 0,
	container = "Activity136ChoiceViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_selfselectfivestars/activity136choiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_2/v2a2_selfselectfivestars/activity136choiceitem.prefab"
	}
}
var_0_0.Activity136View = {
	destroy = 0,
	container = "Activity136ViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_selfselectfivestars/v2a2_selfselectfivestarsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.Activity136FullView = {
	destroy = 0,
	container = "Activity136FullViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_selfselectfivestars/v2a2_selfselectfivestarsfullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.Role37PuzzleView = {
	destroy = 0,
	container = "Role37PuzzleViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_37role/v1a4_role37_questionview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Role37PuzzleRecordView = {
	destroy = 0,
	container = "Role37PuzzleRecordViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_37role/v1a4_role37_recordpanel.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Role37PuzzleResultView = {
	destroy = 0,
	container = "Role37PuzzleResultViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_37role/v1a4_role37_gameresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.Activity130TaskView = {
	bgBlur = 0,
	container = "Activity130TaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_37role/v1a4_role37_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		Activity130TaskItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Activity130GameView = {
	destroy = 0,
	container = "Activity130GameViewContainer",
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_37role/v1a4_role37_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Activity130LevelView = {
	bgBlur = 0,
	container = "Activity130LevelViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_37role/v1a4_role37_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/versionactivity_1_4/v1a4_37role/v1a4_role37_levelviewstageitem.prefab",
		"ui/viewres/versionactivity_1_4/v1a4_37role/v1a4_dungeon_change.prefab",
		"scenes/v1a4_m_s12_37jshd/prefab/v1a4_m_s12_zjm_37_a_p.prefab",
		"scenes/v1a4_m_s12_37jshd/prefab/v1a4_m_s12_zjm_37_b_p.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.ActivityDoubleFestivalSignPaiLianView_1_3 = {
	destroy = 0,
	container = "ActivityDoubleFestivalSignPaiLianViewContainer_1_3",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/activitydoublefestivalsignpailianview_1_3.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/activitydoublefestivalsignitem_1_3.prefab"
	}
}
var_0_0.Activity130DialogView = {
	destroy = 0,
	container = "Activity130DialogViewContainer",
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_37role/v1a4_role37_dialogview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Activity130CollectView = {
	bgBlur = 1,
	container = "Activity130CollectViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_37role/v1a4_role37_collectpanel.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_4/v1a4_37role/v1a4_role37_collectitem.prefab"
	}
}
var_0_0.Activity131TaskView = {
	bgBlur = 0,
	container = "Activity131TaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_6role/v1a4_role6_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		Activity131TaskItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Activity131GameView = {
	destroy = 0,
	container = "Activity131GameViewContainer",
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_6role/v1a4_role6_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Activity131LevelView = {
	bgBlur = 0,
	container = "Activity131LevelViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_6role/v1a4_role6_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_4/v1a4_6role/v1a4_role6_levelviewstageitem.prefab",
		[2] = "scenes/v1a4_m_s12_6jshd/prefab/v1a4_m_s12_6_zjm_a.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Activity131DialogView = {
	destroy = 0,
	container = "Activity131DialogViewContainer",
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_6role/v1a4_role6_dialogview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Activity131LogView = {
	container = "Activity131LogViewContainer",
	maskAlpha = 0,
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_6role/v1a4_role6_logview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_4/v1a4_6role/v1a4_role6_logitem.prefab",
		[2] = "ui/viewres/versionactivity_1_4/v1a4_6role/v1a4_role6_logcategoryitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Activity131BattleView = {
	destroy = 0,
	container = "Activity131BattleViewContainer",
	maskAlpha = 0,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_6role/v1a4_role6_interactivepanel.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default
}
var_0_0.Activity133View = {
	destroy = 0,
	container = "Activity133ViewContainer",
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_shiprepair/activity133view.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_4/v1a4_shiprepair/activity133item.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.ActivityStarLightSignPart1PaiLianView_1_3 = {
	destroy = 0,
	container = "ActivityStarLightSignPart1PaiLianViewContainer_1_3",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/activitystarlightsignpart1pailianview_1_3.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.ActivityStarLightSignPart2PaiLianView_1_3 = {
	destroy = 0,
	container = "ActivityStarLightSignPart2PaiLianViewContainer_1_3",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/activitystarlightsignpart2pailianview_1_3.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.DailyAllowanceView = {
	destroy = 0,
	container = "DailyAllowanceViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_goldview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.Activity133TaskView = {
	destroy = 0,
	container = "Activity133TaskViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_shiprepair/activity133taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_4/v1a4_shiprepair/activity133taskitem.prefab"
	}
}
var_0_0.Activity134View = {
	destroy = 0,
	container = "Activity134ViewContainer",
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_dustyrecords/v1a4_dustyrecordsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_4/v1a4_dustyrecords/v1a4_dustyrecordsreportitem.prefab",
		[2] = "ui/viewres/versionactivity_1_4/v1a4_dustyrecords/v1a4_dustyrecordsprogressitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.Activity134TaskView = {
	destroy = 0,
	container = "Activity134TaskViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_dustyrecords/activity134taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_4/v1a4_dustyrecords/activity134taskitem.prefab"
	}
}
var_0_0.VersionActivity1_4TaskView = {
	destroy = 0,
	container = "VersionActivity1_4TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_collect/task/v1a4_main_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_4/v1a4_collect/task/v1a4_main_taskitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.V1a4_BossRushMainView = {
	bgBlur = 0,
	container = "V1a4_BossRushMainViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a4_bossrushmainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		BossRushEnum.ResPath.v1a4_bossrushmainitem,
		BossRushEnum.ResPath.v1a4_bossrush_mainview_assessicon
	}
}
var_0_0.V1a4_BossRushLevelDetail = {
	bgBlur = 0,
	container = "V1a4_BossRushLevelDetailContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a4_bossrushleveldetail.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		BossRushEnum.ResPath.v1a4_bossrush_leveldetail_assessicon,
		BossRushEnum.ResPath.v1a4_bossrushleveldetail_spine
	},
	preloader = module_views_preloader
}
var_0_0.V1a4_BossRush_ScoreTaskAchievement = {
	bgBlur = 1,
	container = "V1a4_BossRush_ScoreTaskAchievementContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a4_bossrush_scoretaskachievement.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a4_bossrush_scoretaskachievementitem.prefab",
		[2] = BossRushEnum.ResPath.v1a4_bossrush_achievement_assessicon
	}
}
var_0_0.V1a4_BossRush_ResultView = {
	destroy = 0,
	container = "V1a4_BossRush_ResultViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a4_bossrush_resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		BossRushEnum.ResPath.v1a4_bossrush_result_assess,
		BossRushEnum.ResPath.v1a4_bossrush_herogroup,
		BossRushEnum.ResPath.v1a4_bossrush_herogroupitem1,
		BossRushEnum.ResPath.v1a4_bossrush_herogroupitem2
	}
}
var_0_0.V1a4_BossRush_ResultPanel = {
	destroy = 0,
	container = "V1a4_BossRush_ResultPanelContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a4_bossrush_resultpanel.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		BossRushEnum.ResPath.v1a4_bossrush_result_assess
	}
}
var_0_0.V1a4_BossRush_ScheduleView = {
	destroy = 0,
	container = "V1a4_BossRush_ScheduleViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a4_bossrush_scheduleview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a4_bossrush_scheduleitem.prefab"
	}
}
var_0_0.V1a4_BossRush_EnemyInfoView = {
	destroy = 0,
	container = "V1a4_BossRush_EnemyInfoViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/herogroup/enemyinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.V1a6_BossRush_EnterView = {
	destroy = 0,
	container = "V1a6_BossRush_EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.V1a6_BossRush_StoreView = {
	destroy = 0,
	container = "V1a6_BossRush_StoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.V1a6_BossRush_BonusView = {
	destroy = 0,
	container = "V1a6_BossRush_BonusViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a4_bossrush_scoretaskachievement.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_1_4/v1a4_bossrush/v2a1_bossrush_specialscheduleview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_achievementview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_scheduleview.prefab"
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_achievementitem.prefab",
		"ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_scheduleitem.prefab",
		BossRushEnum.ResPath.v1a4_bossrush_achievement_assessicon,
		"ui/viewres/versionactivity_1_4/v1a4_bossrush/v2a1_bossrush_specialscheduleitem.prefab"
	}
}
var_0_0.V1a6_BossRush_ResultView = {
	destroy = 0,
	container = "V1a6_BossRush_ResultViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a4_bossrush_resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		BossRushEnum.ResPath.v1a4_bossrush_result_assess,
		BossRushEnum.ResPath.v1a4_bossrush_herogroup,
		BossRushEnum.ResPath.v1a4_bossrush_herogroupitem1,
		BossRushEnum.ResPath.v1a4_bossrush_herogroupitem2
	}
}
var_0_0.V1a6_BossRush_ResultPanel = {
	destroy = 0,
	container = "V1a6_BossRush_ResultPanelContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_resultpanel.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		BossRushEnum.ResPath.v1a6_bossrush_result_assess,
		BossRushEnum.ResPath.v1a4_bossrush_result_assess
	}
}
var_0_0.V2a1_BossRush_OfferRoleView = {
	destroy = 0,
	container = "V2a1_BossRush_OfferRoleViewContainer",
	maskAlpha = 0,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v2a1_bossrush_offercharview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v2a1_bossrush_offercharitem.prefab"
	}
}
var_0_0.VersionActivity1_4DungeonView = {
	bgBlur = 0,
	container = "VersionActivity1_4DungeonViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_dungeon/v1a4_dungeonview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_4/v1a4_dungeon/v1a4_dungeonitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity1_4DungeonEpisodeView = {
	bgBlur = 0,
	container = "VersionActivity1_4DungeonEpisodeViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_dungeon/v1a4_dungeonepisodeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.Activity129View = {
	bgBlur = 0,
	container = "Activity129ViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_tokenstore/v1a4_tokenstore.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/common/commonpropitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.Season1_4MainView = {
	destroy = 0,
	container = "Season1_4MainViewContainer",
	mainRes = "ui/viewres/v1a4_season/seasonmainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		role5 = "scenes/v1a4_m_s15_sj_1_4/prefab/m_s15_sj_yfyt_qz_z_6.prefab",
		section4 = "scenes/v1a4_m_s15_sj_1_4/scene_prefab/v1a4_m_s15_sj_1_4_section04.prefab",
		scene = "scenes/v1a4_m_s15_sj_1_4/scene_prefab/v1a4_m_s15_sj_1_4_background_a.prefab",
		section1 = "scenes/v1a4_m_s15_sj_1_4/scene_prefab/v1a4_m_s15_sj_1_4_section01.prefab",
		section6 = "scenes/v1a4_m_s15_sj_1_4/scene_prefab/v1a4_m_s15_sj_1_4_section06.prefab",
		role3 = "scenes/v1a4_m_s15_sj_1_4/prefab/m_s15_sj_yfyt_qz_y_6.prefab",
		role6 = "scenes/v1a4_m_s15_sj_1_4/prefab/m_s15_sj_yfyt_qz_y_37.prefab",
		section3 = "scenes/v1a4_m_s15_sj_1_4/scene_prefab/v1a4_m_s15_sj_1_4_section03.prefab",
		role1 = "scenes/v1a4_m_s15_sj_1_4/prefab/m_s15_sj_yfyt_qz_z_37.prefab",
		role4 = "scenes/v1a4_m_s15_sj_1_4/prefab/m_s15_sj_yfyt_qz_z_sfy.prefab",
		section5 = "scenes/v1a4_m_s15_sj_1_4/scene_prefab/v1a4_m_s15_sj_1_4_section05.prefab",
		section2 = "scenes/v1a4_m_s15_sj_1_4/scene_prefab/v1a4_m_s15_sj_1_4_section02.prefab",
		role2 = "scenes/v1a4_m_s15_sj_1_4/prefab/m_s15_sj_yfyt_qz_y_sfy.prefab"
	},
	preloader = module_views_preloader
}
var_0_0.Season1_4MarketView = {
	destroy = 0,
	container = "Season1_4MarketViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/v1a4_season/seasonmarketview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season1_4SpecialMarketView = {
	destroy = 0,
	container = "Season1_4SpecialMarketViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/v1a4_season/seasonspecialmarketview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season1_4RetailView = {
	destroy = 0,
	container = "Season1_4RetailViewContainer",
	mainRes = "ui/viewres/v1a4_season/seasonretailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season1_4RetailLevelInfoView = {
	destroy = 0,
	container = "Season1_4RetailLevelInfoViewContainer",
	mainRes = "ui/viewres/v1a4_season/seasonretaillevelinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season1_4TaskView = {
	destroy = 0,
	container = "Season1_4TaskViewContainer",
	mainRes = "ui/viewres/v1a4_season/seasontaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a4_season/seasontaskitem.prefab"
	}
}
var_0_0.Season1_4SettlementView = {
	destroy = 0,
	container = "Season1_4SettlementViewContainer",
	mainRes = "ui/viewres/v1a4_season/seasonsettlementview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		itemRes = "ui/viewres/v1a4_season/seasonsettlementherogroupitem.prefab"
	}
}
var_0_0.Season1_4CelebrityCardGetlView = {
	destroy = 0,
	container = "Season1_4CelebrityCardGetlViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a4_season/seasoncelebritycardgetlview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Season1_4EquipView = {
	bgBlur = 0,
	container = "Season1_4EquipViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a4_season/seasonequipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a4_season/seasonequipcarditem.prefab",
		[2] = "ui/viewres/v1a4_season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.Season1_4EquipHeroView = {
	bgBlur = 0,
	container = "Season1_4EquipHeroViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a4_season/seasonequipheroview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a4_season/seasonequipcarditem.prefab",
		[2] = "ui/viewres/v1a4_season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.Season1_4FightFailView = {
	destroy = 0,
	container = "Season1_4FightFailViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a4_season/seasonfightfailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Season1_4FightSuccView = {
	destroy = 0,
	container = "Season1_4FightSuccViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a4_season/seasonfightsuccview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Season1_4StoreView = {
	destroy = 0,
	container = "Season1_4StoreViewContainer",
	mainRes = "ui/viewres/v1a4_season/seasonstoreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		itemPath = "ui/viewres/v1a4_season/seasonstoreitem.prefab"
	}
}
var_0_0.Season1_4EquipSelfChoiceView = {
	destroy = 0,
	container = "Season1_4EquipSelfChoiceViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a4_season/seasonmulticardchoiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/v1a4_season/seasonmulticardchoiceitem.prefab",
		[2] = "ui/viewres/v1a4_season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.Season1_4CelebrityCardTipView = {
	container = "Season1_4CelebrityCardTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a4_season/seasoncelebritycardtipview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	otherRes = {
		[1] = "ui/viewres/v1a4_season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.Season1_4EquipComposeView = {
	bgBlur = 0,
	container = "Season1_4EquipComposeViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a4_season/seasonequipcomposeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a4_season/seasonequipcomposeitem.prefab",
		[2] = "ui/viewres/v1a4_season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.Season1_4EquipBookView = {
	bgBlur = 0,
	container = "Season1_4EquipBookViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a4_season/seasonequipbookview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a4_season/seasonequipbookitem.prefab",
		[2] = "ui/viewres/v1a4_season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.Season1_4FightRuleTipView = {
	destroy = 0,
	container = "Season1_4FightRuleTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v1a4_season/seasonfightruletipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				"ui/viewres/v1a4_season/seasonfightruleview.prefab"
			},
			{
				"ui/viewres/v1a4_season/seasonfightcardview.prefab"
			}
		}
	}
}
var_0_0.Season1_4HeroGroupFightView = {
	bgBlur = 4,
	container = "Season1_4HeroGroupFightViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a4_season/seasonherogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
var_0_0.Season1_4AdditionRuleTipView = {
	destroy = 0,
	container = "Season1_4AdditionRuleTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v1a4_season/seasonadditionruletipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Season1_4SumView = {
	destroy = 0,
	container = "Season1_4SumViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/v1a4_season/seasonsumview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.V1a4_Role_PanelSignView_Part1 = {
	destroy = 0,
	container = "V1a4_Role_PanelSignView_Part1_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a4_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a4_role_signitem.prefab"
	}
}
var_0_0.V1a4_Role_PanelSignView_Part2 = {
	destroy = 0,
	container = "V1a4_Role_PanelSignView_Part2_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a4_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a4_role_signitem.prefab"
	}
}
var_0_0.V1a4_Role_FullSignView_Part1 = {
	destroy = 0,
	container = "V1a4_Role_FullSignView_Part1_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v1a4_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a4_role_signitem.prefab"
	}
}
var_0_0.V1a4_Role_FullSignView_Part2 = {
	destroy = 0,
	container = "V1a4_Role_FullSignView_Part2_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v1a4_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a4_role_signitem.prefab"
	}
}
var_0_0.TurnbackPopupBeginnerView = {
	destroy = 0,
	container = "TurnbackPopupBeginnerViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/turnback/turnbackpopupbeginnerview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/turnback/turnbackpopuprewardview.prefab"
	}
}
var_0_0.TurnbackBeginnerView = {
	bgBlur = 1,
	container = "TurnbackBeginnerViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/turnback/turnbackbeginnerview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/turnback/turnbackcategoryitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.TurnbackTaskView = {
	destroy = 0,
	container = "TurnbackTaskViewContainer",
	mainRes = "ui/viewres/turnback/turnbacktaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/turnback/turnbacktaskitem.prefab"
	}
}
var_0_0.TurnbackDungeonShowView = {
	destroy = 0,
	container = "TurnbackDungeonShowViewContainer",
	mainRes = "ui/viewres/turnback/turnbackdungeonshowview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.TurnbackRewardShowView = {
	destroy = 0,
	container = "TurnbackRewardShowViewContainer",
	mainRes = "ui/viewres/turnback/turnbackrewardshowview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.TurnbackSignInView = {
	destroy = 0,
	container = "TurnbackSignInViewContainer",
	mainRes = "ui/viewres/turnback/turnbacksigninview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/turnback/turnbacksigninitem.prefab"
	}
}
var_0_0.TurnbackRecommendView = {
	destroy = 0,
	container = "TurnbackRecommendViewContainer",
	mainRes = "ui/viewres/turnback/turnbackrecommendview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.TurnBackInvitationMainView = {
	destroy = 0,
	container = "TurnBackInvitationMainViewContainer",
	mainRes = "ui/viewres/activity/v2a5_turnback_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.TurnbackNewBeginnerView = {
	bgBlur = 1,
	container = "TurnbackNewBeginnerViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/turnback/new/turnbacknewbeginnerview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/turnback/new/turnbacknewcategoryitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.TurnbackNewTaskView = {
	destroy = 0,
	container = "TurnbackNewTaskViewContainer",
	mainRes = "ui/viewres/turnback/new/turnbacknewtaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/turnback/new/turnbacknewtaskitem.prefab"
	}
}
var_0_0.TurnbackNewBenfitView = {
	destroy = 0,
	container = "TurnbackNewBenfitViewContainer",
	mainRes = "ui/viewres/turnback/new/turnbacknewbenfitview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.TurnbackNewProgressView = {
	destroy = 0,
	container = "TurnbackNewProgressViewContainer",
	mainRes = "ui/viewres/turnback/new/turnbacknewprogressview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.TurnbackNewSignInView = {
	destroy = 0,
	container = "TurnbackNewSignInViewContainer",
	mainRes = "ui/viewres/turnback/new/turnbacknewsigninview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.TurnbackNewRecommendView = {
	destroy = 0,
	container = "TurnbackNewRecommendViewContainer",
	mainRes = "ui/viewres/turnback/new/turnbacknewrecommendview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.TurnbackNewLatterView = {
	bgBlur = 1,
	container = "TurnbackNewLatterViewContainer",
	mainRes = "ui/viewres/turnback/new/turnbacklatterview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8
}
var_0_0.TurnbackDoubleRewardChargeView = {
	bgBlur = 1,
	container = "TurnbackDoubleRewardChargeViewContainer",
	mainRes = "ui/viewres/turnback/new/turnbackdoublerewardchargeview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.TurnbackNewShowRewardView = {
	destroy = 0,
	container = "TurnbackNewShowRewardViewContainer",
	mainRes = "ui/viewres/turnback/new/turnbackshowrewardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.TurnbackReviewView = {
	destroy = 0,
	container = "TurnbackReviewViewContainer",
	mainRes = "ui/viewres/turnback/new/turnbackstoryreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.AchievementEntryView = {
	destroy = 0,
	container = "AchievementEntryViewContainer",
	mainRes = "ui/viewres/achievement/achievemententryview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.AchievementMainView = {
	destroy = 0,
	container = "AchievementMainViewContainer",
	mainRes = "ui/viewres/achievement/achievementmainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/achievement/achievementmainitem.prefab",
		[2] = "ui/viewres/achievement/achievementmainicon.prefab"
	}
}
var_0_0.AchievementSelectView = {
	destroy = 0,
	container = "AchievementSelectViewContainer",
	mainRes = "ui/viewres/achievement/achievementselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/achievement/achievementselectitem.prefab",
		[2] = "ui/viewres/achievement/achievementmainicon.prefab"
	}
}
var_0_0.AchievementLevelView = {
	bgBlur = 1,
	container = "AchievementLevelViewContainer",
	mainRes = "ui/viewres/achievement/achievementlevelview.prefab",
	destroy = 0,
	blurIterations = 2,
	blurFactor = 0.1,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	customAnimBg = {
		"bg"
	},
	otherRes = {
		[1] = "ui/viewres/achievement/achievementmainicon.prefab"
	}
}
var_0_0.AchievementGroupPreView = {
	destroy = 0,
	container = "AchievementGroupPreViewContainer",
	bgBlur = 1,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/achievement/achievementmainicon.prefab"
	}
}
var_0_0.VoiceChooseView = {
	destroy = 0,
	container = "VoiceChooseViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/voice/voicechooseview.prefab",
	layer = "TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/voice/voicechooseitem.prefab"
	}
}
var_0_0.VersionActivity1_5EnterView = {
	destroy = 0,
	container = "VersionActivity1_5EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_1_5/versionactivity_1_5_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity1_5DungeonMapView = {
	destroy = 0,
	container = "VersionActivity1_5DungeonMapViewContainer",
	mainRes = "ui/viewres/versionactivity_1_5/dungeon/versionactivity_1_5_dungeonmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/versionactivity_1_5/dungeon/versionactivity_1_5_mapepisodeitem.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab",
		"ui/viewres/versionactivity_1_5/dungeon/v1a5_dungeonmapinteractiveitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity1_5DungeonMapLevelView = {
	destroy = 0,
	container = "VersionActivity1_5DungeonMapLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_1_5/dungeon/versionactivity_1_5_dungeonmaplevelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		},
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity1_5StoreView = {
	destroy = 0,
	container = "VersionActivity1_5StoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_5/dungeon/versionactivity_1_5_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.RoleStoryActivityMainView = {
	bgBlur = 0,
	container = "RoleStoryActivityMainViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/dungeon/rolestory/actrolestorymainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	otherRes = {
		itemRes = "ui/viewres/dungeon/rolestory/actrolestoryitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/dungeon/rolestory/rolestorycurrencyview.prefab"
			}
		}
	}
}
var_0_0.RoleStoryHeroGroupFightView = {
	bgBlur = 4,
	container = "RoleStoryHeroGroupFightViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/herogroup/herogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
var_0_0.RoleStoryDispatchView = {
	bgBlur = 0,
	container = "RoleStoryDispatchViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/dungeon/rolestory/rolestorydispatchview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		storyItemRes = "ui/viewres/dungeon/rolestory/rolestorydispatchstoryitem.prefab",
		normalItemRes = "ui/viewres/dungeon/rolestory/rolestorydispatchnormalitem.prefab"
	}
}
var_0_0.RoleStoryDispatchTipsView = {
	destroy = 0,
	container = "RoleStoryDispatchTipsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/dungeon/rolestory/rolestorydispatchtipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				"ui/viewres/dungeon/rolestory/rolestorycurrencyview.prefab"
			}
		}
	}
}
var_0_0.RoleStoryReviewView = {
	destroy = 0,
	container = "RoleStoryReviewViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/dungeon/rolestory/rolestoryreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.RoleStoryDispatchMainView = {
	destroy = 0,
	container = "RoleStoryDispatchMainViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/dungeon/rolestory/rolestorydispatchmainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		itemRes = "ui/viewres/dungeon/rolestory/actrolestoryitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/dungeon/rolestory/rolestorycurrencyview.prefab"
			}
		}
	}
}
var_0_0.VersionActivity1_5NormalStoreGoodsView = {
	bgBlur = 1,
	container = "VersionActivity1_5NormalStoreGoodsViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/store/normalstoregoodsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity1_5TaskView = {
	destroy = 0,
	container = "VersionActivity1_5TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_1_5/dungeon/versionactivity_1_5_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_1_5/dungeon/versionactivity_1_5_taskitem.prefab"
	}
}
var_0_0.VersionActivity1_5DispatchView = {
	destroy = 0,
	container = "VersionActivity1_5DispatchViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_5/dungeon/versionactivity_1_5_dispatchview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.VersionActivity1_5RevivalTaskView = {
	bgBlur = 1,
	container = "VersionActivity1_5RevivalTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_5/dungeon/v1a5_revival/v1a5_revivaltaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_1_5/dungeon/v1a5_revival/v1a5_revivaltaskitem.prefab"
	}
}
var_0_0.VersionActivity1_5DungeonMapTaskView = {
	destroy = 0,
	container = "VersionActivity1_5DungeonMapTaskViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_5/dungeon/versionactivity_1_5_dungeonmaptaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.V1a5BuildingView = {
	destroy = 0,
	container = "V1a5BuildingViewContainer",
	mainRes = "ui/viewres/versionactivity_1_5/dungeon/v1a5_building/v1a5_buildingview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.V1a5BuildingDetailView = {
	destroy = 0,
	container = "V1a5BuildingDetailViewContainer",
	mainRes = "ui/viewres/versionactivity_1_5/dungeon/v1a5_building/v1a5_buildingdetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.V1a5BuildingSkillView = {
	destroy = 0,
	container = "V1a5BuildingSkillViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_5/dungeon/v1a5_building/v1a5_buildingskillview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.AiZiLaMapView = {
	bgBlur = 0,
	container = "AiZiLaMapViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_mapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		AiZiLaStageItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.AiZiLaStoryView = {
	bgBlur = 3,
	container = "AiZiLaStoryViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_storyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		AiZiLaStoryItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.AiZiLaTaskView = {
	bgBlur = 0,
	container = "AiZiLaTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		AiZiLaTaskItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.AiZiLaEquipView = {
	bgBlur = 3,
	container = "AiZiLaEquipViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_equipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		AiZiLaGoodsItem.prefabPath2
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.AiZiLaRecordView = {
	destroy = 0,
	container = "AiZiLaRecordViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_recordview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.AiZiLaHandbookView = {
	bgBlur = 3,
	container = "AiZiLaHandbookViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_handbook.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		AiZiLaGoodsItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.AiZiLaEpsiodeDetailView = {
	bgBlur = 3,
	container = "AiZiLaEpsiodeDetailViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_epsiodedetail.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal,
	otherRes = {
		AiZiLaGoodsItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.AiZiLaGameOpenEffectView = {
	destroy = 0,
	container = "AiZiLaGameOpenEffectViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_gameopeneffectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default
}
var_0_0.AiZiLaGameView = {
	bgBlur = 0,
	container = "AiZiLaGameViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	otherRes = {
		AiZiLaGoodsItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.AiZiLaGameResultView = {
	destroy = 0,
	container = "AiZiLaGameResultViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_gameresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		AiZiLaGoodsItem.prefabPath
	}
}
var_0_0.AiZiLaGameStateView = {
	destroy = 0,
	container = "AiZiLaGameStateViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_gamestateview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.AiZiLaGamePackView = {
	bgBlur = 3,
	container = "AiZiLaGamePackViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_gamepackview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		AiZiLaGoodsItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.AiZiLaGameEventView = {
	destroy = 0,
	container = "AiZiLaGameEventViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_gameeventview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	otherRes = {
		AiZiLaGoodsItem.prefabPath
	}
}
var_0_0.AiZiLaGameEventResult = {
	destroy = 0,
	container = "AiZiLaGameEventResultContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_gameeventresult.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	otherRes = {
		AiZiLaGoodsItem.prefabPath
	}
}
var_0_0.Activity142MapView = {
	destroy = 0,
	container = "Activity142MapViewContainer",
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_kerandian/v1a5_kerandian_mapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Activity142StoryView = {
	destroy = 0,
	container = "Activity142StoryViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_kerandian/v1a5_kerandian_storyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Activity142TaskView = {
	destroy = 0,
	container = "Activity142TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_kerandian/v1a5_kerandian_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_5/v1a5_kerandian/v1a5_kerandian_taskitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Activity142CollectView = {
	destroy = 0,
	container = "Activity142CollectViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_kerandian/v1a5_kerandian_collectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Activity142GetCollectionView = {
	destroy = 0,
	container = "Activity142GetCollectionViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_kerandian/v1a5_kerandian_getcollectionview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.Activity142ResultView = {
	destroy = 0,
	container = "Activity142ResultViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_kerandian/v1a5_kerandian_resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.Activity142GameView = {
	destroy = 0,
	container = "Activity142GameViewContainer",
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_kerandian/v1a5_kerandian_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	otherRes = {},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_1_3/va3chess/va3chessgamescene.prefab"
			}
		}
	}
}
var_0_0.SportsNewsView = {
	destroy = 0,
	container = "SportsNewsViewContainer",
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_news/v1a5_news_mainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_1_5/v1a5_news/v1a5_news_mainreaditem.prefab",
		"ui/viewres/versionactivity_1_5/v1a5_news/v1a5_news_maintaskitem.prefab",
		"ui/viewres/versionactivity_1_5/v1a5_news/v1a5_news_tasktabitem.prefab"
	}
}
var_0_0.SportsNewsTaskView = {
	bgBlur = 1,
	container = "SportsNewsTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_news/v1a5_news_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_5/v1a5_news/v1a5_news_taskitem.prefab",
		[2] = "ui/viewres/versionactivity_1_5/v1a5_news/v1a5_news_tasktabitem.prefab"
	}
}
var_0_0.SportsNewsReadView = {
	destroy = 0,
	container = "SportsNewsReadViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_news/v1a5_news_readview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.SportsNewsPaperView = {
	destroy = 0,
	container = "SportsNewsPaperViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_news/v1a5_news_paperview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.VersionActivity1_5WarmUpView = {
	destroy = 0,
	container = "VersionActivity1_5WarmUpViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_warmup/v1a5_warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.PeaceUluView = {
	destroy = 0,
	container = "PeaceUluViewContainer",
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_peaceulu/v1a5_peaceulu_view.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_5/v1a5_peaceulu/v1a5_peaceulu_taskitem.prefab",
		[2] = "ui/viewres/versionactivity_1_5/v1a5_peaceulu/v1a5_peaceulu_progressitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_1_5/v1a5_peaceulu/v1a5_peaceulu_mainview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_5/v1a5_peaceulu/v1a5_peaceulu_gameview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_5/v1a5_peaceulu/v1a5_peaceulu_resultview.prefab"
			}
		}
	}
}
var_0_0.Season1_5MainView = {
	destroy = 0,
	container = "Season1_5MainViewContainer",
	mainRes = "ui/viewres/v1a5_season/seasonmainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		role5 = "scenes/v1a5_m_s15_sj_zhex/perfab/m_s15_1_5_kanjila_b.prefab",
		section4 = "scenes/v1a5_m_s15_sj_zhex/scene_prefab/m_s15_sj_1_5_section04.prefab",
		scene = "scenes/v1a5_m_s15_sj_zhex/scene_prefab/m_s15_sj_1_5_background_a.prefab",
		section1 = "scenes/v1a5_m_s15_sj_zhex/scene_prefab/m_s15_sj_1_5_section01.prefab",
		section6 = "scenes/v1a5_m_s15_sj_zhex/scene_prefab/m_s15_sj_1_5_section06.prefab",
		role3 = "scenes/v1a5_m_s15_sj_zhex/perfab/m_s15_1_5_shasirong_a.prefab",
		role6 = "scenes/v1a5_m_s15_sj_zhex/perfab/m_s15_1_5_shasirong_b.prefab",
		section3 = "scenes/v1a5_m_s15_sj_zhex/scene_prefab/m_s15_sj_1_5_section03.prefab",
		role1 = "scenes/v1a5_m_s15_sj_zhex/perfab/m_s15_1_5_aizila_a.prefab",
		role4 = "scenes/v1a5_m_s15_sj_zhex/perfab/m_s15_1_5_aizila_b.prefab",
		section5 = "scenes/v1a5_m_s15_sj_zhex/scene_prefab/m_s15_sj_1_5_section05.prefab",
		section2 = "scenes/v1a5_m_s15_sj_zhex/scene_prefab/m_s15_sj_1_5_section02.prefab",
		role2 = "scenes/v1a5_m_s15_sj_zhex/perfab/m_s15_1_5_kanjila_a.prefab"
	}
}
var_0_0.Season1_5MarketView = {
	destroy = 0,
	container = "Season1_5MarketViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/v1a5_season/seasonmarketview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season1_5SpecialMarketView = {
	destroy = 0,
	container = "Season1_5SpecialMarketViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/v1a5_season/seasonspecialmarketview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season1_5RetailView = {
	destroy = 0,
	container = "Season1_5RetailViewContainer",
	mainRes = "ui/viewres/v1a5_season/seasonretailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season1_5RetailLevelInfoView = {
	destroy = 0,
	container = "Season1_5RetailLevelInfoViewContainer",
	mainRes = "ui/viewres/v1a5_season/seasonretaillevelinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season1_5TaskView = {
	destroy = 0,
	container = "Season1_5TaskViewContainer",
	mainRes = "ui/viewres/v1a5_season/seasontaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a5_season/seasontaskitem.prefab"
	}
}
var_0_0.Season1_5SettlementView = {
	destroy = 0,
	container = "Season1_5SettlementViewContainer",
	mainRes = "ui/viewres/v1a5_season/seasonsettlementview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		itemRes = "ui/viewres/v1a5_season/seasonsettlementherogroupitem.prefab"
	}
}
var_0_0.Season1_5CelebrityCardGetlView = {
	destroy = 0,
	container = "Season1_5CelebrityCardGetlViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a5_season/seasoncelebritycardgetlview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Season1_5EquipView = {
	bgBlur = 0,
	container = "Season1_5EquipViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a5_season/seasonequipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a5_season/seasonequipcarditem.prefab",
		[2] = "ui/viewres/v1a5_season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.Season1_5EquipHeroView = {
	bgBlur = 0,
	container = "Season1_5EquipHeroViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a5_season/seasonequipheroview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a5_season/seasonequipcarditem.prefab",
		[2] = "ui/viewres/v1a5_season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.Season1_5FightFailView = {
	destroy = 0,
	container = "Season1_5FightFailViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a5_season/seasonfightfailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Season1_5FightSuccView = {
	destroy = 0,
	container = "Season1_5FightSuccViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a5_season/seasonfightsuccview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Season1_5StoreView = {
	destroy = 0,
	container = "Season1_5StoreViewContainer",
	mainRes = "ui/viewres/v1a5_season/seasonstoreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		itemPath = "ui/viewres/v1a5_season/seasonstoreitem.prefab"
	}
}
var_0_0.Season1_5EquipSelfChoiceView = {
	destroy = 0,
	container = "Season1_5EquipSelfChoiceViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a5_season/seasonmulticardchoiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/v1a5_season/seasonmulticardchoiceitem.prefab",
		[2] = "ui/viewres/v1a5_season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.Season1_5CelebrityCardTipView = {
	container = "Season1_5CelebrityCardTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a5_season/seasoncelebritycardtipview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	otherRes = {
		[1] = "ui/viewres/v1a5_season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.Season1_5EquipComposeView = {
	bgBlur = 0,
	container = "Season1_5EquipComposeViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a5_season/seasonequipcomposeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a5_season/seasonequipcomposeitem.prefab",
		[2] = "ui/viewres/v1a5_season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.Season1_5EquipBookView = {
	bgBlur = 0,
	container = "Season1_5EquipBookViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a5_season/seasonequipbookview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a5_season/seasonequipbookitem.prefab",
		[2] = "ui/viewres/v1a5_season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.Season1_5FightRuleTipView = {
	destroy = 0,
	container = "Season1_5FightRuleTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v1a5_season/seasonfightruletipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				"ui/viewres/v1a5_season/seasonfightruleview.prefab"
			},
			{
				"ui/viewres/v1a5_season/seasonfightcardview.prefab"
			}
		}
	}
}
var_0_0.Season1_5HeroGroupFightView = {
	bgBlur = 4,
	container = "Season1_5HeroGroupFightViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a5_season/seasonherogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
var_0_0.Season1_5AdditionRuleTipView = {
	destroy = 0,
	container = "Season1_5AdditionRuleTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v1a5_season/seasonadditionruletipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Season1_5SumView = {
	destroy = 0,
	container = "Season1_5SumViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/v1a5_season/seasonsumview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.V1a5_Role_PanelSignView_Part1 = {
	destroy = 0,
	container = "V1a5_Role_PanelSignView_Part1_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a5_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a5_role_signitem.prefab"
	}
}
var_0_0.V1a5_Role_PanelSignView_Part2 = {
	destroy = 0,
	container = "V1a5_Role_PanelSignView_Part2_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a5_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a5_role_signitem.prefab"
	}
}
var_0_0.V1a5_Role_FullSignView_Part1 = {
	destroy = 0,
	container = "V1a5_Role_FullSignView_Part1_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v1a5_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a5_role_signitem.prefab"
	}
}
var_0_0.V1a5_Role_FullSignView_Part2 = {
	destroy = 0,
	container = "V1a5_Role_FullSignView_Part2_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v1a5_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a5_role_signitem.prefab"
	}
}
var_0_0.V1a5_DoubleFestival_PanelSignView = {
	destroy = 0,
	container = "V1a5_DoubleFestival_PanelSignViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a5_doublefestival_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a5_doublefestival_signitem.prefab"
	}
}
var_0_0.V1a5_DoubleFestival_FullSignView = {
	destroy = 0,
	container = "V1a5_DoubleFestival_FullSignViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v1a5_doublefestival_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a5_doublefestival_signitem.prefab"
	}
}
var_0_0.V1a5_DoubleFestival_WishPanel = {
	destroy = 0,
	container = "V1a5_DoubleFestival_WishPanelContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a5_doublefestival_wishpanel.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.DialogueView = {
	bgBlur = 1,
	container = "DialogueViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/dialogue/dialogueview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
var_0_0.VersionActivity2_0DialogueView = tabletool.copy(var_0_0.DialogueView)
var_0_0.VersionActivity2_0DialogueView.mainRes = "ui/viewres/versionactivity_2_0/v2a0_dialogueview.prefab"
var_0_0.TipDialogView = {
	destroy = 0,
	container = "TipDialogViewContainer",
	mainRes = "ui/viewres/tipdialog/tipdialogview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.RoleStoryTipView = {
	destroy = 0,
	container = "RoleStoryTipViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/dungeon/rolestory/rolestorytipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.RoleStoryRewardView = {
	bgBlur = 0,
	container = "RoleStoryRewardViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/dungeon/rolestory/rolestoryprogressview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		itemRes = "ui/viewres/dungeon/rolestory/rolestoryprogressitem.prefab"
	}
}
var_0_0.RoleStoryFightSuccView = {
	destroy = 0,
	container = "RoleStoryFightSuccViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/dungeon/rolestory/rolestoryfightsuccview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.VersionActivity1_6EnterView = {
	destroy = 0,
	container = "VersionActivity1_6EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/versionactivity_1_6_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_1_6/va_1_6_dungeonenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_6/v1a6_v1a1reprint/v1a6_v1a1reprint_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_6/v1a6_quniang/v1a6_quniang_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_6/v1a6_getian/v1a6_getian_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_6/v1a6_season/v1a6_season_enterview.prefab"
			},
			{
				"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_6/v1a6_explore/v1a6_explore_enterview.prefab"
			}
		}
	}
}
var_0_0.VersionActivity1_6EnterVideoView = {
	destroy = 0,
	container = "VersionActivity1_6EnterVideoViewContainer",
	mainRes = "ui/viewres/battlepass/bpvideoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.VersionActivity1_6DungeonMapView = {
	container = "VersionActivity1_6DungeonMapViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_6/dungeon/versionactivity_1_6_dungeonmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/versionactivity_1_6/dungeon/versionactivity_1_6_mapepisodeitem.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	preloader = module_views_preloader
}
var_0_0.VersionActivity1_6DungeonMapLevelView = {
	destroy = 0,
	container = "VersionActivity1_6DungeonMapLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/dungeon/versionactivity_1_6_dungeonmaplevelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		},
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity1_6DungeonBossView = {
	bgBlur = 0,
	container = "VersionActivity1_6DungeonBossViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_activityboss/v1a6_activityboss_main.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity1_6_BossScheduleView = {
	destroy = 0,
	container = "VersionActivity1_6_BossScheduleViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_activityboss/v1a6_activityboss_scheduleview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_6/v1a6_activityboss/v1a6_activityboss_scheduleitem.prefab"
	}
}
var_0_0.VersionActivity1_6BossInfoView = {
	destroy = 0,
	container = "VersionActivity1_6BossInfoViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/baseenemyinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity1_6BossFightSuccView = {
	destroy = 0,
	container = "VersionActivity1_6BossFightSuccViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_activityboss/v1a6_activityboss_successview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.VersionActivity1_6StoreView = {
	destroy = 0,
	container = "VersionActivity1_6StoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_6/versionactivity_1_6_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity1_6NormalStoreGoodsView = {
	bgBlur = 1,
	container = "VersionActivity1_6NormalStoreGoodsViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/store/normalstoregoodsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity1_6TaskView = {
	destroy = 0,
	container = "VersionActivity1_6TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/versionactivity_1_6_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_1_6/versionactivity_1_6_taskitem.prefab"
	}
}
var_0_0.VersionActivity1_6SkillView = {
	destroy = 0,
	container = "VersionActivity1_6SkillViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_talent/v1a6_talent_lvupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity1_6SkillLvUpView = {
	destroy = 0,
	container = "VersionActivity1_6SkillLvUpViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_talent/v1a6_talent_wishview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.GoldenMilletPresentView = {
	destroy = 0,
	container = "GoldenMilletPresentViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_goldenmilletpresent.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.ActQuNiangLevelView = {
	destroy = 0,
	container = "ActQuNiangLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_quniang/v1a6_quniang_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_6/v1a6_quniang/v1a6_quniang_levelviewstageitem.prefab",
		[2] = "ui/viewres/versionactivity_1_6/v1a6_quniang/v1a6_quniang_levelviewstageitem2.prefab"
	}
}
var_0_0.ActQuNiangTaskView = {
	bgBlur = 0,
	container = "ActQuNiangTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_quniang/v1a6_quniang_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		ActQuNiangTaskItem.prefabPath
	}
}
var_0_0.ActGeTianLevelView = {
	destroy = 0,
	container = "ActGeTianLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_getian/v1a6_getian_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_6/v1a6_getian/v1a6_getian_levelviewstageitem.prefab",
		[2] = "ui/viewres/versionactivity_1_6/v1a6_getian/v1a6_getian_levelviewstageitem2.prefab"
	}
}
var_0_0.ActGeTianTaskView = {
	bgBlur = 0,
	container = "ActGeTianTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_getian/v1a6_getian_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		ActGeTianTaskItem.prefabPath
	}
}
var_0_0.V1a6_Role_PanelSignView_Part1 = {
	destroy = 0,
	container = "V1a6_Role_PanelSignView_Part1_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a6_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a6_role_signitem.prefab"
	}
}
var_0_0.V1a6_Role_PanelSignView_Part2 = {
	destroy = 0,
	container = "V1a6_Role_PanelSignView_Part2_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a6_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a6_role_signitem.prefab"
	}
}
var_0_0.NewYearEveGiftView = {
	destroy = 0,
	container = "NewYearEveGiftViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_eve/v1a6_eve_dialogueview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.NewYearEveActivityView = {
	destroy = 0,
	container = "NewYearEveActivityViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_eve/v1a6_eve_mainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.Season1_6MainView = {
	destroy = 0,
	container = "Season1_6MainViewContainer",
	mainRes = "ui/viewres/v1a6_season/seasonmainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		role5 = "scenes/v1a6_m_s15_sj_wcmt/perfab/v1a6_m_s15_quniang_a.prefab",
		section4 = "scenes/v1a6_m_s15_sj_wcmt/scene_prefab/v1a6_m_s15_section04.prefab",
		scene = "scenes/v1a6_m_s15_sj_wcmt/scene_prefab/v1a6_m_s15_background_a.prefab",
		section1 = "scenes/v1a6_m_s15_sj_wcmt/scene_prefab/v1a6_m_s15_section01.prefab",
		section6 = "scenes/v1a6_m_s15_sj_wcmt/scene_prefab/v1a6_m_s15_section06.prefab",
		role3 = "scenes/v1a6_m_s15_sj_wcmt/perfab/v1a6_m_s15_xiaoyenisai_a.prefab",
		role6 = "scenes/v1a6_m_s15_sj_wcmt/perfab/v1a6_m_s15_xiaoyenisai_b.prefab",
		section3 = "scenes/v1a6_m_s15_sj_wcmt/scene_prefab/v1a6_m_s15_section03.prefab",
		role1 = "scenes/v1a6_m_s15_sj_wcmt/perfab/v1a6_m_s15_getian_a.prefab",
		role4 = "scenes/v1a6_m_s15_sj_wcmt/perfab/v1a6_m_s15_getian_b.prefab",
		section5 = "scenes/v1a6_m_s15_sj_wcmt/scene_prefab/v1a6_m_s15_section05.prefab",
		section2 = "scenes/v1a6_m_s15_sj_wcmt/scene_prefab/v1a6_m_s15_section02.prefab",
		role2 = "scenes/v1a6_m_s15_sj_wcmt/perfab/v1a6_m_s15_quniang_b.prefab"
	}
}
var_0_0.Season1_6MarketView = {
	destroy = 0,
	container = "Season1_6MarketViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/v1a6_season/seasonmarketview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season1_6SpecialMarketView = {
	destroy = 0,
	container = "Season1_6SpecialMarketViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/v1a6_season/seasonspecialmarketview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season1_6RetailView = {
	destroy = 0,
	container = "Season1_6RetailViewContainer",
	mainRes = "ui/viewres/v1a6_season/seasonretailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season1_6RetailLevelInfoView = {
	destroy = 0,
	container = "Season1_6RetailLevelInfoViewContainer",
	mainRes = "ui/viewres/v1a6_season/seasonretaillevelinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season1_6TaskView = {
	destroy = 0,
	container = "Season1_6TaskViewContainer",
	mainRes = "ui/viewres/v1a6_season/seasontaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a6_season/seasontaskitem.prefab"
	}
}
var_0_0.Season1_6SettlementView = {
	destroy = 0,
	container = "Season1_6SettlementViewContainer",
	mainRes = "ui/viewres/v1a6_season/seasonsettlementview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		itemRes = "ui/viewres/v1a6_season/seasonsettlementherogroupitem.prefab"
	}
}
var_0_0.Season1_6CelebrityCardGetlView = {
	destroy = 0,
	container = "Season1_6CelebrityCardGetlViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a6_season/seasoncelebritycardgetlview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Season1_6EquipView = {
	bgBlur = 0,
	container = "Season1_6EquipViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a6_season/seasonequipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a6_season/seasonequipcarditem.prefab",
		[2] = "ui/viewres/v1a6_season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.Season1_6EquipHeroView = {
	bgBlur = 0,
	container = "Season1_6EquipHeroViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a6_season/seasonequipheroview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a6_season/seasonequipcarditem.prefab",
		[2] = "ui/viewres/v1a6_season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.Season1_6FightFailView = {
	destroy = 0,
	container = "Season1_6FightFailViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a6_season/seasonfightfailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Season1_6FightSuccView = {
	destroy = 0,
	container = "Season1_6FightSuccViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a6_season/seasonfightsuccview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Season1_6StoreView = {
	destroy = 0,
	container = "Season1_6StoreViewContainer",
	mainRes = "ui/viewres/v1a6_season/seasonstoreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		itemPath = "ui/viewres/v1a6_season/seasonstoreitem.prefab"
	}
}
var_0_0.Season1_6EquipSelfChoiceView = {
	destroy = 0,
	container = "Season1_6EquipSelfChoiceViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a6_season/seasonmulticardchoiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/v1a6_season/seasonmulticardchoiceitem.prefab",
		[2] = "ui/viewres/v1a6_season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.Season1_6CelebrityCardTipView = {
	container = "Season1_6CelebrityCardTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a6_season/seasoncelebritycardtipview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	otherRes = {
		[1] = "ui/viewres/v1a6_season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.Season1_6EquipComposeView = {
	bgBlur = 0,
	container = "Season1_6EquipComposeViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a6_season/seasonequipcomposeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a6_season/seasonequipcomposeitem.prefab",
		[2] = "ui/viewres/v1a6_season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.Season1_6EquipBookView = {
	bgBlur = 0,
	container = "Season1_6EquipBookViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a6_season/seasonequipbookview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a6_season/seasonequipbookitem.prefab",
		[2] = "ui/viewres/v1a6_season/seasoncelebritycarditem.prefab"
	}
}
var_0_0.Season1_6FightRuleTipView = {
	destroy = 0,
	container = "Season1_6FightRuleTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v1a6_season/seasonfightruletipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				"ui/viewres/v1a6_season/seasonfightruleview.prefab"
			},
			{
				"ui/viewres/v1a6_season/seasonfightcardview.prefab"
			}
		}
	}
}
var_0_0.Season1_6HeroGroupFightView = {
	bgBlur = 4,
	container = "Season1_6HeroGroupFightViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a6_season/seasonherogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
var_0_0.Season1_6AdditionRuleTipView = {
	destroy = 0,
	container = "Season1_6AdditionRuleTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v1a6_season/seasonadditionruletipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Season1_6SumView = {
	destroy = 0,
	container = "Season1_6SumViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/v1a6_season/seasonsumview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.V1a6_Spring_PanelSignView = {
	destroy = 0,
	container = "V1a6_Spring_PanelSignViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a6_spring_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a6_spring_signitem.prefab"
	}
}
var_0_0.FurnaceTreasureView = {
	destroy = 0,
	container = "FurnaceTreasureViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_secretstore/v1a6_secretstore_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.FurnaceTreasureBuyView = {
	destroy = 0,
	container = "FurnaceTreasureBuyViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_secretstore/v1a6_secretstore_buyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.ReactivityStoreView = {
	destroy = 0,
	container = "ReactivityStoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_8/v1a8_dungeon/v1a8_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.ReactivityRuleView = {
	destroy = 0,
	container = "ReactivityRuleViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/reprint_ruleview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.ReactivityTaskView = {
	bgBlur = 3,
	container = "ReactivityTaskViewContainer",
	mainRes = "ui/viewres/versionactivity_1_8/v1a8_dungeon/v1a8_taskview.prefab",
	destroy = 0,
	blurFactor = 0.64,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_1_8/v1a8_dungeon/v1a8_taskitem.prefab"
	}
}
var_0_0.LimitedRoleView = {
	destroy = 0,
	container = "LimitedRoleViewContainer",
	mainRes = "ui/viewres/main/limitedroleview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.VersionActivity1_6WarmUpView = {
	destroy = 0,
	container = "VersionActivity1_6WarmUpViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_warmup/v1a6_warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.VersionActivity1_7WarmUpView = {
	destroy = 0,
	container = "VersionActivity1_7WarmUpViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_1_7/v1a7_warmup/v1a7_warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		mapRes = "ui/viewres/versionactivity_1_7/v1a7_warmup/v1a7_warmupmap.prefab"
	}
}
var_0_0.VersionActivity1_7EnterView = {
	destroy = 0,
	container = "VersionActivity1_7EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_1_7/v1a7_enter/v1a7_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_1_7/v1a7_enter/v1a7_enterview_dungeon.prefab"
			},
			{
				"ui/viewres/versionactivity_1_7/v1a7_isolde/v1a7_isolde_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_7/v1a7_marcus/v1a7_marcus_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_7/v1a7_v1a2reprint/v1a7_v1a2reprint_enterview.prefab"
			},
			{
				"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_7/v1a7_season/v1a7_season_enterview.prefab"
			}
		}
	}
}
var_0_0.VersionActivity1_7StoreView = {
	destroy = 0,
	container = "VersionActivity1_7StoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_7/v1a7_dungeon/v1a7_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity1_7TaskView = {
	destroy = 0,
	container = "VersionActivity1_7TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_1_7/v1a7_dungeon/v1a7_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_1_7/v1a7_dungeon/v1a7_taskitem.prefab"
	}
}
var_0_0.ActIsoldeLevelView = {
	destroy = 0,
	container = "ActIsoldeLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_1_7/v1a7_isolde/v1a7_isolde_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_7/v1a7_isolde/v1a7_isolde_levelviewstageitem.prefab",
		[2] = "ui/viewres/versionactivity_1_7/v1a7_isolde/v1a7_isolde_levelviewstageitem2.prefab"
	}
}
var_0_0.ActIsoldeTaskView = {
	bgBlur = 0,
	container = "ActIsoldeTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_7/v1a7_isolde/v1a7_isolde_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_7/v1a7_isolde/v1a7_isolde_taskitem.prefab"
	}
}
var_0_0.ActMarcusLevelView = {
	destroy = 0,
	container = "ActMarcusLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_1_7/v1a7_marcus/v1a7_marcus_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_7/v1a7_marcus/v1a7_marcus_levelviewstageitem.prefab",
		[2] = "ui/viewres/versionactivity_1_7/v1a7_marcus/v1a7_marcus_levelviewstageitem2.prefab"
	}
}
var_0_0.ActMarcusTaskView = {
	bgBlur = 0,
	container = "ActMarcusTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_7/v1a7_marcus/v1a7_marcus_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_7/v1a7_marcus/v1a7_marcus_taskitem.prefab"
	}
}
var_0_0.V1a7_Role_FullSignView_Part1 = {
	destroy = 0,
	container = "V1a7_Role_FullSignView_Part1_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v1a7_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a7_role_signitem.prefab"
	}
}
var_0_0.V1a7_Role_FullSignView_Part2 = {
	destroy = 0,
	container = "V1a7_Role_FullSignView_Part2_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v1a7_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a7_role_signitem.prefab"
	}
}
var_0_0.V1a7_Role_PanelSignView_Part1 = {
	destroy = 0,
	container = "V1a7_Role_PanelSignView_Part1_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a7_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a7_role_signitem.prefab"
	}
}
var_0_0.V1a7_Role_PanelSignView_Part2 = {
	destroy = 0,
	container = "V1a7_Role_PanelSignView_Part2_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a7_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a7_role_signitem.prefab"
	}
}
var_0_0.V1a7_DoubleDropView = {
	destroy = 0,
	container = "V1a7_DoubleDropViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v1a7_doubledrop.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.FullScreenVideoView = {
	destroy = 0,
	container = "FullScreenVideoViewContainer",
	mainRes = "ui/viewres/battlepass/bpvideoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.LanternFestivalQuestionTipView = {
	destroy = 0,
	container = "LanternFestivalQuestionTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_7/v1a7_lamp/v1a7_lamp_questionpanelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
var_0_0.LanternFestivalActivityView = {
	destroy = 0,
	container = "LanternFestivalActivityViewContainer",
	mainRes = "ui/viewres/versionactivity_1_7/v1a7_lamp/v1a7_lamp_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		"ui/viewres/versionactivity_1_7/v1a7_lamp/v1a7_lamp_item.prefab"
	}
}
var_0_0.LanternFestivalView = {
	bgBlur = 1,
	container = "LanternFestivalViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_7/v1a7_lamp/v1a7_lamp_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_1_7/v1a7_lamp/v1a7_lamp_item.prefab"
	}
}
var_0_0.VersionActivity1_8EnterView = {
	destroy = 0,
	container = "VersionActivity1_8EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_1_8/v1a8_enter/v1a8_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_1_8/v1a8_enter/v1a8_dungeonenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_3/map/v1a8_v1a3reprint_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_8/v1a8_weila/v1a8_weila_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_enterview.prefab"
			},
			{
				"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_8/v1a8_windsong/v1a8_windsong_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_8/v1a8_season/v1a8_season_enterview.prefab"
			}
		}
	}
}
var_0_0.VersionActivity1_8DungeonMapView = {
	destroy = 0,
	container = "VersionActivity1_8DungeonMapViewContainer",
	mainRes = "ui/viewres/versionactivity_1_8/v1a8_dungeon/v1a8_dungeonmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/versionactivity_1_8/v1a8_dungeon/v1a8_mapepisodeitem.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
		"ui/viewres/versionactivity_1_8/v1a8_dungeon/v1a8_dungeonmap_direction.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity1_8DungeonMapLevelView = {
	destroy = 0,
	container = "VersionActivity1_8DungeonMapLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_1_8/v1a8_dungeon/v1a8_dungeonmaplevelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		},
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity1_8StoreView = {
	destroy = 0,
	container = "VersionActivity1_8StoreViewContainer",
	mainRes = "ui/viewres/versionactivity_1_8/v1a8_dungeon/v1a8_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity1_8TaskView = {
	destroy = 0,
	container = "VersionActivity1_8TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_1_8/v1a8_dungeon/v1a8_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_1_8/v1a8_dungeon/v1a8_taskitem.prefab"
	}
}
var_0_0.VersionActivity1_8DispatchView = {
	destroy = 0,
	container = "VersionActivity1_8DispatchViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_8/v1a8_dungeon/v1a8_dispatchview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.VersionActivity1_8FactoryMapView = {
	destroy = 0,
	container = "VersionActivity1_8FactoryMapViewContainer",
	mainRes = "ui/viewres/versionactivity_1_8/v1a8_dungeon/v1a8_factorymapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_8/v1a8_dungeon/mapline/v1a8_mapline.prefab"
	}
}
var_0_0.VersionActivity1_8FactoryBlueprintView = {
	destroy = 0,
	container = "VersionActivity1_8FactoryBlueprintViewContainer",
	mainRes = "ui/viewres/versionactivity_1_8/v1a8_dungeon/v1a8_factoryblueprintview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity1_8FactoryRepairView = {
	bgBlur = 1,
	container = "VersionActivity1_8FactoryRepairViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_8/v1a8_dungeon/v1a8_factoryrepairview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_8/v1a8_dungeon/v1a8_factoryrepairitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity1_8FactoryCompositeView = {
	destroy = 0,
	container = "VersionActivity1_8FactoryCompositeViewContainer",
	mainRes = "ui/viewres/versionactivity_1_8/v1a8_dungeon/v1a8_factorycompositeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.V1a8_Role_FullSignView_Part1 = {
	destroy = 0,
	container = "V1a8_Role_FullSignView_Part1_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v1a8_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a8_role_signitem.prefab"
	}
}
var_0_0.V1a8_Role_FullSignView_Part2 = {
	destroy = 0,
	container = "V1a8_Role_FullSignView_Part2_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v1a8_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a8_role_signitem.prefab"
	}
}
var_0_0.V1a8_Role_PanelSignView_Part1 = {
	destroy = 0,
	container = "V1a8_Role_PanelSignView_Part1_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a8_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a8_role_signitem.prefab"
	}
}
var_0_0.V1a8_Role_PanelSignView_Part2 = {
	destroy = 0,
	container = "V1a8_Role_PanelSignView_Part2_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a8_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a8_role_signitem.prefab"
	}
}
var_0_0.ActWeilaLevelView = {
	destroy = 0,
	container = "ActWeilaLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_1_8/v1a8_weila/v1a8_weila_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_8/v1a8_weila/v1a8_weila_levelviewstageitem.prefab",
		[2] = "ui/viewres/versionactivity_1_8/v1a8_weila/v1a8_weila_levelviewstageitem2.prefab"
	}
}
var_0_0.ActWeilaTaskView = {
	bgBlur = 0,
	container = "ActWeilaTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_8/v1a8_weila/v1a8_weila_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_8/v1a8_weila/v1a8_weila_taskitem.prefab"
	}
}
var_0_0.ActWindSongLevelView = {
	destroy = 0,
	container = "ActWindSongLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_1_8/v1a8_windsong/v1a8_windsong_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_8/v1a8_windsong/v1a8_windsong_levelviewstageitem.prefab",
		[2] = "ui/viewres/versionactivity_1_8/v1a8_windsong/v1a8_windsong_levelviewstageitem2.prefab"
	}
}
var_0_0.ActWindSongTaskView = {
	bgBlur = 0,
	container = "ActWindSongTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_8/v1a8_windsong/v1a8_windsong_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_8/v1a8_windsong/v1a8_windsong_taskitem.prefab"
	}
}
var_0_0.VersionActivity1_8WarmUpView = {
	destroy = 0,
	container = "VersionActivity1_8WarmUpViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_1_8/v1a8_warmup/v1a8_warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.V1a8_Work_FullSignView = {
	destroy = 0,
	container = "V1a8_Work_FullSignViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v1a8_work_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a8_work_signitem.prefab"
	}
}
var_0_0.V1a8_Work_PanelSignView = {
	destroy = 0,
	container = "V1a8_Work_PanelSignViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a8_work_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a8_work_signitem.prefab"
	}
}
var_0_0.Season123_2_3EntryView = {
	destroy = 0,
	container = "Season123_2_3EntryViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123mainview.prefab",
	layer = "POPUP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season123_2_3EntryOverview = {
	destroy = 0,
	container = "Season123_2_3EntryOverviewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123entryoverview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season123_2_3RetailView = {
	destroy = 0,
	container = "Season123_2_3RetailViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123retaillevelinfoview.prefab",
	layer = "POPUP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.Season123_2_3HeroGroupFightView = {
	bgBlur = 4,
	container = "Season123_2_3HeroGroupFightViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123herogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
var_0_0.Season123_2_3EpisodeListView = {
	destroy = 0,
	container = "Season123_2_3EpisodeListViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123episodelistview.prefab",
	layer = "POPUP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season123_2_3EpisodeLoadingView = {
	destroy = 0,
	container = "Season123_2_3EpisodeLoadingViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123episodeloadingview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
var_0_0.Season123_2_3EpisodeDetailView = {
	destroy = 0,
	container = "Season123_2_3EpisodeDetailViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123marketview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season123_2_3PickAssistView = {
	destroy = 0,
	container = "Season123_2_3PickAssistViewContainer",
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123pickassistview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/v2a3_act123/season123pickassistitem.prefab"
	}
}
var_0_0.Season123_2_3HeroGroupEditView = {
	container = "Season123_2_3HeroGroupEditViewContainer",
	destroy = 5,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123herogroupeditview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/v2a3_act123/season123herogroupedititem.prefab",
		[2] = "ui/viewres/seasonver/v2a3_act123/season123herogroupquickedititem.prefab"
	},
	customAnimBg = {
		"bg"
	}
}
var_0_0.Season123_2_3PickHeroEntryView = {
	destroy = 0,
	container = "Season123_2_3PickHeroEntryViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123pickheroentryview.prefab",
	layer = "POPUP",
	viewType = ViewType.Normal,
	otherRes = {
		[1] = "ui/viewres/seasonver/v2a3_act123/season123celebritycarditem.prefab"
	}
}
var_0_0.Season123_2_3PickHeroView = {
	destroy = 0,
	container = "Season123_2_3PickHeroViewContainer",
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123pickheroview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/v2a3_act123/season123pickheroitem.prefab"
	}
}
var_0_0.Season123_2_3StageLoadingView = {
	destroy = 0,
	container = "Season123_2_3StageLoadingViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123loadingview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.Season123_2_3StageFinishView = {
	destroy = 0,
	container = "Season123_2_3StageFinishViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123stagefinishview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.Season123_2_3ShowHeroView = {
	destroy = 0,
	container = "Season123_2_3ShowHeroViewContainer",
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123showheroview.prefab",
	layer = "POPUP",
	viewType = ViewType.Normal,
	otherRes = {
		[1] = "ui/viewres/seasonver/v2a3_act123/season123celebritycarditem.prefab"
	}
}
var_0_0.Season123_2_3EquipHeroView = {
	bgBlur = 0,
	container = "Season123_2_3EquipHeroViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123equipheroview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/v2a3_act123/season123equipcarditem.prefab",
		[2] = "ui/viewres/seasonver/v2a3_act123/season123celebritycarditem.prefab"
	}
}
var_0_0.Season123_2_3EquipView = {
	bgBlur = 0,
	container = "Season123_2_3EquipViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123equipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/v2a3_act123/season123equipcarditem.prefab",
		[2] = "ui/viewres/seasonver/v2a3_act123/season123celebritycarditem.prefab"
	}
}
var_0_0.Season123_2_3EnemyView = {
	bgBlur = 1,
	container = "Season123_2_3EnemyViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123enemyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	customAnimBg = {
		"#simage_bg",
		"#simage_rightbg"
	}
}
var_0_0.Season123_2_3StoreView = {
	destroy = 0,
	container = "Season123_2_3StoreViewContainer",
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/v2a3_act123/season123storeitem.prefab"
	}
}
var_0_0.Season123_2_3TaskView = {
	destroy = 0,
	container = "Season123_2_3TaskViewContainer",
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/v2a3_act123/season123taskitem.prefab"
	}
}
var_0_0.Season123_2_3EquipBookView = {
	bgBlur = 0,
	container = "Season123_2_3EquipBookViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123equipbookview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/v2a3_act123/season123equipbookitem.prefab",
		[2] = "ui/viewres/seasonver/v2a3_act123/season123celebritycarditem.prefab"
	}
}
var_0_0.Season123_2_3BatchDecomposeView = {
	bgBlur = 0,
	container = "Season123_2_3BatchDecomposeViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123batchdecomposeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/v2a3_act123/season123decomposeitem.prefab",
		[2] = "ui/viewres/seasonver/v2a3_act123/season123celebritycarditem.prefab"
	}
}
var_0_0.Season123_2_3DecomposeFilterView = {
	destroy = 10,
	container = "Season123_2_3DecomposeFilterViewContainer",
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123decomposefilterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.Season123_2_3DecomposeView = {
	container = "Season123_2_3DecomposeViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123decomposeview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/seasonver/v2a3_act123/season123celebritycarditem.prefab"
	}
}
var_0_0.Season123_2_3CelebrityCardTipView = {
	container = "Season123_2_3CelebrityCardTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123celebritycardtipview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	otherRes = {
		[1] = "ui/viewres/seasonver/v2a3_act123/season123celebritycarditem.prefab"
	}
}
var_0_0.Season123_2_3CelebrityCardGetView = {
	destroy = 0,
	container = "Season123_2_3CelebrityCardGetViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123celebritycardgetview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Season123_2_3CardPackageView = {
	bgBlur = 1,
	container = "Season123_2_3CardPackageViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123cardpackageview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/v2a3_act123/season123cardpackageitem.prefab",
		[2] = "ui/viewres/seasonver/v2a3_act123/season123celebritycarditem.prefab"
	}
}
var_0_0.Season123_2_3StoryView = {
	destroy = 0,
	container = "Season123_2_3StoryViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123storyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season123_2_3StoryPagePopView = {
	destroy = 0,
	container = "Season123_2_3StoryPagePopViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123storypagepopview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Season123_2_3RecordWindow = {
	destroy = 0,
	container = "Season123_2_3RecordWindowContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123recordwindow.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Season123_2_3FightSuccView = {
	destroy = 0,
	container = "Season123_2_3FightSuccViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123fightsuccview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Season123_2_3FightFailView = {
	destroy = 0,
	container = "Season123_2_3FightFailViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123fightfailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Season123_2_3SettlementView = {
	destroy = 0,
	container = "Season123_2_3SettlementViewContainer",
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123settlementview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		itemRes = "ui/viewres/seasonver/v2a3_act123/season123settlementherogroupitem.prefab"
	}
}
var_0_0.Season123_2_3AdditionRuleTipView = {
	destroy = 0,
	container = "Season123_2_3AdditionRuleTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123additionruletipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Season123_2_3FightRuleTipView = {
	destroy = 0,
	container = "Season123_2_3FightRuleTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123fightruletipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				"ui/viewres/seasonver/v2a3_act123/season123fightruleview.prefab"
			},
			{
				"ui/viewres/seasonver/v2a3_act123/season123fightcardview.prefab"
			}
		}
	}
}
var_0_0.Season123_2_3ResetView = {
	destroy = 0,
	container = "Season123_2_3ResetViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123resetview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.FightWaveChangeView = {
	destroy = 0,
	container = "FightWaveChangeViewContainer",
	mainRes = "ui/viewres/fight/fightwavechangeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.GMFightEntityView = {
	destroy = 0,
	container = "GMFightEntityViewContainer",
	mainRes = "ui/viewres/gm/gmfightentityview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.OptionalChargeView = {
	destroy = 0,
	container = "OptionalChargeViewContainer",
	mainRes = "ui/viewres/store/optionalgiftview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
var_0_0.PickAssistView = {
	destroy = 0,
	container = "PickAssistViewContainer",
	mainRes = "ui/viewres/pickassist/pickassistview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/pickassist/pickassistitem.prefab"
	}
}
var_0_0.BGMSwitchView = {
	bgBlur = 0,
	container = "BGMSwitchViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/bgmswitch/bgmswitchview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/animations/dynamic/maincamera.controller"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.BGMSwitchMusicFilterView = {
	destroy = 0,
	container = "BGMSwitchMusicFilterViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/bgmswitch/bgmswitchfilterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.RougeMapView = {
	bgBlur = 0,
	container = "RougeMapViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/rouge/map/rougemapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		RougeEnum.ResPath.CommonCollectionItem,
		RougeEnum.ResPath.CommonHeroGroupItem,
		RougeEnum.ResPath.CommonLvItem,
		RougeEnum.ResPath.CoinView
	}
}
var_0_0.RougeMapChoiceView = {
	bgBlur = 0,
	container = "RougeMapChoiceViewContainer",
	destroy = 0.5,
	mainRes = "ui/viewres/rouge/map/rougechoiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/rouge/map/rougemapchoiceitem.prefab",
		RougeEnum.ResPath.CommonCollectionItem,
		RougeEnum.ResPath.CommonHeroGroupItem,
		RougeEnum.ResPath.CommonLvItem,
		RougeEnum.ResPath.CommonCollectionSlotItem,
		RougeEnum.ResPath.CoinView
	}
}
var_0_0.RougeMapPieceChoiceView = {
	bgBlur = 0,
	container = "RougeMapPieceChoiceViewContainer",
	destroy = 0.5,
	mainRes = "ui/viewres/rouge/map/rougechoiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/rouge/map/rougemapchoiceitem.prefab",
		"ui/viewres/rouge/map/rougemapchoiceoptionitem.prefab",
		RougeEnum.ResPath.CommonCollectionItem,
		RougeEnum.ResPath.CommonHeroGroupItem,
		RougeEnum.ResPath.CommonLvItem,
		RougeEnum.ResPath.CommonCollectionSlotItem,
		RougeEnum.ResPath.CoinView
	}
}
var_0_0.RougeCollectionDropView = {
	bgBlur = 0,
	container = "RougeCollectionDropViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/rouge/map/rougecollectionselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		RougeEnum.ResPath.CommonCollectionItem
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				RougeEnum.ResPath.CollectionDetailBtnItem
			}
		}
	}
}
var_0_0.RougeBossCollectionDropView = {
	bgBlur = 0,
	container = "RougeBossCollectionDropViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/rouge/dlc/103/rougebosscollectionselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		RougeEnum.ResPath.CommonCollectionItem
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				RougeEnum.ResPath.CollectionDetailBtnItem
			}
		}
	}
}
var_0_0.RougeStoreView = {
	destroy = 0,
	container = "RougeMapStoreViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/rouge/map/rougestoreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		RougeEnum.ResPath.CoinView,
		RougeEnum.ResPath.CommonCollectionItem
	}
}
var_0_0.RougeStoreGoodsView = {
	bgBlur = 1,
	container = "RougeStoreGoodsViewContainer",
	destroy = 10,
	mainRes = "ui/viewres/rouge/map/rougestoregoodsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		RougeEnum.ResPath.CoinView
	},
	tabRes = {
		{
			{
				RougeEnum.ResPath.CollectionDetailBtnItem
			}
		}
	}
}
var_0_0.RougeFinishView = {
	destroy = 0,
	container = "RougeFinishViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/rouge/map/rougefinishview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.RougeNextLayerView = {
	destroy = 0,
	container = "RougeNextLayerViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/rouge/map/rougenextlayerview.prefab",
	layer = "TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.RougeMapCollectionAbandonView = {
	bgBlur = 0,
	container = "RougeMapCollectionAbandonViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/rouge/map/rougecollectionabandonview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				RougeEnum.ResPath.CollectionDetailBtnItem
			}
		}
	},
	otherRes = {
		RougeEnum.ResPath.CommonCollectionItem,
		RougeMapEnum.CollectionLeftItemRes,
		RougeMapEnum.CollectionRightItemRes
	}
}
var_0_0.RougeMapCollectionExchangeView = {
	bgBlur = 0,
	container = "RougeMapCollectionExchangeViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/rouge/map/rougecollectionexchangeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				RougeEnum.ResPath.CollectionDetailBtnItem
			}
		}
	},
	otherRes = {
		RougeEnum.ResPath.CommonCollectionItem,
		RougeMapEnum.CollectionLeftItemRes,
		RougeMapEnum.CollectionRightItemRes
	}
}
var_0_0.RougeMapCollectionStorageView = {
	bgBlur = 0,
	container = "RougeMapCollectionStorageViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/rouge/map/rougecollectionstoageview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				RougeEnum.ResPath.CollectionDetailBtnItem
			}
		}
	},
	otherRes = {
		RougeEnum.ResPath.CommonCollectionItem,
		RougeMapEnum.CollectionLeftItemRes,
		RougeMapEnum.CollectionRightItemRes
	}
}
var_0_0.RougeMapTipView = {
	destroy = 0,
	container = "RougeMapTipViewContainer",
	mainRes = "ui/viewres/rouge/map/rougemaptipview.prefab",
	layer = "TOP",
	viewType = ViewType.Normal
}
var_0_0.RougeLevelUpView = {
	destroy = 0,
	container = "RougeLevelUpViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/rouge/map/rougelevelupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.RougeFightSuccessView = {
	destroy = 0,
	container = "RougeFightSuccessViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/rouge/fight/rougefightsuccview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.RougeFavoriteView = {
	destroy = 0,
	container = "RougeFavoriteViewContainer",
	mainRes = "ui/viewres/rouge/rougefavoriteview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.RougeResultReportView = {
	destroy = 0,
	container = "RougeResultReportViewContainer",
	mainRes = "ui/viewres/rouge/rougeresultreportview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		[1] = "ui/viewres/rouge/rougeresultreportitem.prefab",
		[2] = "ui/viewres/rouge/rougeresultheroitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.RougeFavoriteCollectionView = {
	destroy = 0,
	container = "RougeFavoriteCollectionViewContainer",
	mainRes = "ui/viewres/rouge/rougefavoritecollectionview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		[1] = "ui/viewres/rouge/rougecollectionlistitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/rouge/rougecollectionlistview.prefab"
			},
			{
				"ui/viewres/rouge/rougecollectionhandbookview.prefab"
			}
		},
		{
			{
				RougeEnum.ResPath.CollectionDetailBtnItem
			}
		}
	}
}
var_0_0.RougeReviewView = {
	destroy = 0,
	container = "RougeReviewViewContainer",
	mainRes = "ui/viewres/rouge/rougereviewview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/rouge/rougereviewitem.prefab"
	}
}
var_0_0.RougeIllustrationListView = {
	destroy = 0,
	container = "RougeIllustrationListViewContainer",
	mainRes = "ui/viewres/rouge/rougeillustrationlistview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/rouge/rougeillustrationlistpage.prefab",
		[2] = "ui/viewres/rouge/rougeillustrationlistitem.prefab"
	}
}
var_0_0.RougeIllustrationDetailView = {
	destroy = 0,
	container = "RougeIllustrationDetailViewContainer",
	mainRes = "ui/viewres/rouge/rougeillustrationdetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.RougeFactionIllustrationView = {
	destroy = 0,
	container = "RougeFactionIllustrationViewContainer",
	mainRes = "ui/viewres/rouge/rougefactionillustrationview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/rouge/rougefactionillustrationitem.prefab"
	}
}
var_0_0.RougeFactionIllustrationDetailView = {
	destroy = 0,
	container = "RougeFactionIllustrationDetailViewContainer",
	mainRes = "ui/viewres/rouge/rougefactionillustrationdetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/rouge/rougefactionillustrationdetailitem.prefab"
	}
}
var_0_0.RougeTalentView = {
	destroy = 0,
	container = "RougeTalentViewContainer",
	mainRes = "ui/viewres/rouge/rougetalentview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.RougeInitTeamView = {
	destroy = 0,
	container = "RougeInitTeamViewContainer",
	mainRes = "ui/viewres/rouge/rougeinitteamview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		[1] = "ui/viewres/rouge/rougeherogroupedititem.prefab",
		[2] = RougeEnum.ResPath.rougepageprogress
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.RougePickAssistView = {
	destroy = 0,
	container = "RougePickAssistViewContainer",
	mainRes = "ui/viewres/rouge/rougepickassistview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/rouge/rougepickassistitem.prefab"
	}
}
var_0_0.RougeTeamView = {
	destroy = 0,
	container = "RougeTeamViewContainer",
	mainRes = "ui/viewres/rouge/rougeteamview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/rouge/rougeherogroueffectitem.prefab"
	}
}
var_0_0.RougeHeroGroupFightView = {
	bgBlur = 4,
	container = "RougeHeroGroupFightViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/rouge/rougeherogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
var_0_0.RougeMainView = {
	destroy = 0,
	container = "RougeMainViewContainer",
	mainRes = "ui/viewres/rouge/rougemainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.RougeHeroGroupEditView = {
	container = "RougeHeroGroupEditViewContainer",
	destroy = 5,
	mainRes = "ui/viewres/rouge/rougeherogroupeditview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/rouge/rougeherogroupedititem.prefab",
		[2] = "ui/viewres/rouge/rougeherogroupquickedititem.prefab"
	},
	customAnimBg = {
		"bg"
	}
}
var_0_0.RougeDifficultyView = {
	destroy = 0,
	container = "RougeDifficultyViewContainer",
	mainRes = "ui/viewres/rouge/rougedifficultyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		RougeEnum.ResPath.rougedifficultyitem,
		RougeEnum.ResPath.rougepageprogress
	}
}
var_0_0.RougeCollectionGiftView = {
	destroy = 0,
	container = "RougeCollectionGiftViewContainer",
	mainRes = "ui/viewres/rouge/rougecollectiongiftview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		RougeEnum.ResPath.rougepageprogress
	}
}
var_0_0.RougeFactionView = {
	destroy = 0,
	container = "RougeFactionViewContainer",
	mainRes = "ui/viewres/rouge/rougefactionview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		RougeEnum.ResPath.rougefactionitem,
		RougeEnum.ResPath.rougepageprogress
	}
}
var_0_0.RougeRewardNoticeView = {
	destroy = 0,
	container = "RougeRewardNoticeViewContainer",
	mainRes = "ui/viewres/rouge/rougerewardnoticeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.RougeRewardView = {
	destroy = 0,
	container = "RougeRewardViewContainer",
	mainRes = "ui/viewres/rouge/rougerewardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.RougerewardThemeTipView = {
	destroy = 0,
	container = "RougerewardThemeTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/rouge/rougerewardthemetipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.RougeCollectionChessView = {
	destroy = 0,
	container = "RougeCollectionChessViewContainer",
	mainRes = "ui/viewres/rouge/rougecollectionchessview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		RougeEnum.ResPath.CollectionIconItem
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				RougeEnum.ResPath.CollectionDetailBtnItem
			}
		}
	}
}
var_0_0.RougeCollectionTipView = {
	destroy = 0,
	container = "RougeCollectionTipViewContainer",
	mainRes = "ui/viewres/rouge/rougecollectiontipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.RougeCollectionEnchantView = {
	destroy = 0,
	container = "RougeCollectionEnchantViewContainer",
	mainRes = "ui/viewres/rouge/rougecollectionenchantview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				RougeEnum.ResPath.CollectionDetailBtnItem
			}
		}
	}
}
var_0_0.RougeCollectionOverView = {
	destroy = 0,
	container = "RougeCollectionOverViewContainer",
	mainRes = "ui/viewres/rouge/rougecollectionoverview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		RougeEnum.ResPath.CollectionIconItem
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				RougeEnum.ResPath.CollectionDetailBtnItem
			}
		}
	}
}
var_0_0.RougeCollectionFilterView = {
	destroy = 0,
	container = "RougeCollectionFilterViewContainer",
	mainRes = "ui/viewres/rouge/rougecollectionfilterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
var_0_0.RougeCollectionCompositeView = {
	destroy = 0,
	container = "RougeCollectionCompositeViewContainer",
	mainRes = "ui/viewres/rouge/rougecollectioncompositeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		RougeEnum.ResPath.CollectionIconItem,
		RougeEnum.ResPath.CommonCollectionItem
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				RougeEnum.ResPath.CollectionDetailBtnItem
			}
		}
	}
}
var_0_0.RougeCollectionHandBookView = {
	destroy = 0,
	container = "RougeCollectionHandBookViewContainer",
	mainRes = "ui/viewres/rouge/rougecollectionhandbookview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.RougeCollectionInitialView = {
	destroy = 0,
	container = "RougeCollectionInitialViewContainer",
	mainRes = "ui/viewres/rouge/rougecollectioninitialview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				RougeEnum.ResPath.CollectionDetailBtnItem
			}
		}
	}
}
var_0_0.RougeEndingThreeView = {
	destroy = 0,
	container = "RougeEndingThreeViewContainer",
	mainRes = "ui/viewres/rouge/rougeendingthreeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal
}
var_0_0.RougeResultView = {
	destroy = 0,
	container = "RougeResultViewContainer",
	mainRes = "ui/viewres/rouge/rougeresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.RougeSettlementView = {
	destroy = 0,
	container = "RougeSettlementViewContainer",
	mainRes = "ui/viewres/rouge/rougesettlementview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.RougeResultReView = {
	destroy = 0,
	container = "RougeResultReViewContainer",
	mainRes = "ui/viewres/rouge/rougeresultreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/rouge/rougeresultheroitem.prefab"
	}
}
var_0_0.RougeTalentTreeTrunkView = {
	destroy = 0,
	container = "RougeTalentTreeTrunkViewContainer",
	mainRes = "ui/viewres/rouge/tree/rougetalenttreeview_trunk.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		branchitem = "ui/viewres/rouge/tree/rougetalenttreeitem.prefab"
	}
}
var_0_0.RougeTalentTreeView = {
	destroy = 0,
	container = "RougeTalentTreeViewContainer",
	mainRes = "ui/viewres/rouge/tree/rougetalenttreeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/rouge/tree/rougetalenttreeview_branch_1.prefab"
			},
			{
				"ui/viewres/rouge/tree/rougetalenttreeview_branch_2.prefab"
			},
			{
				"ui/viewres/rouge/tree/rougetalenttreeview_branch_3.prefab"
			},
			{
				"ui/viewres/rouge/tree/rougetalenttreeview_branch_4.prefab"
			},
			{
				"ui/viewres/rouge/tree/rougetalenttreeview_branch_5.prefab"
			},
			{
				"ui/viewres/rouge/tree/rougetalenttreeview_branch_6.prefab"
			},
			{
				"ui/viewres/rouge/tree/rougetalenttreeview_branch_7.prefab"
			},
			{
				"ui/viewres/rouge/tree/rougetalenttreeview_branch_8.prefab"
			}
		}
	},
	otherRes = {
		branchitem = "ui/viewres/rouge/tree/rougetalenttreeitem.prefab"
	}
}
var_0_0.RougeTalentTreeOverview = {
	destroy = 0,
	container = "RougeTalentTreeOverviewContainer",
	mainRes = "ui/viewres/rouge/tree/rougetalenttreeoverview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.RougeOpenGuideView = {
	destroy = 0,
	container = "RougeOpenGuideViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/rouge/guide/rougeguideview.prefab",
	blurFactor = 0.3,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.RougeDLCSelectView = {
	destroy = 0,
	container = "RougeDLCSelectViewContainer",
	mainRes = "ui/viewres/rouge/dlc/rougedlcselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.RougeDLCTipsView = {
	destroy = 0,
	container = "RougeDLCTipsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/rouge/dlc/rougedlctipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.DecalogPresentView = {
	destroy = 0,
	container = "DecalogPresentViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_versionsummon.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.V1a9DecalogPresentFullView = {
	destroy = 0,
	container = "V1a9DecalogPresentFullViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_versionsummonfull.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.RougeLimiterView = {
	destroy = 0,
	container = "RougeLimiterViewContainer",
	mainRes = "ui/viewres/rouge/dlc/101/rougelimiterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		LimiterGroupItem = "ui/viewres/rouge/dlc/101/rougelimiterdebuffitem.prefab",
		LimiterItem = "ui/viewres/rouge/dlc/101/rougelimiteritem.prefab"
	}
}
var_0_0.RougeLimiterLockedTipsView = {
	destroy = 0,
	container = "RougeLimiterLockedTipsViewContainer",
	mainRes = "ui/viewres/rouge/dlc/101/rougelimiterlockedtips.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.RougeLimiterBuffView = {
	destroy = 0,
	container = "RougeLimiterBuffViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/rouge/dlc/101/rougelimiterbuffview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	otherRes = {
		BuffItem = "ui/viewres/rouge/dlc/101/rougelimiterbuffitem.prefab",
		LimiterItem = "ui/viewres/rouge/dlc/101/rougelimiteritem.prefab"
	}
}
var_0_0.RougeLimiterOverView = {
	destroy = 0,
	container = "RougeLimiterOverViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/rouge/dlc/101/rougelimiteroverview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				"ui/viewres/rouge/dlc/101/rougelimiterdebuffoverview.prefab"
			},
			{
				"ui/viewres/rouge/dlc/101/rougelimiterbuffoverview.prefab"
			}
		}
	}
}
var_0_0.RougeLimiterResultView = {
	destroy = 0,
	container = "RougeLimiterResultViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/rouge/dlc/101/rougelimiterresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.RougeDangerousView = {
	destroy = 0,
	container = "RougeDangerousViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/rouge/dlc/101/rougedangerousview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal
}
var_0_0.RougeFactionLockedTips = {
	destroy = 0,
	container = "RougeFactionLockedTipsContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/rouge/rougefactionlockedtips.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.RougeCollectionLevelUpView = {
	bgBlur = 0,
	container = "RougeCollectionLevelUpViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/rouge/dlc/102/rougecollectionlevelupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				RougeEnum.ResPath.CollectionDetailBtnItem
			}
		}
	},
	otherRes = {
		RougeEnum.ResPath.CommonCollectionItem,
		RougeEnum.ResPath.CollectionLevelUpLeftItem,
		RougeEnum.ResPath.CollectionLevelUpRightItem
	}
}
var_0_0.FairyLandOptionView = {
	destroy = 0,
	container = "FairyLandOptionViewContainer",
	bgBlur = 2,
	mainRes = "ui/viewres/fairyland/fairylandoptionview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.FairyLandView = {
	destroy = 0,
	container = "FairyLandViewContainer",
	mainRes = "ui/viewres/fairyland/fairylandview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		scene = "scenes/v1a9_m_s14_hhdt/v1a9_m_s14_hddt_p.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.FairyLandCompleteView = {
	destroy = 0,
	container = "FairyLandCompleteViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/fairyland/fairylandcompleteview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.ToughBattleEnterView = {
	destroy = 0,
	container = "ToughBattleEnterViewContainer",
	mainRes = "ui/viewres/dungeon/toughbattle/toughbattle_mainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		word = "ui/viewres/dungeon/toughbattle/toughbattle_mainview_word.prefab"
	}
}
var_0_0.ToughBattleMapView = {
	destroy = 0,
	container = "ToughBattleMapViewContainer",
	mainRes = "ui/viewres/dungeon/toughbattle/toughbattlemapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		rolelist = "ui/viewres/dungeon/toughbattle/toughbattle_supportrolelistview.prefab"
	}
}
var_0_0.ToughBattleLoadingView = {
	bgBlur = 3,
	container = "ToughBattleLoadingViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/dungeon/toughbattle/toughbattleloadingview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.ToughBattleEnemyInfoView = {
	bgBlur = 1,
	container = "ToughBattleEnemyInfoViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/dungeon/toughbattle/toughbattle_enemyinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
var_0_0.ToughBattleSkillView = {
	bgBlur = 1,
	container = "ToughBattleSkillViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/dungeon/toughbattle/toughbattle_supportview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		rolelist = "ui/viewres/dungeon/toughbattle/toughbattle_supportrolelistview.prefab"
	}
}
var_0_0.ToughBattleActEnterView = var_0_0.ToughBattleEnterView
var_0_0.ToughBattleActMapView = var_0_0.ToughBattleMapView
var_0_0.ToughBattleActLoadingView = var_0_0.ToughBattleLoadingView
var_0_0.ToughBattleFightSuccView = {
	destroy = 0,
	container = "ToughBattleFightSuccViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/fight/fightsuccview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.InvestigateClueView = {
	destroy = 0,
	container = "InvestigateClueViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/dungeon/investigate/investigateclueview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.InvestigateView = {
	destroy = 0,
	container = "InvestigateViewContainer",
	mainRes = "ui/viewres/dungeon/investigate/investigateroleview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.InvestigateOpinionTabView = {
	destroy = 0,
	container = "InvestigateOpinionTabViewContainer",
	mainRes = "ui/viewres/dungeon/investigate/investigateopiniontabview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	otherRes = {
		"ui/viewres/dungeon/investigate/investigateopinionitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/dungeon/investigate/investigateopinionview.prefab"
			},
			{
				"ui/viewres/dungeon/investigate/investigateopinionextendview.prefab"
			}
		}
	}
}
var_0_0.InvestigateRoleStoryView = {
	destroy = 0,
	container = "InvestigateRoleStoryViewContainer",
	mainRes = "ui/viewres/dungeon/investigate/investigaterolestory.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
var_0_0.InvestigateTaskView = {
	destroy = 0,
	container = "InvestigateTaskViewContainer",
	mainRes = "ui/viewres/dungeon/investigate/investigatetaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/dungeon/investigate/investigatetaskitem.prefab"
	}
}
var_0_0.InvestigateTipsView = {
	destroy = 0,
	container = "InvestigateTipsViewContainer",
	mainRes = "ui/viewres/dungeon/investigate/investigatetipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal
}
var_0_0.BalanceUmbrellaClueView = {
	destroy = 0,
	container = "BalanceUmbrellaClueViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/dungeon/balanceumbrella/balanceumbrellaclueview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.BalanceUmbrellaView = {
	destroy = 0,
	container = "BalanceUmbrellaViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/dungeon/balanceumbrella/balanceumbrellaview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity1_9EnterView = {
	destroy = 0,
	container = "VersionActivity1_9EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_1_9/v1a9_enter/v1a9_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_1_9/v1a9_enter/v1a9_enterview_dungeon.prefab"
			},
			{
				"ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_enterview.prefab"
			},
			{
				"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_9/v1a9_season/v1a9_season_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_9/v1a9_lucy/v1a9_lucy_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_9/v1a9_kakania/v1a9_kakania_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_9/v1a9_rouge/v1a9_rouge_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_9/v1a9_explore/v1a9_explore_enterview.prefab"
			}
		}
	}
}
var_0_0.VersionActivity1_9StoreView = {
	destroy = 0,
	container = "VersionActivity1_9StoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_9/v1a9_dungeon/v1a9_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity1_9TaskView = {
	destroy = 0,
	container = "VersionActivity1_9TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_1_9/v1a9_enter/v1a9_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_1_9/v1a9_enter/v1a9_taskitem.prefab"
	}
}
var_0_0.RoomGiftView = {
	destroy = 0,
	container = "RoomGiftViewContainer",
	mainRes = "ui/viewres/activity/v1a9_roomgiftview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.V1a9DecalogPresentView = {
	destroy = 0,
	container = "V1a9DecalogPresentViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_9/v1a9_versionsummon.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.SemmelWeisGiftView = {
	destroy = 0,
	container = "SemmelWeisGiftViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_9/v1a9_semmelweisgiftview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.SemmelWeisGiftFullView = {
	destroy = 0,
	container = "SemmelWeisGiftFullViewContainer",
	mainRes = "ui/viewres/versionactivity_1_9/v1a9_semmelweisgiftfullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.V1a9_MatildagiftView = {
	destroy = 0,
	container = "V1a9_MatildagiftViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_9/v1a9_matildagiftview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.V1a9_ActivityShow_MatildagiftView = {
	destroy = 0,
	container = "V1a9_ActivityShow_MatildagiftViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_1_9/v1a9_matildagiftfullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.HeroInvitationView = {
	destroy = 0,
	container = "HeroInvitationViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/dungeon/heroinvitation/invitationview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		itemRes = "ui/viewres/dungeon/heroinvitation/invitationitem.prefab"
	}
}
var_0_0.HeroInvitationDungeonMapView = {
	destroy = 0,
	container = "HeroInvitationDungeonMapViewContainer",
	mainRes = "ui/viewres/dungeon/heroinvitation/dungeonmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	preloader = module_views_preloader
}
var_0_0.OptionPackageDownloadView = {
	destroy = 0,
	container = "OptionPackageDownloadViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/optionpackage/optionpackagedownloadview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.V1a9_Role_FullSignView_Part1 = {
	destroy = 0,
	container = "V1a9_Role_FullSignView_Part1_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v1a9_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a9_role_signitem.prefab"
	}
}
var_0_0.V1a9_Role_FullSignView_Part2 = {
	destroy = 0,
	container = "V1a9_Role_FullSignView_Part2_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v1a9_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a9_role_signitem.prefab"
	}
}
var_0_0.V1a9_Role_PanelSignView_Part1 = {
	destroy = 0,
	container = "V1a9_Role_PanelSignView_Part1_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a9_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a9_role_signitem.prefab"
	}
}
var_0_0.V1a9_Role_PanelSignView_Part2 = {
	destroy = 0,
	container = "V1a9_Role_PanelSignView_Part2_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a9_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a9_role_signitem.prefab"
	}
}
var_0_0.DragonBoatFestivalQuestionTipView = {
	destroy = 0,
	container = "DragonFestivalQuestionTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/dragonboat/dragonboat_questionpanelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
var_0_0.DragonBoatFestivalActivityView = {
	destroy = 0,
	container = "DragonBoatFestivalActivityViewContainer",
	mainRes = "ui/viewres/dragonboat/dragonboat_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		"ui/viewres/dragonboat/dragonboat_item.prefab"
	}
}
var_0_0.DragonBoatFestivalView = {
	bgBlur = 1,
	container = "DragonBoatFestivalViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/dragonboat/dragonboat_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/dragonboat/dragonboat_item.prefab"
	}
}
var_0_0.V1a9_AnniversarySign_PanelSignView = {
	destroy = 0,
	container = "V1a9_AnniversarySign_PanelSignViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a9_anniversarysign_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a9_anniversarysign_signitem.prefab"
	}
}
var_0_0.V1a9_AnniversarySign_FullSignView = {
	destroy = 0,
	container = "V1a9_AnniversarySign_FullSignViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v1a9_anniversarysign_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a9_anniversarysign_signitem.prefab"
	}
}
var_0_0.ActLucyLevelView = {
	destroy = 0,
	container = "ActLucyLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_1_9/v1a9_lucy/v1a9_lucy_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_9/v1a9_lucy/v1a9_lucy_levelviewstageitem.prefab",
		[2] = "ui/viewres/versionactivity_1_9/v1a9_lucy/v1a9_lucy_levelviewstageitem2.prefab"
	}
}
var_0_0.ActLucyTaskView = {
	bgBlur = 0,
	container = "ActLucyTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_9/v1a9_lucy/v1a9_lucy_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_9/v1a9_lucy/v1a9_lucy_taskitem.prefab"
	}
}
var_0_0.ActKaKaNiaLevelView = {
	destroy = 0,
	container = "ActKaKaNiaLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_1_9/v1a9_kakania/v1a9_kakania_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_9/v1a9_kakania/v1a9_kakania_levelviewstageitem.prefab",
		[2] = "ui/viewres/versionactivity_1_9/v1a9_kakania/v1a9_kakania_levelviewstageitem2.prefab"
	}
}
var_0_0.ActKaKaNiaTaskView = {
	bgBlur = 0,
	container = "ActKaKaNiaTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_9/v1a9_kakania/v1a9_kakania_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_9/v1a9_kakania/v1a9_kakania_taskitem.prefab"
	}
}
var_0_0.VersionActivity1_9WarmUpView = {
	destroy = 0,
	container = "VersionActivity1_9WarmUpViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_1_9/v1a9_warmup/v1a9_warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.Permanent1_1EnterView = {
	destroy = 0,
	container = "Permanent1_1EnterViewContainer",
	mainRes = "ui/viewres/dungeon/reappear/a1_reappear_mainactivity_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Permanent1_2EnterView = {
	destroy = 0,
	container = "Permanent1_2EnterViewContainer",
	mainRes = "ui/viewres/dungeon/reappear/a2_reappear_mainactivity_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Permanent1_3EnterView = {
	destroy = 0,
	container = "Permanent1_3EnterViewContainer",
	mainRes = "ui/viewres/dungeon/reappear/a3_reappear_mainactivity_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Permanent1_4EnterView = {
	destroy = 0,
	container = "Permanent1_4EnterViewContainer",
	mainRes = "ui/viewres/dungeon/reappear/a4_reappear_mainactivity_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Permanent1_5EnterView = {
	destroy = 0,
	container = "Permanent1_5EnterViewContainer",
	mainRes = "ui/viewres/dungeon/reappear/a5_reappear_mainactivity_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Permanent1_6EnterView = {
	destroy = 0,
	container = "Permanent1_6EnterViewContainer",
	mainRes = "ui/viewres/dungeon/reappear/a6_reappear_mainactivity_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Permanent1_7EnterView = {
	destroy = 0,
	container = "Permanent1_7EnterViewContainer",
	mainRes = "ui/viewres/dungeon/reappear/a7_reappear_mainactivity_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Permanent1_8EnterView = {
	destroy = 0,
	container = "Permanent1_8EnterViewContainer",
	mainRes = "ui/viewres/dungeon/reappear/a8_reappear_mainactivity_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.ActivityWelfareView = {
	destroy = 0,
	container = "ActivityWelfareViewContainer",
	mainRes = "ui/viewres/activity/activitybeginnerview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/newwelfare/newwelfarefullview.prefab"
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/activity/activitynormalcategoryitem.prefab"
	}
}
var_0_0.NewWelfareView = {
	destroy = 0,
	container = "NewWelfareViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/newwelfare/newwelfarefullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.NewWelfarePanel = {
	destroy = 0,
	container = "NewWelfarePanelContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/newwelfare/newwelfarepanelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.GMErrorView = {
	destroy = 0,
	container = "GMErrorViewContainer",
	mainRes = "ui/viewres/gm/gmerrorview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.VersionActivity2_0EnterView = {
	destroy = 0,
	container = "VersionActivity2_0EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_2_0/v2a0_enter/v2a0_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_2_0/v2a0_enter/v2a0_dungeonenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_0/v2a0_season/v2a0_season_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_0/v2a0_v1a5reprint_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_0/v2a0_mercuria/v2a0_mercuria_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_0/v2a0_joe/v2a0_joe_enterview.prefab"
			},
			{
				"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
			}
		}
	}
}
var_0_0.VersionActivity2_0StoreView = {
	destroy = 0,
	container = "VersionActivity2_0StoreViewContainer",
	mainRes = "ui/viewres/versionactivity_2_0/v2a0_dungeon/v2a0_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity2_0TaskView = {
	destroy = 0,
	container = "VersionActivity2_0TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_0/v2a0_dungeon/v2a0_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_0/v2a0_dungeon/v2a0_taskitem.prefab"
	}
}
var_0_0.VersionActivity2_0DungeonMapView = {
	destroy = 0,
	container = "VersionActivity2_0DungeonMapViewContainer",
	mainRes = "ui/viewres/versionactivity_2_0/v2a0_dungeon/v2a0_dungeonmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/versionactivity_2_0/v2a0_dungeon/v2a0_mapepisodeitem.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
		"ui/viewres/versionactivity_2_0/v2a0_dungeon/v2a0_dungeonmap_direction.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity2_0DungeonMapLevelView = {
	destroy = 0,
	container = "VersionActivity2_0DungeonMapLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_0/v2a0_dungeon/v2a0_dungeonmaplevelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		},
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity2_0DungeonMapGraffitiEnterView = {
	destroy = 0,
	container = "VersionActivity2_0DungeonMapGraffitiEnterViewContainer",
	mainRes = "ui/viewres/versionactivity_2_0/v2a0_dungeon/v2a0_dungeonmapgraffitienterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.VersionActivity2_0DungeonGraffitiView = {
	destroy = 0,
	container = "VersionActivity2_0DungeonGraffitiViewContainer",
	mainRes = "ui/viewres/versionactivity_2_0/v2a0_dungeon/v2a0_dungeongraffitiview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_0/v2a0_dungeon/v2a0_dungeongraffitiitem.prefab",
		"ui/materials/dynamic/ui_halfgray2.mat",
		"ui/materials/dynamic/ui_halfgray.mat"
	}
}
var_0_0.VersionActivity2_0DungeonGraffitiDrawView = {
	destroy = 0,
	container = "VersionActivity2_0DungeonGraffitiDrawViewContainer",
	mainRes = "ui/viewres/versionactivity_2_0/v2a0_dungeon/v2a0_dungeongraffitidrawview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.V2a0_SummerSign_PanelView = {
	destroy = 0,
	container = "V2a0_SummerSign_PanelViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a0_summersign_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a0_summersign_signitem.prefab"
	}
}
var_0_0.V2a0_SummerSign_FullView = {
	destroy = 0,
	container = "V2a0_SummerSign_FullViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a0_summersign_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a0_summersign_signitem.prefab"
	}
}
var_0_0.V2a0_Role_FullSignView_Part1 = {
	destroy = 0,
	container = "V2a0_Role_FullSignView_Part1_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a0_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a0_role_signitem.prefab"
	}
}
var_0_0.V2a0_Role_FullSignView_Part2 = {
	destroy = 0,
	container = "V2a0_Role_FullSignView_Part2_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a0_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a0_role_signitem.prefab"
	}
}
var_0_0.V2a0_Role_PanelSignView_Part1 = {
	destroy = 0,
	container = "V2a0_Role_PanelSignView_Part1_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a0_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a0_role_signitem.prefab"
	}
}
var_0_0.V2a0_Role_PanelSignView_Part2 = {
	destroy = 0,
	container = "V2a0_Role_PanelSignView_Part2_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a0_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a0_role_signitem.prefab"
	}
}
var_0_0.V2a0_WarmUp = {
	destroy = 0,
	container = "V2a0_WarmUpContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_0/v2a0_warmup/v2a0_warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.ActMercuriaLevelView = {
	destroy = 0,
	container = "ActMercuriaLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_0/v2a0_mercuria/v2a0_mercuria_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_0/v2a0_mercuria/v2a0_mercuria_levelviewstageitem.prefab",
		[2] = "ui/viewres/versionactivity_2_0/v2a0_mercuria/v2a0_mercuria_levelviewstageitem2.prefab"
	}
}
var_0_0.ActMercuriaTaskView = {
	bgBlur = 0,
	container = "ActMercuriaTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_0/v2a0_mercuria/v2a0_mercuria_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_0/v2a0_mercuria/v2a0_mercuria_taskitem.prefab"
	}
}
var_0_0.ActJoeLevelView = {
	destroy = 0,
	container = "ActJoeLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_0/v2a0_joe/v2a0_joe_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_0/v2a0_joe/v2a0_joe_levelviewstageitem.prefab",
		[2] = "ui/viewres/versionactivity_2_0/v2a0_joe/v2a0_joe_levelviewstageitem2.prefab"
	}
}
var_0_0.ActJoeTaskView = {
	bgBlur = 0,
	container = "ActJoeTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_0/v2a0_joe/v2a0_joe_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_0/v2a0_joe/v2a0_joe_taskitem.prefab"
	}
}
var_0_0.OptionalChargeView = {
	destroy = 0,
	container = "OptionalChargeViewContainer",
	mainRes = "ui/viewres/store/optionalgiftview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
var_0_0.PlayerCardView = {
	container = "PlayerCardViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/player/personalcard/playercardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	customAnimFadeTime = {
		0.3
	},
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		achieveview = "ui/viewres/player/personalcard/playercardachieveview.prefab",
		achieveitem = "ui/viewres/achievement/achievementmainicon.prefab",
		groupview = "ui/viewres/player/personalcard/playercardgroupview.prefab",
		carditem = "ui/viewres/player/personalcard/playercarditem.prefab",
		assitview = "ui/viewres/player/personalcard/playercardassitview.prefab",
		chapterview = "ui/viewres/player/personalcard/playercardchapterview.prefab",
		infoview = "ui/viewres/player/personalcard/playercardinfoview.prefab"
	}
}
var_0_0.NewPlayerCardView = {
	container = "NewPlayerCardViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/player/playercard/playercardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	customAnimFadeTime = {
		0.3
	},
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		achieveitem = "ui/viewres/achievement/achievementmainicon.prefab"
	}
}
var_0_0.NewPlayerCardContentView = {
	container = "NewPlayerCardContentViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/player/playercard/playercardcontentview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	customAnimFadeTime = {
		0.3
	},
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		skinpreview = "ui/viewres/player/playercard/playercardskinpreview.prefab",
		achieveitem = "ui/viewres/achievement/achievementmainicon.prefab"
	}
}
var_0_0.PlayerCardCritterPlaceView = {
	destroy = 0,
	container = "PlayerCardCritterPlaceViewContainer",
	mainRes = "ui/viewres/player/playercard/playercardcritterplaceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	customAnimFadeTime = {
		0.3
	},
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.PlayerCardBaseInfoView = {
	destroy = 0,
	container = "PlayerCardBaseInfoViewContainer",
	mainRes = "ui/viewres/player/playercard/playercardbaseinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	customAnimFadeTime = {
		0.3
	},
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.PlayerCardProgressView = {
	destroy = 0,
	container = "PlayerCardProgressViewContainer",
	mainRes = "ui/viewres/player/playercard/playercardprogressview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	customAnimFadeTime = {
		0.3
	},
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.PlayerCardShowView = {
	destroy = 0,
	container = "PlayerCardShowViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/player/personalcard/playercardshowview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		carditem = "ui/viewres/player/personalcard/playercarditem.prefab"
	}
}
var_0_0.PlayerCardLayoutView = {
	destroy = 0,
	container = "PlayerCardLayoutViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/player/personalcard/playercardlayoutview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		achieveview = "ui/viewres/player/personalcard/playercardachieveview.prefab",
		achieveitem = "ui/viewres/achievement/achievementmainicon.prefab",
		groupview = "ui/viewres/player/personalcard/playercardgroupview.prefab",
		carditem = "ui/viewres/player/personalcard/playercarditem.prefab",
		assitview = "ui/viewres/player/personalcard/playercardassitview.prefab",
		chapterview = "ui/viewres/player/personalcard/playercardchapterview.prefab",
		infoview = "ui/viewres/player/personalcard/playercardinfoview.prefab"
	}
}
var_0_0.PlayerCardCharacterSwitchView = {
	destroy = 0,
	container = "PlayerCardCharacterSwitchViewContainer",
	mainRes = "ui/viewres/player/playercard/playercardroleswitchview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	otherRes = {
		[1] = "ui/viewres/character/characterswitchitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.PlayerCardAchievementSelectView = {
	destroy = 0,
	container = "PlayerCardAchievementSelectViewContainer",
	mainRes = "ui/viewres/achievement/achievementselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/achievement/achievementselectitem.prefab",
		[2] = "ui/viewres/achievement/achievementmainicon.prefab"
	}
}
var_0_0.VersionActivity2_2EnterView = {
	destroy = 0,
	container = "VersionActivity2_2EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_enter/v2a2_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_2_2/v2a2_enter/v2a2_dungeonenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_2/v2a2_tianshinana/v2a2_tianshinana_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminate_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_2/v2a2_season/v2a2_season_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_enterview.prefab"
			},
			{
				"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_2/v2a2_lopera/v2a2_lopera_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_2/v2a2_roomcritter/v2a2_roomcritter_enterview.prefab"
			}
		}
	}
}
var_0_0.VersionActivity2_2StoreView = {
	destroy = 0,
	container = "VersionActivity2_2StoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_dungeon/v2a2_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity2_2TaskView = {
	destroy = 0,
	container = "VersionActivity2_2TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_dungeon/v2a2_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_2/v2a2_dungeon/v2a2_taskitem.prefab"
	}
}
var_0_0.VersionActivity2_2RoomSignView = {
	destroy = 0,
	container = "VersionActivity2_2RoomSignViewContainer",
	mainRes = "ui/viewres/activity/v2a2_room_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		"ui/viewres/activity/v2a2_room_rewarditem.prefab"
	}
}
var_0_0.EliminateTaskView = {
	destroy = 0,
	container = "EliminateTaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminate_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminate_taskitem.prefab"
	}
}
var_0_0.EliminateSelectChessMenView = {
	destroy = 0,
	container = "EliminateSelectChessMenViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminateselectchessmenview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		"ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminateselectchessmenitem.prefab",
		"ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminateselectchessmenslot.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.EliminateSelectRoleView = {
	destroy = 0,
	container = "EliminateSelectRoleViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminateselectroleview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		"ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminateselectroleitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.EliminateMapView = {
	destroy = 0,
	container = "EliminateMapViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminatemapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[2] = "ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminatemapstageitemnormal.prefab",
		[3] = "ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminatemapstageitemboss.prefab"
	}
}
var_0_0.EliminateNoticeView = {
	destroy = 0,
	container = "EliminateNoticeViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminate_noticeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
var_0_0.EliminateLevelResultView = {
	bgBlur = 3,
	container = "EliminateLevelResultViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminate_gameresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.EliminateLevelRewardView = {
	destroy = 0,
	container = "EliminateLevelRewardViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminate_rewardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.EliminateEffectView = {
	destroy = 0,
	container = "EliminateEffectViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminate_chesseffectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.EliminateCharacterSkillTipView = {
	destroy = 0,
	container = "CharacterSkillTipViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminate_skilltipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.EliminateLevelView = {
	destroy = 0,
	container = "EliminateLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminate_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	otherRes = {
		"ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_teamchess_chessitem.prefab",
		"ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminate_fourchessitem.prefab",
		"ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminate_sixchessitem.prefab",
		"ui/viewres/versionactivity_2_2/v2a2_eliminate/eliminatescenecanvas.prefab",
		nil,
		"ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminate_chesstips.prefab",
		"ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminate_maxchessitem.prefab",
		nil,
		"ui/materials/dynamic/ui_effects_gray.mat",
		"ui/materials/dynamic/ui_effects.mat",
		"singlebg/season/full/seasonsecretlandentrance_mask.png"
	},
	preloader = module_views_preloader
}
var_0_0.TianShiNaNaMainView = {
	destroy = 0,
	container = "TianShiNaNaMainViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_tianshinana/v2a2_tianshinana_mainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.TianShiNaNaLevelView = {
	destroy = 0,
	container = "TianShiNaNaLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_tianshinana/v2a2_tianshinana_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "scenes/v2a2_m_s12_tsnn_jshd/prefab/v2a2_m_s12_tsnn_box_p.prefab"
	}
}
var_0_0.TianShiNaNaTalkView = {
	destroy = 0,
	container = "TianShiNaNaTalkViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_tianshinana/v2a2_tianshinana_talkview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.TianShiNaNaResultView = {
	bgBlur = 3,
	container = "TianShiNaNaResultViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_tianshinana/v2a2_tianshinana_resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.TianShiNaNaTaskView = {
	destroy = 0,
	container = "TianShiNaNaTaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_tianshinana/v2a2_tianshinana_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_2/v2a2_tianshinana/v2a2_tianshinana_taskitem.prefab"
	}
}
var_0_0.V2a2_Role_FullSignView_Part1 = {
	destroy = 0,
	container = "V2a2_Role_FullSignView_Part1_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a2_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a2_role_signitem.prefab"
	}
}
var_0_0.V2a2_Role_FullSignView_Part2 = {
	destroy = 0,
	container = "V2a2_Role_FullSignView_Part2_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a2_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a2_role_signitem.prefab"
	}
}
var_0_0.V2a2_Role_PanelSignView_Part1 = {
	destroy = 0,
	container = "V2a2_Role_PanelSignView_Part1_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a2_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a2_role_signitem.prefab"
	}
}
var_0_0.V2a2_Role_PanelSignView_Part2 = {
	destroy = 0,
	container = "V2a2_Role_PanelSignView_Part2_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a2_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a2_role_signitem.prefab"
	}
}
var_0_0.V2a2_RedLeafFestival_FullView = {
	destroy = 0,
	container = "V2a2_RedLeafFestival_FullViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a2_redleaffestival_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a2_redleaffestival_signitem.prefab"
	}
}
var_0_0.V2a2_RedLeafFestival_PanelView = {
	destroy = 0,
	container = "V2a2_RedLeafFestival_PanelViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a2_redleaffestival_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a2_redleaffestival_signitem.prefab"
	}
}
var_0_0.V2a2_WarmUp = {
	destroy = 0,
	container = "V2a2_WarmUpContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v2a2_warmup/v2a2_warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.RoomManufactureBuildingView = {
	destroy = 0,
	container = "RoomManufactureBuildingViewContainer",
	mainRes = "ui/viewres/room/manufacture/roommanufacturebuildingview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				RoomManufactureBuildingDetailBanner.prefabPath
			}
		}
	}
}
var_0_0.RoomManufactureBuildingDetailView = {
	destroy = 0,
	container = "RoomManufactureBuildingDetailViewContainer",
	mainRes = "ui/viewres/room/manufacture/roommanufacturebuildingdetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		RoomManufactureCritterDetail.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.RoomCritterListView = {
	destroy = 0,
	container = "RoomCritterListViewContainer",
	mainRes = "ui/viewres/room/manufacture/roommanufacturecritterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.RoomManufactureAddPopView = {
	destroy = 0,
	container = "RoomManufactureAddPopViewContainer",
	mainRes = "ui/viewres/room/manufacture/roommanufactureaddpopview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.RoomBuildingLevelUpView = {
	bgBlur = 1,
	container = "RoomBuildingLevelUpViewContainer",
	maskAlpha = 0,
	destroy = 0,
	mainRes = "ui/viewres/room/critter/roomcritterbuildinglevelupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.RoomManufactureBuildingLevelUpTipsView = {
	destroy = 0,
	container = "RoomManufactureBuildingLevelUpTipsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/critter/roomcritterleveluptipsview.prefab",
	blurFactor = 0.3,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.RoomManufactureAccelerateView = {
	destroy = 0,
	container = "RoomManufactureAccelerateViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/manufacture/roommanufactureaccelerateview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.RoomOverView = {
	destroy = 0,
	container = "RoomOverViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/manufacture/roomoverview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/room/manufacture/roommanufactureoverview.prefab"
			},
			{
				"ui/viewres/room/manufacture/roomtransportoverview.prefab"
			}
		}
	}
}
var_0_0.RoomManufactureWrongTipView = {
	destroy = 0,
	container = "RoomManufactureWrongTipViewContainer",
	mainRes = "ui/viewres/room/manufacture/roommanufacturewrongtipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.RoomCritterOneKeyView = {
	destroy = 0,
	container = "RoomCritterOneKeyViewContainer",
	mainRes = "ui/viewres/room/manufacture/roomcritteronekeyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.RoomOneKeyView = {
	destroy = 0,
	container = "RoomOneKeyViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/manufacture/roomonekeytipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal
}
var_0_0.RoomCritterBuildingView = {
	destroy = 0,
	container = "RoomCritterBuildingViewContainer",
	mainRes = "ui/viewres/room/manufacture/roomcritterbuildingview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		RoomTrainSlotItem.prefabPath,
		RoomTrainHeroItem.prefabPath,
		RoomCritterTrainItem.prefabPath,
		RoomCritterTrainDetailItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/room/manufacture/roomcritterrestview.prefab"
			},
			{
				"ui/viewres/room/critter/roomcrittertrainview.prefab"
			},
			{
				"ui/viewres/room/critter/roomcrittersummonview.prefab"
			},
			{
				"ui/viewres/room/critter/roomcritterincubateview.prefab"
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.RoomCritterPlaceView = {
	destroy = 0,
	container = "RoomCritterPlaceViewContainer",
	mainRes = "ui/viewres/room/manufacture/roomcritterplaceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal
}
var_0_0.RoomCritterTrainReportView = {
	destroy = 0,
	container = "RoomCritterTrainReportViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/critter/roomtrainreportview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.RoomTrainAccelerateView = {
	destroy = 0,
	container = "RoomTrainAccelerateViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/critter/roomtrainaccelerateview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		RoomCritterTrainDetailItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.RoomCritterTrainEventView = {
	destroy = 0,
	container = "RoomCritterTrainEventViewContainer",
	mainRes = "ui/viewres/room/critter/roomcrittertraineventview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.RoomCritterTrainStoryView = {
	destroy = 0,
	container = "RoomCritterTrainStoryViewContainer",
	mainRes = "ui/viewres/room/critter/roomcrittertrainstoryview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		RoomCritterTrainDetailItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.RoomCritterTrainEventResultView = {
	destroy = 0,
	container = "RoomCritterTrainEventResultViewContainer",
	mainRes = "ui/viewres/room/critter/roomcrittertraineventresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		RoomCritterTrainDetailItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.RoomCritterExchangeView = {
	destroy = 0,
	container = "RoomCritterExchangeViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/critter/roomcritterexchangeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.RoomCritterRenameView = {
	destroy = 0,
	container = "RoomCritterRenameViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/layout/roomlayoutcopyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.RoomCritterSummonSkipView = {
	destroy = 0,
	container = "RoomCritterSummonSkipViewContainer",
	mainRes = "ui/viewres/room/critter/roomcrittersummonskipview.prefab",
	layer = "TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				"ui/viewres/room/critter/roomcrittersummondragview.prefab"
			}
		}
	}
}
var_0_0.RoomGetCritterView = {
	destroy = 0,
	container = "RoomGetCritterViewContainer",
	mainRes = "ui/viewres/room/critter/roomgetcritterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		"ui/viewres/room/critter/egg/roomcritter_egg1.prefab",
		"ui/viewres/room/critter/egg/roomcritter_egg2.prefab",
		"ui/viewres/room/critter/egg/roomcritter_egg3.prefab"
	}
}
var_0_0.RoomCritterSummonResultView = {
	destroy = 0,
	container = "RoomCritterSummonResultViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/critter/roomcrittersummonresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		"ui/viewres/room/critter/egg/roomcrittersummonresult_egg1.prefab",
		"ui/viewres/room/critter/egg/roomcrittersummonresult_egg2.prefab",
		"ui/viewres/room/critter/egg/roomcrittersummonresult_egg3.prefab"
	}
}
var_0_0.RoomCritterSummonRuleTipsView = {
	destroy = 0,
	container = "RoomCritterSummonRuleTipsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/critter/roomcrittersummonruletipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.RoomCriiterDetailSimpleView = {
	destroy = 0,
	container = "RoomCriiterDetailSimpleViewContainer",
	mainRes = "ui/viewres/room/critter/roomcritterdetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
var_0_0.RoomCritterDetailYoungView = {
	destroy = 0,
	container = "RoomCritterDetailYoungViewContainer",
	mainRes = "ui/viewres/room/critter/roomcritterdetailyoungview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.RoomCritterDetailMaturityView = {
	destroy = 0,
	container = "RoomCritterDetailMaturityViewContainer",
	mainRes = "ui/viewres/room/critter/roomcritterdetailmaturityview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.RoomCritterFilterView = {
	destroy = 0,
	container = "RoomCritterFilterViewContainer",
	mainRes = "ui/viewres/room/critter/roomcrittersearchfilterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.RoomTradeView = {
	destroy = 0,
	container = "RoomTradeViewContainer",
	mainRes = "ui/viewres/room/trade/roomtradeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/room/trade/roomdailyorderview.prefab"
			},
			{
				"ui/viewres/room/trade/roomwholesaleview.prefab"
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		RoomDailyOrderItem.ResUrl,
		RoomWholesaleItem.ResUrl
	}
}
var_0_0.RoomRecordView = {
	destroy = 0,
	container = "RoomRecordViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/record/roomrecordview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/room/record/roomtradetaskview.prefab"
			},
			{
				"ui/viewres/room/record/roomlogview.prefab"
			},
			{
				"ui/viewres/room/record/roomcritterhandbookview.prefab"
			}
		}
	},
	otherRes = {
		"ui/viewres/room/record/roomtradetaskitem.prefab",
		"ui/viewres/room/record/roomtradelevelunlockitem.prefab",
		"ui/viewres/room/record/roomlogitem.prefab"
	}
}
var_0_0.RoomTradeLevelUpTipsView = {
	destroy = 0,
	container = "RoomTradeLevelUpTipsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/record/roomtradeleveluptipsview.prefab",
	blurFactor = 0.3,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.RoomCritterHandBookBackView = {
	destroy = 0,
	container = "RoomCritterHandBookBackViewContanier",
	bgBlur = 1,
	mainRes = "ui/viewres/room/record/roomhandbookbackview.prefab",
	blurFactor = 0.3,
	layer = "POPUP_TOP",
	viewType = ViewType.FULL,
	anim = ViewAnim.Default
}
var_0_0.RoomBackpackView = {
	destroy = 0,
	container = "RoomBackpackViewContainer",
	mainRes = "ui/viewres/room/roombackpackview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/room/roombackpackcritterview.prefab"
			},
			{
				"ui/viewres/room/roombackpackproprview.prefab"
			}
		}
	}
}
var_0_0.RoomCritterDecomposeView = {
	destroy = 0,
	container = "RoomCritterDecomposeViewContainer",
	mainRes = "ui/viewres/room/critter/roomcritterdecomposeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.RoomManufactureGetView = {
	destroy = 0,
	container = "RoomManufactureGetViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/manufacture/roommanufacturegetview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.RoomCritterRestTipsView = {
	destroy = 0,
	container = "RoomCritterRestTipsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/manufacture/roomcritterresttipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity2_1EnterView = {
	destroy = 0,
	container = "VersionActivity2_1EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_enter/v2a1_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_2_1/v2a1_enter/v2a1_dungeonenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_1/v2a1_season/v2a1_season_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_1/v2a1_tuesday/v2a1_tuesday_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_1/v2a1_aergusi/v2a1_aergusi_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_1/v2a1_rouge/v2a1_rouge_enterview.prefab"
			},
			{
				"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_0/v2a0_v1a5reprint_enterview.prefab"
			}
		}
	}
}
var_0_0.VersionActivity2_1StoreView = {
	destroy = 0,
	container = "VersionActivity2_1StoreViewContainer",
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_dungeon/v2a1_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity2_1TaskView = {
	destroy = 0,
	container = "VersionActivity2_1TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_dungeon/v2a1_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_1/v2a1_dungeon/v2a1_taskitem.prefab"
	}
}
var_0_0.VersionActivity2_1DungeonMapView = {
	destroy = 0,
	container = "VersionActivity2_1DungeonMapViewContainer",
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_dungeon/v2a1_dungeonmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/versionactivity_2_1/v2a1_dungeon/v2a1_mapepisodeitem.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
		"ui/viewres/versionactivity_2_1/v2a1_dungeon/v2a1_dungeonmap_direction.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity2_1DungeonMapLevelView = {
	destroy = 0,
	container = "VersionActivity2_1DungeonMapLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_dungeon/v2a1_dungeonmaplevelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		},
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.V2a1_MoonFestival_PanelView = {
	destroy = 0,
	container = "V2a1_MoonFestival_PanelViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a1_moonfestival_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a1_moonfestival_signitem.prefab"
	}
}
var_0_0.V2a1_MoonFestival_FullView = {
	destroy = 0,
	container = "V2a1_MoonFestival_FullViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a1_moonfestival_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a1_moonfestival_signitem.prefab"
	}
}
var_0_0.V2a1_Role_FullSignView_Part1 = {
	destroy = 0,
	container = "V2a1_Role_FullSignView_Part1_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a1_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a1_role_signitem.prefab"
	}
}
var_0_0.V2a1_Role_FullSignView_Part2 = {
	destroy = 0,
	container = "V2a1_Role_FullSignView_Part2_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a1_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a1_role_signitem.prefab"
	}
}
var_0_0.V2a1_Role_PanelSignView_Part1 = {
	destroy = 0,
	container = "V2a1_Role_PanelSignView_Part1_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a1_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a1_role_signitem.prefab"
	}
}
var_0_0.V2a1_Role_PanelSignView_Part2 = {
	destroy = 0,
	container = "V2a1_Role_PanelSignView_Part2_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a1_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a1_role_signitem.prefab"
	}
}
var_0_0.V2a1_WarmUp = {
	destroy = 0,
	container = "V2a1_WarmUpContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_warmup/v2a1_warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.Activity165StoryEnterView = {
	destroy = 0,
	container = "Activity165StoryEnterViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_1/act165/act165storyenterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Activity165StoryReviewView = {
	destroy = 0,
	container = "Activity165StoryReviewViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_1/act165/act165storyreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Activity165StoryEditView = {
	destroy = 0,
	container = "Activity165StoryEditViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_1/act165/act165storyeditview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_1/act165/story/go_story1.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.CommonTrialHeroDetailView = {
	destroy = 0,
	container = "CommonTrialHeroDetailViewContainer",
	mainRes = "ui/viewres/summon/summonherodetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.LanShouPaGameResultView = {
	bgBlur = 3,
	container = "LanShouPaGameResultViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_tuesday/v2a1_tuesday_gameresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.LanShouPaMapView = {
	bgBlur = 0,
	container = "LanShouPaMapViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_tuesday/v2a1_tuesday_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/versionactivity_2_1/v2a1_tuesday/v2a1_tuesday_levelviewstageitem.prefab",
		"scenes/v1a3_m_s12_dfw_jlbn/prefab/m_s12_jlbn_zjm_01_p.prefab",
		"scenes/v1a3_m_s12_dfw_jlbn/prefab/m_s12_jlbn_zjm_02_p.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.LanShouPaGameView = {
	bgBlur = 0,
	container = "LanShouPaGameViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_tuesday/v2a1_tuesday_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.LanShouPaTaskView = {
	bgBlur = 0,
	container = "LanShouPaTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_tuesday/v2a1_tuesday_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_1/v2a1_tuesday/v2a1_tuesday_taskitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.LanShouPaStoryView = {
	bgBlur = 3,
	container = "LanShouPaStoryViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_tuesday/v2a1_tuesday_storyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_1/v2a1_tuesday/v2a1_tuesday_storyviewitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.AergusiLevelView = {
	bgBlur = 0,
	container = "AergusiLevelViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_aergusi/v2a1_aergusi_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_1/v2a1_aergusi/v2a1_aergusi_levelitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.AergusiDialogView = {
	destroy = 0,
	container = "AergusiDialogViewContainer",
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_aergusi/v2a1_aergusi_dialogview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.AergusiClueView = {
	bgBlur = 1,
	container = "AergusiClueViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_aergusi/v2a1_aergusi_clueview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_1/v2a1_aergusi/v2a1_aergusi_clueitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.AergusiTaskView = {
	bgBlur = 0,
	container = "AergusiTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_aergusi/v2a1_aergusi_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		AergusiTaskItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.AergusiFailView = {
	bgBlur = 1,
	container = "AergusiFailViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_aergusi/v2a1_aergusi_failview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.AergusiDialogStartView = {
	bgBlur = 1,
	container = "AergusiDialogStartViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_aergusi/v2a1_aergusi_dialogstartview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.AergusiDialogEndView = {
	bgBlur = 1,
	container = "AergusiDialogEndViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_aergusi/v2a1_aergusi_dialogendingview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.PlayerCardCharacterSwitchTipsView = {
	destroy = 0,
	container = "PlayerCardCharacterSwitchTipsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/player/playercard/playercardroleswitchtipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
var_0_0.Season166MainView = {
	destroy = 0,
	container = "Season166MainViewContainer",
	mainRes = "ui/viewres/seasonver/act166/season166mainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	preloader = module_views_preloader
}
var_0_0.Season166BaseSpotView = {
	destroy = 0,
	container = "Season166_2_6BaseSpotViewContainer",
	mainRes = "ui/viewres/seasonver/act166/season166basespotview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/act166/season166wordcontent.prefab",
		[2] = "ui/viewres/seasonver/act166/season166wordeffect.prefab"
	}
}
var_0_0.Season166TrainView = {
	destroy = 0,
	container = "Season166_2_6TrainViewContainer",
	mainRes = "ui/viewres/seasonver/act166/season166trainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/act166/season166wordcontent.prefab",
		[2] = "ui/viewres/seasonver/act166/season166wordeffect.prefab"
	}
}
var_0_0.Season166TeachView = {
	destroy = 0,
	container = "Season166TeachViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/seasonver/act166/season166teachview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season166HeroGroupFightView = {
	bgBlur = 4,
	container = "Season166_2_6HeroGroupFightViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/seasonver/act166/season166herogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
var_0_0.Season166HeroGroupEditView = {
	container = "Season166HeroGroupEditViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/seasonver/act166/season166herogroupeditview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/act166/season166herogroupedititem.prefab",
		[2] = "ui/viewres/seasonver/act166/season166herogroupquickedititem.prefab"
	},
	customAnimBg = {
		"bg"
	}
}
var_0_0.Season166HeroGroupTargetView = {
	destroy = 0,
	container = "Season166HeroGroupTargetViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act166/season166herogrouptargetview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.Season166InformationMainView = {
	destroy = 0,
	container = "Season166_2_6InformationMainViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/seasonver/act166/season_infoanalyze_reportview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season166InformationAnalyView = {
	destroy = 0,
	container = "Season166_2_6InformationAnalyViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/seasonver/act166/season_infoanalyze_reportdetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season166InformationRewardView = {
	destroy = 0,
	container = "Season166InformationRewardViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/seasonver/act166/season_infoanalyze_rewardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season166TalentView = {
	destroy = 0,
	container = "Season166TalentViewContainer",
	mainRes = "ui/viewres/seasonver/act166/season166talentview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season166TalentSelectView = {
	destroy = 0,
	container = "Season166_2_6TalentSelectViewContainer",
	mainRes = "ui/viewres/seasonver/act166/season166talentselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Season166ResultView = {
	destroy = 0,
	container = "Season166ResultViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act166/season166resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
var_0_0.Season166ResultPanel = {
	destroy = 0,
	container = "Season166ResultPanelContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act166/season166resultpanel.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
var_0_0.Season166TalentInfoView = {
	destroy = 0,
	container = "Season166TalentInfoViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act166/season166talentinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
var_0_0.LoperaMainView = {
	destroy = 0,
	container = "LoperaMainViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_lopera/v2a2_lopera_mapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_2/v2a2_lopera/v2a2_lopera_mapstageitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.LoperaLevelView = {
	destroy = 0,
	container = "LoperaLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_lopera/v2a2_lopera_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.LoperaLevelTipsView = {
	destroy = 0,
	container = "LoperaLevelTipsViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_lopera/v2a2_lopera_leveltipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.LoperaTaskView = {
	bgBlur = 0,
	container = "LoperaTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_lopera/v2a2_lopera_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_2/v2a2_lopera/v2a2_lopera_taskitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.LoperaGameResultView = {
	destroy = 0,
	container = "LoperaGameResultViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_lopera/v2a2_lopera_resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		LoperaGoodsItem.prefabPath3
	}
}
var_0_0.LoperaSmeltView = {
	bgBlur = 3,
	container = "LoperaSmeltViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_lopera/v2a2_lopera_smeltview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		LoperaGoodsItem.prefabPath3
	}
}
var_0_0.LoperaSmeltResultView = {
	destroy = 0,
	container = "LoperaSmeltResultViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_lopera/v2a2_lopera_smeltresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Activity173FullView = {
	destroy = 0,
	container = "Activity173FullViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_limitdecorate/v2a2_limitdecoratefullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Activity173PanelView = {
	destroy = 0,
	container = "Activity173PanelViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_limitdecorate/v2a2_limitdecoratepanelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal
}
var_0_0.ActivityInsightShowView = {
	destroy = 0,
	container = "ActivityInsightShowViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/show/activityinsightshowview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.GiftInsightHeroChoiceView = {
	destroy = 0,
	container = "GiftInsightHeroChoiceViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/gift/giftinsightherochoiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/gift/giftinsightherochoiceitem.prefab"
	}
}
var_0_0.FightEnemyActionView = {
	destroy = 0,
	container = "FightEnemyActionViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/fight/fightenemyactionview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/fight/fightcarditem.prefab"
	}
}
var_0_0.StressTipView = {
	destroy = 0,
	container = "StressTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/fightstresstip/fightstresstipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.WebView = {
	destroy = 0,
	container = "WebViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/webview/webview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.TowerGuideView = {
	destroy = 0,
	container = "TowerGuideViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/tower/towerguideview.prefab",
	blurFactor = 0.3,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
var_0_0.TowerPermanentView = {
	destroy = 0,
	container = "TowerPermanentViewContainer",
	mainRes = "ui/viewres/tower/towerpermanentview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.TowerMopUpView = {
	destroy = 0,
	container = "TowerMopUpViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/tower/towermopupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.TowerMainView = {
	destroy = 0,
	container = "TowerMainViewContainer",
	mainRes = "ui/viewres/tower/towermainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.TowerBossSelectView = {
	destroy = 0,
	container = "TowerBossSelectViewContainer",
	mainRes = "ui/viewres/tower/towerbossselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		itemRes = "ui/viewres/tower/towerbossselectitem.prefab"
	}
}
var_0_0.TowerBossEpisodeView = {
	destroy = 0,
	container = "TowerBossEpisodeViewContainer",
	mainRes = "ui/viewres/tower/towerbossepisodeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.TowerBossSpEpisodeView = {
	destroy = 0,
	container = "TowerBossSpEpisodeViewContainer",
	mainRes = "ui/viewres/tower/towerbossspepisodeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.TowerAssistBossView = {
	destroy = 0,
	container = "TowerAssistBossViewContainer",
	mainRes = "ui/viewres/tower/towerassistbosstview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		itemRes = "ui/viewres/tower/towerassistbossitem.prefab"
	}
}
var_0_0.TowerHeroGroupFightView = {
	bgBlur = 4,
	container = "TowerHeroGroupFightViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/tower/towerherogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
var_0_0.TowerAssistBossDetailView = {
	destroy = 0,
	container = "TowerAssistBossDetailViewContainer",
	mainRes = "ui/viewres/tower/towerassistbosstdetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.TowerAssistBossTalentView = {
	destroy = 0,
	container = "TowerAssistBossTalentViewContainer",
	mainRes = "ui/viewres/tower/towertalentview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.TowerAssistBossTalentTallView = {
	destroy = 0,
	container = "TowerAssistBossTalentTallViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/tower/towertalentallview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.TowerBossResultView = {
	destroy = 0,
	container = "TowerBossResultViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/tower/towerbossresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.TowerPermanentResultView = {
	destroy = 0,
	container = "TowerPermanentResultViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/tower/towerpermanentresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.TowerTaskView = {
	destroy = 0,
	container = "TowerTaskViewContainer",
	mainRes = "ui/viewres/tower/towertaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/tower/towertaskitem.prefab"
	}
}
var_0_0.TowerTimeLimitLevelView = {
	destroy = 0,
	container = "TowerTimeLimitLevelViewContainer",
	mainRes = "ui/viewres/tower/towertimelimitlevelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.TowerBossSkillTipsView = {
	destroy = 0,
	container = "TowerBossSkillTipsViewContainer",
	mainRes = "ui/viewres/tower/towerbosstipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.TowerBossAttributeTipsView = {
	destroy = 0,
	container = "TowerBossAttributeTipsViewContainer",
	mainRes = "ui/viewres/tower/towerbossattributetipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.TowerBossHeroGroupAttributeTipsView = {
	destroy = 0,
	container = "TowerBossHeroGroupAttributeTipsViewContainer",
	mainRes = "ui/viewres/tower/towerherogrouptipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.TowerSkillTipView = {
	destroy = 0,
	container = "TowerSkillTipViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/tower/towerbossskilltipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"#go_newskilltip/skillbg"
	}
}
var_0_0.VersionActivity2_3EnterView = {
	destroy = 0,
	container = "VersionActivity2_3EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/v2a3_enter/v2a3_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_2_3/v2a3_enter/v2a3_dungeonenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_3/v2a3_enter/v2a3_act174enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_3/v2a3_roledudugu/v2a3_roledudugu_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_3/v2a3_zhixinquaner/v2a3_zhixinquaner_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_3/v2a3_season/v2a3_season_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_enterview.prefab"
			},
			{
				"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
			},
			{
				"ui/viewres/activity/show/activityweekwalkdeepshowview.prefab"
			},
			{
				"ui/viewres/tower/towermainentryview.prefab"
			}
		}
	}
}
var_0_0.VersionActivity2_3StoreView = {
	destroy = 0,
	container = "VersionActivity2_3StoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_3/v2a3_dungeon/v2a3_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity2_3TaskView = {
	destroy = 0,
	container = "VersionActivity2_3TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/v2a3_dungeon/v2a3_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_3/v2a3_dungeon/v2a3_taskitem.prefab"
	}
}
var_0_0.VersionActivity2_3DungeonMapView = {
	destroy = 0,
	container = "VersionActivity2_3DungeonMapViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/v2a3_dungeon/v2a3_dungeonmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/versionactivity_2_3/v2a3_dungeon/v2a3_mapepisodeitem.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
		"ui/viewres/versionactivity_2_3/v2a3_dungeon/v2a3_dungeonmap_direction.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity2_3DungeonMapLevelView = {
	destroy = 0,
	container = "VersionActivity2_3DungeonMapLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/v2a3_dungeon/v2a3_dungeonmaplevelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		},
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.ActDuDuGuLevelView = {
	destroy = 0,
	container = "ActDuDuGuLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/v2a3_roledudugu/v2a3_roledudugu_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_3/v2a3_roledudugu/v2a3_roledudugu_levelstageitem.prefab"
	}
}
var_0_0.ActDuDuGuTaskView = {
	bgBlur = 0,
	container = "ActDuDuGuTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_3/v2a3_roledudugu/v2a3_roledudugu_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_3/v2a3_roledudugu/v2a3_roledudugu_taskitem.prefab"
	}
}
var_0_0.ActivityInsightShowView_2_3 = {
	destroy = 0,
	container = "ActivityInsightShowView_2_3Container",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_3/v2a3_newinsight/v2a3_activityinsightshowview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.ZhiXinQuanErLevelView = {
	destroy = 0,
	container = "ZhiXinQuanErLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/v2a3_zhixinquaner/v2a3_zhixinquaner_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_3/v2a3_zhixinquaner/v2a3_zhixinquaner_levelviewstageitem.prefab"
	}
}
var_0_0.ZhiXinQuanErTaskView = {
	bgBlur = 0,
	container = "ZhiXinQuanErTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_3/v2a3_zhixinquaner/v2a3_zhixinquaner_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_3/v2a3_zhixinquaner/v2a3_zhixinquaner_taskitem.prefab"
	}
}
var_0_0.PuzzleMazeDrawView = {
	destroy = 0,
	container = "PuzzleMazeDrawViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/v2a3_zhixinquaner/maze/v2a3_puzzlemazedrawview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_3/v2a3_zhixinquaner/maze/v2a3_puzzlemazeitem.prefab",
		"ui/viewres/versionactivity_2_3/v2a3_zhixinquaner/maze/v2a3_puzzlemazepath.prefab",
		"ui/viewres/versionactivity_2_3/v2a3_zhixinquaner/maze/v2a3_puzzlemazepawn.prefab",
		"ui/viewres/versionactivity_2_3/v2a3_zhixinquaner/maze/v2a3_puzzlemazeswitchitem.prefab"
	}
}
var_0_0.Act174MainView = {
	destroy = 0,
	container = "Act174MainViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/act174/act174mainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Act174BadgeWallView = {
	destroy = 0,
	container = "Act174BadgeWallViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/act174/act174badgewallview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
var_0_0.Act174RotationView = {
	destroy = 0,
	container = "Act174RotationViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_3/act174/act174ruledetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Act174StoreView = {
	destroy = 0,
	container = "Act174StoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_3/act174/act174storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.Act174ForcePickView = {
	destroy = 0,
	container = "Act174ForcePickViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/act174/act174forcepickview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Act174GameView = {
	destroy = 0,
	container = "Act174GameViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/act174/act174gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Act174MatchView = {
	destroy = 0,
	container = "Act174MatchViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/act174/act174matchview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
var_0_0.Act174FightReadyView = {
	destroy = 0,
	container = "Act174FightReadyViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/act174/act174fightreadyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		Activity174Enum.PrefabPath.BattleHero
	}
}
var_0_0.Act174BetSuccessView = {
	destroy = 0,
	container = "Act174BetSuccessViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_3/act174/act174betsuccessview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.Act174FightResultView = {
	destroy = 0,
	container = "Act174FightResultViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_3/act174/act174fightresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		Activity174Enum.PrefabPath.BattleHero
	}
}
var_0_0.Act174EndLessView = {
	destroy = 0,
	container = "Act174EndLessViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/act174/act174endlessview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
var_0_0.Act174SettlementView = {
	destroy = 0,
	container = "Act174SettlementViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/act174/act174settlementview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		Activity174Enum.PrefabPath.BattleHero
	}
}
var_0_0.Act174ItemTipView = {
	destroy = 0,
	container = "Act174ItemTipViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/act174/act174itemtipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.Act174BuffTipView = {
	destroy = 0,
	container = "Act174BuffTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_3/act174/act174bufftipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
var_0_0.Act174RoleInfo = {
	destroy = 0,
	container = "Act174RoleInfoContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_3/act174/act174roleinfo.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
var_0_0.VersionActivity2_3NewCultivationGiftView = {
	destroy = 0,
	container = "VersionActivity2_3NewCultivationGiftViewContainer",
	mainRes = "ui/viewres/activity/v2a3_destiny_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.VersionActivity2_3NewCultivationGiftFullView = {
	destroy = 0,
	container = "VersionActivity2_3NewCultivationGiftFullViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a3_destiny_panelsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.VersionActivity2_3NewCultivationGiftRewardView = {
	destroy = 0,
	container = "VersionActivity2_3NewCultivationGiftRewardViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/v2a3_newcultivationgift/v2a3_newcultivationrewardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
var_0_0.VersionActivity2_3NewCultivationDetailView = {
	destroy = 0,
	container = "VersionActivity2_3NewCultivationDetailViewContainer",
	mainRes = "ui/viewres/activity/v2a3_destiny_preview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
var_0_0.V2a3_Role_FullSignView_Part1 = {
	destroy = 0,
	container = "V2a3_Role_FullSignView_Part1_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a3_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a3_role_signitem.prefab"
	}
}
var_0_0.V2a3_Role_FullSignView_Part2 = {
	destroy = 0,
	container = "V2a3_Role_FullSignView_Part2_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a3_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a3_role_signitem.prefab"
	}
}
var_0_0.V2a3_Role_PanelSignView_Part1 = {
	destroy = 0,
	container = "V2a3_Role_PanelSignView_Part1_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a3_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a3_role_signitem.prefab"
	}
}
var_0_0.V2a3_Role_PanelSignView_Part2 = {
	destroy = 0,
	container = "V2a3_Role_PanelSignView_Part2_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a3_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a3_role_signitem.prefab"
	}
}
var_0_0.VersionActivity2_4EnterView = {
	destroy = 0,
	container = "VersionActivity2_4EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_enter/v2a4_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_2_4/v2a4_enter/v2a4_dungeonenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_4/v2a4_wuerlixi/v2a4_wuerlixi_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_4/v2a4_reprint/v2a4_v1a8reprint_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_4/v2a4_rouge/v2a4_rouge_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_4/v2a4_season/v2a4_season_enterview.prefab"
			},
			{
				"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_enterview.prefab"
			},
			{
				"ui/viewres/activity/show/activityweekwalkdeepshowview.prefab"
			},
			{
				"ui/viewres/tower/towermainentryview.prefab"
			}
		}
	}
}
var_0_0.VersionActivity2_4DungeonMapView = {
	destroy = 0,
	container = "VersionActivity2_4DungeonMapViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_dungeon/v2a4_dungeonmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/versionactivity_2_4/v2a4_dungeon/v2a4_mapepisodeitem.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
		"ui/viewres/versionactivity_2_4/v2a4_dungeon/v2a4_dungeonmap_direction.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity2_4DungeonMapLevelView = {
	destroy = 0,
	container = "VersionActivity2_4DungeonMapLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_dungeon/v2a4_dungeonmaplevelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		},
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity2_4StoreView = {
	destroy = 0,
	container = "VersionActivity2_4StoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_dungeon/v2a4_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity2_4SudokuView = {
	destroy = 0,
	container = "VersionActivity2_4SudokuViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_sudokuview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity2_4TaskView = {
	destroy = 0,
	container = "VersionActivity2_4TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_dungeon/v2a4_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_4/v2a4_dungeon/v2a4_taskitem.prefab"
	}
}
var_0_0.PinballTaskView = {
	destroy = 0,
	container = "PinballTaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_taskitem.prefab"
	}
}
var_0_0.PinballCityView = {
	destroy = 0,
	container = "PinballCityViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_cityview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		menu = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_building_menu.prefab",
		currency = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_currencyitem.prefab"
	}
}
var_0_0.PinballGameView = {
	destroy = 0,
	container = "PinballGameViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.PinballMapSelectView = {
	bgBlur = 1,
	container = "PinballMapSelectViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_mapselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		currency = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_currencyitem.prefab"
	}
}
var_0_0.PinballBuildView = {
	destroy = 0,
	container = "PinballBuildViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_buildview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		currency = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_currencyitem.prefab"
	}
}
var_0_0.PinballUpgradeView = {
	destroy = 0,
	container = "PinballUpgradeViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_upgradeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		currency = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_currencyitem.prefab"
	}
}
var_0_0.PinballCurrencyTipView = {
	destroy = 0,
	container = "PinballCurrencyTipViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_currency_tip.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.PinballResultView = {
	destroy = 0,
	container = "PinballResultViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.PinballTalentView = {
	bgBlur = 1,
	container = "PinballTalentViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_talentview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		currency = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_currencyitem.prefab"
	}
}
var_0_0.PinballRestLoadingView = {
	destroy = 0,
	container = "PinballRestLoadingViewContainer",
	bgBlur = 1,
	delayTime = 4,
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_restview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.PinballStartLoadingView = {
	destroy = 0,
	container = "PinballLoadingViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_loadingview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.PinballDayEndView = {
	destroy = 0,
	container = "PinballDayEndViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_dayendview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.WuErLiXiLevelView = {
	destroy = 0,
	container = "WuErLiXiLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_wuerlixi/v2a4_wuerlixi_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_4/v2a4_wuerlixi/v2a4_wuerlixi_levelitem.prefab"
	}
}
var_0_0.WuErLiXiGameView = {
	destroy = 0,
	container = "WuErLiXiGameViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_wuerlixi/v2a4_wuerlixi_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.WuErLiXiUnitTipView = {
	destroy = 0,
	container = "WuErLiXiUnitTipViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_wuerlixi/v2a4_wuerlixi_unittipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.WuErLiXiTaskView = {
	destroy = 0,
	container = "WuErLiXiTaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_wuerlixi/v2a4_wuerlixi_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_4/v2a4_wuerlixi/v2a4_wuerlixi_taskitem.prefab"
	}
}
var_0_0.ActivityInsightShowView_2_4 = {
	destroy = 0,
	container = "ActivityInsightShowView_2_4Container",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_newinsight/v2a4_activityinsightshowview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.VersionActivity2_4MusicFreeView = {
	destroy = 0,
	container = "VersionActivity2_4MusicFreeViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_freeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_freetrack.prefab",
		"ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_freenotelistiitem.prefab",
		"ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_freenoteitem.prefab",
		"ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_freeinstrument.prefab"
	}
}
var_0_0.VersionActivity2_4MusicBeatView = {
	destroy = 0,
	container = "VersionActivity2_4MusicBeatViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_balaluoer_beatview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_balaluoer_beatitem.prefab"
	}
}
var_0_0.VersionActivity2_4MusicBeatResultView = {
	destroy = 0,
	container = "VersionActivity2_4MusicBeatResultViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_beatresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		"ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_beatresultcomboitem.prefab",
		"ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_beatresultevaluateitem.prefab"
	}
}
var_0_0.VersionActivity2_4MusicTaskView = {
	destroy = 0,
	container = "VersionActivity2_4MusicTaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_balaluoer_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_balaluoer_taskitem.prefab"
	}
}
var_0_0.VersionActivity2_4MusicFreeInstrumentSetView = {
	destroy = 0,
	container = "VersionActivity2_4MusicFreeInstrumentSetViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_freeinstrument_set.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		"ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_freeinstrument_setitem.prefab"
	}
}
var_0_0.VersionActivity2_4MusicFreeCalibrationView = {
	destroy = 0,
	container = "VersionActivity2_4MusicFreeCalibrationViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_freecalibration.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		"ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_freecalibrationitem.prefab"
	}
}
var_0_0.VersionActivity2_4MusicFreeAccompanyView = {
	destroy = 0,
	container = "VersionActivity2_4MusicFreeAccompanyViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_freeaccompanyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
var_0_0.VersionActivity2_4MusicFreeImmerseView = {
	destroy = 0,
	container = "VersionActivity2_4MusicFreeImmerseViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_freeimmerse.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
var_0_0.VersionActivity2_4MusicChapterView = {
	destroy = 0,
	container = "VersionActivity2_4MusicChapterViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_chapterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_chapteritem.prefab"
	}
}
var_0_0.AutoChessMainView = {
	destroy = 0,
	container = "AutoChessMainViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/autochess/autochessmainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		AutoChessEnum.BadgeItemPath
	}
}
var_0_0.AutoChessLeaderView = {
	destroy = 0,
	container = "AutoChessLeaderViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/autochess/autochessleaderview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		AutoChessEnum.LeaderItemPath
	}
}
var_0_0.AutoChessLeaderShowView = {
	destroy = 0,
	container = "AutoChessLeaderShowViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/autochess/autochessleadershowview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		AutoChessEnum.LeaderCardPath
	}
}
var_0_0.AutoChessLeaderNextView = {
	destroy = 0,
	container = "AutoChessLeaderNextViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/autochess/autochessleadernextview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		AutoChessEnum.LeaderItemPath
	}
}
var_0_0.AutoChessCourseView = {
	destroy = 0,
	container = "AutoChessCourseViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/autochess/autochesscourseview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		AutoChessEnum.BadgeItemPath
	}
}
var_0_0.AutoChessBadgeView = {
	destroy = 0,
	container = "AutoChessBadgeViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/autochess/autochessbadgeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		AutoChessEnum.BadgeItemPath
	}
}
var_0_0.AutoChessLevelView = {
	destroy = 0,
	container = "AutoChessLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/autochess/autochesslevelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		AutoChessEnum.LevelItemPath
	}
}
var_0_0.AutoChessTaskView = {
	destroy = 0,
	container = "AutoChessTaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/autochess/autochesstaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		AutoChessTaskItem.prefabPath
	}
}
var_0_0.AutoChessRankUpView = {
	destroy = 0,
	container = "AutoChessRankUpViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/autochess/autochessbadgeupgradeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		AutoChessEnum.BadgeItemPath
	}
}
var_0_0.AutoChessGameView = {
	destroy = 0,
	container = "AutoChessGameViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochessgameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		AutoChessEnum.ChessEntityPath,
		AutoChessEnum.ChessLeaderEntityPath
	}
}
var_0_0.AutoChessForcePickView = {
	destroy = 0,
	container = "AutoChessForcePickViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochessforcepickview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		AutoChessEnum.ChessCardPath
	}
}
var_0_0.AutoChessMallView = {
	destroy = 0,
	container = "AutoChessMallViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochessmallview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.AutoChessMallInfoView = {
	destroy = 0,
	container = "AutoChessMallInfoViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochessmallinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		AutoChessEnum.ChessCardPath
	}
}
var_0_0.AutoChessMallLevelUpView = {
	destroy = 0,
	container = "AutoChessMallLevelUpViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochessstorelevelup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
var_0_0.AutoChessResultView = {
	destroy = 0,
	container = "AutoChessResultViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochessresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
var_0_0.AutoChessPvpSettleView = {
	destroy = 0,
	container = "AutoChessPvpSettleViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochesspvpsettleview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		AutoChessEnum.BadgeItemPath
	}
}
var_0_0.AutoChessPveSettleView = {
	destroy = 0,
	container = "AutoChessPveSettleViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochesspvesettleview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.AutoChessPveFirstSettleView = {
	destroy = 0,
	container = "AutoChessPveFirstSettleViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochesspvefirstsettleview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
var_0_0.AutoChessStartFightView = {
	destroy = 0,
	container = "AutoChessStartFightViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/autochess/autochessenteranimview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.VersionActivity2_5EnterView = {
	destroy = 0,
	container = "VersionActivity2_5EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/v2a5_enter/v2a5_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_2_5/v2a5_enter/v2a5_dungeonenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_5/v2a5_reprint/v2a5_v1a6reprint_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_5/liangyue/view/v2a5_liangyue_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_5/feilinshiduo/view/v2a5_feilinshiduo_enterview.prefab"
			},
			{
				"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
			},
			{
				"ui/viewres/activity/show/activityweekwalkdeepshowview.prefab"
			},
			{
				"ui/viewres/tower/towermainentryview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_5/v2a5_enter/v2a5_autochess_enterview.prefab"
			}
		}
	}
}
var_0_0.VersionActivity2_5StoreView = {
	destroy = 0,
	container = "VersionActivity2_5StoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/v2a5_dungeon/v2a5_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity2_5TaskView = {
	destroy = 0,
	container = "VersionActivity2_5TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/v2a5_dungeon/v2a5_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_5/v2a5_dungeon/v2a5_taskitem.prefab"
	}
}
var_0_0.VersionActivity2_5DungeonMapView = {
	destroy = 0,
	container = "VersionActivity2_5DungeonMapViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/v2a5_dungeon/v2a5_dungeonmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/versionactivity_2_5/v2a5_dungeon/v2a5_mapepisodeitem.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
		"ui/viewres/versionactivity_2_5/v2a5_dungeon/v2a5_dungeonmap_direction.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity2_5DungeonMapLevelView = {
	destroy = 0,
	container = "VersionActivity2_5DungeonMapLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/v2a5_dungeon/v2a5_dungeonmaplevelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		},
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Act183MainView = {
	destroy = 0,
	container = "Act183MainViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_mainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Act183DungeonView = {
	destroy = 0,
	container = "Act183DungeonViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_dungeonview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Act183TaskView = {
	destroy = 0,
	container = "Act183TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_taskitem.prefab",
		"ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_taskheader.prefab",
		"ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_taskonekeyitem.prefab"
	}
}
var_0_0.Act183BadgeView = {
	destroy = 0,
	container = "Act183BadgeViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_badgeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Act183FinishView = {
	destroy = 0,
	container = "Act183FinishViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_finishview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.Act183SettlementView = {
	destroy = 0,
	container = "Act183SettlementViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_settlementview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Act183ReportView = {
	destroy = 0,
	container = "Act183ReportViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_reportview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_reportitem.prefab"
	}
}
var_0_0.Act183RepressView = {
	destroy = 0,
	container = "Act183RepressViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_repressview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.Act183HeroGroupFightView = {
	bgBlur = 4,
	container = "Act183HeroGroupFightViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_herogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
var_0_0.Act183HeroGroupEditView = {
	container = "Act183HeroGroupEditViewContainer",
	destroy = 5,
	mainRes = "ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_herogroupeditview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_herogroupedititem.prefab",
		[2] = "ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_herogroupquickedititem.prefab"
	},
	customAnimBg = {
		"bg"
	}
}
var_0_0.Act183FightSuccView = {
	destroy = 0,
	container = "Act183FightSuccViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_fightsuccview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.FeiLinShiDuoGameView = {
	destroy = 0,
	container = "FeiLinShiDuoGameViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/feilinshiduo/view/v2a5_feilinshiduogameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_5/feilinshiduo/map/v2a5_feilinshiduogamemap.prefab",
		jump = "ui/viewres/versionactivity_2_5/feilinshiduo/map/element/jump.prefab",
		start = "ui/viewres/versionactivity_2_5/feilinshiduo/map/element/start.prefab",
		option = "ui/viewres/versionactivity_2_5/feilinshiduo/map/element/option.prefab",
		wall = "ui/viewres/versionactivity_2_5/feilinshiduo/map/element/wall.prefab",
		target = "ui/viewres/versionactivity_2_5/feilinshiduo/map/element/target.prefab",
		box = "ui/viewres/versionactivity_2_5/feilinshiduo/map/element/box.prefab",
		door = "ui/viewres/versionactivity_2_5/feilinshiduo/map/element/door.prefab",
		colorplane = "ui/viewres/versionactivity_2_5/feilinshiduo/map/element/colorplane.prefab",
		trap = "ui/viewres/versionactivity_2_5/feilinshiduo/map/element/trap.prefab",
		stair = "ui/viewres/versionactivity_2_5/feilinshiduo/map/element/stair.prefab"
	}
}
var_0_0.FeiLinShiDuoEpisodeLevelView = {
	destroy = 0,
	container = "FeiLinShiDuoEpisodeLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/feilinshiduo/view/v2a5_feilinshiduo_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_5/feilinshiduo/view/v2a5_feilinshiduo_levelviewstageitem.prefab"
	}
}
var_0_0.FeiLinShiDuoTaskView = {
	destroy = 0,
	container = "FeiLinShiDuoTaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/feilinshiduo/view/v2a5_feilinshiduo_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_5/feilinshiduo/view/v2a5_feilinshiduo_taskitem.prefab"
	}
}
var_0_0.FeiLinShiDuoResultView = {
	destroy = 0,
	container = "FeiLinShiDuoResultViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/feilinshiduo/view/v2a5_feilinshiduo_resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.LinkageActivity_PanelView = {
	destroy = 0,
	container = "LinkageActivity_PanelViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/linkageactivity_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.LinkageActivity_FullView = {
	destroy = 0,
	container = "LinkageActivity_FullViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/linkageactivity_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.V2a3_WarmUp = {
	destroy = 0,
	container = "V2a3_WarmUpContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v2a3_warmup/v2a3_warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	preloader = module_views_preloader
}
var_0_0.V2a3_Special_FullSignView = {
	destroy = 0,
	container = "V2a3_Special_FullSignViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a3_special_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.V2a3_Special_PanelsView = {
	destroy = 0,
	container = "V2a3_Special_PanelsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a3_special_panelsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.Activity181MainView = {
	destroy = 0,
	container = "Activity181MainViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_actxmasview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.Activity181RewardView = {
	destroy = 0,
	container = "Activity181RewardViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_actxmasrewardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.V2a4_Role_FullSignView_Part1 = {
	destroy = 0,
	container = "V2a4_Role_FullSignView_Part1_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a4_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a4_role_signitem.prefab"
	}
}
var_0_0.V2a4_Role_FullSignView_Part2 = {
	destroy = 0,
	container = "V2a4_Role_FullSignView_Part2_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a4_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a4_role_signitem.prefab"
	}
}
var_0_0.V2a4_Role_PanelSignView_Part1 = {
	destroy = 0,
	container = "V2a4_Role_PanelSignView_Part1_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a4_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a4_role_signitem.prefab"
	}
}
var_0_0.V2a4_Role_PanelSignView_Part2 = {
	destroy = 0,
	container = "V2a4_Role_PanelSignView_Part2_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a4_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a4_role_signitem.prefab"
	}
}
var_0_0.V2a4_WarmUp = {
	destroy = 0,
	container = "V2a4_WarmUpContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v2a4_warmup/v2a4_warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.V2a4_WarmUp_DialogueView = {
	destroy = 0,
	container = "V2a4_WarmUp_DialogueViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v2a4_warmup/v2a4_warmup_dialogueview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.V2a4_WarmUp_TaskView = {
	destroy = 0,
	container = "V2a4_WarmUp_TaskViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v2a4_warmup/v2a4_warmup_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/v2a4_warmup/v2a4_warmup_taskitem.prefab"
	}
}
var_0_0.V2a4_WarmUp_ResultView = {
	destroy = 0,
	container = "V2a4_WarmUp_ResultViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v2a4_warmup/v2a4_warmup_resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.LiangYueGameView = {
	bgBlur = 1,
	container = "LiangYueGameViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_5/liangyue/view/v2a5_liangyue_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_5/liangyue/view/v2a5_liangyuemeshitem.prefab",
		[2] = "ui/viewres/versionactivity_2_5/liangyue/view/v2a5_liangyuechessitem.prefab"
	}
}
var_0_0.LiangYueLevelView = {
	destroy = 0,
	container = "LiangYueLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/liangyue/view/v2a5_liangyue_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_5/liangyue/view/v2a5_liangyue_levelviewstageitem.prefab"
	}
}
var_0_0.LiangYueTaskView = {
	destroy = 0,
	container = "LiangYueTaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/liangyue/view/v2a5_liangyue_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_5/liangyue/view/v2a5_liangyue_taskitem.prefab"
	}
}
var_0_0.V2a5_Role_FullSignView_Part1 = {
	destroy = 0,
	container = "V2a5_Role_FullSignView_Part1_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a5_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a5_role_signitem.prefab"
	}
}
var_0_0.V2a5_Role_FullSignView_Part2 = {
	destroy = 0,
	container = "V2a5_Role_FullSignView_Part2_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a5_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a5_role_signitem.prefab"
	}
}
var_0_0.V2a5_Role_PanelSignView_Part1 = {
	destroy = 0,
	container = "V2a5_Role_PanelSignView_Part1_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a5_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a5_role_signitem.prefab"
	}
}
var_0_0.V2a5_Role_PanelSignView_Part2 = {
	destroy = 0,
	container = "V2a5_Role_PanelSignView_Part2_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a5_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a5_role_signitem.prefab"
	}
}
var_0_0.ActivityInsightShowView_2_5 = {
	destroy = 0,
	container = "ActivityInsightShowView_2_5Container",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_5/v2a5_newinsight/v2a5_activityinsightshowview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.Activity186View = {
	destroy = 0,
	container = "Activity186ViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_5/act186/activity186view.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Activity186EffectView = {
	destroy = 0,
	container = "Activity186EffectViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_5/act186/activity186effectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.Activity186GiftView = {
	destroy = 0,
	container = "Activity186GiftViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/act186/activity186giftview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.Activity186GameInviteView = {
	destroy = 0,
	container = "Activity186GameInviteViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/act186/activity186gameinviteview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.Activity186GameDrawlotsView = {
	destroy = 0,
	container = "Activity186GameDrawlotsViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_5/act186/activity186gamedrawlotsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.Activity186TaskView = {
	bgBlur = 0,
	container = "Activity186TaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_5/act186/activity186taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		itemRes = "ui/viewres/versionactivity_2_5/act186/activity186taskitem.prefab"
	}
}
var_0_0.Activity186SignView = {
	bgBlur = 0,
	container = "Activity186SignViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_5/act186/activity186signview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		itemRes = "ui/viewres/versionactivity_2_5/act186/activity186signitem.prefab"
	}
}
var_0_0.Activity186GameBiscuitsView = {
	destroy = 0,
	container = "Activity186GameBiscuitsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/act186/activity186gamebiscuitsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.LifeCirclePickChoice = {
	destroy = 0,
	container = "LifeCirclePickChoiceContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/lifecircle/lifecirclepickchoice.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.LifeCircleRewardView = {
	destroy = 0,
	container = "LifeCircleRewardViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/lifecircle/lifecirclerewardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/common/commonpropitem.prefab"
	}
}
var_0_0.Activity187View = {
	destroy = 0,
	container = "Activity187ViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/v2a5_lanternfestival/v2a5_lanternfestival.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.V2a5DecalogPresentView = {
	destroy = 0,
	container = "V2a5DecalogPresentViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/v2a5_versionsummon.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.V2a5DecalogPresentFullView = {
	destroy = 0,
	container = "V2a5DecalogPresentFullViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/v2a5_versionsummonfull.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.V2a5_DecorateStoreView = {
	destroy = 0,
	container = "V2a5_DecorateStoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a5_decoratestore_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
var_0_0.V2a5_DecorateStoreFullView = {
	destroy = 0,
	container = "V2a5_DecorateStoreFullViewContainer",
	mainRes = "ui/viewres/activity/v2a5_decoratestore_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.V2a5_GoldenMilletPresentView = {
	destroy = 0,
	container = "V2a5_GoldenMilletPresentViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/v2a5_goldenmilletpresent.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.V2a5_GoldenMilletPresentFullView = {
	destroy = 0,
	container = "V2a5_GoldenMilletPresentFullViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/v2a5_goldenmilletpresentfull.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
var_0_0.V2a5_WarmUp = {
	destroy = 0,
	container = "V2a5_WarmUpContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v2a5_warmup/v2a5_warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.VersionActivity2_6EnterView = {
	destroy = 0,
	container = "VersionActivity2_6EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_2_6/v2a6_enter/v2a6_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_2_4/v2a4_reprint/v2a4_v1a8reprint_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_6/v2a6_enter/v2a6_dungeonenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_6/dicehero/v2a6_dicehero_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_6/v2a6_xugouji/v2a6_xugouji_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_6/v2a6_rouge/v2a6_rouge_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_enterview.prefab"
			},
			{
				"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_6/v2a6_season/v2a6_season_enterview.prefab"
			},
			{
				"ui/viewres/activity/show/activityweekwalkdeepshowview.prefab"
			},
			{
				"ui/viewres/tower/towermainentryview.prefab"
			},
			{
				"ui/viewres/activity/show/activiyweekwalkheartshowview.prefab"
			}
		}
	}
}
var_0_0.VersionActivity2_6StoreView = {
	destroy = 0,
	container = "VersionActivity2_6StoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_6/v2a6_dungeon/v2a6_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
var_0_0.VersionActivity2_6TaskView = {
	destroy = 0,
	container = "VersionActivity2_6TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_6/v2a6_dungeon/v2a6_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_6/v2a6_dungeon/v2a6_taskitem.prefab"
	}
}

DiceHeroViewDefine.init(var_0_0)

var_0_0.XugoujiLevelView = {
	destroy = 0,
	container = "XugoujiLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_6/v2a6_xugouji/v2a6_xugouji_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_6/v2a6_xugouji/v2a6_xugouji_levelitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.XugoujiTaskView = {
	bgBlur = 0,
	container = "XugoujiTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_6/v2a6_xugouji/v2a6_xugouji_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_6/v2a6_xugouji/v2a6_xugouji_taskitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.XugoujiGameView = {
	destroy = 0,
	container = "XugoujiGameViewContainer",
	mainRes = "ui/viewres/versionactivity_2_6/v2a6_xugouji/v2a6_xugouji_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.XugoujiGameResultView = {
	destroy = 0,
	container = "XugoujiGameResultViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/versionactivity_2_6/v2a6_xugouji/v2a6_xugouji_resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
var_0_0.XugoujiCardInfoView = {
	destroy = 0,
	container = "XugoujiCardInfoViewContainer",
	mainRes = "ui/viewres/versionactivity_2_6/v2a6_xugouji/v2a6_xugouji_skilltips.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
var_0_0.ShortenAct_FullView = {
	destroy = 0,
	container = "ShortenAct_FullViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/shortenact_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/shortenact_taskitem.prefab"
	}
}
var_0_0.ShortenAct_PanelView = {
	destroy = 0,
	container = "ShortenAct_PanelViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/shortenact_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/shortenact_taskitem.prefab"
	}
}
var_0_0.V2a6_WeekwalkHeart_FullView = {
	destroy = 0,
	container = "V2a6_WeekwalkHeart_FullViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a6_weekwalkheart_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.V2a6_WeekwalkHeart_PanelView = {
	destroy = 0,
	container = "V2a6_WeekwalkHeart_PanelViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a6_weekwalkheart_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.ActivityInsightShowView_2_6 = {
	destroy = 0,
	container = "ActivityInsightShowView_2_6Container",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_6/v2a6_newinsight/v2a6_activityinsightshowview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
var_0_0.V2a6_WarmUp = {
	destroy = 0,
	container = "V2a6_WarmUpContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v2a6_warmup/v2a6_warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}

local var_0_1 = {}

for iter_0_0, iter_0_1 in pairs(var_0_0) do
	if iter_0_0 ~= "StoryBackgroundView" and iter_0_1.layer == "POPUP" then
		iter_0_1.layer = "POPUP_TOP"
	end

	var_0_1[iter_0_0] = iter_0_0
end

setGlobal("ViewName", var_0_1)

return var_0_0
