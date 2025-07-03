module("modules.logic.versionactivity2_7.dungeon.controller.VersionActivity2_7DungeonController", package.seeall)

local var_0_0 = class("VersionActivity2_7DungeonController", VersionActivityFixedDungeonController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._isShowLoading = false
	arg_1_0._sceneGo = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._isShowLoading = false
	arg_2_0._sceneGo = nil
end

function var_0_0.openVersionActivityDungeonMapView(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	var_0_0.super.openVersionActivityDungeonMapView(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)

	if arg_3_0:_isSpaceScene(arg_3_2) and not arg_3_0._sceneGo then
		arg_3_0:showLoading()
	end
end

function var_0_0._isSpaceScene(arg_4_0, arg_4_1)
	local var_4_0 = VersionActivity2_7DungeonEnum.SpaceSceneEpisodeIndexs

	arg_4_1 = arg_4_1 or VersionActivityFixedDungeonModel.instance:getInitEpisodeId()

	local var_4_1 = DungeonConfig.instance:getEpisodeLevelIndexByEpisodeId(arg_4_1)

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if var_4_1 == iter_4_1 then
			return true
		end
	end
end

function var_0_0.loadingFinish(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0:_isSpaceScene(arg_5_1) or arg_5_0._isShowLoading then
		arg_5_0:hideLoading()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_loading_scene)

	arg_5_0._sceneGo = arg_5_2
end

function var_0_0.showLoading(arg_6_0)
	ViewMgr.instance:openView(ViewName.V2a7LoadingSpaceView, nil, true)

	arg_6_0._isShowLoading = true
end

function var_0_0.hideLoading(arg_7_0)
	if ViewMgr.instance:isOpen(ViewName.V2a7LoadingSpaceView) then
		ViewMgr.instance:closeView(ViewName.V2a7LoadingSpaceView)
	end

	arg_7_0._isShowLoading = false
end

function var_0_0.resetLoading(arg_8_0)
	arg_8_0._isShowLoading = false
	arg_8_0._sceneGo = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
