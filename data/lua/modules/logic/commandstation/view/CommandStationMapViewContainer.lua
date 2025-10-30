module("modules.logic.commandstation.view.CommandStationMapViewContainer", package.seeall)

local var_0_0 = class("CommandStationMapViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._leftVersionView = CommandStationMapLeftVersionView.New()
	arg_1_0._timelineAnimView = CommandStationMapTimelineAnimView.New()
	arg_1_0._mapScene = CommandStationMapSceneView.New()
	arg_1_0._mapEvent = CommandStationMapEventView.New()

	local var_1_0 = {}

	table.insert(var_1_0, CommandStationMapVersionLogoView.New())
	table.insert(var_1_0, arg_1_0._leftVersionView)
	table.insert(var_1_0, CommandStationMapVersionView.New())
	table.insert(var_1_0, arg_1_0._mapEvent)
	table.insert(var_1_0, arg_1_0._mapScene)
	table.insert(var_1_0, arg_1_0._timelineAnimView)
	table.insert(var_1_0, CommandStationMapView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_lefttop"))

	return var_1_0
end

function var_0_0.getLeftVersionView(arg_2_0)
	return arg_2_0._leftVersionView
end

function var_0_0.getTimelineAnimView(arg_3_0)
	return arg_3_0._timelineAnimView
end

function var_0_0.getMapEventView(arg_4_0)
	return arg_4_0._mapEvent
end

function var_0_0.getSceneGo(arg_5_0)
	return arg_5_0._mapScene and arg_5_0._mapScene:getSceneGo()
end

function var_0_0.buildTabViews(arg_6_0, arg_6_1)
	if arg_6_1 == 1 then
		arg_6_0._helpId = HelpEnum.HelpId.CommandStationMap
		arg_6_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			true
		}, arg_6_0._helpId)

		return {
			arg_6_0.navigateView
		}
	end
end

function var_0_0.showHelp(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0.navigateView:setHelpId(arg_7_0._helpId)
	else
		arg_7_0.navigateView:hideHelpIcon()
	end
end

function var_0_0._setVisible(arg_8_0, arg_8_1)
	var_0_0.super._setVisible(arg_8_0, arg_8_1)

	if arg_8_0._mapScene then
		arg_8_0._mapScene:setSceneVisible(arg_8_1)
	end
end

function var_0_0._onResLoadFinish(arg_9_0, arg_9_1)
	arg_9_0.viewGO = CommandStationMapModel.instance:getPreloadView()

	if not arg_9_0.viewGO then
		local var_9_0 = ViewMgr.instance:getUILayer(arg_9_0._viewSetting.layer)
		local var_9_1 = arg_9_0._abLoader:getAssetItem(arg_9_0._viewSetting.mainRes):GetResource(arg_9_0._viewSetting.mainRes)

		arg_9_0.viewGO = gohelper.clone(var_9_1, var_9_0, arg_9_0.viewName)
	else
		CommandStationMapModel.instance:setPreloadView(nil)
		recthelper.setAnchor(arg_9_0.viewGO.transform, 0, 0)
		gohelper.setAsLastSibling(arg_9_0.viewGO)
	end

	arg_9_0._views = arg_9_0:buildViews()

	if arg_9_0._views then
		for iter_9_0, iter_9_1 in ipairs(arg_9_0._views) do
			if isTypeOf(iter_9_1, TabViewGroup) then
				arg_9_0._tabViews = arg_9_0._tabViews or {}
				arg_9_0._tabViews[iter_9_1:getTabContainerId()] = iter_9_1
			end

			iter_9_1:tryCallMethodName("__onInit")

			iter_9_1.viewGO = arg_9_0.viewGO
			iter_9_1.viewContainer = arg_9_0
			iter_9_1.viewName = arg_9_0.viewName

			iter_9_1:onInitViewInternal()
			iter_9_1:addEventsInternal()
		end
	end

	arg_9_0:onContainerInit()

	BaseViewContainer.ViewLoadingCount = BaseViewContainer.ViewLoadingCount - 1

	if BaseViewContainer.ViewLoadingCount <= 0 then
		UIBlockMgr.instance:endBlock(UIBlockKey.ViewOpening)
	end

	arg_9_0:_reallyOpen()
end

return var_0_0
