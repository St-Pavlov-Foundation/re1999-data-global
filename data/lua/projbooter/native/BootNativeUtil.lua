module("projbooter.native.BootNativeUtil", package.seeall)

local var_0_0 = {}

var_0_0.nativeClsName = "com.shenlan.AppUtil"
var_0_0.SUCCESS = 0
var_0_0.FAILED = -1

function var_0_0.setNativeClassName(arg_1_0)
	var_0_0.nativeClsName = arg_1_0
end

function var_0_0.getAppVersion()
	return SLFramework.NativeUtil.GetAppVersion()
end

function var_0_0.getPackageName()
	if SLFramework.FrameworkSettings.IsEditor then
		return GameChannelConfig.getPackageName()
	end

	if var_0_0.isWindows() then
		return SDKMgr.instance:getWinPackageName()
	end

	return SLFramework.NativeUtil.GetPackageName()
end

function var_0_0.getMetaData(arg_4_0)
	if SLFramework.FrameworkSettings.IsAndroidPlayer() then
		return SLFramework.NativeUtil.StringCallNative(var_0_0.nativeClsName, "getMetaData", arg_4_0, "")
	elseif SLFramework.FrameworkSettings.IsIOSPlayer() then
		return SLFramework.NativeUtil.GetInfoPlistValue(arg_4_0)
	end

	return ""
end

function var_0_0.getCpuName()
	if SLFramework.FrameworkSettings.IsAndroidPlayer() then
		return SLFramework.NativeUtil.StringCallNative(var_0_0.nativeClsName, "getCpuName", "", "")
	end

	return UnityEngine.SystemInfo.processorType
end

function var_0_0.isAndroid()
	return SLFramework.FrameworkSettings.CurPlatform == SLFramework.FrameworkSettings.AndroidPlayer
end

function var_0_0.isIOS()
	return SLFramework.FrameworkSettings.CurPlatform == SLFramework.FrameworkSettings.IOSPlayer
end

function var_0_0.isWindows()
	return SLFramework.FrameworkSettings.CurPlatform == SLFramework.FrameworkSettings.WindowsPlayer
end

function var_0_0.isMacOS()
	return SLFramework.FrameworkSettings.CurPlatform == SLFramework.FrameworkSettings.OSXPlayer
end

function var_0_0.isStandalonePlayer()
	return var_0_0.isMacOS() or var_0_0.isWindows()
end

function var_0_0.isMobilePlayer()
	return var_0_0.isAndroid() or var_0_0.isIOS()
end

function var_0_0.getDisplayResolution()
	return SLFramework.NativeUtil.GetDisplayWidth(), SLFramework.NativeUtil.GetDisplayHeight()
end

return var_0_0
