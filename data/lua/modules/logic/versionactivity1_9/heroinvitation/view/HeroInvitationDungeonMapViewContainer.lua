module("modules.logic.versionactivity1_9.heroinvitation.view.HeroInvitationDungeonMapViewContainer", package.seeall)

local var_0_0 = class("HeroInvitationDungeonMapViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0.mapView = HeroInvitationDungeonMapView.New()
	arg_1_0.mapSceneElements = HeroInvitationDungeonMapSceneElements.New()
	arg_1_0.mapScene = HeroInvitationDungeonMapScene.New()

	table.insert(var_1_0, HeroInvitationDungeonMapHoleView.New())
	table.insert(var_1_0, arg_1_0.mapView)
	table.insert(var_1_0, arg_1_0.mapSceneElements)
	table.insert(var_1_0, arg_1_0.mapScene)
	table.insert(var_1_0, DungeonMapElementReward.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	return var_1_0
end

function var_0_0.getMapScene(arg_2_0)
	return arg_2_0.mapScene
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	arg_3_0.navigateView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		arg_3_0.navigateView
	}
end

function var_0_0.onUpdateParamInternal(arg_4_0, arg_4_1)
	arg_4_0.viewParam = arg_4_1

	arg_4_0:onContainerUpdateParam()
	arg_4_0:_setVisible(true)

	if arg_4_0._views then
		for iter_4_0, iter_4_1 in ipairs(arg_4_0._views) do
			iter_4_1.viewParam = arg_4_1

			iter_4_1:onUpdateParamInternal()
		end
	end
end

function var_0_0.setVisibleInternal(arg_5_0, arg_5_1)
	var_0_0.super.setVisibleInternal(arg_5_0, arg_5_1)

	if ViewMgr.instance:isOpen(ViewName.StoryBackgroundView) then
		arg_5_1 = true
	end

	if arg_5_0.mapScene then
		arg_5_0.mapScene:setSceneVisible(arg_5_1)
	end
end

return var_0_0
