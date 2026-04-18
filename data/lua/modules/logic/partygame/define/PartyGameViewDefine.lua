-- chunkname: @modules/logic/partygame/define/PartyGameViewDefine.lua

module("modules.logic.partygame.define.PartyGameViewDefine", package.seeall)

local PartyGameViewDefine = class("PartyGameViewDefine")

function PartyGameViewDefine.init(module_views)
	module_views.PartyGameResultView = {
		destroy = 0,
		container = "PartyGameResultViewContainer",
		mainRes = "ui/viewres/partygame/knockout/knockout_result.prefab",
		layer = "TOP",
		viewType = ViewType.Normal
	}
	module_views.PartyGameMatchView = {
		destroy = 0,
		container = "PartyGameMatchViewContainer",
		mainRes = "ui/viewres/partygame/common/common_gamematch.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
	module_views.CoinGrabbingGameGameView = PartyGameViewDefine.GetGameViewParam("CoinGrabbingGameViewContainer", "coingrabbing/coingrabbing_gameview")
	module_views.WayFindingGameView = PartyGameViewDefine.GetGameViewParam("WayFindingGameViewContainer", "wayfinding/wayfinding_gameview")
	module_views.DodgeBulletsGameView = PartyGameViewDefine.GetGameViewParam("DodgeBulletsGameViewContainer", "dodgebullets/dodgebullets_gameview")
	module_views.PedalingPlaidGameView = PartyGameViewDefine.GetGameViewParam("PedalingPlaidGameViewContainer", "pedalingplaid/pedalingplaid_gameview")
	module_views.SnatchTerritoryGameView = PartyGameViewDefine.GetGameViewParam("SnatchTerritoryGameViewContainer", "snatchterritory/snatchterritory_gameview")
	module_views.SnatchPlaidGameView = PartyGameViewDefine.GetGameViewParam("SnatchPlaidGameViewContainer", "snatchplaid/snatchplaid_gameview")
	module_views.SnatchPlaidGameView.otherRes.num = "modules/party_game/game6/prefabs/number.prefab"
	module_views.WoodenManGameView = PartyGameViewDefine.GetGameViewParam("WoodenManGameViewContainer", "woodenman/woodenman_gameview")
	module_views.SecurityGameView = PartyGameViewDefine.GetGameViewParam("SecurityGameViewContainer", "security/security_gameview")
	module_views.DecisionGameView = PartyGameViewDefine.GetGameViewParam("DecisionGameViewContainer", "decision/decision_gameview")
	module_views.JengaGameView = PartyGameViewDefine.GetGameViewParam("JengaGameViewContainer", "jenga/jenga_gameview")
	module_views.FindDoorGameView = PartyGameViewDefine.GetGameViewParam("FindDoorGameViewContainer", "finddoor/finddoor_gameview")
	module_views.SplicingRoadGameView = PartyGameViewDefine.GetGameViewParam("SplicingRoadGameViewContainer", "splicingroad/splicingroad_gameview")
	module_views.CollatingSortGameView = PartyGameViewDefine.GetGameViewParam("CollatingSortGameViewContainer", "collatingsort/collatingsort_gameview")
	module_views.CollatingSortGameView.otherRes.collatingsort_gameball = "ui/viewres/partygame/collatingsort/collatingsort_gameball.prefab"
	module_views.CollatingSortGameView.otherRes.collatingsort_gamelevelitem = "ui/viewres/partygame/collatingsort/collatingsort_gamelevelitem.prefab"
	module_views.CollatingSortGameView.otherRes.collatingsort_gamelevelitembg = "singlebg/v3a4_party_singlebg/v3a4_party_game12_fullbg.png"
	module_views.CollatingSortGameView.otherRes.collatingsort_gameeffect = "ui/viewres/partygame/collatingsort/collatingsort_gameeffect.prefab"
	module_views.FindLoveGameView = PartyGameViewDefine.GetGameViewParam("FindLoveGameViewContainer", "findlove/findlovegameview")
	module_views.WhichMoreGameView = PartyGameViewDefine.GetGameViewParam("WhichMoreGameViewContainer", "whichmore/whichmoregameview")
	module_views.SnatchAreaGameView = PartyGameViewDefine.GetGameViewParam("SnatchAreaGameViewContainer", "snatcharea/snatchareagameview")
	module_views.SnatchAreaGameView.otherRes.partygameplayerhead = "ui/viewres/partygame/common/component/partygameplayerhead.prefab"
	module_views.CardDropVSView = {
		destroy = 0,
		container = "CardDropVSViewContainer",
		mainRes = "ui/viewres/partygame/knockout/knockout_vspanel.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		otherRes = {
			common_playeritem = "ui/viewres/partygame/common/common_knockoutplayeritem.prefab"
		}
	}
	module_views.CardDropResultView = {
		destroy = 0,
		container = "CardDropResultViewContainer",
		mainRes = "ui/viewres/partygame/knockout/knockout_result.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
	module_views.CardDropPromotionView = {
		destroy = 0,
		container = "CardDropPromotionViewContainer",
		mainRes = "ui/viewres/partygame/knockout/knockout_promotion.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
	module_views.CardDropLoadingView = {
		destroy = 0,
		container = "CardDropLoadingViewContainer",
		mainRes = "ui/viewres/partygame/knockout/knockout_loading.prefab",
		layer = "TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.CardDropStartGameView = {
		destroy = 0,
		container = "CardDropStartGameViewContainer",
		mainRes = "ui/viewres/partygame/battle/battlegame_start.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
	module_views.CardDropCardTipView = {
		destroy = 0,
		container = "CardDropCardTipViewContainer",
		mainRes = "ui/viewres/partygame/battle/battlegametipsview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		otherRes = {
			cardItem = "ui/viewres/partygame/common/common_carditem.prefab"
		}
	}
	module_views.CardDropGameView = {
		destroy = 0,
		container = "CardDropGameViewContainer",
		mainRes = "ui/viewres/partygame/battle/battlegame_mainview.prefab",
		layer = "HUD",
		viewType = ViewType.Normal,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			float = "ui/viewres/partygame/battle/partygamefloat.prefab",
			cardItem = "ui/viewres/partygame/common/common_carditem.prefab"
		}
	}
	module_views.CardDropEditGameView = {
		destroy = 0,
		container = "CardDropEditGameViewContainer",
		mainRes = "ui/viewres/partygame/battle/carddropedit.prefab",
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
	module_views.SnatchAreaEditGameView = {
		destroy = 0,
		container = "SnatchAreaGameEditViewContainer",
		mainRes = "ui/viewres/partygame/snatcharea/snatchareagameeditview.prefab",
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
	module_views.GuessWhoGameView = PartyGameViewDefine.GetGameViewParam("GuessWhoGameViewContainer", "guesswho/guesswhogameview")
	module_views.PuzzleGameView = PartyGameViewDefine.GetGameViewParam("PuzzleGameViewContainer", "puzzle/puzzlegameview")
	module_views.PartyGameSoloResultView = {
		bgBlur = 1,
		container = "PartyGameSoloResultViewContainer",
		maskAlpha = 0,
		destroy = 0,
		mainRes = "ui/viewres/partygame/common/common_gamesoloresult.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		otherRes = {
			rewardHp = "ui/viewres/partygame/common/common_gameresulthp.prefab",
			playerInfo = "ui/viewres/partygame/common/common_playerinfo.prefab"
		}
	}
	module_views.PartyGameSoloResultGuideView = {
		bgBlur = 1,
		container = "PartyGameSoloResultGuideViewContainer",
		maskAlpha = 0,
		destroy = 0,
		mainRes = "ui/viewres/partygame/common/common_gamesoloresult.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		otherRes = {
			rewardHp = "ui/viewres/partygame/common/common_gameresulthp.prefab",
			playerInfo = "ui/viewres/partygame/common/common_playerinfo.prefab"
		}
	}
	module_views.PartyGameTeamResultView = {
		bgBlur = 1,
		container = "PartyGameTeamResultViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/partygame/common/common_gameteamresult.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		otherRes = {
			rewardHp = "ui/viewres/partygame/common/common_gameresulthp.prefab"
		}
	}
	module_views.PartyGameTeamResultGuideView = {
		bgBlur = 1,
		container = "PartyGameTeamResultGuideViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/partygame/common/common_gameteamresult.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		otherRes = {
			rewardHp = "ui/viewres/partygame/common/common_gameresulthp.prefab"
		}
	}
	module_views.PartyGameRewardView = {
		destroy = 0,
		container = "PartyGameRewardViewContainer",
		mainRes = "ui/viewres/partygame/common/common_gamereward.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		otherRes = {
			cardItem = "ui/viewres/partygame/common/common_carditem.prefab"
		}
	}
	module_views.PartyGameRewardGuideView = {
		destroy = 0,
		container = "PartyGameRewardGuideViewContainer",
		mainRes = "ui/viewres/partygame/common/common_gamereward.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		otherRes = {
			cardItem = "ui/viewres/partygame/common/common_carditem.prefab"
		}
	}
	module_views.PartyGameHelpView = {
		destroy = 0,
		container = "PartyGameHelpViewContainer",
		mainRes = "ui/viewres/partygame/common/common_helpview_ex.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
end

function PartyGameViewDefine.GetGameViewParam(containerName, mainResName)
	return {
		destroy = 0,
		layer = "HUD",
		container = containerName,
		viewType = ViewType.Normal,
		mainRes = string.format("ui/viewres/partygame/%s.prefab", mainResName),
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			playerInfo = "ui/viewres/partygame/common/common_playerinfo.prefab",
			netdelay = "ui/viewres/partygame/common/common_netdelay.prefab",
			joystick = "ui/viewres/partygame/common/common_joystick.prefab"
		}
	}
end

return PartyGameViewDefine
