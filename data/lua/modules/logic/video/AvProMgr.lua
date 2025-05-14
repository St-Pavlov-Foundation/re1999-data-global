module("modules.logic.video.AvProMgr", package.seeall)

local var_0_0 = class("AvProMgr")

var_0_0.Type_AvProUGUIPlayer = typeof(ZProj.AvProUGUIPlayer)
var_0_0.Type_DisplayUGUI = typeof(RenderHeads.Media.AVProVideo.DisplayUGUI)

function var_0_0.preload(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._callback = arg_1_1
	arg_1_0._callbackObj = arg_1_2
	arg_1_0._resDict = {}
	arg_1_0._loader = MultiAbLoader.New()

	arg_1_0._loader:setPathList(AvProMgrConfig.getPreloadList())
	arg_1_0._loader:setOneFinishCallback(arg_1_0._onOnePreloadCallback, arg_1_0)
	arg_1_0._loader:startLoad(arg_1_0._onPreloadCallback, arg_1_0)
end

function var_0_0._onOnePreloadCallback(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._resDict[arg_2_2.ResPath] = arg_2_2
end

function var_0_0._onPreloadCallback(arg_3_0)
	if arg_3_0._callback then
		arg_3_0._callback(arg_3_0._callbackObj)
	end

	arg_3_0._callback = nil
	arg_3_0._callbackObj = nil
end

function var_0_0._getGOInstance(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if SettingsModel.instance:getVideoEnabled() == false then
		arg_4_1 = AvProMgrConfig.UrlVideoDisable
	end

	local var_4_0 = arg_4_0._resDict[arg_4_1]

	if var_4_0 then
		local var_4_1 = var_4_0:GetResource(arg_4_1)

		if var_4_1 then
			return gohelper.clone(var_4_1, arg_4_2, arg_4_3)
		else
			logError(arg_4_1 .. " prefab not in ab")
		end
	end

	logError(arg_4_1 .. " videoPrefab need preload")
end

function var_0_0.swicthVideoUrl(arg_5_0, arg_5_1, arg_5_2)
	if SettingsModel.instance:getVideoCompatible() then
		return arg_5_2
	end

	return arg_5_1
end

function var_0_0.getVideoPlayer(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:swicthVideoUrl(AvProMgrConfig.UrlVideo, AvProMgrConfig.UrlVideoCompatible)
	local var_6_1 = arg_6_0:_getGOInstance(var_6_0, arg_6_1, arg_6_2)

	if SettingsModel.instance:getVideoEnabled() == false then
		return AvProUGUIPlayer_adjust.instance, nil, var_6_1
	end

	local var_6_2 = var_6_1:GetComponent(var_0_0.Type_AvProUGUIPlayer)
	local var_6_3 = var_6_1:GetComponent(var_0_0.Type_DisplayUGUI)

	var_6_3.ScaleMode = UnityEngine.ScaleMode.ScaleAndCrop

	return var_6_2, var_6_3, var_6_1
end

function var_0_0.getFightUrl(arg_7_0)
	if SettingsModel.instance:getVideoEnabled() == false then
		return AvProMgrConfig.UrlVideoDisable
	end

	return arg_7_0:swicthVideoUrl(AvProMgrConfig.UrlFightVideo, AvProMgrConfig.UrlFightVideoCompatible)
end

function var_0_0.getStoryUrl(arg_8_0)
	if SettingsModel.instance:getVideoEnabled() == false then
		return AvProMgrConfig.UrlVideoDisable
	end

	return arg_8_0:swicthVideoUrl(AvProMgrConfig.UrlStoryVideo, AvProMgrConfig.UrlStoryVideoCompatible)
end

function var_0_0.getNicknameUrl(arg_9_0)
	if SettingsModel.instance:getVideoEnabled() == false then
		return AvProMgrConfig.UrlVideoDisable
	end

	return arg_9_0:swicthVideoUrl(AvProMgrConfig.UrlNicknameVideo, AvProMgrConfig.UrlNicknameVideoCompatible)
end

function var_0_0.getRolesprefabUrl(arg_10_0, arg_10_1)
	if SettingsModel.instance:getVideoCompatible() or BootNativeUtil.isWindows() then
		return AvProMgrConfig.URLRolesprefabDict[arg_10_1] or arg_10_1
	end

	return arg_10_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
