-- chunkname: @modules/logic/activitywelfare/define/ActivityWelfareViewDefine.lua

module("modules.logic.activitywelfare.define.ActivityWelfareViewDefine", package.seeall)

local ActivityWelfareViewDefine = {}

function ActivityWelfareViewDefine.init(module_views)
	module_views.ActivityWelfareView = {
		destroy = 0,
		container = "ActivityWelfareViewContainer",
		mainRes = "ui/viewres/activity/activitybeginnerview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			},
			{
				{
					"ui/viewres/activity/newwelfare/newwelfarefullview.prefab"
				}
			}
		},
		otherRes = {
			[1] = "ui/viewres/activity/activitynormalcategoryitem.prefab"
		}
	}
	module_views.NewWelfareView = {
		destroy = 0,
		container = "NewWelfareViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/activity/newwelfare/newwelfarefullview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.NewWelfarePanel = {
		destroy = 0,
		container = "NewWelfarePanelContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/actiivty/newwelfare/newwelfarepanelview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	module_views.ActivityNoviceSignView = {
		bgBlur = 0,
		container = "ActivityNoviceSignViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/activity/newwelfare/activitynovicesignview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/activity/newwelfare/activitynovicesignitem.prefab"
		},
		customAnimBg = {}
	}
	module_views.VersionActivity3_8NewWelfareView = {
		destroy = 0,
		container = "VersionActivity3_8NewWelfareViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/activity/newwelfare/v3a8_newwelfareview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.VersionActivity3_8NoviceSignView = {
		destroy = 0,
		container = "VersionActivity3_8NoviceSignViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/activity/newwelfare/v3a8_novicesignview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.VersionActivity3_8SelfSelectSixView = {
		destroy = 0,
		container = "VersionActivity3_8SelfSelectSixViewContainer",
		mainRes = "ui/viewres/activity/newwelfare/v3a8_selfselectsixview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
end

return ActivityWelfareViewDefine
