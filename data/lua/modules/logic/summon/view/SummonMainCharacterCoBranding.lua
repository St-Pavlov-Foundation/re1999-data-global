module("modules.logic.summon.view.SummonMainCharacterCoBranding", package.seeall)

local var_0_0 = class("SummonMainCharacterCoBranding", SummonMainCharacterProbUp)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goui = gohelper.findChild(arg_1_0.viewGO, "#go_ui")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_bg")
	arg_1_0._simagerole1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/node1/#simage_role1")
	arg_1_0._simagetitle1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/title/#simage_title1")
	arg_1_0._simagelogo = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/title/#simage_logo")
	arg_1_0._gocharacteritem1 = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/right/#go_characteritem1")
	arg_1_0._txtgoto = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/current/right/#go_characteritem1/btn_goto/#txt_goto")
	arg_1_0._txttimes = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/current/first/#txt_times")
	arg_1_0._txtdeadline = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/current/#txt_deadline")
	arg_1_0._simageline = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#txt_deadline/#simage_line")
	arg_1_0._btnsummon1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/summonbtns/summon1/#btn_summon1")
	arg_1_0._simagecurrency1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/summonbtns/summon1/currency/#simage_currency1")
	arg_1_0._txtcurrency11 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_1")
	arg_1_0._txtcurrency12 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_2")
	arg_1_0._btnsummon10 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/summonbtns/summon10/#btn_summon10")
	arg_1_0._simagecurrency10 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/summonbtns/summon10/currency/#simage_currency10")
	arg_1_0._txtcurrency101 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_1")
	arg_1_0._txtcurrency102 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_2")
	arg_1_0._btngift = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/#btn_gift")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_lefttop")
	arg_1_0._gorighttop = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_righttop")
	arg_1_0._txtpreferential = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/current/first/#txt_times")
	arg_1_0._gopreferential = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/first")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnsummon1:AddClickListener(arg_2_0._btnsummon1OnClick, arg_2_0)
	arg_2_0._btnsummon10:AddClickListener(arg_2_0._btnsummon10OnClick, arg_2_0)
	arg_2_0._btnclaim:AddClickListener(arg_2_0._btnclaimOnClick, arg_2_0)
	arg_2_0._btngoto:AddClickListener(arg_2_0._btngotoOnClick, arg_2_0)

	if arg_2_0._btngift then
		arg_2_0._btngift:AddClickListener(arg_2_0._btngiftOnClick, arg_2_0)
	end
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnsummon1:RemoveClickListener()
	arg_3_0._btnsummon10:RemoveClickListener()
	arg_3_0._btnclaim:RemoveClickListener()
	arg_3_0._btngoto:RemoveClickListener()

	if arg_3_0._btngift then
		arg_3_0._btngift:RemoveClickListener()
	end
end

function var_0_0._btnsummon1OnClick(arg_4_0)
	var_0_0.super._btnsummon1OnClick(arg_4_0)
end

function var_0_0._btnsummon10OnClick(arg_5_0)
	var_0_0.super._btnsummon10OnClick(arg_5_0)
end

function var_0_0._btnclaimOnClick(arg_6_0)
	local var_6_0 = SummonMainModel.instance:getCurPool()

	arg_6_0._nextRewardsRequestTime = arg_6_0._nextRewardsRequestTime or 0

	if var_6_0 and arg_6_0._nextRewardsRequestTime <= Time.time then
		arg_6_0._nextRewardsRequestTime = Time.time + 0.3

		SummonRpc.instance:sendGetSummonProgressRewardsRequest(var_6_0.id)
	end
end

function var_0_0._btngotoOnClick(arg_7_0)
	local var_7_0 = SummonMainModel.instance:getCurPool()

	if var_7_0 then
		SummonMainController.instance:openpPogressRewardView(var_7_0.id)
	end
end

function var_0_0._btngiftOnClick(arg_8_0)
	local var_8_0 = SummonMainModel.instance:getCurPool()

	if var_8_0 then
		local var_8_1 = var_8_0.id
		local var_8_2 = SummonEnum.CharacterCoBrandingGiftView[var_8_0.customClz]

		ViewMgr.instance:openView(var_8_2 or ViewName.V2a9_LinkGiftView, {
			poolId = var_8_1
		})

		if StoreGoodsTaskController.instance:isHasNewRedDotByPoolId(var_8_1) then
			StoreGoodsTaskController.instance:clearNewRedDotByPoolId(var_8_1)
			StoreGoodsTaskController.instance:waitUpdateRedDot(var_8_1)
			arg_8_0:_refreshGift()
		end
	end
