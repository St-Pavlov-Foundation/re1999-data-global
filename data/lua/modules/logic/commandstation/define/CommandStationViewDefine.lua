module("modules.logic.commandstation.define.CommandStationViewDefine", package.seeall)

return {
	init = function(arg_1_0)
		arg_1_0.CommandStationEnterView = {
			destroy = 0,
			container = "CommandStationEnterViewContainer",
			mainRes = "ui/viewres/commandstation/commandstation_enterview.prefab",
			layer = "POPUP_TOP",
			viewType = ViewType.Full,
			anim = ViewAnim.Internal,
			tabRes = {
				{
					{
						NavigateButtonsView.prefabPath
					}
				}
			},
			otherRes = {
				"singlebg/commandstation/enter/commandstation_enter_fullbg.png",
				"singlebg/commandstation/enter/commandstation_enter_mask.png",
				"singlebg/commandstation/enter/commandstation_enter_decbg.png",
				"ui/spriteassets/sp_commandstation.asset"
			}
		}
		arg_1_0.CommandStationPaperView = {
			destroy = 0,
			container = "CommandStationPaperViewContainer",
			mainRes = "ui/viewres/commandstation/commandstation_paperview.prefab",
			layer = "POPUP_TOP",
			viewType = ViewType.Full,
			anim = ViewAnim.Internal,
			tabRes = {
				{
					{
						NavigateButtonsView.prefabPath
					}
				}
			},
			otherRes = {
				"singlebg/commandstation/paper/commandstation_paper_fullbg.png"
			}
		}
		arg_1_0.CommandStationPaperGetView = {
			bgBlur = 4,
			container = "CommandStationPaperGetViewContainer",
			destroy = 0,
			mainRes = "ui/viewres/commandstation/commandstation_getdiskview.prefab",
			layer = "POPUP_TOP",
			viewType = ViewType.Modal,
			anim = ViewAnim.Internal
		}
		arg_1_0.CommandStationTaskView = {
			destroy = 0,
			container = "CommandStationTaskViewContainer",
			mainRes = "ui/viewres/commandstation/commandstation_taskview.prefab",
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
				"ui/viewres/commandstation/commandstation_taskitem.prefab"
			}
		}
		arg_1_0.CommandStationDispatchEventMainView = {
			destroy = 0,
			container = "CommandStationDispatchEventMainViewContainer",
			mainRes = "ui/viewres/commandstation/commandstation_dispatcheventmainview.prefab",
			layer = "POPUP_TOP",
			viewType = ViewType.Normal,
			anim = ViewAnim.Internal,
			otherRes = {
				[1] = "ui/viewres/commandstation/commandstation_dispatcheventprocessheroitem.prefab"
			},
			tabRes = {
				{
					{
						NavigateButtonsView.prefabPath
					}
				},
				{
					{
						"ui/viewres/commandstation/commandstation_dispatcheventnormalview.prefab"
					},
					{
						"ui/viewres/commandstation/commandstation_dispatcheventprocessview.prefab"
					}
				}
			}
		}
		arg_1_0.CommandStationCharacterEventView = {
			destroy = 0,
			container = "CommandStationCharacterEventViewContainer",
			mainRes = "ui/viewres/commandstation/commandstation_charactereventview.prefab",
			layer = "POPUP_TOP",
			viewType = ViewType.Normal,
			anim = ViewAnim.Internal,
			tabRes = {
				{
					{
						NavigateButtonsView.prefabPath
					}
				}
			}
		}
		arg_1_0.CommandStationDialogueEventView = {
			destroy = 0,
			container = "CommandStationDialogueEventViewContainer",
			mainRes = "ui/viewres/commandstation/commandstation_dialogueeventview.prefab",
			layer = "POPUP_TOP",
			viewType = ViewType.Normal,
			anim = ViewAnim.Internal,
			tabRes = {
				{
					{
						NavigateButtonsView.prefabPath
					}
				}
			}
		}
		arg_1_0.CommandStationMapView = {
			container = "CommandStationMapViewContainer",
			destroy = 0,
			mainRes = "ui/viewres/commandstation/commandstation_mapview.prefab",
			layer = "POPUP_TOP",
			viewType = ViewType.Full,
			anim = ViewAnim.Internal,
			otherRes = {
				[1] = "ui/viewres/commandstation/commandstation_mapitem.prefab"
			},
			tabRes = {
				{
					{
						NavigateButtonsView.prefabPath
					}
				}
			},
			preloader = module_views_preloader
		}
		arg_1_0.CommandStationTimelineEventView = {
			destroy = 0,
			container = "CommandStationTimelineEventViewContainer",
			mainRes = "ui/viewres/commandstation/commandstation_timelineeventview.prefab",
			layer = "POPUP_TOP",
			viewType = ViewType.Normal,
			anim = ViewAnim.Internal,
			tabRes = {
				{
					{
						NavigateButtonsView.prefabPath
					}
				}
			}
		}
		arg_1_0.CommandStationDetailView = {
			destroy = 0,
			container = "CommandStationDetailViewContainer",
			bgBlur = 1,
			mainRes = "ui/viewres/commandstation/commandstation_timedetailpanel.prefab",
			layer = "POPUP_TOP",
			viewType = ViewType.Normal,
			anim = ViewAnim.Internal
		}
		arg_1_0.CommandStationEnterAnimView = {
			destroy = 0,
			container = "CommandStationEnterAnimViewContainer",
			mainRes = "ui/viewres/commandstation/commandstation_enteranimview.prefab",
			layer = "POPUP_SECOND",
			viewType = ViewType.Normal,
			anim = ViewAnim.Internal,
			otherRes = {
				[1] = "ui/animations/dynamic/commandstation_enter.controller",
				[2] = "ui/spriteassets/sp_commandstation.asset"
			}
		}
	end
}
