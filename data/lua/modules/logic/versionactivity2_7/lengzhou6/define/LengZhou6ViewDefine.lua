module("modules.logic.versionactivity2_7.lengzhou6.define.LengZhou6ViewDefine", package.seeall)

local var_0_0 = class("LengZhou6ViewDefine")

function var_0_0.init(arg_1_0)
	arg_1_0.LengZhou6TaskView = {
		destroy = 0,
		container = "LengZhou6TaskViewContainer",
		mainRes = "ui/viewres/versionactivity_2_7/v2a7_hissabeth/v2a7_hissabeth_taskview.prefab",
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
			"ui/viewres/versionactivity_2_7/v2a7_hissabeth/v2a7_hissabeth_taskitem.prefab"
		}
	}
	arg_1_0.LengZhou6GameView = {
		destroy = 0,
		container = "LengZhou6GameViewContainer",
		mainRes = "ui/viewres/versionactivity_2_7/v2a7_hissabeth/v2a7_hissabeth_gameview.prefab",
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
			"ui/viewres/versionactivity_2_7/v2a7_hissabeth/v2a7_hissabeth_skillitem.prefab",
			"ui/viewres/versionactivity_2_7/v2a7_hissabeth/v2a7_hissabeth_selectskillitem.prefab",
			"ui/viewres/versionactivity_2_7/v2a7_hissabeth/v2a7_hissabeth_buffitem.prefab",
			"ui/viewres/versionactivity_2_7/v2a7_hissabeth/v2a7_hissabeth_effectitem.prefab"
		}
	}
	arg_1_0.LengZhou6GameResult = {
		destroy = 0,
		container = "LengZhou6GameResultContainer",
		mainRes = "ui/viewres/versionactivity_2_7/v2a7_hissabeth/v2a7_hissabeth_resultview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		otherRes = {
			"ui/viewres/versionactivity_2_7/v2a7_hissabeth/v2a7_hissabeth_resultview.prefab"
		}
	}
	arg_1_0.LengZhou6LevelView = {
		destroy = 0,
		container = "LengZhou6LevelViewContainer",
		mainRes = "ui/viewres/versionactivity_2_7/v2a7_hissabeth/v2a7_hissabeth_levelview.prefab",
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
			"ui/viewres/versionactivity_2_7/v2a7_hissabeth/v2a7_hissabeth_levelitem.prefab"
		}
	}
end

return var_0_0
