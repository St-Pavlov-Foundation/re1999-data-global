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
			"ui/viewres/dungeon/rolestory/necrologiststoryweather.prefab",
			"ui/materials/dynamic/ui_halfgray2.mat",
			NecrologistStoryDialogItem.getResPath(),
			NecrologistStoryLocationItem.getResPath(),
			NecrologistStoryAsideItem.getResPath(),
			NecrologistStoryOptionsItem.getResPath(),
			NecrologistStoryMagicItem.getResPath(),
			NecrologistStoryErasePictureItem.getResPath(),
			NecrologistStoryDragPictureItem.getResPath(),
			NecrologistStorySystemItem.getResPath(),
			NecrologistStoryClickPictureItem.getResPath(),
			NecrologistStorySliderPictureItem.getResPath(),
			V3A5NecrologistStoryLongPressItem.getResPath()
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
	module_views.V3A4_RoleStoryLevelView = {
		destroy = 0,
		container = "V3A4_RoleStoryLevelViewContainer",
		mainRes = "ui/viewres/dungeon/rolestory/v3a4/v3a4_rolestorylevelview.prefab",
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
	module_views.V3A4_RoleStoryGameView = {
		destroy = 0,
		container = "V3A4_RoleStoryGameViewContainer",
		mainRes = "ui/viewres/dungeon/rolestory/v3a4/v3a4_rolestorygameview.prefab",
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
	module_views.V3A4_RoleStoryAudioView = {
		destroy = 0,
		container = "V3A4_RoleStoryAudioViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/dungeon/rolestory/v3a4/v3a4_rolestoryaudioview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Internal
	}
	module_views.V3A5_RoleStoryGameView = {
		destroy = 0,
		container = "V3A5_RoleStoryGameViewContainer",
		mainRes = "ui/viewres/dungeon/rolestory/v3a5/v3a5_rolestorygameview.prefab",
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
	module_views.V3A5_RoleStoryBulletView = {
		destroy = 0,
		container = "V3A5_RoleStoryBulletViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/dungeon/rolestory/v3a5/v3a5_rolestorybulletview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
end

return NecologistStoryViewDefine
