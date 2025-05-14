module("modules.logic.seasonver.act166.view.information.Season166InformationReportItem", package.seeall)

local var_0_0 = class("Season166InformationReportItem", LuaCompBase)

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
end

function var_0_0.onClickItem(arg_3_0)
	if not arg_3_0.config then
		return
	end

	local var_3_0 = Season166Model.instance:getActInfo(arg_3_0.activityId)

	if not (var_3_0 and var_3_0:getInformationMO(arg_3_0.infoId)) then
		GameFacade.showToast(ToastEnum.Season166ReportNotUnlock)

		return
	end

	local var_3_1 = {
		actId = arg_3_0.activityId,
		infoId = arg_3_0.infoId,
		unlockState = arg_3_0.unlockState
	}

	ViewMgr.instance:openView(ViewName.Season166InformationAnalyView, var_3_1)

	arg_3_0.canShowNew = false

	Season166Controller.instance:dispatchEvent(Season166Event.ClickInfoReportItem, var_3_1)
	arg_3_0:refreshUnlockState(Season166Enum.UnlockState)
end

function var_0_0.refreshUI(arg_4_0, arg_4_1)
	arg_4_0.config = arg_4_1

	gohelper.setActive(arg_4_0.go, arg_4_1 ~= nil)

	if not arg_4_1 then
		return
	end

	arg_4_0.activityId = arg_4_0.config.activityId
	arg_4_0.infoId = arg_4_0.config.infoId

	arg_4_0.simagePic:LoadImage(string.format("singlebg/seasonver/season_infoanalyze_reportpic_%s_1.png", arg_4_0.infoId))
	arg_4_0.simagePicLocked:LoadImage(string.format("singlebg/seasonver/season_infoanalyze_reportpic_%s_0.png", arg_4_0.infoId))

	local var_4_0 = Season166Model.instance:getActInfo(arg_4_0.activityId)
	local var_4_1 = var_4_0 and var_4_0:getInformationMO(arg_4_0.infoId)

	arg_4_0.unlockState = var_4_1 and Season166Enum.UnlockState or Season166Enum.LockState

	gohelper.setActive(arg_4_0.goLockIcon, not var_4_1)
	arg_4_0:refreshSchdule(var_4_1)
	gohelper.setActive(arg_4_0.goLockTips, arg_4_0.unlockState == Season166Enum.LockState)

	if arg_4_0.unlockState == Season166Enum.LockState then
		arg_4_0.txtLockTips.text = arg_4_0.config.unlockDes
	end

	arg_4_0:playOpenAnim()
end

function var_0_0.playOpenAnim(arg_5_0)
	if arg_5_0.hasPlayOpen then
		return
	end

	arg_5_0.hasPlayOpen = true

	arg_5_0.animItem:SetBool("isUnlock", arg_5_0.unlockState == Season166Enum.UnlockState)

	if arg_5_0.unlockState == Season166Enum.UnlockState then
		arg_5_0.animItem:Play("open")
	else
		arg_5_0.animItem:Play("unlock")
	end
end

