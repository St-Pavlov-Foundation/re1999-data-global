module("modules.logic.seasonver.act166.view2_6.Season166_2_6InformationReportItem", package.seeall)

local var_0_0 = class("Season166_2_6InformationReportItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.animItem = arg_1_0.go:GetComponent(typeof(UnityEngine.Animator))

	local var_1_0 = gohelper.findChild(arg_1_0.go, "image_Line")

	arg_1_0.lockedCtrl = var_1_0:GetComponent(typeof(ZProj.MaterialPropsCtrl))
	arg_1_0.animPlayer = SLFramework.AnimatorPlayer.Get(var_1_0)
	arg_1_0.simagePic = gohelper.findChildSingleImage(arg_1_0.go, "image_Line/image_ReportPic")
	arg_1_0.goLock = gohelper.findChild(arg_1_0.go, "image_Line/#go_Locked")
	arg_1_0.goLockTips = gohelper.findChild(arg_1_0.goLock, "#go_LockTips")
	arg_1_0.txtLockTips = gohelper.findChildTextMesh(arg_1_0.goLock, "#go_LockTips/image_LockTips/#txt_LockTips")
	arg_1_0.goLockIcon = gohelper.findChild(arg_1_0.goLock, "image_LockedIcon")
	arg_1_0.simagePicLocked = gohelper.findChildSingleImage(arg_1_0.goLock, "image_ReportLockedPic")
	arg_1_0.goSchdule = gohelper.findChild(arg_1_0.go, "Schdule")
	arg_1_0.animSchdule = arg_1_0.goSchdule:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0.goSchduleItem = gohelper.findChild(arg_1_0.goSchdule, "#go_Item")

	gohelper.setActive(arg_1_0.goSchduleItem, false)

	arg_1_0.schduleItems = {}
	arg_1_0.btnClick = gohelper.findButtonWithAudio(arg_1_0.go)
	arg_1_0.goreddot = gohelper.findChild(arg_1_0.go, "image_Line/#go_reddot")
	arg_1_0.gonewReddot = gohelper.findChild(arg_1_0.go, "image_Line/#go_infoNewReddot")
	arg_1_0.canShowNew = false
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0.btnClick:AddClickListener(arg_2_0.onClickItem, arg_2_0)
	Season166Controller.instance:registerCallback(Season166Event.OnAnalyInfoSuccess, arg_2_0.refreshReddot, arg_2_0)
	Season166Controller.instance:registerCallback(Season166Event.ClickInfoReportItem, arg_2_0.onClickInfoReportItem, arg_2_0)
end

function var_0_0.onClickInfoReportItem(arg_3_0, arg_3_1)
	if not arg_3_1 or arg_3_1.infoId ~= arg_3_0.infoId then
		return
	end

	arg_3_0:refreshUnlockState(arg_3_1.unlockState)
end

function var_0_0.onClickItem(arg_4_0)
	if not arg_4_0.config then
		return
	end

	local var_4_0 = {
		actId = arg_4_0.activityId,
		infoId = arg_4_0.infoId
	}

	ViewMgr.instance:openView(ViewName.Season166InformationAnalyView, var_4_0)
end

function var_0_0.refreshUI(arg_5_0, arg_5_1)
	arg_5_0.config = arg_5_1

	gohelper.setActive(arg_5_0.go, arg_5_1 ~= nil)

	if not arg_5_1 then
		return
	end

	arg_5_0.activityId = arg_5_0.config.activityId
	arg_5_0.infoId = arg_5_0.config.infoId

	arg_5_0.simagePic:LoadImage(string.format("singlebg/seasonver/season_infoanalyze_reportpic_%s_1.png", arg_5_0.infoId))
	arg_5_0.simagePicLocked:LoadImage(string.format("singlebg/seasonver/season_infoanalyze_reportpic_%s_0.png", arg_5_0.infoId))

	local var_5_0 = Season166Model.instance:getActInfo(arg_5_0.activityId)
	local var_5_1 = var_5_0 and var_5_0:getInformationMO(arg_5_0.infoId)

	arg_5_0.unlockState = var_5_1 and Season166Enum.UnlockState or Season166Enum.LockState

	gohelper.setActive(arg_5_0.goLockIcon, not var_5_1)
	arg_5_0:refreshSchdule(var_5_1)
	gohelper.setActive(arg_5_0.goLockTips, arg_5_0.unlockState == Season166Enum.LockState)

	if arg_5_0.unlockState == Season166Enum.LockState then
		arg_5_0.txtLockTips.text = arg_5_0.config.unlockDes
	end

	arg_5_0:playOpenAnim()
end

function var_0_0.playOpenAnim(arg_6_0)
	if arg_6_0.hasPlayOpen then
		return
	end

	arg_6_0.hasPlayOpen = true

	arg_6_0.animItem:SetBool("isUnlock", arg_6_0.unlockState == Season166Enum.UnlockState)

	if arg_6_0.unlockState == Season166Enum.UnlockState then
		arg_6_0.animItem:Play("open")
	else
		arg_6_0.animItem:Play("unlock")
	end
end

function var_0_0.refreshSchdule(arg_7_0, arg_7_1)
	if not arg_7_1 then
		gohelper.setActive(arg_7_0.goSchdule, false)
		arg_7_0:_setImgValue(0)

		return
	end

	gohelper.setActive(arg_7_0.goSchdule, true)

	local var_7_0 = Season166Config.instance:getSeasonInfoAnalys(arg_7_0.activityId, arg_7_0.infoId) or {}

	for iter_7_0 = 1, math.max(#arg_7_0.schduleItems, #var_7_0) do
		local var_7_1 = arg_7_0.schduleItems[iter_7_0] or arg_7_0:createSchduleItem(iter_7_0)

		arg_7_0:refreshSchduleItem(var_7_1, var_7_0[iter_7_0], arg_7_1.stage)
	end

	local var_7_2 = #var_7_0
	local var_7_3 = arg_7_1.stage / var_7_2

	arg_7_0:_setImgValue(var_7_3)
end

function var_0_0._setImgValue(arg_8_0, arg_8_1)
	arg_8_0.lockedCtrl:GetIndexProp(2, 2)

	local var_8_0 = arg_8_0.lockedCtrl.vector_03

	arg_8_0.lockedCtrl.vector_03 = Vector4.New(arg_8_1, 0.05, 0, 0)

	arg_8_0.lockedCtrl:SetIndexProp(2, 2)
end

function var_0_0.createSchduleItem(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getUserDataTb_()

	var_9_0.go = gohelper.cloneInPlace(arg_9_0.goSchduleItem, string.format("schdule%s", arg_9_1))
	var_9_0.goStatus0 = gohelper.findChild(var_9_0.go, "image_status0")
	var_9_0.goStatus = gohelper.findChild(var_9_0.go, "#image_status")
	arg_9_0.schduleItems[arg_9_1] = var_9_0

	return var_9_0
end

function var_0_0.refreshSchduleItem(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if not arg_10_2 then
		gohelper.setActive(arg_10_1.go, false)

		return
	end

	gohelper.setActive(arg_10_1.go, true)
	gohelper.setActive(arg_10_1.goStatus, arg_10_3 >= arg_10_2.stage)
end

function var_0_0.refreshUnlockState(arg_11_0, arg_11_1)
	if arg_11_0.unlockState == Season166Enum.UnlockState and arg_11_0.unlockState ~= arg_11_1 then
		arg_11_0.canShowNew = true
	else
		arg_11_0.canShowNew = false
	end

	arg_11_0:refreshReddot()
end

function var_0_0.refreshUnlockAnimState(arg_12_0, arg_12_1)
	if (arg_12_1[arg_12_0.infoId] or Season166Enum.LockState) == Season166Enum.LockState and arg_12_0.unlockState == Season166Enum.UnlockState then
		local var_12_0 = Season166Model.instance:getActInfo(arg_12_0.activityId)

		if (var_12_0 and var_12_0:getInformationMO(arg_12_0.infoId)).stage == 0 then
			Season166Model.instance:setLocalPrefsTab(Season166Enum.ReportUnlockAnimLocalSaveKey, arg_12_0.infoId, Season166Enum.UnlockState)
			gohelper.setActive(arg_12_0.goLockIcon, true)
			gohelper.setActive(arg_12_0.goSchdule, false)
			TaskDispatcher.runDelay(arg_12_0._playUnlockAnim, arg_12_0, 1.6)
		end
	end
end

function var_0_0._playUnlockAnim(arg_13_0)
	AudioMgr.instance:trigger(AudioEnum.Season166.play_ui_wangshi_argus_level_open)
	arg_13_0.animPlayer:Play("unlock", arg_13_0.onUnlockAnimPlayFinish, arg_13_0)
	gohelper.setActive(arg_13_0.goSchdule, true)
	arg_13_0.animSchdule:Play("open")
end

function var_0_0.onUnlockAnimPlayFinish(arg_14_0)
	gohelper.setActive(arg_14_0.goLockIcon, false)
end

function var_0_0.refreshFinishAnimState(arg_15_0, arg_15_1)
	if arg_15_0.unlockState == Season166Enum.LockState then
		return
	end

	local var_15_0 = arg_15_1[arg_15_0.infoId] or Season166Enum.LockState
	local var_15_1 = Season166Config.instance:getSeasonInfoAnalys(arg_15_0.activityId, arg_15_0.infoId) or {}
	local var_15_2 = Season166Model.instance:getActInfo(arg_15_0.activityId)
	local var_15_3 = (var_15_2 and var_15_2:getInformationMO(arg_15_0.infoId)).stage >= #var_15_1

	if var_15_0 == Season166Enum.LockState and var_15_3 then
		Season166Model.instance:setLocalPrefsTab(Season166Enum.ReportFinishAnimLocalSaveKey, arg_15_0.infoId, Season166Enum.UnlockState)
		gohelper.setActive(arg_15_0.goLock, true)
		AudioMgr.instance:trigger(AudioEnum.Season166.play_ui_checkpoint_unlock)
		arg_15_0.animPlayer:Play("finish", arg_15_0.onFinishAnimPlayFinish, arg_15_0)
	end
end

function var_0_0.onFinishAnimPlayFinish(arg_16_0)
	return
end

function var_0_0.refreshReddot(arg_17_0)
	RedDotController.instance:addRedDot(arg_17_0.goreddot, RedDotEnum.DotNode.Season166InfoSmallReward, arg_17_0.infoId, arg_17_0.checkReddotShow, arg_17_0)
end

function var_0_0.checkReddotShow(arg_18_0, arg_18_1)
	arg_18_1:defaultRefreshDot()

	if arg_18_0.canShowNew then
		gohelper.setActive(arg_18_0.gonewReddot, true)
		gohelper.setActive(arg_18_0.goreddot, false)
	else
		gohelper.setActive(arg_18_0.goreddot, true)
		gohelper.setActive(arg_18_0.gonewReddot, false)
		arg_18_1:showRedDot(RedDotEnum.Style.Normal)
	end
end

function var_0_0.removeEventListeners(arg_19_0)
	arg_19_0.btnClick:RemoveClickListener()
	Season166Controller.instance:unregisterCallback(Season166Event.OnAnalyInfoSuccess, arg_19_0.refreshReddot, arg_19_0)
	Season166Controller.instance:unregisterCallback(Season166Event.ClickInfoReportItem, arg_19_0.onClickInfoReportItem, arg_19_0)
end

function var_0_0.onDestroy(arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._playUnlockAnim, arg_20_0)
	arg_20_0.simagePic:UnLoadImage()
	arg_20_0.simagePicLocked:UnLoadImage()
	arg_20_0:__onDispose()
end

return var_0_0
