-- chunkname: @modules/logic/bossrush/view/BossRushDefine.lua

module("modules.logic.bossrush.view.BossRushDefine", package.seeall)

local BossRushDefine = {}

function BossRushDefine.init(module_views)
	module_views.V2a9_BossRushHeroGroupFightView = {
		bgBlur = 4,
		container = "V2a9_BossRushHeroGroupFightViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/sp01/assassin2/v2a9_herogroupview.prefab",
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
			[1] = "ui/viewres/fight/clothskill.prefab",
			[2] = "ui/viewres/sp01/assassin2/v2a9_herogroupskillview.prefab"
		}
	}
	module_views.V2a9_BossRushSkillBackpackView = {
		destroy = 0,
		container = "V2a9_BossRushSkillBackpackViewContainer",
		mainRes = "ui/viewres/sp01/assassin2/assassinbackpackview.prefab",
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
	module_views.V3a2_BossRush_MainView = {
		bgBlur = 0,
		container = "V3a2_BossRush_MainViewContainer",
		destroy = 0,
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		mainRes = BossRushEnum.ResPath.v3a2_bossrush_mainview,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			BossRushEnum.ResPath.v1a4_bossrush_mainview_assessicon,
			BossRushEnum.ResPath.v3a2_bossrush_rankbtn
		}
	}
	module_views.V3a2_BossRush_LevelDetailView = {
		bgBlur = 0,
		container = "V3a2_BossRush_LevelDetailViewContainer",
		destroy = 0,
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		mainRes = BossRushEnum.ResPath.v3a2_bossrush_leveldetail,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			BossRushEnum.ResPath.v1a4_bossrush_leveldetail_assessicon,
			BossRushEnum.ResPath.v1a4_bossrushleveldetail_spine,
			[4] = BossRushEnum.ResPath.v3a2_bossrush_strategyitem
		},
		preloader = module_views_preloader
	}
	module_views.V3a2_BossRush_HandBookView = {
		bgBlur = 0,
		container = "V3a2_BossRush_HandBookViewContainer",
		destroy = 0,
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		mainRes = BossRushEnum.ResPath.v3a2_bossrush_handbookview,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			BossRushEnum.ResPath.v3a2_bossrush_handbookitem,
			BossRushEnum.ResPath.v3a2_bossrush_rankbtn,
			BossRushEnum.ResPath.v3a2_bossrush_strategyitem
		}
	}
	module_views.V3a2_BossRush_RankView = {
		bgBlur = 0,
		container = "V3a2_BossRush_RankViewContainer",
		destroy = 0,
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		mainRes = BossRushEnum.ResPath.v3a2_bossrush_rankview,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			BossRushEnum.ResPath.v3a2_bossrush_rankbonus
		}
	}
	module_views.V3a2_BossRush_ResultView = {
		bgBlur = 1,
		container = "V3a2_BossRush_ResultViewContainer",
		destroy = 0,
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		mainRes = BossRushEnum.ResPath.v3a2_bossrush_resultview,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			BossRushEnum.ResPath.v1a4_bossrush_result_assess,
			BossRushEnum.ResPath.v1a4_bossrush_herogroup,
			BossRushEnum.ResPath.v1a4_bossrush_herogroupitem1,
			BossRushEnum.ResPath.v1a4_bossrush_herogroupitem2
		}
	}
	module_views.V3a2_BossRush_ResultPanel = {
		destroy = 0,
		container = "V3a2_BossRush_ResultPanelContainer",
		bgBlur = 1,
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		mainRes = BossRushEnum.ResPath.v3a2_bossrush_resultpanel,
		otherRes = {
			BossRushEnum.ResPath.v3a2_bossrush_resultassess,
			BossRushEnum.ResPath.v1a4_bossrush_result_assess
		}
	}
end

return BossRushDefine