end

function var_0_0._editableInitView(arg_9_0)
	var_0_0.super._editableInitView(arg_9_0)

	arg_9_0._btnclaim = gohelper.findChildButtonWithAudio(arg_9_0.viewGO, "#go_ui/current/right/#go_characteritem1/btn_claim")
	arg_9_0._btngoto = gohelper.findChildButtonWithAudio(arg_9_0.viewGO, "#go_ui/current/right/#go_characteritem1/btn_goto")
	arg_9_0._goallGet = gohelper.findChild(arg_9_0.viewGO, "#go_ui/current/right/#go_characteritem1/go_allGet")
	arg_9_0._gogifgReddot = gohelper.findChild(arg_9_0.viewGO, "#go_ui/#btn_gift/go_reddot")
	arg_9_0._animcharacter = gohelper.findChildComponent(arg_9_0.viewGO, "#go_ui/current/right/#go_characteritem1", gohelper.Type_Animator)

	if arg_9_0._gogifgReddot then
		arg_9_0._redotComp = RedDotController.instance:addNotEventRedDot(arg_9_0._gogifgReddot, arg_9_0._checkRedPointFunc, arg_9_0, RedDotEnum.Style.NewTag)
	end
end

function var_0_0.onUpdateParam(arg_10_0)
	var_0_0.super.onUpdateParam(arg_10_0)
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0:addEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, arg_11_0._refreshProgressRewards, arg_11_0)
	arg_11_0:addEventCb(SummonController.instance, SummonEvent.onSummonProgressRewards, arg_11_0._refreshProgressRewards, arg_11_0)
	arg_11_0:addEventCb(TaskController.instance, TaskEvent.SetTaskList, arg_11_0._refreshGift, arg_11_0)
	arg_11_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_11_0._refreshGift, arg_11_0)
	arg_11_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_11_0._checkCanFinishGiftTask, arg_11_0)
	arg_11_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_11_0._onCloseViewEvent, arg_11_0)
	var_0_0.super.onOpen(arg_11_0)
	arg_11_0:_refreshProgressRewards()
	arg_11_0:_refreshGift()

	if arg_11_0:_checkCanFinishGiftTask() then
		StoreGoodsTaskController.instance:autoFinishTaskByPoolId(SummonMainModel.instance:getCurId())
	end

	arg_11_0:_refreshPreferentialInfo()
end

function var_0_0._checkCanFinishGiftTask(arg_12_0)
	local var_12_0 = SummonMainModel.instance:getCurId()

	if var_12_0 and StoreGoodsTaskController.instance:isHasCanFinishTaskByPoolId(var_12_0) then
		arg_12_0._isHasCanFinishTask = true

		return true
	end

	return false
end

function var_0_0.onClose(arg_13_0)
	arg_13_0:removeEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, arg_13_0._refreshProgressRewards, arg_13_0)
	arg_13_0:removeEventCb(SummonController.instance, SummonEvent.onSummonProgressRewards, arg_13_0._refreshProgressRewards, arg_13_0)
	arg_13_0:removeEventCb(TaskController.instance, TaskEvent.SetTaskList, arg_13_0._refreshGift, arg_13_0)
	arg_13_0:removeEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_13_0._refreshGift, arg_13_0)
	arg_13_0:removeEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_13_0._checkCanFinishGiftTask, arg_13_0)
	arg_13_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_13_0._onCloseViewEvent, arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._onRunTaskOpenGiftView, arg_13_0)
	var_0_0.super.onClose(arg_13_0)
end

function var_0_0.onDestroyView(arg_14_0)
	var_0_0.super.onDestroyView(arg_14_0)
end

function var_0_0._adLoaded(arg_15_0)
	return
end

function var_0_0._onCloseViewEvent(arg_16_0, arg_16_1)
	if arg_16_0._isHasCanFinishTask then
		TaskDispatcher.cancelTask(arg_16_0._onRunTaskOpenGiftView, arg_16_0)
		TaskDispatcher.runDelay(arg_16_0._onRunTaskOpenGiftView, arg_16_0, 0.1)
	end
end

function var_0_0._onRunTaskOpenGiftView(arg_17_0)
	if arg_17_0._isHasCanFinishTask and ViewHelper.instance:checkViewOnTheTop(arg_17_0.viewName) then
		arg_17_0._isHasCanFinishTask = false

		arg_17_0:_btngiftOnClick()
	end
end

