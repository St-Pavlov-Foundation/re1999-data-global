module("projbooter.sdk.SDKMgr", package.seeall)

local var_0_0 = class("SDKMgr")

var_0_0.ShareContentType = {
	Text = 1,
	Image = 2,
	Web = 3,
	Video = 4
}
var_0_0.SharePlatform = {
	WechatMoment = 3,
	LINE = 13,
	QQZone = 5,
	XiaoHongShu = 8,
	DISCORD = 17,
	Facebook = 11,
	WHATSAPP = 14,
	SinaWeibo = 1,
	TikTok = 6,
	WechatFriend = 2,
	INSTAGRAM = 15,
	Twitter = 12,
	QQ = 4
}
var_0_0.ChannelId = {
	Douyin = "107",
	QQMobile = "102"
}

function var_0_0.ctor(arg_1_0)
	arg_1_0.csharpInst = ZProj.SDKManager.Instance
	arg_1_0._callbackList = {
		[arg_1_0.csharpInst.initCallbackType] = arg_1_0._initSDKCallback,
		[arg_1_0.csharpInst.loginCallBackType] = arg_1_0._loginCallback,
		[arg_1_0.csharpInst.logoutCallbackType] = arg_1_0._logoutCallback,
		[arg_1_0.csharpInst.exitCallbackType] = arg_1_0._exitCallback,
		[arg_1_0.csharpInst.vistorUpGradeCallBackType] = arg_1_0._vistorUpGradeCallBack,
		[arg_1_0.csharpInst.socialShareCallBackType] = arg_1_0._socialShareCallBack,
		[arg_1_0.csharpInst.screenShotCallBackType] = arg_1_0._screenShotCallBack,
		[arg_1_0.csharpInst.payCallBackType] = arg_1_0._payCallBack,
		[arg_1_0.csharpInst.earphoneStatusChangeCallBackType] = arg_1_0._changeEarphoneContact,
		[arg_1_0.csharpInst.windowsModeChangedCallbackType] = arg_1_0._windowsModeChanged,
		[arg_1_0.csharpInst.recordVideoCallbackType] = arg_1_0._handleRecordVideoCalled,
		[arg_1_0.csharpInst.queryProductDetailsCallbackType] = arg_1_0._queryProductDetailsCallBack
	}

	if VersionUtil.isVersionLargeEqual("2.4.0") or SLFramework.FrameworkSettings.IsEditor then
		arg_1_0._callbackList[arg_1_0.csharpInst.dataPropertiesChangeCallbackType] = arg_1_0._dataPropertiesChangeCallBack
		arg_1_0._callbackList[arg_1_0.csharpInst.readNfcCallbackType] = arg_1_0._handleReadNfcCalled
	else
		arg_1_0._callbackList[arg_1_0.csharpInst.dataPropertiesChangeCallBackType] = arg_1_0._dataPropertiesChangeCallBack
	end

	arg_1_0.csharpInst:AddCallback(arg_1_0._callback, arg_1_0)

	arg_1_0._moduleSocialShareCallBack = nil
	arg_1_0._moduleSocialShareCallBackObj = nil
	arg_1_0._moduleScreenShotCallBack = nil
	arg_1_0._moduleScreenShotCallBackObj = nil
	arg_1_0._moduleQueryProductDetailsCallBack = nil
	arg_1_0._moduleQueryProductDetailsCallBackObj = nil
	arg_1_0._moduleDataPropertiesChangeCallBack = nil
	arg_1_0._moduleDataPropertiesChangeCallBackObj = nil
end

function var_0_0._callback(arg_2_0, arg_2_1, ...)
	local var_2_0 = arg_2_0._callbackList[arg_2_1]

	if var_2_0 then
		var_2_0(arg_2_0, unpack({
			...
		}))
	elseif VersionUtil.isVersionLess("2.4.0") and arg_2_1 == arg_2_0.csharpInst.readNfcCallbackType then
		-- block empty
	else
		logError("SDKMgr callbackType error callbackType:", tonumber(arg_2_1))
	end
