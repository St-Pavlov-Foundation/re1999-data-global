module("modules.logic.season.defines.SeasonViewDefine", package.seeall)

local var_0_0 = class("SeasonViewDefine")

function var_0_0.init(arg_1_0)
	var_0_0.initDefine3_0(arg_1_0)
end

function var_0_0.initDefine3_0(arg_2_0)
	arg_2_0.Season3_0MainView = {
		destroy = 0,
		container = "Season3_0MainViewContainer",
		mainRes = "ui/viewres/v3a0_season/seasonmainview.prefab",
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
			role5 = "scenes/v3a0_m_s15_sj/perfab/m_s15_sj_qz_karong.prefab",
			section4 = "scenes/v3a0_m_s15_sj/scene_prefab/v3a0_m_s15_section04.prefab",
			scene = "scenes/v3a0_m_s15_sj/scene_prefab/v3a0_m_s15_background_a.prefab",
			section1 = "scenes/v3a0_m_s15_sj/scene_prefab/v3a0_m_s15_section01.prefab",
			role3 = "scenes/v3a0_m_s15_sj/perfab/m_s15_sj_qz_shaoxiao.prefab",
			role6 = "scenes/v3a0_m_s15_sj/perfab/m_s15_sj_qz_weierting.prefab",
			section3 = "scenes/v3a0_m_s15_sj/scene_prefab/v3a0_m_s15_section03.prefab",
			role1 = "scenes/v3a0_m_s15_sj/perfab/m_s15_sj_qz_aiguozhe.prefab",
			role4 = "scenes/v3a0_m_s15_sj/perfab/m_s15_sj_qz_14.prefab",
			section5 = "scenes/v3a0_m_s15_sj/scene_prefab/v3a0_m_s15_section05.prefab",
			section2 = "scenes/v3a0_m_s15_sj/scene_prefab/v3a0_m_s15_section02.prefab",
			role2 = "scenes/v3a0_m_s15_sj/perfab/m_s15_sj_qz_hongnujian.prefab"
		}
	}
	arg_2_0.Season3_0MarketView = {
		destroy = 0,
		container = "Season3_0MarketViewContainer",
		bgBlur = 4,
		mainRes = "ui/viewres/v3a0_season/seasonmarketview.prefab",
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
	arg_2_0.Season3_0SpecialMarketView = {
		destroy = 0,
		container = "Season3_0SpecialMarketViewContainer",
		bgBlur = 4,
		mainRes = "ui/viewres/v3a0_season/seasonspecialmarketview.prefab",
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
	arg_2_0.Season3_0RetailView = {
		destroy = 0,
		container = "Season3_0RetailViewContainer",
		mainRes = "ui/viewres/v3a0_season/seasonretailview.prefab",
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
	arg_2_0.Season3_0RetailLevelInfoView = {
		destroy = 0,
		container = "Season3_0RetailLevelInfoViewContainer",
		mainRes = "ui/viewres/v3a0_season/seasonretaillevelinfoview.prefab",
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
	arg_2_0.Season3_0TaskView = {
		destroy = 0,
		container = "Season3_0TaskViewContainer",
		mainRes = "ui/viewres/v3a0_season/seasontaskview.prefab",
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
			[1] = "ui/viewres/v3a0_season/seasontaskitem.prefab"
		}
	}
	arg_2_0.Season3_0SettlementView = {
		destroy = 0,
		container = "Season3_0SettlementViewContainer",
		mainRes = "ui/viewres/v3a0_season/seasonsettlementview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {
			itemRes = "ui/viewres/v3a0_season/seasonsettlementherogroupitem.prefab"
		}
	}
	arg_2_0.Season3_0CelebrityCardGetlView = {
		destroy = 0,
		container = "Season3_0CelebrityCardGetlViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/v3a0_season/seasoncelebritycardgetlview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	arg_2_0.Season3_0EquipView = {
		bgBlur = 0,
		container = "Season3_0EquipViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/v3a0_season/seasonequipview.prefab",
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
			[1] = "ui/viewres/v3a0_season/seasonequipcarditem.prefab",
			[2] = "ui/viewres/v3a0_season/seasoncelebritycarditem.prefab"
		}
	}
	arg_2_0.Season3_0EquipHeroView = {
		bgBlur = 0,
		container = "Season3_0EquipHeroViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/v3a0_season/seasonequipheroview.prefab",
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
			[1] = "ui/viewres/v3a0_season/seasonequipcarditem.prefab",
			[2] = "ui/viewres/v3a0_season/seasoncelebritycarditem.prefab"
		}
	}
	arg_2_0.Season3_0FightFailView = {
		destroy = 0,
		container = "Season3_0FightFailViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/v3a0_season/seasonfightfailview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	arg_2_0.Season3_0FightSuccView = {
		destroy = 0,
		container = "Season3_0FightSuccViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/v3a0_season/seasonfightsuccview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	arg_2_0.Season3_0StoreView = {
		destroy = 0,
		container = "Season3_0StoreViewContainer",
		mainRes = "ui/viewres/v3a0_season/seasonstoreview.prefab",
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
			itemPath = "ui/viewres/v3a0_season/seasonstoreitem.prefab"
		}
	}
	arg_2_0.Season3_0EquipSelfChoiceView = {
		destroy = 0,
		container = "Season3_0EquipSelfChoiceViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/v3a0_season/seasonmulticardchoiceview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/v3a0_season/seasonmulticardchoiceitem.prefab",
			[2] = "ui/viewres/v3a0_season/seasoncelebritycarditem.prefab"
		}
	}
	arg_2_0.Season3_0CelebrityCardTipView = {
		container = "Season3_0CelebrityCardTipViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/v3a0_season/seasoncelebritycardtipview.prefab",
		destroy = 0,
		blurIterations = 3,
		blurFactor = 0.85,
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		desampleRate = PostProcessingMgr.DesamplingRate.x8,
		reduceRate = PostProcessingMgr.DesamplingRate.x8,
		otherRes = {
			[1] = "ui/viewres/v3a0_season/seasoncelebritycarditem.prefab"
		}
	}
	arg_2_0.Season3_0EquipComposeView = {
		bgBlur = 0,
		container = "Season3_0EquipComposeViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/v3a0_season/seasonequipcomposeview.prefab",
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
			[1] = "ui/viewres/v3a0_season/seasonequipcomposeitem.prefab",
			[2] = "ui/viewres/v3a0_season/seasoncelebritycarditem.prefab"
		}
	}
	arg_2_0.Season3_0EquipBookView = {
		bgBlur = 0,
		container = "Season3_0EquipBookViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/v3a0_season/seasonequipbookview.prefab",
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
			[1] = "ui/viewres/v3a0_season/seasonequipbookitem.prefab",
			[2] = "ui/viewres/v3a0_season/seasoncelebritycarditem.prefab"
		}
	}
	arg_2_0.Season3_0FightRuleTipView = {
		destroy = 0,
		container = "Season3_0FightRuleTipViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/v3a0_season/seasonfightruletipview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					"ui/viewres/v3a0_season/seasonfightruleview.prefab"
				},
				{
					"ui/viewres/v3a0_season/seasonfightcardview.prefab"
				}
			}
		}
	}
	arg_2_0.Season3_0HeroGroupFightView = {
		bgBlur = 4,
		container = "Season3_0HeroGroupFightViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/v3a0_season/seasonherogroupview.prefab",
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
	arg_2_0.Season3_0AdditionRuleTipView = {
		destroy = 0,
		container = "Season3_0AdditionRuleTipViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/v3a0_season/seasonadditionruletipview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	arg_2_0.Season3_0SumView = {
		destroy = 0,
		container = "Season3_0SumViewContainer",
		bgBlur = 3,
		mainRes = "ui/viewres/v3a0_season/seasonsumview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	arg_2_0.Season3_0StoryView = {
		destroy = 0,
		container = "Season3_0StoryViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/v3a0_season/seasonstoryview.prefab",
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
	arg_2_0.Season3_0StoryPagePopView = {
		destroy = 0,
		container = "Season3_0StoryPagePopViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/v3a0_season/seasonstorypagepopview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
end

return var_0_0
