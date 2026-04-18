-- chunkname: @modules/logic/partycloth/define/PartyClothViewDefine.lua

module("modules.logic.partycloth.define.PartyClothViewDefine", package.seeall)

local PartyClothViewDefine = class("PartyClothViewDefine")

function PartyClothViewDefine.init(module_views)
	module_views.PartyClothView = {
		bgBlur = 2,
		container = "PartyClothViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/partygame/cloth/partyclothview.prefab",
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
			PartyClothEnum.ResPath.PartItem,
			PartyClothEnum.ResPath.SuitItem
		}
	}
	module_views.PartyClothLotteryView = {
		destroy = 0,
		container = "PartyClothLotteryViewContainer",
		mainRes = "ui/viewres/partygame/cloth/partyclothlotteryview.prefab",
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
			PartyClothEnum.ResPath.PartItem,
			PartyClothEnum.ResPath.LotterySuitItem
		}
	}
	module_views.PartyClothRewardView = {
		destroy = 0,
		container = "PartyClothRewardViewContainer",
		mainRes = "ui/viewres/partygame/cloth/partyclothrewardview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		otherRes = {
			PartyClothEnum.ResPath.PartItem,
			PartyClothEnum.ResPath.SuitItem
		},
		tabRes = {
			{
				{
					CurrencyView.prefabPath
				}
			}
		}
	}
	module_views.PartyClothLoadingView = {
		destroy = 0,
		container = "PartyClothLoadingViewContainer",
		mainRes = "ui/viewres/partygame/cloth/partyclothloadingview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
end

return PartyClothViewDefine
