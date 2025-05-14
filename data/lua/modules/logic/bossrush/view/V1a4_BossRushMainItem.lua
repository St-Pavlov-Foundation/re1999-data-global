module("modules.logic.bossrush.view.V1a4_BossRushMainItem", package.seeall)

local var_0_0 = class("V1a4_BossRushMainItem", LuaCompBase)
local var_0_1 = BossRushEnum.AnimMainItem

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = gohelper.findChild(arg_1_1, "Root")
	arg_1_0._btnItemBG = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_ItemBG")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._goUnlocked = gohelper.findChild(arg_1_0.viewGO, "#go_Unlocked")
	arg_1_0._imageIssxIcon = gohelper.findChildImage(arg_1_0.viewGO, "#go_Unlocked/Title/#image_IssxIcon")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "#go_Unlocked/Title/#txt_Title")
	arg_1_0._txtTitleEn = gohelper.findChildText(arg_1_0.viewGO, "#go_Unlocked/Title/#txt_TitleEn")
	arg_1_0._btnGo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Unlocked/#btn_Go", AudioEnum.ui_activity.play_ui_activity_open)
	arg_1_0._goLocked = gohelper.findChild(arg_1_0.viewGO, "#go_Locked")
	arg_1_0._txtLocked = gohelper.findChildText(arg_1_0.viewGO, "#go_Locked/#txt_Locked")
	arg_1_0._btnLocked = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Locked/#btn_Locked")
	arg_1_0._goRecord = gohelper.findChild(arg_1_0.viewGO, "#go_Record")
	arg_1_0._txtRecordNum = gohelper.findChildText(arg_1_0.viewGO, "#go_Record/#txt_RecordNum")
	arg_1_0._goAssessIcon = gohelper.findChild(arg_1_0.viewGO, "#go_Record/#go_AssessIcon")
	arg_1_0._goRed = gohelper.findChild(arg_1_0.viewGO, "#go_Red")
	arg_1_0._imgItemBG = gohelper.findChildImage(arg_1_0.viewGO, "#btn_ItemBG")
	arg_1_0._go3s = gohelper.findChild(arg_1_0.viewGO, "3s")
	arg_1_0._go4s = gohelper.findChild(arg_1_0.viewGO, "4s")
	arg_1_0._anim = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnItemBG:AddClickListener(arg_2_0._btnItemBGOnClick, arg_2_0)
	arg_2_0._btnGo:AddClickListener(arg_2_0._btnGoOnClick, arg_2_0)
	arg_2_0._btnLocked:AddClickListener(arg_2_0._btnLockedOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnItemBG:RemoveClickListener()
	arg_3_0._btnGo:RemoveClickListener()
	arg_3_0._btnLocked:RemoveClickListener()
end

function var_0_0._btnItemBGOnClick(arg_4_0)
	arg_4_0:_onClick()
end

function var_0_0._btnGoOnClick(arg_5_0)
	arg_5_0:_onClick()
end

function var_0_0._btnLockedOnClick(arg_6_0)
	arg_6_0:_onClick()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0:_initAssessIcon()

	arg_7_0._txtLocked.text = ""
	arg_7_0._txtRecordNum.text = ""
end

function var_0_0.onDestroy(arg_8_0)
	arg_8_0:onDestroyView()
end

function var_0_0.onDestroyView(arg_9_0)
	GameUtil.onDestroyViewMember(arg_9_0, "_assessIcon")

	arg_9_0._isForcePlayUnlock = false
	arg_9_0._openAnim = false

	arg_9_0._simagebg:UnLoadImage()
	TaskDispatcher.cancelTask(arg_9_0._onRefreshDeadline, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._delayOpenCallBack, arg_9_0)
end

function var_0_0._initAssessIcon(arg_10_0)
	local var_10_0 = ViewMgr.instance:getContainer(ViewName.V1a4_BossRushMainView)
	local var_10_1 = V1a4_BossRush_AssessIcon
	local var_10_2 = var_10_0:getResInst(BossRushEnum.ResPath.v1a4_bossrush_mainview_assessicon, arg_10_0._goAssessIcon, var_10_1.__cname)

	arg_10_0._assessIcon = MonoHelper.addNoUpdateLuaComOnceToGo(var_10_2, var_10_1)

	arg_10_0._assessIcon:initData(arg_10_0, false)
end

function var_0_0.setData(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._mo = arg_11_1

	arg_11_0:_refresh()
	arg_11_0:_setActive(false)

	if arg_11_2 then
		arg_11_0:_tweenOpen()
	else
		arg_11_0:_playIdle()
	end

	if not arg_11_0:_isOpen() then
		arg_11_0:_onRefreshDeadline()
		TaskDispatcher.runRepeat(arg_11_0._onRefreshDeadline, arg_11_0, 1)
	end

	arg_11_0:_refreshRed()
end

function var_0_0._refresh(arg_12_0)
	local var_12_0 = arg_12_0._mo.stageCO
	local var_12_1 = var_12_0.stage
	local var_12_2 = arg_12_0:_isOpen()
	local var_12_3 = BossRushConfig.instance:getIssxIconName(var_12_1)
	local var_12_4 = BossRushModel.instance:getHighestPoint(var_12_1)
	local var_12_5 = var_12_0.name

	if GameConfig:GetCurLangType() == LangSettings.zh and not string.nilorempty(var_12_5) then
		local var_12_6 = string.len(var_12_5)

		if var_12_6 >= 4 then
			local var_12_7 = "<size=67>%s</size>"
			local var_12_8 = var_12_5:sub(1, 3)
			local var_12_9 = var_12_5:sub(4, var_12_6 - 3)
			local var_12_10 = var_12_5:sub(var_12_6 - 2, var_12_6)

			var_12_5 = string.format(var_12_7, var_12_8) .. var_12_9 .. string.format(var_12_7, var_12_10)
		end
	end

	UISpriteSetMgr.instance:setCommonSprite(arg_12_0._imageIssxIcon, var_12_3)
	gohelper.setActive(arg_12_0._goRecord, var_12_2)

	arg_12_0._txtRecordNum.text = var_12_4
	arg_12_0._txtTitle.text = var_12_5
	arg_12_0._txtTitleEn.text = var_12_0.name_en

	arg_12_0._simagebg:LoadImage(BossRushConfig.instance:getBossRushMainItemBossSprite(var_12_1))

	local var_12_11 = BossRushModel.instance:getLayer4HightScore(var_12_1) == var_12_4

	arg_12_0._assessIcon:setData(var_12_1, var_12_4, var_12_11)

	if var_12_2 then
		gohelper.addUIClickAudio(arg_12_0._btnItemBG.gameObject, AudioEnum.UI.UI_Activity_open)
	end

	local var_12_12, var_12_13 = BossRushConfig.instance:getAssessMainBossBgName(var_12_1, var_12_4, var_12_11)

	UISpriteSetMgr.instance:setV1a4BossRushSprite(arg_12_0._imgItemBG, var_12_12)

	local var_12_14 = var_12_13 and var_12_13 == BossRushEnum.ScoreLevel.S_AA
	local var_12_15 = var_12_13 and var_12_13 == BossRushEnum.ScoreLevel.S_AAA

	gohelper.setActive(arg_12_0._go3s, var_12_14)
	gohelper.setActive(arg_12_0._go4s, var_12_15)
end

function var_0_0._isOpen(arg_13_0)
	local var_13_0 = arg_13_0:_getStage()

	return BossRushModel.instance:isBossOnline(var_13_0)
end

function var_0_0._getStage(arg_14_0)
	return arg_14_0._mo.stageCO.stage
end

function var_0_0._onRefreshDeadline(arg_15_0)
	local var_15_0 = arg_15_0:_getStage()
	local var_15_1 = BossRushModel.instance:getStageOpenServerTime(var_15_0) - ServerTime.now()

	if var_15_1 > 0 then
		arg_15_0._txtLocked.text = BossRushConfig.instance:getRemainTimeStrWithFmt(var_15_1, Activity128Config.ETimeFmtStyle.UnLock)
	else
		TaskDispatcher.cancelTask(arg_15_0._onRefreshDeadline, arg_15_0)

		if arg_15_0:_isOpen() then
			if arg_15_0._openAnimed then
				BossRushRedModel.instance:setIsNewUnlockStage(var_15_0, false)
				arg_15_0:_playUnlocking()
			else
				arg_15_0:_playUnlock(true)
			end
		end

		arg_15_0:_refresh()
	end
end

function var_0_0._onClick(arg_16_0)
	local var_16_0 = arg_16_0._mo

	BossRushController.instance:openLevelDetailView(var_16_0)
end

function var_0_0._delayOpenCallBack(arg_17_0)
	arg_17_0:_setActive(true)

	if arg_17_0._isForcePlayUnlock and arg_17_0:_isOpen() then
		arg_17_0:_playUnlock(true)
	else
		arg_17_0:_playOpen()
	end

	arg_17_0._openAnim = false
end

function var_0_0._tweenOpen(arg_18_0)
	if arg_18_0._openAnim then
		return
	end

	arg_18_0._openAnim = true

	local var_18_0 = arg_18_0:_getStage()

	if BossRushRedModel.instance:getIsNewUnlockStage(var_18_0) then
		arg_18_0._isForcePlayUnlock = true
	end

	arg_18_0._openAnimed = true

	TaskDispatcher.runDelay(arg_18_0._delayOpenCallBack, arg_18_0, arg_18_0._index * 0.06)
end

function var_0_0._playOpen(arg_19_0)
	if arg_19_0:_isOpen() then
		arg_19_0:_playAnim(var_0_1.OpeningUnlocked, 0, 0)
	else
		arg_19_0:_playAnim(var_0_1.OpeningLocked, 0, 0)
	end
end

function var_0_0._playIdle(arg_20_0)
	if arg_20_0:_isOpen() then
		arg_20_0:_playAnim(var_0_1.UnlockedIdle, 0, 1)
	else
		arg_20_0:_playAnim(var_0_1.LockedIdle, 0, 1)
	end
end

function var_0_0._playUnlock(arg_21_0, arg_21_1)
	if arg_21_0._openAnim and not arg_21_0._isForcePlayUnlock then
		if arg_21_1 then
			arg_21_0._isForcePlayUnlock = true
		end

		return
	end

	arg_21_0:_playAnim(var_0_1.Unlock, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_4_qiutu.play_ui_qiutu_list_maintain)

	arg_21_0._isForcePlayUnlock = false

	gohelper.setActive(arg_21_0._goRecord, true)
end

function var_0_0._playUnlocking(arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._delayOpenCallBack, arg_22_0)
	arg_22_0:_playAnim(var_0_1.Unlocking, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_4_qiutu.play_ui_qiutu_list_maintain)

	arg_22_0._isForcePlayUnlock = false

	gohelper.setActive(arg_22_0._goRecord, true)
end

function var_0_0._setActive(arg_23_0, arg_23_1)
	gohelper.setActive(arg_23_0.viewGO, arg_23_1)
end

function var_0_0._playAnim(arg_24_0, arg_24_1, ...)
	arg_24_0._anim:Play(arg_24_1, ...)
end

function var_0_0._refreshRed(arg_25_0)
	local var_25_0 = arg_25_0:_getStage()

	RedDotController.instance:addRedDot(arg_25_0._goRed, RedDotEnum.DotNode.BossRushBoss, var_25_0)
end

return var_0_0
