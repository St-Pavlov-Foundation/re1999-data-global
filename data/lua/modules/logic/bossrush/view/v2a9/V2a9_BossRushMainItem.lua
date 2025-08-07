module("modules.logic.bossrush.view.v2a9.V2a9_BossRushMainItem", package.seeall)

local var_0_0 = class("V2a9_BossRushMainItem", V1a4_BossRushMainItem)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = gohelper.findChild(arg_1_1, "Root")
	arg_1_0._btnItemBG = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_ItemBG")
	arg_1_0._goUnlocked = gohelper.findChild(arg_1_0.viewGO, "#go_Unlocked")
	arg_1_0._imageIssxIcon = gohelper.findChildImage(arg_1_0.viewGO, "#go_Unlocked/Title/#image_IssxIcon")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "#go_Unlocked/Title/#txt_Title")
	arg_1_0._txtTitleEn = gohelper.findChildText(arg_1_0.viewGO, "#go_Unlocked/Title/#txt_TitleEn")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Unlocked/#simage_bg")
	arg_1_0._goSpecialRecord = gohelper.findChild(arg_1_0.viewGO, "#go_Unlocked/#go_NormalRecord")
	arg_1_0._txtSpecialRecordNum = gohelper.findChildText(arg_1_0.viewGO, "#go_Unlocked/#go_NormalRecord/#txt_RecordNum")
	arg_1_0._goSpecialAssessIcon = gohelper.findChild(arg_1_0.viewGO, "#go_Unlocked/#go_NormalRecord/#go_AssessIcon")
	arg_1_0._goNormalRecord = gohelper.findChild(arg_1_0.viewGO, "#go_Unlocked/#go_SpecialRecord")
	arg_1_0._txtRecordNum = gohelper.findChildText(arg_1_0.viewGO, "#go_Unlocked/#go_SpecialRecord/#txt_RecordNum")
	arg_1_0._goAssessIcon = gohelper.findChild(arg_1_0.viewGO, "#go_Unlocked/#go_SpecialRecord/#go_AssessIcon")
	arg_1_0._goLocked = gohelper.findChild(arg_1_0.viewGO, "#go_Locked")
	arg_1_0._txtLocked = gohelper.findChildText(arg_1_0.viewGO, "#go_Locked/#txt_Locked")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "#go_Locked/#txt_LimitTime")
	arg_1_0._btnLocked = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Locked/#btn_Locked")
	arg_1_0._simageLocked = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Locked/image_Empty")
	arg_1_0._goRed = gohelper.findChild(arg_1_0.viewGO, "#go_Red")
	arg_1_0._anim = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnItemBG:AddClickListener(arg_2_0._btnItemBGOnClick, arg_2_0)
	arg_2_0._btnLocked:AddClickListener(arg_2_0._btnLockedOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnItemBG:RemoveClickListener()
	arg_3_0._btnLocked:RemoveClickListener()
end

function var_0_0._btnLockedOnClick(arg_4_0)
	if not string.nilorempty(arg_4_0._jumpParam) then
		local var_4_0, var_4_1, var_4_2 = JumpController.instance:canJumpNew(arg_4_0._jumpParam)

		if var_4_0 then
			JumpController.instance:jumpByParam(arg_4_0._jumpParam)
		elseif var_4_1 then
			ToastController.instance:showToast(var_4_1, var_4_2 and unpack(var_4_2))
		end
	end
end

function var_0_0.returnPlayAnim(arg_5_0, arg_5_1)
	if arg_5_1 then
		if arg_5_0:_getIsNewUnlockStage() then
			arg_5_0:_playUnlock(true)
			gohelper.setActive(arg_5_0._goRed, true)

			return
		end
	else
		arg_5_0:_playIdle()
	end
end

function var_0_0._refresh(arg_6_0)
	local var_6_0 = arg_6_0._mo.stageCO
	local var_6_1 = var_6_0.stage
	local var_6_2 = arg_6_0:_isOpen()
	local var_6_3 = BossRushConfig.instance:getIssxIconName(var_6_1)
	local var_6_4 = BossRushModel.instance:getHighestPoint(var_6_1)
	local var_6_5 = V2a9BossRushModel.instance:getHighestPoint(var_6_1)
	local var_6_6 = var_6_0.name
	local var_6_7 = var_6_1 == 1 and VersionActivity2_9Enum.ActivityId.Dungeon or VersionActivity2_9Enum.ActivityId.Dungeon2

	arg_6_0._jumpParam = string.format("%s#%s", JumpEnum.JumpView.ActivityView, var_6_7)

	UISpriteSetMgr.instance:setCommonSprite(arg_6_0._imageIssxIcon, var_6_3)
	gohelper.setActive(arg_6_0._goRecord, var_6_2)
	gohelper.setActive(arg_6_0._goRed, var_6_2)

	arg_6_0._txtRecordNum.text = var_6_4
	arg_6_0._txtTitle.text = var_6_6
	arg_6_0._txtTitleEn.text = var_6_0.name_en
	arg_6_0._txtSpecialRecordNum.text = var_6_5

	local var_6_8 = GameUtil.parseColor("#E6AA6A")
	local var_6_9 = GameUtil.parseColor("#808080")

	arg_6_0._txtRecordNum.color = var_6_4 > 0 and var_6_8 or var_6_9
	arg_6_0._txtSpecialRecordNum.color = var_6_5 > 0 and var_6_8 or var_6_9

	arg_6_0._simagebg:LoadImage(BossRushConfig.instance:getBossRushMainItemBossSprite(var_6_1))
	arg_6_0._assessIcon:setData(var_6_1, var_6_4, false)
	arg_6_0._spAssessIcon:setData(var_6_1, var_6_5, false)

	local var_6_10 = BossRushConfig.instance:getStageCO(var_6_1).bossRushMainItemBossSprite .. "_locked"

	arg_6_0._simageLocked:LoadImage(ResUrl.getV1a4BossRushIcon(var_6_10))

	if not var_6_2 then
		if BossRushModel.instance:isBossOnline(var_6_1) then
			local var_6_11 = arg_6_0:_getUnlockEpisodeId(var_6_1)
			local var_6_12, var_6_13 = V2a9BossRushModel.instance:getUnlockEpisodeDisplay(var_6_1, var_6_11)
			local var_6_14 = luaLang("bossrush_unlockepisode")

			arg_6_0._txtLocked.text = GameUtil.getSubPlaceholderLuaLangTwoParam(var_6_14, var_6_12, var_6_13)

			gohelper.setActive(arg_6_0._txtLimitTime.gameObject, false)
		else
			arg_6_0._txtLocked.text = ""

			local var_6_15 = BossRushModel.instance:getStageOpenServerTime(var_6_1)
			local var_6_16 = arg_6_0:getRemainTimeStr2(var_6_15 - ServerTime.now())

			arg_6_0._txtLimitTime.text = var_6_16

			gohelper.setActive(arg_6_0._txtLimitTime.gameObject, true)
		end
	end

	if var_6_2 then
		gohelper.addUIClickAudio(arg_6_0._btnItemBG.gameObject, AudioEnum.UI.UI_Activity_open)
	end
end

function var_0_0.getRemainTimeStr2(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_2 and TimeUtil.DateEnFormat.Day or luaLangUTC("time_day")
	local var_7_1 = arg_7_2 and TimeUtil.DateEnFormat.Hour or luaLangUTC("time_hour2")
	local var_7_2 = arg_7_2 and TimeUtil.DateEnFormat.Minute or luaLangUTC("time_minute2")

	if not arg_7_1 or arg_7_1 <= 0 then
		return 0 .. var_7_2
	end

	arg_7_1 = math.floor(arg_7_1)

	local var_7_3 = Mathf.Floor(arg_7_1 / TimeUtil.OneDaySecond)

	if var_7_3 > 0 then
		return var_7_3 .. var_7_0
	end

	local var_7_4 = arg_7_1 % TimeUtil.OneDaySecond
	local var_7_5 = Mathf.Floor(var_7_4 / TimeUtil.OneHourSecond)

	if var_7_5 > 0 then
		return var_7_5 .. var_7_1
	end

	local var_7_6 = var_7_4 % TimeUtil.OneHourSecond
	local var_7_7 = Mathf.Floor(var_7_6 / TimeUtil.OneMinuteSecond)

	if var_7_7 <= 0 then
		var_7_7 = "<1"
	end

	return var_7_7 .. var_7_2
end

function var_0_0._getUnlockEpisodeId(arg_8_0, arg_8_1)
	local var_8_0 = BossRushModel.instance:getStageLayersInfo(arg_8_1)

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		local var_8_1 = BossRushConfig.instance:getDungeonEpisodeCO(arg_8_1, iter_8_1.layer)

		if var_8_1 and var_8_1.preEpisode ~= 0 then
			return var_8_1.preEpisode
		end
	end
end

function var_0_0._isOpen(arg_9_0)
	local var_9_0 = arg_9_0:_getStage()

	if not BossRushModel.instance:isBossOnline(var_9_0) then
		return false
	end

	return BossRushModel.instance:isBossOpen(var_9_0)
end

function var_0_0._initAssessIcon(arg_10_0)
	local var_10_0 = ViewMgr.instance:getContainer(ViewName.V1a4_BossRushMainView)
	local var_10_1 = V1a4_BossRush_AssessIcon
	local var_10_2 = BossRushEnum.ResPath.v1a4_bossrush_mainview_assessicon
	local var_10_3 = var_10_1.__cname
	local var_10_4 = var_10_0:getResInst(var_10_2, arg_10_0._goAssessIcon, var_10_3)

	arg_10_0._assessIcon = MonoHelper.addNoUpdateLuaComOnceToGo(var_10_4, var_10_1)

	arg_10_0._assessIcon:initData(arg_10_0, false)

	local var_10_5 = var_10_0:getResInst(var_10_2, arg_10_0._goSpecialAssessIcon, var_10_3)

	arg_10_0._spAssessIcon = MonoHelper.addNoUpdateLuaComOnceToGo(var_10_5, var_10_1)

	arg_10_0._spAssessIcon:initData(arg_10_0, false)
end

function var_0_0.onDestroyView(arg_11_0)
	var_0_0.super.onDestroyView(arg_11_0)
	arg_11_0._simageLocked:UnLoadImage()
end

return var_0_0