function var_0_0.refreshSchdule(arg_6_0, arg_6_1)
	if not arg_6_1 then
		gohelper.setActive(arg_6_0.goSchdule, false)
		arg_6_0:_setImgValue(0)

		return
	end

	gohelper.setActive(arg_6_0.goSchdule, true)

	local var_6_0 = Season166Config.instance:getSeasonInfoAnalys(arg_6_0.activityId, arg_6_0.infoId) or {}

	for iter_6_0 = 1, math.max(#arg_6_0.schduleItems, #var_6_0) do
		local var_6_1 = arg_6_0.schduleItems[iter_6_0] or arg_6_0:createSchduleItem(iter_6_0)

		arg_6_0:refreshSchduleItem(var_6_1, var_6_0[iter_6_0], arg_6_1.stage)
	end

	local var_6_2 = #var_6_0
	local var_6_3 = arg_6_1.stage / var_6_2

	arg_6_0:_setImgValue(var_6_3)
end

function var_0_0._setImgValue(arg_7_0, arg_7_1)
	arg_7_0.lockedCtrl:GetIndexProp(2, 2)

	local var_7_0 = arg_7_0.lockedCtrl.vector_03

	arg_7_0.lockedCtrl.vector_03 = Vector4.New(arg_7_1, 0.05, 0, 0)

	arg_7_0.lockedCtrl:SetIndexProp(2, 2)
end

function var_0_0.createSchduleItem(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getUserDataTb_()

	var_8_0.go = gohelper.cloneInPlace(arg_8_0.goSchduleItem, string.format("schdule%s", arg_8_1))
	var_8_0.goStatus0 = gohelper.findChild(var_8_0.go, "image_status0")
	var_8_0.goStatus = gohelper.findChild(var_8_0.go, "#image_status")
	arg_8_0.schduleItems[arg_8_1] = var_8_0

	return var_8_0
end

function var_0_0.refreshSchduleItem(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if not arg_9_2 then
		gohelper.setActive(arg_9_1.go, false)

		return
	end

	gohelper.setActive(arg_9_1.go, true)
	gohelper.setActive(arg_9_1.goStatus, arg_9_3 >= arg_9_2.stage)
end

function var_0_0.refreshUnlockState(arg_10_0, arg_10_1)
	if arg_10_0.unlockState == Season166Enum.UnlockState and arg_10_0.unlockState ~= arg_10_1 then
		arg_10_0.canShowNew = true
	else
		arg_10_0.canShowNew = false
	end

	arg_10_0:refreshReddot()
end

function var_0_0.refreshUnlockAnimState(arg_11_0, arg_11_1)
	if (arg_11_1[arg_11_0.infoId] or Season166Enum.LockState) == Season166Enum.LockState and arg_11_0.unlockState == Season166Enum.UnlockState then
		local var_11_0 = Season166Model.instance:getActInfo(arg_11_0.activityId)

		if (var_11_0 and var_11_0:getInformationMO(arg_11_0.infoId)).stage == 0 then
			Season166Model.instance:setLocalPrefsTab(Season166Enum.ReportUnlockAnimLocalSaveKey, arg_11_0.infoId, Season166Enum.UnlockState)
			gohelper.setActive(arg_11_0.goLockIcon, true)
			gohelper.setActive(arg_11_0.goSchdule, false)
			TaskDispatcher.runDelay(arg_11_0._playUnlockAnim, arg_11_0, 1.6)
		end
	end
end

function var_0_0._playUnlockAnim(arg_12_0)
	AudioMgr.instance:trigger(AudioEnum.Season166.play_ui_wangshi_argus_level_open)
	arg_12_0.animPlayer:Play("unlock", arg_12_0.onUnlockAnimPlayFinish, arg_12_0)
	gohelper.setActive(arg_12_0.goSchdule, true)
	arg_12_0.animSchdule:Play("open")
end

function var_0_0.onUnlockAnimPlayFinish(arg_13_0)
	gohelper.setActive(arg_13_0.goLockIcon, false)
end

function var_0_0.refreshFinishAnimState(arg_14_0, arg_14_1)
	if arg_14_0.unlockState == Season166Enum.LockState then
		return
	end

	local var_14_0 = arg_14_1[arg_14_0.infoId] or Season166Enum.LockState
	local var_14_1 = Season166Config.instance:getSeasonInfoAnalys(arg_14_0.activityId, arg_14_0.infoId) or {}
	local var_14_2 = Season166Model.instance:getActInfo(arg_14_0.activityId)
	local var_14_3 = (var_14_2 and var_14_2:getInformationMO(arg_14_0.infoId)).stage >= #var_14_1

	if var_14_0 == Season166Enum.LockState and var_14_3 then
		Season166Model.instance:setLocalPrefsTab(Season166Enum.ReportFinishAnimLocalSaveKey, arg_14_0.infoId, Season166Enum.UnlockState)
		gohelper.setActive(arg_14_0.goLock, true)
		AudioMgr.instance:trigger(AudioEnum.Season166.play_ui_checkpoint_unlock)
		arg_14_0.animPlayer:Play("finish", arg_14_0.onFinishAnimPlayFinish, arg_14_0)
	end
end

function var_0_0.onFinishAnimPlayFinish(arg_15_0)
	return
end

function var_0_0.refreshReddot(arg_16_0)
	RedDotController.instance:addRedDot(arg_16_0.goreddot, RedDotEnum.DotNode.Season166InfoSmallReward, arg_16_0.infoId, arg_16_0.checkReddotShow, arg_16_0)
end

function var_0_0.checkReddotShow(arg_17_0, arg_17_1)
	arg_17_1:defaultRefreshDot()

	if arg_17_0.canShowNew then
		gohelper.setActive(arg_17_0.gonewReddot, true)
		gohelper.setActive(arg_17_0.goreddot, false)
	else
		gohelper.setActive(arg_17_0.goreddot, true)
		gohelper.setActive(arg_17_0.gonewReddot, false)
		arg_17_1:showRedDot(RedDotEnum.Style.Normal)
	end
end

function var_0_0.removeEventListeners(arg_18_0)
	arg_18_0.btnClick:RemoveClickListener()
	Season166Controller.instance:unregisterCallback(Season166Event.OnAnalyInfoSuccess, arg_18_0.refreshReddot, arg_18_0)
end

function var_0_0.onDestroy(arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._playUnlockAnim, arg_19_0)
	arg_19_0.simagePic:UnLoadImage()
	arg_19_0.simagePicLocked:UnLoadImage()
	arg_19_0:__onDispose()
end

return var_0_0
