module("modules.logic.versionactivity2_1.aergusi.view.AergusiEnterView", package.seeall)

local var_0_0 = class("AergusiEnterView", VersionActivityEnterBaseSubView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#simage_Title")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Right/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "Right/#txt_Descr")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Enter")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_Enter/#go_reddot")
	arg_1_0._btnLocked = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Locked")
	arg_1_0._txtUnLocked = gohelper.findChildText(arg_1_0.viewGO, "Right/#btn_Locked/#txt_UnLocked")
	arg_1_0._goTry = gohelper.findChild(arg_1_0.viewGO, "Right/#go_Try")
	arg_1_0._goTips = gohelper.findChild(arg_1_0.viewGO, "Right/#go_Try/#go_Tips")
	arg_1_0._simageReward = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#go_Try/#go_Tips/#simage_Reward")
	arg_1_0._btnTrial = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_Try/image_TryBtn")
	arg_1_0._txtNum = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#go_Try/#go_Tips/#txt_Num")
	arg_1_0._btnItem = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_Try/#go_Tips/#btn_item")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnEnter:AddClickListener(arg_2_0._btnEnterOnClick, arg_2_0)
	arg_2_0._btnLocked:AddClickListener(arg_2_0._btnLockedOnClick, arg_2_0)
	arg_2_0._btnTrial:AddClickListener(arg_2_0._btnTrailOnClick, arg_2_0)
	arg_2_0._btnItem:AddClickListener(arg_2_0._btnItemOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnEnter:RemoveClickListener()
	arg_3_0._btnLocked:RemoveClickListener()
	arg_3_0._btnTrial:RemoveClickListener()
	arg_3_0._btnItem:RemoveClickListener()
end

function var_0_0._btnEnterOnClick(arg_4_0)
	AergusiController.instance:openAergusiLevelView()
end

function var_0_0._btnLockedOnClick(arg_5_0)
	local var_5_0, var_5_1 = OpenHelper.getToastIdAndParam(arg_5_0.actCo.openId)

	if var_5_0 and var_5_0 ~= 0 then
		GameFacade.showToastWithTableParam(var_5_0, var_5_1)
	end
end

function var_0_0._btnTrailOnClick(arg_6_0)
	if ActivityHelper.getActivityStatus(VersionActivity2_1Enum.ActivityId.Aergusi) == ActivityEnum.ActivityStatus.Normal then
		local var_6_0 = arg_6_0.actCo.tryoutEpisode

		if var_6_0 <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		local var_6_1 = DungeonConfig.instance:getEpisodeCO(var_6_0)

		DungeonFightController.instance:enterFight(var_6_1.chapterId, var_6_0)
	else
		arg_6_0:_clickLock()
	end
end

function var_0_0._btnItemOnClick(arg_7_0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.FreeDiamondCoupon, false, nil, false)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0.actCo = ActivityConfig.instance:getActivityCo(VersionActivity2_1Enum.ActivityId.Aergusi)
	arg_8_0._txtDescr.text = arg_8_0.actCo.actDesc

	local var_8_0 = arg_8_0.actCo.tryoutEpisode
	local var_8_1 = 0
	local var_8_2 = false

	if var_8_0 > 0 then
		local var_8_3 = DungeonModel.instance:getEpisodeFirstBonus(var_8_0)

		var_8_1 = var_8_3[1] and var_8_3[1][3] or 0
	end

	arg_8_0._txtNum.text = var_8_1

	RedDotController.instance:addRedDot(arg_8_0._goreddot, RedDotEnum.DotNode.V2a1AergusiTaskRed, VersionActivity2_1Enum.ActivityId.Aergusi)
end

function var_0_0.onOpen(arg_9_0)
	var_0_0.super.onOpen(arg_9_0)
	arg_9_0:_refreshTime()
end

function var_0_0.onClose(arg_10_0)
	var_0_0.super.onClose(arg_10_0)
end

function var_0_0.everySecondCall(arg_11_0)
	arg_11_0:_refreshTime()
end

function var_0_0._refreshTime(arg_12_0)
	local var_12_0 = ActivityModel.instance:getActivityInfo()[VersionActivity2_1Enum.ActivityId.Aergusi]

	if var_12_0 then
		local var_12_1 = var_12_0:getRealEndTimeStamp() - ServerTime.now()

		gohelper.setActive(arg_12_0._txtLimitTime.gameObject, var_12_1 > 0)

		if var_12_1 > 0 then
			local var_12_2 = TimeUtil.SecondToActivityTimeFormat(var_12_1)

			arg_12_0._txtLimitTime.text = var_12_2
		end

		local var_12_3 = ActivityHelper.getActivityStatus(VersionActivity2_1Enum.ActivityId.Aergusi) ~= ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(arg_12_0._btnEnter, not var_12_3)
		gohelper.setActive(arg_12_0._btnLocked, var_12_3)
	end
end

return var_0_0
