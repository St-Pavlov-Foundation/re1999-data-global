module("projbooter.sdk.SDKNativeUtil", package.seeall)

local var_0_0 = {}

var_0_0.nativeClsName = "com.ssgame.mobile.gamesdk.unity.UnityStaticSdk"
var_0_0.toolClsName = "com.ssgame.mobile.commonbase.unity.GameSdkTool"
var_0_0.Permissions = {
	Internet = "android.permission.INTERNET"
}

function var_0_0.isLogin()
	if not SLFramework.FrameworkSettings.IsEditor and BootNativeUtil.isAndroid() then
		return SLFramework.NativeUtil.BoolCallNative(var_0_0.nativeClsName, "isLogin", "")
	end

	return true
end

function var_0_0.isShowShareButton()
	if GameChannelConfig.isLongCheng() then
		return false
	end

	if VersionValidator.instance:isInReviewing() and BootNativeUtil.isIOS() then
		return false
	end

	if BootNativeUtil.isIOS() then
		return SDKMgr.instance:isShowShareButton()
	end

	return SLFramework.NativeUtil.BoolCallNative(var_0_0.nativeClsName, "isShowShareButton", "")
end

function var_0_0.isGamePad()
	return false
end

function var_0_0.updateGame(arg_4_0)
	if BootNativeUtil.isAndroid() then
		if VersionUtil.isVersionLargeEqual("2.7.0") then
			SLFramework.NativeUtil.VoidCallNative(var_0_0.nativeClsName, "updateGame", arg_4_0)
		else
			SLFramework.NativeUtil.BoolCallNative(var_0_0.nativeClsName, "updateGame", "")
		end
	end
end

function var_0_0.openCostumerService(arg_5_0)
	if BootNativeUtil.isAndroid() then
		SLFramework.NativeUtil.VoidCallNative(var_0_0.nativeClsName, "openCostumerService", arg_5_0)

		return true
	end

	if BootNativeUtil.isWindows() and not GameChannelConfig.isSlsdk() and GameConfig:GetCurRegionType() == RegionEnum.zh then
		UnityEngine.Application.OpenURL("https://bluepoch.soboten.com/chat/pc/v6/index.html?sysnum=b049a5df3dff49ae9c4ad54beb088015&channelid=3")

		return true
	end

	if BootNativeUtil.isIOS() then
		SDKMgr.instance:openCostumerService(arg_5_0)

		return true
	end

	if BootNativeUtil.isWindows() and not SLFramework.FrameworkSettings.IsEditor then
		SDKMgr.instance:openCostumerService(arg_5_0)

		return true
	end

	return false
end

function var_0_0.checkPermissions(arg_6_0)
	if BootNativeUtil.isAndroid() then
		return SLFramework.NativeUtil.BoolCallNative(var_0_0.toolClsName, "checkPermissions", arg_6_0, true)
	end

	return true
end

return var_0_0