end

function var_0_0.initSDK(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0._isInitSDK then
		logError("SDKMgr initSDK call repeatedly")

		return
	end

	arg_3_0._callbackNum = 0
	arg_3_0._isInitSDK = true
	arg_3_0._initCallback = {
		arg_3_1,
		arg_3_2
	}

	arg_3_0.csharpInst:InitSDK()
end

function var_0_0._initSDKCallback(arg_4_0)
	arg_4_0._callbackNum = arg_4_0._callbackNum + 1

	if not arg_4_0._initCallback then
		logError(string.format("SDKMgr initSDK callback error _isInitSDK:%s _callbackNum:%s", arg_4_0._isInitSDK, arg_4_0._callbackNum))

		return
	end

	local var_4_0 = arg_4_0._initCallback[1]
	local var_4_1 = arg_4_0._initCallback[2]

	arg_4_0._initCallback = nil

	arg_4_0:_initSDKDataTrackMgr()
	var_4_0(var_4_1)
end

function var_0_0._initSDKDataTrackMgr(arg_5_0)
	SDKDataTrackMgr.instance:initSDKDataTrack()
	SDKDataTrackMgr.instance:getDataTrackProperties()
end

function var_0_0.useSimulateLogin(arg_6_0)
	return arg_6_0.csharpInst:UseSimulateLogin()
end

function var_0_0.isLogin(arg_7_0)
	return arg_7_0.csharpInst:IsLogin()
end

function var_0_0.login(arg_8_0)
	if arg_8_0._loginSuccess then
		return
	end

	arg_8_0._isStartLogin = true

	arg_8_0.csharpInst:Login()
	logNormal("SDKMgr login 请求登录")
end

function var_0_0.isLoginSuccess(arg_9_0)
	return arg_9_0._loginSuccess
end

function var_0_0._loginCallback(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6, arg_10_7)
	logNormal("SDKMgr login callback result:" .. tostring(arg_10_1))

	if not arg_10_0._isStartLogin then
		logNormal("SDKMgr login callback 重复收到回调，忽略掉")

		return
	end

	arg_10_0._isStartLogin = nil
	arg_10_0._loginSuccess = arg_10_1

	if arg_10_1 then
		LoginModel.instance:setChannelParam(arg_10_3, arg_10_4, arg_10_5, arg_10_6, arg_10_7)
		LoginController.instance:login({})

		if not var_0_0.instance:isAdult() and var_0_0.instance:getUserType() == 99 then
			arg_10_0:showMinorLoginTipDialog()
		end
	else
		logWarn("SDKMgr login fail: msg = " .. (arg_10_2 or "nil"))
	end

	LoginController.instance:dispatchEvent(LoginEvent.OnSdkLoginReturn, arg_10_1, arg_10_2)
end

function var_0_0.logout(arg_11_0)
	if arg_11_0._loginSuccess then
		arg_11_0._loginSuccess = false

		arg_11_0.csharpInst:Logout()
	end
end

function var_0_0._logoutCallback(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0._loginSuccess = false

	if LoginController then
		LoginController.instance:onSdkLogout()
	end
end

function var_0_0._exitCallback(arg_13_0, arg_13_1, arg_13_2)
	if LoginController then
		LoginController.instance:dispose()
	end

	if ConnectAliveMgr then
		ConnectAliveMgr.instance:dispose()
	end
end

function var_0_0._vistorUpGradeCallBack(arg_14_0, arg_14_1, arg_14_2)
	return
end

function var_0_0._socialShareCallBack(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0._moduleSocialShareCallBack then
		arg_15_0._moduleSocialShareCallBack(arg_15_0._moduleSocialShareCallBackObj, arg_15_1, arg_15_2)
	end
end

function var_0_0.setSocialShareCallBack(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0._moduleSocialShareCallBack = arg_16_1
	arg_16_0._moduleSocialShareCallBackObj = arg_16_2
end

function var_0_0._screenShotCallBack(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_0._moduleScreenShotCallBack then
		arg_17_0._moduleScreenShotCallBack(arg_17_0._moduleScreenShotCallBackObj, arg_17_1, arg_17_2)
	end
end

function var_0_0.setScreenShotCallBack(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0._moduleScreenShotCallBack = arg_18_1
	arg_18_0._moduleScreenShotCallBackObj = arg_18_2
end

function var_0_0._payCallBack(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_0._modulePayCallBack then
		arg_19_0._modulePayCallBack(arg_19_0._modulePayCallBackObj, arg_19_1, arg_19_2)
	end
end

function var_0_0.setPayCallBack(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0._modulePayCallBack = arg_20_1
	arg_20_0._modulePayCallBackObj = arg_20_2
end

function var_0_0._queryProductDetailsCallBack(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0._moduleQueryProductDetailsCallBack then
		arg_21_0._moduleQueryProductDetailsCallBack(arg_21_0._moduleQueryProductDetailsCallBackObj, arg_21_1, arg_21_2)
	end
end

function var_0_0.setQueryProductDetailsCallBack(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0._moduleQueryProductDetailsCallBack = arg_22_1
	arg_22_0._moduleQueryProductDetailsCallBackObj = arg_22_2
end

function var_0_0._dataPropertiesChangeCallBack(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_0._moduleDataPropertiesChangeCallBack then
		arg_23_0._moduleDataPropertiesChangeCallBack(arg_23_0._moduleDataPropertiesChangeCallBackObj, arg_23_1, arg_23_2)
	end
end

function var_0_0.setDataPropertiesChangeCallBack(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0._moduleDataPropertiesChangeCallBack = arg_24_1
	arg_24_0._moduleDataPropertiesChangeCallBackObj = arg_24_2
end

function var_0_0.showVistorPlayTimeOutDialog(arg_25_0)
	arg_25_0.csharpInst:CallVoidFunc("showVistorPlayTimeOutDialog")
end

function var_0_0.showVistorUpgradeDialog(arg_26_0)
	arg_26_0.csharpInst:CallVoidFunc("showVistorUpgradeDialog")
end

function var_0_0.showMinorLoginTipDialog(arg_27_0)
	arg_27_0.csharpInst:CallVoidFunc("showMinorLoginTipDialog")
end

function var_0_0.showMinorPlayTimeOutDialog(arg_28_0)
	arg_28_0.csharpInst:CallVoidFunc("showMinorPlayTimeOutDialog")
end

function var_0_0.showMinorLimitLoginTimeDialog(arg_29_0)
	arg_29_0.csharpInst:CallVoidFunc("showMinorLimitLoginTimeDialog")
end

function var_0_0.exitSdk(arg_30_0)
	arg_30_0.csharpInst:CallVoidFunc("exitSdk")
end

function var_0_0.destroyGame(arg_31_0)
	arg_31_0.csharpInst:CallVoidFunc("destroyGame")
end

function var_0_0.getGameCode(arg_32_0)
	if SLFramework.FrameworkSettings.IsEditor or GameChannelConfig.isSlsdk() then
		return GameChannelConfig.getGameCode()
	end

	return arg_32_0.csharpInst:CallGetStrFunc("getGameCode")
end

function var_0_0.getGameId(arg_33_0)
	if SLFramework.FrameworkSettings.IsEditor or GameChannelConfig.isSlsdk() then
		return GameChannelConfig.getGameId()
	end

	return arg_33_0.csharpInst:CallGetStrFunc("getGameId")
end

function var_0_0.getGameSdkToken(arg_34_0)
	if SLFramework.FrameworkSettings.IsEditor or GameChannelConfig.isSlsdk() then
		return ""
	end

	return arg_34_0.csharpInst:CallGetStrFunc("getGameSdkToken")
end

function var_0_0.getChannelId(arg_35_0)
	if SLFramework.FrameworkSettings.IsEditor or GameChannelConfig.isSlsdk() then
		return GameChannelConfig.getChannelId()
	end

	return arg_35_0.csharpInst:CallGetStrFunc("getChannelId")
end

function var_0_0.getSubChannelId(arg_36_0)
	if SLFramework.FrameworkSettings.IsEditor or GameChannelConfig.isSlsdk() then
		return GameChannelConfig.getSubChannelId()
	end

	return arg_36_0.csharpInst:CallGetStrFunc("getSubChannelId")
end

function var_0_0.getUserType(arg_37_0)
	if SLFramework.FrameworkSettings.IsEditor or GameChannelConfig.isSlsdk() then
		return 99
	end

	local var_37_0 = arg_37_0.csharpInst:CallGetStrFunc("getUserType")

	return tonumber(var_37_0)
end

function var_0_0.isAdult(arg_38_0)
	if SLFramework.FrameworkSettings.IsEditor or GameChannelConfig.isSlsdk() then
		return true
	end

	return arg_38_0.csharpInst:CallGetStrFunc("isAdult") ~= "False"
end

function var_0_0.setScreenLightingOff(arg_39_0, arg_39_1)
	if not arg_39_1 then
		arg_39_0.csharpInst:CallToolVoidFunc("turnOffScreenLighting")
	else
		arg_39_0.csharpInst:CallToolVoidFunc("turnOnScreenLighting")
	end
end

function var_0_0.openLauncher(arg_40_0)
	arg_40_0.csharpInst:CallVoidFunc("sdkOpenLauncher")
end

function var_0_0.openCostumerService(arg_41_0, arg_41_1)
	arg_41_0.csharpInst:CallVoidFuncWithParams("openCostumerService", arg_41_1)
end

function var_0_0.shareMedia(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	arg_42_0.csharpInst:ShareMedia(arg_42_1, arg_42_2, arg_42_3)
end

function var_0_0.saveImage(arg_43_0, arg_43_1)
	arg_43_0.csharpInst:SaveImage(arg_43_1)
end

function var_0_0.enterGame(arg_44_0, arg_44_1)
	arg_44_0.csharpInst:EnterGame(arg_44_1)
end

function var_0_0.createRole(arg_45_0, arg_45_1)
	arg_45_0.csharpInst:CreateRole(arg_45_1)
end

function var_0_0.upgradeRole(arg_46_0, arg_46_1)
	arg_46_0.csharpInst:UpgradeRole(arg_46_1)
end

function var_0_0.updateRole(arg_47_0, arg_47_1)
	arg_47_0.csharpInst:UpdateRole(arg_47_1)
end

function var_0_0.payGoods(arg_48_0, arg_48_1)
	arg_48_0.csharpInst:PayGoods(arg_48_1)
end

function var_0_0.queryProductDetailEntity(arg_49_0, arg_49_1, arg_49_2)
	arg_49_0.csharpInst:queryProductList(arg_49_1, arg_49_2)
end

function var_0_0.getProductList(arg_50_0)
	return arg_50_0.csharpInst:getProductList()
end

function var_0_0.getWinPackageName(arg_51_0)
	if GameChannelConfig.isSlsdk() then
		return "com.shenlan.m.proj1"
	else
		return arg_51_0.csharpInst:GetWinPackageName()
	end
end

function var_0_0.pcLoginForQrCode(arg_52_0)
	arg_52_0.csharpInst:PcLoginForQrcode()
end

function var_0_0.isShowUserCenter(arg_53_0)
	return arg_53_0.csharpInst:IsShowUserCenter()
end

function var_0_0.isShowUnregisterButton(arg_54_0)
	return arg_54_0.csharpInst:CallGetStrFunc("isShowUnregisterButton") ~= "False"
end

function var_0_0.isNotificationEnable(arg_55_0)
	return arg_55_0.csharpInst:IsNotificationEnable()
end

function var_0_0.openNotificationSettings(arg_56_0)
	arg_56_0.csharpInst:OpenNotificationSettings()
end

function var_0_0.unregisterSdk(arg_57_0)
	arg_57_0.csharpInst:CallVoidFunc("unregisterSdk")
end

function var_0_0.isShowShareButton(arg_58_0)
	return arg_58_0.csharpInst:CallGetStrFunc("isShowShareButton") ~= "False"
end

function var_0_0.isShowAgreementButton(arg_59_0)
	return arg_59_0.csharpInst:IsShowAgreementButton()
end

function var_0_0.isShowPcLoginButton(arg_60_0)
	return arg_60_0.csharpInst:IsShowPcLoginButton()
end

function var_0_0.showUserCenter(arg_61_0)
	arg_61_0.csharpInst:ShowUserCenter()
end

function var_0_0.isEarphoneContact(arg_62_0)
	if arg_62_0._isInitSDK then
		return arg_62_0.csharpInst:IsEarphoneContact()
	end
end

function var_0_0.isEmulator(arg_63_0)
	return BootNativeUtil.isAndroid() and arg_63_0.csharpInst:IsEmulator()
end

function var_0_0.showAgreement(arg_64_0)
	arg_64_0.csharpInst:CallVoidFunc("showAgreement")
end

function var_0_0._changeEarphoneContact(arg_65_0)
	if AudioMgr and AudioMgr.instance then
		AudioMgr.instance:changeEarMode()
	end
end

function var_0_0._windowsModeChanged(arg_66_0, arg_66_1, arg_66_2)
	return
end

function var_0_0._handleRecordVideoCalled(arg_67_0, arg_67_1, arg_67_2)
	logNormal(string.format("_handleRecordVideoCalled code = [%s], msg = [%s]", arg_67_1, arg_67_2))
	ToastController.instance:showToastWithString(tostring(arg_67_2))
end

function var_0_0._handleQueryProductDetailsCalled(arg_68_0, arg_68_1, arg_68_2)
	logNormal(string.format("_handleQueryProductDetailsCalled code = [%s], msg = [%s]", arg_68_1, arg_68_2))
	ToastController.instance:showToastWithString(tostring(arg_68_2))
end

function var_0_0._handleDataPropertiesChangeCalled(arg_69_0, arg_69_1, arg_69_2)
	logNormal(string.format("_handleDataPropertiesChangeCalled code = [%s], msg = [%s]", arg_69_1, arg_69_2))
	ToastController.instance:showToastWithString(tostring(arg_69_2))
end

function var_0_0._handleReadNfcCalled(arg_70_0, arg_70_1, arg_70_2)
	logNormal(string.format("_handleReadNfcCalled code = [%s], msg = [%s]", arg_70_1, arg_70_2))

	if NFCController == nil or NFCController.instance == nil then
		logNormal("NFCController is nil")

		return
	end

	NFCController.instance:onNFCRead(arg_70_2)
end

function var_0_0.requestReadAndWritePermission(arg_71_0)
	arg_71_0.csharpInst:RequestReadAndWritePermission()
end

function var_0_0.showRecordBubble(arg_72_0)
	return
end

function var_0_0.hideRecordBubble(arg_73_0)
	return
end

function var_0_0.startRecord(arg_74_0)
	return
end

function var_0_0.stopRecord(arg_75_0)
	return
end

function var_0_0.isRecording(arg_76_0)
	return false
end

function var_0_0.isSupportRecord(arg_77_0)
	return false
end

function var_0_0.openVideosPage(arg_78_0)
	arg_78_0.csharpInst:CallVoidFunc("openVideosPage")
end

function var_0_0.setLanguage(arg_79_0, arg_79_1)
	arg_79_0.csharpInst:setLanguage(arg_79_1)
end

function var_0_0.openSoJump(arg_80_0, arg_80_1)
	arg_80_0.csharpInst:openSoJump(arg_80_1)
end

function var_0_0.checkReadExternalStoragePermissions(arg_81_0)
	if BootNativeUtil.isAndroid() then
		return arg_81_0.csharpInst:CheckPermissions("android.permission.READ_EXTERNAL_STORAGE")
	else
		return true
	end
end

function var_0_0.appReview(arg_82_0)
	if VersionValidator.instance:isInReviewing() then
		return
	end

	local var_82_0 = {}

	var_82_0.eventName = "appReview"

	local var_82_1 = cjson.encode(var_82_0)

	arg_82_0.csharpInst:appReview(var_82_1)
end

function var_0_0.stopService(arg_83_0)
	arg_83_0.csharpInst:stopService()
end

function var_0_0.isShowStopServiceBaffle(arg_84_0)
	return arg_84_0.csharpInst:isShowStopServiceBaffle()
end

function var_0_0.openAccountBind(arg_85_0)
	arg_85_0.csharpInst:openAccountBind()
end

function var_0_0.showATTDialog(arg_86_0, arg_86_1)
	if BootNativeUtil.isIOS() and GameChannelConfig.isEfun() then
		arg_86_0.csharpInst:showATTDialog(arg_86_1)
	end
end

function var_0_0.getUserInfo(arg_87_0)
	return arg_87_0.csharpInst:CallGetStrFunc("getUserInfo")
end

function var_0_0.getUserInfoExtraParams(arg_88_0)
	local var_88_0 = cjson.decode(arg_88_0:getUserInfo()).extraJson

	if var_88_0 == nil then
		return nil
	end

	return cjson.decode(var_88_0)
end

function var_0_0.restartGame(arg_89_0)
	arg_89_0.csharpInst:CallVoidFunc("restartGame")
end

function var_0_0.isIgnoreFileMissing(arg_90_0)
	return arg_90_0.csharpInst:IsIgnoreFileMissing()
end

function var_0_0.isUnsupportChangeVolume(arg_91_0)
	return arg_91_0.csharpInst:IsUnsupportChangeVolume()
end

function var_0_0.getUserInfo(arg_92_0)
	return arg_92_0.csharpInst:CallGetStrFunc("getUserInfo")
end

function var_0_0.getUserInfoExtraParams(arg_93_0)
	local var_93_0 = cjson.decode(arg_93_0:getUserInfo() or "{}").extraJson

	if var_93_0 == nil then
		return nil
	end

	return cjson.decode(var_93_0)
end

function var_0_0.restartGame(arg_94_0)
	arg_94_0.csharpInst:CallVoidFunc("restartGame")
end

function var_0_0.getSystemMediaVolume(arg_95_0)
	return arg_95_0.csharpInst:GetSystemMediaVolume()
end

function var_0_0.setSystemMediaVolume(arg_96_0, arg_96_1)
	arg_96_0.csharpInst:SetSystemMediaVolume(arg_96_1)
end

function var_0_0.isIgnoreFileMissing(arg_97_0)
	if BootNativeUtil.getPackageName() == "com.shenlan.m.reverse1999.nearme.gamecenter" then
		return false
	else
		return arg_97_0.csharpInst:IsIgnoreFileMissing()
	end
end

function var_0_0.isUnsupportChangeVolume(arg_98_0)
	return arg_98_0.csharpInst:IsUnsupportChangeVolume()
end

function var_0_0.getDeviceInfo(arg_99_0)
	if not arg_99_0._deviceInfo then
		local var_99_0 = arg_99_0.csharpInst:CallGetStrFunc("getDeviceInfo")

		if not string.nilorempty(var_99_0) then
			arg_99_0._deviceInfo = cjson.decode(var_99_0)
		else
			arg_99_0._deviceInfo = {}
		end
	end

	return arg_99_0._deviceInfo
end

function var_0_0.getGameSdkConfig(arg_100_0)
	if not arg_100_0._gameSdkConfig then
		local var_100_0 = arg_100_0.csharpInst:CallGetStrFunc("getGameSdkConfig")

		if not string.nilorempty(var_100_0) then
			arg_100_0._gameSdkConfig = cjson.decode(var_100_0)
		else
			arg_100_0._gameSdkConfig = {}
		end
	end

	return arg_100_0._gameSdkConfig
end

function var_0_0.getShowNotice(arg_101_0)
	local var_101_0 = arg_101_0:getGameSdkConfig()

	if var_101_0 and var_101_0.showButtons then
		return var_101_0.showButtons.Notice
	end

	return true
end

var_0_0.instance = var_0_0.New()

return var_0_0
