module("modules.logic.necrologiststory.define.NecologistStoryViewDefine", package.seeall)

local var_0_0 = class("NecologistStoryViewDefine")

function var_0_0.init(arg_1_0)
	arg_1_0.NecrologistStoryView = {
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
			weatherRes = "ui/viewres/dungeon/rolestory/necrologiststoryweather.prefab"
		}
	}
	arg_1_0.NecrologistStoryReviewView = {
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
	arg_1_0.NecrologistStoryTaskView = {
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
	arg_1_0.NecrologistStoryTipView = {
		destroy = 0,
		container = "NecrologistStoryTipViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/dungeon/rolestory/necrologiststorytipview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	arg_1_0.V3A1_RoleStoryGameView = {
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
	arg_1_0.V3A1_RoleStoryTicketView = {
		destroy = 0,
		container = "V3A1_RoleStoryTicketViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/dungeon/rolestory/v3a1/v3a1_rolestoryticketview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
	arg_1_0.V3A1_RoleStoryFailView = {
		destroy = 0,
		container = "V3A1_RoleStoryFailViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/dungeon/rolestory/v3a1/v3a1_rolestoryfailview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
	arg_1_0.V3A1_RoleStorySuccessView = {
		destroy = 0,
		container = "V3A1_RoleStorySuccessViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/dungeon/rolestory/v3a1/v3a1_rolestorysuccessview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
end

return var_0_0
