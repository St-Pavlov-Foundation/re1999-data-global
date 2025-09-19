module("modules.logic.survival.define.SurvivalViewDefine", package.seeall)

local var_0_0 = class("SurvivalViewDefine")

function var_0_0.init(arg_1_0)
	var_0_0.initMapDefine(arg_1_0)
	var_0_0.initShelterDefine(arg_1_0)

	arg_1_0.SurvivalTalentView = {
		bgBlur = 1,
		container = "SurvivalTalentViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/survival/map/survivaltalentview.prefab",
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
			itemRes = "ui/viewres/survival/map/survivalmapbagitem.prefab",
			infoView = "ui/viewres/survival/map/survivaltalentinfoview.prefab"
		}
	}
	arg_1_0.SurvivalTalentOverView = {
		destroy = 0,
		container = "SurvivalTalentOverViewContainer",
		bgBlur = 4,
		mainRes = "ui/viewres/survival/map/survivaltalentoverview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	arg_1_0.SurvivalView = {
		destroy = 0,
		container = "SurvivalViewContainer",
		mainRes = "ui/viewres/survival/map/survivalview.prefab",
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
			itemRes = "ui/viewres/survival/map/survivalmapbagitem.prefab",
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab"
		}
	}
	arg_1_0.SurvivalShelterRewardView = {
		bgBlur = 0,
		container = "SurvivalShelterRewardViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/survival/shelter/survivalshelterrewardview.prefab",
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
			itemRes = "ui/viewres/survival/shelter/survivalshelterrewarditem.prefab"
		}
	}
	arg_1_0.SurvivalItemInfoView = {
		destroy = 0,
		container = "SurvivalItemInfoViewContainer",
		mainRes = "ui/viewres/survival/map/survivalmapbaginfoview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	arg_1_0.SurvivalCurrencyTipView = {
		destroy = 0,
		container = "SurvivalCurrencyTipViewContainer",
		mainRes = "ui/viewres/survival/map/survivalcurrencytipview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
end

function var_0_0.initMapDefine(arg_2_0)
	arg_2_0.SurvivalMapMainView = {
		destroy = 0,
		container = "SurvivalMapMainViewContainer",
		mainRes = "ui/viewres/survival/map/survivalmapmainview.prefab",
		layer = "HUD",
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
			itemRes = "ui/viewres/survival/map/survivalmapbagitem.prefab",
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab",
			unititem = "ui/viewres/survival/map/survivalmapunititem.prefab"
		}
	}
	arg_2_0.SurvivalMapEventView = {
		destroy = 0,
		container = "SurvivalMapEventViewContainer",
		bgBlur = 4,
		mainRes = "ui/viewres/survival/map/survivaleventview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Internal,
		otherRes = {
			itemRes = "ui/viewres/survival/map/survivalmapbagitem.prefab",
			cameraRes = "survival/common/survivalcamera.prefab",
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab"
		}
	}
	arg_2_0.SurvivalMapSearchView = {
		destroy = 0,
		container = "SurvivalMapSearchViewContainer",
		bgBlur = 4,
		mainRes = "ui/viewres/survival/map/survivalmapsearchview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab",
			itemRes = "ui/viewres/survival/map/survivalmapbagitem.prefab"
		}
	}
	arg_2_0.SurvivalMapBagView = {
		destroy = 0,
		container = "SurvivalMapBagViewContainer",
		bgBlur = 4,
		mainRes = "ui/viewres/survival/map/survivalmapbagview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Internal,
		otherRes = {
			itemRes = "ui/viewres/survival/map/survivalmapbagitem.prefab",
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab"
		}
	}
	arg_2_0.SurvivalMapResultView = {
		destroy = 0,
		container = "SurvivalMapResultViewContainer",
		bgBlur = 4,
		mainRes = "ui/viewres/survival/map/survivalmapresultview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {
			itemRes = "ui/viewres/survival/map/survivalmapbagitem.prefab",
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab"
		}
	}
	arg_2_0.SurvivalMapResultPanelView = {
		destroy = 0,
		container = "SurvivalMapResultPanelViewContainer",
		maskAlpha = 0,
		mainRes = "ui/viewres/survival/map/survivalmapresultpanelview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	arg_2_0.SurvivalInitTeamView = {
		bgBlur = 1,
		container = "SurvivalInitTeamViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/survival/map/survivalinitteamview.prefab",
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
			initNpcItemSmall = "ui/viewres/survival/map/survivalinitnpcsmallitem.prefab",
			initHeroItem = "ui/viewres/survival/map/survivalinitheroitem.prefab",
			initHeroItemSmall = "ui/viewres/survival/map/survivalinitherosmallitem.prefab",
			initNpcItem = "ui/viewres/survival/map/survivalinitnpcitem.prefab"
		}
	}
	arg_2_0.SurvivalMapTeamView = {
		bgBlur = 4,
		container = "SurvivalMapTeamViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/survival/map/survivalmapteamview.prefab",
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
			initNpcItemSmall = "ui/viewres/survival/map/survivalinitnpcsmallitem.prefab",
			initHeroItemSmall = "ui/viewres/survival/map/survivalinitherosmallitem.prefab",
			infoView = "ui/viewres/survival/map/survivalpartnermanageinfoview.prefab"
		}
	}
	arg_2_0.SurvivalNPCSelectView = {
		destroy = 0,
		container = "SurvivalNPCSelectViewContainer",
		mainRes = "ui/viewres/survival/map/survivalnpcselectview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {
			infoView = "ui/viewres/survival/map/survivalpartnermanageinfoview.prefab"
		}
	}
	arg_2_0.SurvivalPickAssistView = {
		destroy = 0,
		container = "SurvivalPickAssistViewContainer",
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
	arg_2_0.SurvivalInitHeroSelectView = {
		container = "SurvivalInitHeroSelectViewContainer",
		destroy = 5,
		mainRes = "ui/viewres/survival/map/survivalinitselectheroeditview.prefab",
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
			[1] = "ui/viewres/survival/map/survivalherogroupedititem.prefab",
			[2] = "ui/viewres/survival/map/survivalherogroupquickedititem.prefab"
		},
		customAnimBg = {
			"bg"
		}
	}
	arg_2_0.SurvivalLoadingView = {
		destroy = 0,
		container = "SurvivalLoadingViewContainer",
		mainRes = "ui/viewres/survival/map/survivalloadingview.prefab",
		layer = "TOP",
		viewType = ViewType.Full,
		otherRes = {
			[1] = "singlebg/survival_singlebg/loading/survival_loading_fullbg.png"
		}
	}
	arg_2_0.SurvivalSmallMapView = {
		destroy = 0,
		container = "SurvivalSmallMapViewContainer",
		bgBlur = 4,
		mainRes = "ui/viewres/survival/map/survivalsmallmapview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
	arg_2_0.SurvivalToastView = {
		destroy = 0,
		container = "SurvivalToastViewContainer",
		mainRes = "ui/viewres/survival/map/survivaltoastview.prefab",
		layer = "MESSAGE",
		viewType = ViewType.Normal
	}
	arg_2_0.SurvivalLogView = {
		bgBlur = 4,
		container = "SurvivalLogViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/survival/map/survivalmaploginfoview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
	arg_2_0.SurvivalCommitItemView = {
		bgBlur = 4,
		container = "SurvivalCommitItemViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/survival/map/survivalcommititemview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Internal,
		otherRes = {
			itemRes = "ui/viewres/survival/map/survivalmapbagitem.prefab",
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab"
		}
	}
	arg_2_0.SurvivalHeroGroupFightView = {
		bgBlur = 4,
		container = "SurvivalHeroGroupFightViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/survival/map/survivalherogroupview.prefab",
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
	arg_2_0.SurvivalHeroGroupEditView = {
		container = "SurvivalHeroGroupEditViewContainer",
		destroy = 5,
		mainRes = "ui/viewres/survival/map/survivalherogroupeditview.prefab",
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
			[1] = "ui/viewres/survival/map/survivalherogroupedititem.prefab",
			[2] = "ui/viewres/survival/map/survivalherogroupquickedititem.prefab"
		},
		customAnimBg = {
			"bg"
		}
	}
	arg_2_0.SurvivalTalentGetView = {
		destroy = 0,
		container = "SurvivalTalentGetViewContainer",
		maskAlpha = 0,
		mainRes = "ui/viewres/survival/map/survivaltalentrewardview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
	arg_2_0.SurvivalDropSelectView = {
		destroy = 0,
		container = "SurvivalDropSelectViewContainer",
		maskAlpha = 0,
		mainRes = "ui/viewres/survival/map/survivalrewardchooseview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		otherRes = {
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab"
		}
	}
	arg_2_0.SurvivalShopView = {
		bgBlur = 4,
		container = "SurvivalShopViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/survival/map/survivalshopview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Internal,
		otherRes = {
			itemRes = "ui/viewres/survival/map/survivalmapbagitem.prefab",
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab"
		}
	}
	arg_2_0.SurvivalGetRewardView = {
		destroy = 0,
		container = "SurvivalGetRewardViewContainer",
		maskAlpha = 0,
		mainRes = "ui/viewres/survival/map/survivalrewardchooseview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		otherRes = {
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab"
		}
	}
end

function var_0_0.initShelterDefine(arg_3_0)
	arg_3_0.SurvivalMainView = {
		destroy = 0,
		container = "SurvivalMainViewContainer",
		mainRes = "ui/viewres/survival/shelter/survivalmainview.prefab",
		layer = "HUD",
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
			unititem = "ui/viewres/survival/shelter/survivalshelterunititem.prefab"
		}
	}
	arg_3_0.SurvivalHardView = {
		destroy = 0,
		container = "SurvivalHardViewContainer",
		mainRes = "ui/viewres/survival/map/survivalselectdifficultyview.prefab",
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
	arg_3_0.SurvivalSelectTalentTreeView = {
		destroy = 0,
		container = "SurvivalSelectTalentTreeViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/survival/shelter/survivalceremonyopeningview.prefab",
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
	arg_3_0.SurvivalEquipView = {
		bgBlur = 4,
		container = "SurvivalEquipViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/survival/shelter/survivalequipview.prefab",
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
			itemRes = "ui/viewres/survival/map/survivalmapbagitem.prefab",
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab"
		}
	}
	arg_3_0.SurvivalEquipOverView = {
		destroy = 0,
		container = "SurvivalEquipOverViewContainer",
		bgBlur = 4,
		mainRes = "ui/viewres/survival/shelter/survivalequipoverview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {
			itemRes = "ui/viewres/survival/map/survivalmapbagitem.prefab",
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab"
		}
	}
	arg_3_0.ShelterHeroGroupFightView = {
		bgBlur = 4,
		container = "ShelterHeroGroupFightViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/survival/shelter/survivalherogroupview.prefab",
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
	arg_3_0.ShelterTaskView = {
		destroy = 0,
		container = "ShelterTaskViewContainer",
		mainRes = "ui/viewres/survival/map/survivaltaskview.prefab",
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
			itemRes = "ui/viewres/survival/map/survivalmapbagitem.prefab"
		}
	}
	arg_3_0.ShelterNpcManagerView = {
		destroy = 0,
		container = "ShelterNpcManagerViewContainer",
		mainRes = "ui/viewres/survival/map/survivalpartnermanageview.prefab",
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
			infoView = "ui/viewres/survival/map/survivalpartnermanageinfoview.prefab"
		}
	}
	arg_3_0.ShelterBuildingManagerView = {
		destroy = 0,
		container = "ShelterBuildingManagerViewContainer",
		mainRes = "ui/viewres/survival/map/survivalbuildingmanageview.prefab",
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
			infoView = "ui/viewres/survival/map/survivalpartnermanageinfoview.prefab"
		}
	}
	arg_3_0.ShelterTentManagerView = {
		destroy = 0,
		container = "ShelterTentManagerViewContainer",
		mainRes = "ui/viewres/survival/map/survivaltentmanageview.prefab",
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
			infoView = "ui/viewres/survival/map/survivalpartnermanageinfoview.prefab"
		}
	}
	arg_3_0.ShelterRestManagerView = {
		destroy = 0,
		container = "ShelterRestManagerViewContainer",
		mainRes = "ui/viewres/survival/map/survivalrestmanageview.prefab",
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
			itemRes = "ui/viewres/survival/map/survivalinitheroitem.prefab",
			infoView = "ui/viewres/survival/map/survivalpartnermanageinfoview.prefab"
		}
	}
	arg_3_0.ShelterRestHeroSelectView = {
		container = "ShelterRestHeroSelectViewContainer",
		destroy = 5,
		mainRes = "ui/viewres/survival/map/survivalinitselectheroeditview.prefab",
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
			[1] = "ui/viewres/survival/map/survivalherogroupedititem.prefab",
			[2] = "ui/viewres/survival/map/survivalherogroupquickedititem.prefab"
		},
		customAnimBg = {
			"bg"
		}
	}
	arg_3_0.ShelterMapEventView = {
		destroy = 0,
		container = "ShelterMapEventViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/survival/map/survivaleventview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {
			itemRes = "ui/viewres/survival/map/survivalmapbagitem.prefab",
			cameraRes = "survival/common/survivalcamera.prefab",
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab"
		}
	}
	arg_3_0.SurvivalMonsterEventView = {
		destroy = 0,
		container = "SurvivalMonsterEventViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/survival/map/survivalmonstereventview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	arg_3_0.SurvivalNpcStationView = {
		destroy = 0,
		container = "SurvivalNpcStationViewContainer",
		mainRes = "ui/viewres/survival/map/survivalnpcstationview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
	arg_3_0.SurvivalDecreeView = {
		destroy = 0,
		container = "SurvivalDecreeViewContainer",
		mainRes = "ui/viewres/survival/map/survivaldecreeview.prefab",
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
			itemRes = "ui/viewres/survival/map/survivaldecreeitem.prefab",
			infoView = "ui/viewres/survival/map/survivalpartnermanageinfoview.prefab"
		}
	}
	arg_3_0.SurvivalDecreeSelectView = {
		destroy = 0,
		container = "SurvivalDecreeSelectViewContainer",
		mainRes = "ui/viewres/survival/map/survivaldecreeselectview.prefab",
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
	arg_3_0.SurvivalDecreeVoteView = {
		destroy = 0,
		container = "SurvivalDecreeVoteViewContainer",
		mainRes = "ui/viewres/survival/map/survivaldecreevoteview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			itemRes = "ui/viewres/survival/map/survivaldecreevoteitem.prefab"
		}
	}
	arg_3_0.ShelterMapBagView = {
		destroy = 0,
		container = "ShelterMapBagViewContainer",
		bgBlur = 4,
		mainRes = "ui/viewres/survival/map/survivalmapbagview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Internal,
		otherRes = {
			itemRes = "ui/viewres/survival/map/survivalmapbagitem.prefab",
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab"
		}
	}
	arg_3_0.ShelterHeroWareHouseView = {
		container = "ShelterHeroWareHouseViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/survival/shelter/survivalherowarehouseview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Internal,
		otherRes = {
			itemRes = "ui/viewres/survival/map/survivalherogroupedititem.prefab"
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
	arg_3_0.ShelterRecruitView = {
		destroy = 0,
		container = "ShelterRecruitViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/survival/shelter/survivalshelterrecruitview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	arg_3_0.ShelterCompositeView = {
		bgBlur = 1,
		container = "ShelterCompositeViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/survival/shelter/survivalcompositeview.prefab",
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
			itemRes = "ui/viewres/survival/map/survivalmapbagitem.prefab",
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab"
		}
	}
	arg_3_0.ShelterCompositeSuccessView = {
		bgBlur = 1,
		container = "ShelterCompositeSuccessViewContainer",
		maskAlpha = 0,
		destroy = 0,
		mainRes = "ui/viewres/survival/shelter/survivalcompositesuccessview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab"
		}
	}
	arg_3_0.SurvivalCeremonyClosingView = {
		destroy = 0,
		container = "SurvivalCeremonyClosingViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/survival/shelter/survivalceremonyclosingview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			itemRes = "ui/viewres/survival/map/survivalmapbagitem.prefab"
		}
	}
	arg_3_0.SurvivalBootyChooseView = {
		destroy = 0,
		container = "SurvivalBootyChooseViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/survival/shelter/survivalbootychooseview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			infoView = "ui/viewres/survival/map/survivalpartnermanageinfoview.prefab",
			equipInfoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab",
			equipItemView = "ui/viewres/survival/map/survivalmapbagitem.prefab",
			itemRes = "ui/viewres/survival/map/survivalmapbagitem.prefab"
		}
	}
	arg_3_0.SurvivalReportView = {
		destroy = 0,
		container = "SurvivalReportViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/survival/shelter/survivalreportview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	arg_3_0.SurvivalEventPanelView = {
		destroy = 0,
		container = "SurvivalEventPanelViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/survival/map/survivaleventpanelview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	arg_3_0.SurvivalBossInvadeView = {
		destroy = 0,
		container = "SurvivalBossInvadeViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/survival/map/survivalbossinvadeview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	arg_3_0.SurvivalShelterResultPanelView = {
		destroy = 0,
		container = "SurvivalShelterResultPanelViewContainer",
		maskAlpha = 0,
		mainRes = "ui/viewres/survival/shelter/survivalshelterresultpanelview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
end

return var_0_0
