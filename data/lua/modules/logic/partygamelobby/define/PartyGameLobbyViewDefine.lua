-- chunkname: @modules/logic/partygamelobby/define/PartyGameLobbyViewDefine.lua

module("modules.logic.partygamelobby.define.PartyGameLobbyViewDefine", package.seeall)

local PartyGameLobbyViewDefine = class("PartyGameLobbyViewDefine")

function PartyGameLobbyViewDefine.init(module_views)
	module_views.PartyGameLobbyMainView = {
		destroy = 0,
		container = "PartyGameLobbyMainViewContainer",
		mainRes = "ui/viewres/partygame/main/partygame_mainview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.HUD,
		anim = ViewAnim.Internal,
		otherRes = {
			buildinginfo = "ui/viewres/partygame/main/partygame_buildinginfo.prefab",
			playerheadinfo = "ui/viewres/partygame/main/partygame_playerheadinfo.prefab",
			joystick = "ui/viewres/partygame/common/common_joystick.prefab",
			tips = PartyGameLobbyEnum.TipsRes.Join
		}
	}
	module_views.PartyGameLobbyLoadingView = {
		destroy = 0,
		container = "PartyGameLobbyLoadingViewContainer",
		mainRes = "ui/viewres/partygame/main/partygame_loadingview.prefab",
		layer = "TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.PartyGameLobbyStoreView = {
		destroy = 0,
		container = "PartyGameLobbyStoreViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/partygame/main/partygame_storeview.prefab",
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
	module_views.PartyGameLobbyAddRoomView = {
		destroy = 0,
		container = "PartyGameLobbyAddRoomViewContainer",
		mainRes = "ui/viewres/partygame/main/partygame_addroomview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Internal
	}
	module_views.PartyGameLobbyInRoomView = {
		destroy = 0,
		container = "PartyGameLobbyInRoomViewContainer",
		mainRes = "ui/viewres/partygame/main/partygame_inroomview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Internal,
		otherRes = {
			[1] = "ui/viewres/partygame/main/partygame_inroomplayeritem.prefab"
		}
	}
	module_views.PartyGameLobbyFriendListView = {
		destroy = 0,
		container = "PartyGameLobbyFriendListViewContainer",
		mainRes = "ui/viewres/partygame/main/partygame_friendlistview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Internal,
		otherRes = {
			[1] = "ui/viewres/partygame/main/partygame_frienditem.prefab"
		}
	}
	module_views.PartyGameLobbyPlayerInfoView = {
		destroy = 0,
		container = "PartyGameLobbyPlayerInfoViewContainer",
		mainRes = "ui/viewres/social/playerinfoview2.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		customAnimBg = {
			"bg"
		}
	}
	module_views.PartyGameLobbyMatchView = {
		destroy = 0,
		container = "PartyGameLobbyMatchViewContainer",
		mainRes = "ui/viewres/partygame/main/partygame_roommatchview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Internal
	}
end

return PartyGameLobbyViewDefine