function var_0_0._refreshProgressRewards(arg_18_0)
	local var_18_0 = SummonMainModel.instance:getCurPool()

	if not var_18_0 or string.nilorempty(var_18_0.progressRewards) then
		return
	end

	local var_18_1 = SummonMainModel.instance:getPoolServerMO(var_18_0.id)

	if not var_18_1 then
		return
	end

	local var_18_2 = false
	local var_18_3 = false
	local var_18_4 = var_18_1.customPickMO:getRewardCount() or 0
	local var_18_5 = var_18_1.summonCount or 0
	local var_18_6 = 0
	local var_18_7 = 0
	local var_18_8
	local var_18_9 = SummonConfig.instance:getProgressRewardsByPoolId(var_18_0.id)

	if var_18_9 and #var_18_9 > 0 then
		var_18_6 = #var_18_9

		for iter_18_0, iter_18_1 in ipairs(var_18_9) do
			local var_18_10 = iter_18_1[1]
			local var_18_11 = iter_18_1[2]

			if var_18_10 <= var_18_5 then
				var_18_7 = var_18_7 + 1
			elseif not var_18_8 or var_18_10 < var_18_8 then
				var_18_8 = var_18_10
			end
		end
	end

	gohelper.setActive(arg_18_0._goallGet, var_18_6 <= var_18_4)
	gohelper.setActive(arg_18_0._txtgoto, var_18_4 < var_18_6)
	gohelper.setActive(arg_18_0._btnclaim, var_18_4 < var_18_7)

	if var_18_4 < var_18_6 then
		if var_18_8 and var_18_5 < var_18_8 then
			arg_18_0._txtgoto.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("summonmaincharacter_progress_rewards"), var_18_8 - var_18_5)

			local var_18_12 = "summonmaincharacter_progress_rewards" .. var_18_0.id

			arg_18_0:_playNumAninByKey(var_18_12, var_18_5)
		elseif var_18_4 < var_18_7 then
			arg_18_0._txtgoto.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("summonmaincharacter_progress_rewards_full"), var_18_7 - var_18_4)

			local var_18_13 = "summonmaincharacter_progress_rewards_full" .. var_18_0.id

			arg_18_0:_playNumAninByKey(var_18_13, 1)
		else
			arg_18_0._txtgoto.text = ""
		end
	end

	arg_18_0:_refreshPreferentialInfo()
end

function var_0_0._playNumAninByKey(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = PlayerModel.instance:getPlayerPrefsKey(arg_19_1)
	local var_19_1 = PlayerPrefsHelper.getNumber(var_19_0, -1)

	PlayerPrefsHelper.setNumber(var_19_0, arg_19_2)

	if var_19_1 ~= -1 and var_19_1 ~= arg_19_2 and arg_19_0._animcharacter then
		arg_19_0._animcharacter:Play("num", 0, 0)
	end
end

function var_0_0._refreshGift(arg_20_0)
	local var_20_0 = SummonMainModel.instance:getCurPool()
	local var_20_1 = var_20_0 and StoreConfig.instance:getCharageGoodsCfgListByPoolId(var_20_0.id)
	local var_20_2 = false

	if var_20_1 then
		for iter_20_0, iter_20_1 in ipairs(var_20_1) do
			local var_20_3 = StoreModel.instance:getGoodsMO(iter_20_1.id)

			if var_20_3 and (not var_20_3:isSoldOut() or StoreCharageConditionalHelper.isCharageTaskNotFinish(iter_20_1.id)) then
				var_20_2 = true

				break
			end
		end
	end

	if arg_20_0._redotComp then
		arg_20_0._redotComp:refreshRedDot()

		if not var_20_2 and arg_20_0._redotComp.isShowRedDot then
			var_20_2 = true
		end
	end

	gohelper.setActive(arg_20_0._btngift, var_20_2)
end

function var_0_0._checkRedPointFunc(arg_21_0)
	return StoreGoodsTaskController.instance:isHasNewRedDotByPoolId(SummonMainModel.instance:getCurId())
end

function var_0_0._refreshPreferentialInfo(arg_22_0)
	local var_22_0 = SummonMainModel.instance:getCurPool()

	if not var_22_0 then
		return
	end

	local var_22_1 = SummonMainModel.instance:getPoolServerMO(var_22_0.id)
	local var_22_2 = var_22_1.canGetGuaranteeSRCount

	if arg_22_0._gopreferential then
		gohelper.setActive(arg_22_0._gopreferential, var_22_2 > 0)

		if arg_22_0._txtpreferential and var_22_2 > 0 then
			local var_22_3 = var_22_1.guaranteeSRCountDown

			arg_22_0._txtpreferential.text = var_22_3
		end
	end
end

return var_0_0
