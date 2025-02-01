module("projbooter.native.BootNativeUtil", package.seeall)

return {
	nativeClsName = "com.shenlan.AppUtil",
	SUCCESS = 0,
	FAILED = -1,
	setNativeClassName = function (slot0)
		uv0.nativeClsName = slot0
	end,
	getAppVersion = function ()
		return SLFramework.NativeUtil.GetAppVersion()
	end,
	getPackageName = function ()
		if SLFramework.FrameworkSettings.IsEditor then
			return GameChannelConfig.getPackageName()
		end

		if uv0.isWindows() then
			return SDKMgr.instance:getWinPackageName()
		end

		return SLFramework.NativeUtil.GetPackageName()
	end,
	getMetaData = function (slot0)
		if SLFramework.FrameworkSettings.IsAndroidPlayer() then
			return SLFramework.NativeUtil.StringCallNative(uv0.nativeClsName, "getMetaData", slot0, "")
		elseif SLFramework.FrameworkSettings.IsIOSPlayer() then
			return SLFramework.NativeUtil.GetInfoPlistValue(slot0)
		end

		return ""
	end,
	getCpuName = function ()
		if SLFramework.FrameworkSettings.IsAndroidPlayer() then
			return SLFramework.NativeUtil.StringCallNative(uv0.nativeClsName, "getCpuName", "", "")
		end

		return UnityEngine.SystemInfo.processorType
	end,
	isAndroid = function ()
		return SLFramework.FrameworkSettings.CurPlatform == SLFramework.FrameworkSettings.AndroidPlayer
	end,
	isIOS = function ()
		return SLFramework.FrameworkSettings.CurPlatform == SLFramework.FrameworkSettings.IOSPlayer
	end,
	isWindows = function ()
		return SLFramework.FrameworkSettings.CurPlatform == SLFramework.FrameworkSettings.WindowsPlayer
	end,
	isMacOS = function ()
		return SLFramework.FrameworkSettings.CurPlatform == SLFramework.FrameworkSettings.OSXPlayer
	end,
	isStandalonePlayer = function ()
		return uv0.isMacOS() or uv0.isWindows()
	end,
	isMobilePlayer = function ()
		return uv0.isAndroid() or uv0.isIOS()
	end,
	getDisplayResolution = function ()
		return SLFramework.NativeUtil.GetDisplayWidth(), SLFramework.NativeUtil.GetDisplayHeight()
	end
}
