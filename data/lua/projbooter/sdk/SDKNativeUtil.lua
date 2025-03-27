module("projbooter.sdk.SDKNativeUtil", package.seeall)

return {
	nativeClsName = "com.ssgame.mobile.gamesdk.unity.UnityStaticSdk",
	toolClsName = "com.ssgame.mobile.commonbase.unity.GameSdkTool",
	Permissions = {
		Internet = "android.permission.INTERNET"
	},
	isLogin = function ()
		if not SLFramework.FrameworkSettings.IsEditor and BootNativeUtil.isAndroid() then
			return SLFramework.NativeUtil.BoolCallNative(uv0.nativeClsName, "isLogin", "")
		end

		return true
	end,
	isShowShareButton = function ()
		if GameChannelConfig.isLongCheng() then
			return false
		end

		if VersionValidator.instance:isInReviewing() and BootNativeUtil.isIOS() then
			return false
		end

		if BootNativeUtil.isIOS() then
			return SDKMgr.instance:isShowShareButton()
		end

		return SLFramework.NativeUtil.BoolCallNative(uv0.nativeClsName, "isShowShareButton", "")
	end,
	isGamePad = function ()
		return false
	end,
	updateGame = function ()
		if BootNativeUtil.isAndroid() then
			SLFramework.NativeUtil.BoolCallNative(uv0.nativeClsName, "updateGame", "")
		end
	end,
	openCostumerService = function (slot0)
		if BootNativeUtil.isAndroid() then
			SLFramework.NativeUtil.VoidCallNative(uv0.nativeClsName, "openCostumerService", slot0)

			return true
		end

		if BootNativeUtil.isWindows() and not GameChannelConfig.isSlsdk() and GameConfig:GetCurRegionType() == RegionEnum.zh then
			UnityEngine.Application.OpenURL("https://bluepoch.soboten.com/chat/pc/v6/index.html?sysnum=b049a5df3dff49ae9c4ad54beb088015&channelid=3")

			return true
		end

		if BootNativeUtil.isIOS() then
			SDKMgr.instance:openCostumerService(slot0)

			return true
		end

		if BootNativeUtil.isWindows() and not SLFramework.FrameworkSettings.IsEditor then
			SDKMgr.instance:openCostumerService(slot0)

			return true
		end

		return false
	end,
	checkPermissions = function (slot0)
		if BootNativeUtil.isAndroid() then
			return SLFramework.NativeUtil.BoolCallNative(uv0.toolClsName, "checkPermissions", slot0, true)
		end

		return true
	end
}
