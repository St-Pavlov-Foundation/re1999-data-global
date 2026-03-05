-- chunkname: @modules/logic/necrologiststory/define/NecologistStoryViewDefine.lua

module("modules.logic.necrologiststory.define.NecologistStoryViewDefine", package.seeall)

local NecologistStoryViewDefine = class("NecologistStoryViewDefine")

function NecologistStoryViewDefine.init(module_views)
	module_views.NecrologistStoryView = {
		destroy = 0,
		container = "NecrologistStoryViewContainer",
		mainRes = "ui/viewres/dungeon/rolestory/necrologiststoryview.prefab",
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
			NecrologistStoryDialogItem.getResPath(),
			NecrologistStoryLocationItem.getResPath(),
			NecrologistStoryAsideItem.getResPath(),
			NecrologistStoryOptionsItem.getResPath(),
			NecrologistStoryMagicItem.getResPath(),
			NecrologistStoryErasePictureItem.getResPath(),
			NecrologistStoryDragPictureItem.getResPath(),
			NecrologistStorySystemItem.getResPath(),
			NecrologistStoryClickPictureItem.getResPath(),
			weatherRes = "ui/viewres/dungeon/rolestory/necrologiststoryweather.prefab",
			NecrologistStorySliderPictureItem.getResPath()
		}
	}
	module_views.NecrologistStoryReviewView = {
		destroy = 0,
		container = "NecrologistStoryReviewViewContainer",
		mainRes = "ui/viewres/dungeon/rolestory/necrologistreviewview.prefab",
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
	module_views.NecrologistStoryTaskView = {
		destroy = 0,
		container = "NecrologistStoryTaskViewContainer",
		mainRes = "ui/viewres/dungeon/rolestory/necrologiststorytaskview.prefab",
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
			itemRes = "ui/viewres/dungeon/rolestory/necrologiststorytaskitem.prefab"
		}
	}
	module_views.NecrologistStoryTipView = {
		destroy = 0,
		container = "NecrologistStoryTipViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/dungeon/rolestory/necrologiststorytipview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	module_views.V3A1_RoleStoryGameView = {
		destroy = 0,
		container = "V3A1_RoleStoryGameViewContainer",
		mainRes = "ui/viewres/dungeon/rolestory/v3a1/v3a1_rolestorygameview.prefab",
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
	module_views.V3A1_RoleStoryTicketView = {
		destroy = 0,
		container = "V3A1_RoleStoryTicketViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/dungeon/rolestory/v3a1/v3a1_rolestoryticketview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
	module_views.V3A1_RoleStoryFailView = {
		destroy = 0,
		container = "V3A1_RoleStoryFailViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/dungeon/rolestory/v3a1/v3a1_rolestoryfailview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
	module_views.V3A1_RoleStorySuccessView = {
		destroy = 0,
		container = "V3A1_RoleStorySuccessViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/dungeon/rolestory/v3a1/v3a1_rolestorysuccessview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
	module_views.V3A2_RoleStoryGameView = {
		destroy = 0,
		container = "V3A2_RoleStoryGameViewContainer",
		mainRes = "ui/viewres/dungeon/rolestory/v3a2/rolestory_madierda_gameview.prefab",
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
	module_views.V3A2_RoleStoryItemTipsView = {
		destroy = 0,
		container = "V3A2_RoleStoryItemTipsViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/dungeon/rolestory/v3a2/rolestory_madierda_itemtipsview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
	module_views.V3A2_RoleStoryItemGetView = {
		destroy = 0,
		container = "V3A2_RoleStoryItemGetViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/dungeon/rolestory/v3a2/rolestory_madierda_itemgetview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
	module_views.V3A3_RoleStoryGameView = {
		destroy = 0,
		container = "V3A3_RoleStoryGameViewContainer",
		mainRes = "ui/viewres/dungeon/rolestory/v3a3/v3a3_molideer_gameview.prefab",
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
end

return NecologistStoryViewDefine
