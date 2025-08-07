module("modules.logic.summon.controller.SummonController", package.seeall)

local var_0_0 = class("SummonController", BaseController)

var_0_0.SummonType = {
	SimulationPick = 2,
	Normal = 1
}

local var_0_1

function var_0_0.onInit(arg_1_0)
	arg_1_0.summonViewParam = nil
	arg_1_0._lastViewPoolId = 0
	arg_1_0._viewTime = nil
	arg_1_0._lastPoolId = nil
	arg_1_0.isWaitingSummonResult = false
	arg_1_0._poolInfoParam = nil
	arg_1_0._sendPoolId = nil
	arg_1_0._isInGuideAnim = false
	arg_1_0._isSkipInited = false
end

function var_0_0.reInit(arg_2_0)
	GameUtil.onDestroyViewMember(arg_2_0, "_simpleFlow")

	arg_2_0.summonViewParam = nil
	arg_2_0._lastViewPoolId = 0
	arg_2_0._viewTime = nil
	arg_2_0._lastPoolId = nil
	arg_2_0.isWaitingSummonResult = false
	arg_2_0._poolInfoParam = nil
	arg_2_0._sendPoolId = nil
	arg_2_0._isInGuideAnim = false
	arg_2_0._isSkipInited = false
	var_0_1 = nil
end

function var_0_0.onInitFinish(arg_3_0)
	return
end

function var_0_0.addConstEvents(arg_4_0)
	GuideController.instance:registerCallback(GuideEvent.SpecialEventStart, arg_4_0._guideSpecialEventStart, arg_4_0)
	arg_4_0:registerCallback(SummonEvent.onSummonPoolHistorySummonRequest, arg_4_0._onSummonPoolHistorySummonRequest, arg_4_0)
end

function var_0_0._onSummonPoolHistorySummonRequest(arg_5_0, arg_5_1)
	SummonPoolHistoryModel.instance:addRequestHistoryPool(arg_5_1)

	var_0_1 = arg_5_1
end

function var_0_0._guideSpecialEventStart(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_1 == GuideEnum.SpecialEventEnum.SummonOpen then
		arg_6_0:_playerGuideOpenAnimation()
	elseif arg_6_1 == GuideEnum.SpecialEventEnum.SummonFog then
		arg_6_0:_playGuideWaterAnimation()
	elseif arg_6_1 == GuideEnum.SpecialEventEnum.SummonWheel then
		arg_6_0:_playGuideWheelAnimation()
	elseif arg_6_1 == GuideEnum.SpecialEventEnum.SummonTouch then
		arg_6_0:_guideTouch(arg_6_2, arg_6_3)
	end
end

function var_0_0.jumpSummon(arg_7_0, arg_7_1)
	local var_7_0 = {
		jumpPoolId = arg_7_1
	}

	arg_7_0:enterSummonScene(var_7_0)
end

function var_0_0.jumpSummonByGroup(arg_8_0, arg_8_1)
	local var_8_0 = {
		jumpGroupId = arg_8_1
	}

	arg_8_0:enterSummonScene(var_8_0)
end

function var_0_0.enterSummonScene(arg_9_0, arg_9_1)
	arg_9_0.summonViewParam = arg_9_1 or {}

	GameGCMgr.instance:dispatchEvent(GameGCEvent.CancelDelayFullGC)

	local var_9_0 = true

	if arg_9_0:isInSummonGuide() then
		arg_9_0.summonViewParam.jumpPoolId = SummonEnum.GuidePoolId
		var_9_0 = false
	end

	if not var_9_0 then
		ViewMgr.instance:openView(ViewName.SummonView)
		VirtualSummonScene.instance:openSummonScene(true)
	else
		SummonRpc.instance:sendGetSummonInfoRequest(arg_9_0.jumpCheckWhenReceiveInfo, arg_9_0)
	end
end

function var_0_0.jumpCheckWhenReceiveInfo(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_2 ~= 0 then
		return
	end

	if not LoginController.instance:isEnteredGame() then
		return
	end

	if arg_10_0.summonViewParam ~= nil then
		if arg_10_0:jumpCheckGroupParam() then
			return
		end

		if SummonMainModel.instance:hasPoolAvailable(arg_10_0.summonViewParam.jumpPoolId) then
			SummonMainController.instance:openSummonView(arg_10_0.summonViewParam, true, arg_10_0.onSummonADOpened)

			return
		end
	end

	GameFacade.showToast(ToastEnum.SummonNoOpen)
end

function var_0_0.jumpCheckGroupParam(arg_11_0)
	if arg_11_0.summonViewParam.jumpGroupId then
		local var_11_0 = SummonMainModel.instance:hasPoolGroupAvailable(arg_11_0.summonViewParam.jumpGroupId)

		if var_11_0 then
			arg_11_0.summonViewParam.jumpPoolId = var_11_0.id

			logNormal("jump group id = " .. tostring(var_11_0.id))
			SummonMainController.instance:openSummonView(arg_11_0.summonViewParam, true, arg_11_0.onSummonADOpened)

			return true
		end

		GameFacade.showToast(ToastEnum.SummonGroupNoOpen)

		return true
	end

	return false
end

function var_0_0.onSummonADOpened()
	if not LoginController.instance:isEnteredGame() then
		return
	end

	VirtualSummonScene.instance:openSummonScene(false)
end

function var_0_0.isPreloadReadyToSummon(arg_13_0, arg_13_1)
	return VirtualSummonScene.instance:getSummonScene().director:isPreloadReady(arg_13_1)
end

function var_0_0.isSelectorReadyToSummon(arg_14_0, arg_14_1)
	return VirtualSummonScene.instance:getSummonScene().selector:isSceneGOInited(arg_14_1)
end

var_0_0.GachaBlockKey = "SummonSuccessAnim"

function var_0_0.summonSuccess(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0:getSendPoolId()

	arg_15_0.callingType = arg_15_2 or SummonEnum.SummonCallingType.Summon

	SummonModel.instance:updateSummonResult(arg_15_1, var_15_0)
	SummonPoolHistoryModel.instance:updateSummonResult(arg_15_1)

	local var_15_1 = SummonMainModel.getResultTypeById(var_15_0) == SummonEnum.ResultType.Char

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(var_0_0.GachaBlockKey)
	arg_15_0:dispatchEvent(SummonEvent.summonShowExitAnim)

	if arg_15_0:isSelectorReadyToSummon(var_15_1) and arg_15_0:isPreloadReadyToSummon(var_15_1) then
		TaskDispatcher.runDelay(arg_15_0.onExitSceneAnimFinish, arg_15_0, 0.3)
		arg_15_0:dispatchEvent(SummonEvent.summonShowBlackScreen)
	else
		logNormal("waiting for summon preload")
		arg_15_0:dispatchEvent(SummonEvent.summonShowBlackScreen)
	end
end

function var_0_0.getResultViewName(arg_16_0)
	if arg_16_0.callingType == SummonEnum.SummonCallingType.SummonSimulation then
		return ViewName.SummonSimulationResultView
	else
		return ViewName.SummonResultView
	end
end

function var_0_0.closeBlockMask(arg_17_0)
	UIBlockMgr.instance:endBlock(var_0_0.GachaBlockKey)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.onExitSceneAnimFinish(arg_18_0)
	arg_18_0:closeBlockMask()

	if SummonMainController.instance:getNeedGetInfo() then
		SummonRpc.instance:sendGetSummonInfoRequest()
	end

	arg_18_0:dispatchEvent(SummonEvent.summonMainCloseImmediately)
	arg_18_0:dispatchEvent(SummonEvent.onSummonReply)
end

function var_0_0.onFirstLoadSceneBlock(arg_19_0)
	if SummonMainController.instance:getNeedGetInfo() then
		SummonRpc.instance:sendGetSummonInfoRequest()
	end

	local var_19_0 = SummonMainModel.getResultTypeById(arg_19_0:getSendPoolId()) == SummonEnum.ResultType.Char

	if not arg_19_0:isPreloadReadyToSummon(var_19_0) then
		VirtualSummonScene.instance:registerCallback(SummonSceneEvent.OnPreloadFinishAtScene, arg_19_0.onSummonPreloadFinish, arg_19_0)
		VirtualSummonScene.instance:checkNeedLoad(var_19_0, true)
	elseif not arg_19_0:isSelectorReadyToSummon(var_19_0) then
		VirtualSummonScene.instance:getSummonScene().selector:initSceneGO(var_19_0)
		arg_19_0:closeBlackLoading()
	end
end

function var_0_0.onSummonPreloadFinish(arg_20_0, arg_20_1)
	local var_20_0 = SummonMainModel.getResultTypeById(arg_20_0:getSendPoolId()) == SummonEnum.ResultType.Char

	if var_20_0 == arg_20_1 then
		VirtualSummonScene.instance:unregisterCallback(SummonSceneEvent.OnPreloadFinishAtScene, arg_20_0.onSummonPreloadFinish, arg_20_0)

		if not arg_20_0:isSelectorReadyToSummon(var_20_0) then
			VirtualSummonScene.instance:getSummonScene().selector:initSceneGO(var_20_0)
		end

		logNormal("load SceneEnter completed")
		arg_20_0:closeBlackLoading()
	end
end

function var_0_0.closeBlackLoading(arg_21_0)
	arg_21_0:dispatchEvent(SummonEvent.summonCloseBlackScreen)
	arg_21_0:dispatchEvent(SummonEvent.onSummonReply)
	arg_21_0:closeBlockMask()
end

function var_0_0.getSceneNode(arg_22_0, arg_22_1)
	local var_22_0 = VirtualSummonScene.instance:getSummonScene().selector:getCurSceneGo()

	if var_22_0 then
		return gohelper.findChild(var_22_0, arg_22_1)
	end
end

function var_0_0.getAnim(arg_23_0)
	local var_23_0 = arg_23_0:getSceneNode("anim")

	if not var_23_0 then
		return
	end

	return (var_23_0:GetComponent(typeof(UnityEngine.Animator)))
end

function var_0_0.getAnimEventWrap(arg_24_0)
	local var_24_0 = arg_24_0:getSceneNode("anim")

	if not var_24_0 then
		return
	end

	return (var_24_0:GetComponent(typeof(ZProj.AnimationEventWrap)))
end

function var_0_0.playAnim(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = arg_25_0:getAnim()

	if not var_25_0 then
		return
	end

	var_25_0.enabled = true

	if arg_25_2 and arg_25_3 then
		var_25_0:Play(arg_25_1, arg_25_2, arg_25_3)
	else
		var_25_0:Play(arg_25_1)
	end

	var_25_0.speed = 1

	return var_25_0
end

function var_0_0.resetAnim(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:getAnim()

	if not var_26_0 then
		return
	end

	var_26_0.enabled = true

	local var_26_1 = arg_26_0:getLastPoolId()
	local var_26_2 = SummonMainModel.getResultTypeById(var_26_1)
	local var_26_3 = arg_26_0:isInSummonGuide()

	if var_26_3 and arg_26_1 then
		if var_26_2 == SummonEnum.ResultType.Char then
			var_26_0:Play(SummonEnum.GuideInitialStateAnimationName, 0, 0)

			arg_26_0._isInGuideAnim = true
		else
			var_26_0:Play(SummonEnum.InitialStateEquipAnimationName, 0, 0)

			arg_26_0._isInGuideAnim = false
		end
	elseif not var_26_3 then
		if var_26_2 == SummonEnum.ResultType.Char then
			var_26_0:Play(SummonEnum.InitialStateAnimationName, 0, 0)
		else
			var_26_0:Play(SummonEnum.InitialStateEquipAnimationName, 0, 0)
		end

		arg_26_0._isInGuideAnim = false
	end

	var_26_0:Update(0)

	var_26_0.speed = 0

	if not arg_26_1 then
		local var_26_4 = arg_26_0:getAnimEventWrap()

		if var_26_4 then
			var_26_4:RemoveAllEventListener()
		end
	end

	local var_26_5 = VirtualSummonScene.instance:getSummonScene().director:getDrawComp(var_26_2)

	if var_26_5 then
		var_26_5:setEffect(1)
	end
end

function var_0_0.startPlayAnim(arg_27_0)
	local var_27_0 = arg_27_0:getAnimEventWrap()

	if var_27_0 and not arg_27_0:getIsGuideAnim() then
		var_27_0:AddEventListener("show_guide", arg_27_0.onSummonStartShowGuide, arg_27_0)
		var_27_0:AddEventListener("enter_finish", arg_27_0.onSummonStartAnimFinish, arg_27_0)
	end

	local var_27_1 = arg_27_0:getAnim()

	if not var_27_1 then
		return
	end

	var_27_1.enabled = true
	var_27_1.speed = 1
end

function var_0_0.onSummonStartShowGuide(arg_28_0)
	arg_28_0:dispatchEvent(SummonEvent.onSummonAnimShowGuide)
end

function var_0_0.onSummonStartAnimFinish(arg_29_0)
	arg_29_0:dispatchEvent(SummonEvent.onSummonAnimEnterDraw)
end

function var_0_0.forbidAnim(arg_30_0)
	local var_30_0 = arg_30_0:getAnim()

	if not var_30_0 then
		return
	end

	var_30_0.enabled = false
end

function var_0_0.resetAnimScale(arg_31_0)
	local var_31_0 = arg_31_0:getAnim()

	if not gohelper.isNil(var_31_0) then
		transformhelper.setLocalScale(var_31_0.transform, 1, 1, 1)
	end
end

function var_0_0.drawAnim(arg_32_0)
	arg_32_0:playAnim(SummonEnum.TenAnimationName, 0, 0)

	local var_32_0 = arg_32_0:getAnimEventWrap()

	if var_32_0 then
		var_32_0:AddEventListener("rare_effect", arg_32_0.onSummonAnimRareEffect, arg_32_0)
		var_32_0:AddEventListener("draw_end", arg_32_0.onSummonAnimEnd, arg_32_0)
	end
end

function var_0_0.drawOnlyAnim(arg_33_0)
	arg_33_0:playAnim(SummonEnum.SingleAnimationName, 0, 0)

	local var_33_0 = arg_33_0:getAnimEventWrap()

	if var_33_0 then
		var_33_0:AddEventListener("rare_effect", arg_33_0.onSummonAnimRareEffect, arg_33_0)
		var_33_0:AddEventListener("draw_end", arg_33_0.onSummonAnimEnd, arg_33_0)
	end
end

function var_0_0.drawEquipAnim(arg_34_0)
	arg_34_0:playAnim(SummonEnum.EquipTenAnimationName, 0, 0)

	local var_34_0 = arg_34_0:getAnimEventWrap()

	if var_34_0 then
		var_34_0:AddEventListener("rare_effect", arg_34_0.onSummonAnimRareEffect, arg_34_0)
		var_34_0:AddEventListener("draw_end", arg_34_0.onSummonAnimEnd, arg_34_0)
	end
end

function var_0_0.drawEquipOnlyAnim(arg_35_0)
	arg_35_0:playAnim(SummonEnum.EquipSingleAnimationName, 0, 0)

	local var_35_0 = arg_35_0:getAnimEventWrap()

	if var_35_0 then
		var_35_0:AddEventListener("rare_effect", arg_35_0.onSummonAnimRareEffect, arg_35_0)
		var_35_0:AddEventListener("draw_end", arg_35_0.onSummonAnimEnd, arg_35_0)
	end
end

function var_0_0.playSkipAnimation(arg_36_0, arg_36_1)
	if arg_36_1 then
		arg_36_0:playAnim(SummonEnum.SummonSkipCharacterAnimationName, 0, 0)
	else
		arg_36_0:playAnim(SummonEnum.SummonSkipAnimationName, 0, 0)
	end
end

function var_0_0.onSummonAnimRareEffect(arg_37_0)
	arg_37_0:dispatchEvent(SummonEvent.onSummonAnimRareEffect)
end

function var_0_0.onSummonAnimEnd(arg_38_0)
	arg_38_0:dispatchEvent(SummonEvent.onSummonAnimEnd)
	GuideController.instance:dispatchEvent(GuideEvent.SpecialEventDone, GuideEnum.SpecialEventEnum.SummonDraw)
end

function var_0_0.getUINodes(arg_39_0)
	local var_39_0 = {}
	local var_39_1 = arg_39_0:getSceneNode("anim/StandStill/UI")

	if var_39_1 then
		local var_39_2 = {
			"001",
			"002",
			"003",
			"004",
			"005",
			"006",
			"007",
			"008",
			"009",
			"010"
		}

		for iter_39_0 = 1, 10 do
			local var_39_3 = gohelper.findChild(var_39_1, var_39_2[iter_39_0])

			table.insert(var_39_0, var_39_3)
		end
	end

	return var_39_0
end

function var_0_0.getOnlyUINode(arg_40_0)
	local var_40_0 = {}
	local var_40_1 = arg_40_0:getSceneNode("anim/StandStill/Only/UI")
	local var_40_2 = gohelper.findChild(var_40_1, "001")

	table.insert(var_40_0, var_40_2)

	return var_40_0
end

function var_0_0.getBoomNode(arg_41_0, arg_41_1)
	return arg_41_0:getSceneNode(arg_41_1 == SummonEnum.ResultType.Equip and "anim/boom" or "anim/StandStill/boom")
end

function var_0_0.statViewPoolDetail(arg_42_0, arg_42_1)
	arg_42_0:statExitPoolDetail()

	if not arg_42_1 then
		return
	end

	arg_42_0._viewTime = ServerTime.now()
	arg_42_0._lastViewPoolId = arg_42_1
end

function var_0_0.statExitPoolDetail(arg_43_0)
	if arg_43_0._viewTime and arg_43_0._lastViewPoolId then
		local var_43_0 = SummonConfig.instance:getSummonPool(arg_43_0._lastViewPoolId)

		if var_43_0 then
			local var_43_1 = ServerTime.now() - arg_43_0._viewTime

			StatController.instance:track(StatEnum.EventName.ClickPoolInfo, {
				[StatEnum.EventProperties.PoolId] = tonumber(arg_43_0._lastViewPoolId),
				[StatEnum.EventProperties.PoolName] = var_43_0.nameCn,
				[StatEnum.EventProperties.Time] = var_43_1
			})
		end
	end

	arg_43_0._viewTime = nil
	arg_43_0._lastViewPoolId = nil
end

function var_0_0.prepareSummon(arg_44_0)
	arg_44_0:resetAnim(true)
end

function var_0_0._playerGuideOpenAnimation(arg_45_0)
	TaskDispatcher.runDelay(function(arg_46_0)
		arg_46_0:playAnim(SummonEnum.SummonOpenAnimationName, 0, 0)
	end, arg_45_0, 0.3)

	local var_45_0 = arg_45_0:getAnimEventWrap()

	if var_45_0 then
		var_45_0:AddEventListener("anim_story01_end", function()
			GuideController.instance:dispatchEvent(GuideEvent.SpecialEventDone, GuideEnum.SpecialEventEnum.SummonOpen)
		end, nil)
	end
end

function var_0_0._playGuideWaterAnimation(arg_48_0)
	TaskDispatcher.runDelay(function(arg_49_0)
		arg_49_0:playAnim(SummonEnum.SummonFogAnimationName, 0, 0)
	end, arg_48_0, 0.3)

	local var_48_0 = arg_48_0:getAnimEventWrap()

	if var_48_0 then
		var_48_0:AddEventListener("anim_story02_end", function()
			GuideController.instance:dispatchEvent(GuideEvent.SpecialEventDone, GuideEnum.SpecialEventEnum.SummonFog)
		end, nil)
	end
end

function var_0_0._playGuideWheelAnimation(arg_51_0)
	arg_51_0:playAnim(SummonEnum.SummonWheelAnimationName, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Summon.Play_Chap0_SpinningWheel_Appear)

	local var_51_0 = arg_51_0:getAnimEventWrap()

	if var_51_0 then
		var_51_0:AddEventListener("anim_story03_end", function()
			GuideController.instance:dispatchEvent(GuideEvent.SpecialEventDone, GuideEnum.SpecialEventEnum.SummonWheel)
		end, nil)
	end
end

function var_0_0._guideTouch(arg_53_0, arg_53_1, arg_53_2)
	SummonModel.instance:setSendEquipFreeSummon(false)
	SummonRpc.instance:sendSummonRequest(SummonEnum.GuidePoolId, 1, arg_53_1, arg_53_2, arg_53_0._guideTouchReply, arg_53_0)
end

function var_0_0._guideTouchReply(arg_54_0, arg_54_1, arg_54_2, arg_54_3)
	if arg_54_2 == 0 then
		GuideController.instance:dispatchEvent(GuideEvent.SpecialEventDone, GuideEnum.SpecialEventEnum.SummonTouch)
	end
end

function var_0_0.setLastPoolId(arg_55_0, arg_55_1)
	arg_55_0._lastPoolId = arg_55_1
end

function var_0_0.getLastPoolId(arg_56_0)
	return arg_56_0._lastPoolId
end

function var_0_0.setPoolInfo(arg_57_0, arg_57_1)
	arg_57_0._poolInfoParam = arg_57_1
end

function var_0_0.getPoolInfo(arg_58_0)
	return arg_58_0._poolInfoParam
end

function var_0_0.getIsGuideAnim(arg_59_0)
	return arg_59_0._isInGuideAnim
end

function var_0_0.setSendPoolId(arg_60_0, arg_60_1)
	arg_60_0._sendPoolId = arg_60_1

	arg_60_0:setLastPoolId(arg_60_1)
end

function var_0_0.getSendPoolId(arg_61_0)
	return arg_61_0._sendPoolId
end

function var_0_0.updateSummonInfo(arg_62_0, arg_62_1)
	SummonModel.instance:setFreeEquipSummon(arg_62_1.freeEquipSummon)
	SummonMainModel.instance:setNewbiePoolExist(arg_62_1.isShowNewSummon)
	SummonMainModel.instance:setNewbieProgress(arg_62_1.newSummonCount)
	SummonMainModel.instance:setServerPoolInfos(arg_62_1.poolInfos)
	SummonMainModel.instance:updateByServerData()

	if SummonMainModel.instance:getCount() <= 0 then
		local var_62_0 = "没有卡池定位 time = %s, cfgCount = %s, info = %s"
		local var_62_1 = SummonConfig.instance:getValidPoolList()

		if var_62_1 then
			logError(string.format(var_62_0, ServerTime.now(), #var_62_1, tostring(arg_62_1)))
		end
	end

	arg_62_0:dispatchEvent(SummonEvent.onSummonInfoGot)
end

function var_0_0.summonProgressRewards(arg_63_0, arg_63_1)
	local var_63_0 = SummonMainModel.instance:getPoolServerMO(arg_63_1.poolId)

	if var_63_0 and var_63_0.customPickMO then
		var_63_0.customPickMO.hasGetRewardProgresses = arg_63_1.hasGetRewardProgresses or {}
	end

	arg_63_0:dispatchEvent(SummonEvent.onSummonProgressRewards)
end

function var_0_0.insertSummonPopupList(arg_64_0, arg_64_1, arg_64_2, arg_64_3)
	arg_64_0._popupParams = arg_64_0._popupParams or {}

	local var_64_0 = {
		priority = arg_64_1,
		viewName = arg_64_2,
		param = arg_64_3
	}

	table.insert(arg_64_0._popupParams, var_64_0)
end

function var_0_0.nextSummonPopupParam(arg_65_0)
	if arg_65_0._popupParams and #arg_65_0._popupParams > 0 then
		local var_65_0 = table.remove(arg_65_0._popupParams, 1)

		PopupController.instance:addPopupView(var_65_0.priority, var_65_0.viewName, var_65_0.param)

		return true
	end

	return false
end

function var_0_0.clearSummonPopupList(arg_66_0)
	arg_66_0._popupParams = {}
end

function var_0_0.getCharScenePrefabPath()
	return SummonEnum.SummonCharScenePath
end

function var_0_0.isInSummonGuide(arg_68_0)
	return GuideController.instance:isGuiding() and SummonEnum.GuideIdSet[GuideModel.instance:getDoingGuideId()]
end

function var_0_0.doVirtualSummonBehavior(arg_69_0, arg_69_1, arg_69_2, arg_69_3, arg_69_4, arg_69_5, arg_69_6)
	if not arg_69_1 then
		return
	end

	if #arg_69_1 <= 0 then
		return
	end

	local var_69_0 = {
		hideADView = arg_69_3,
		jumpPoolId = SummonEnum.PoolId.Normal
	}

	arg_69_0:enterSummonScene(var_69_0)

	local var_69_1 = arg_69_0:getVirtualSummonResult(arg_69_1, false, arg_69_2)

	arg_69_0:summonSuccess(var_69_1, SummonEnum.SummonCallingType.SummonSimulation)
	var_0_0.instance:setSummonEndOpenCallBack(arg_69_4, arg_69_5)

	if arg_69_6 then
		TaskDispatcher.runDelay(arg_69_0.autoCloseBlur, arg_69_0, 1.5)
	end
end

function var_0_0.autoCloseBlur(arg_70_0)
	TaskDispatcher.cancelTask(arg_70_0.autoCloseBlur, arg_70_0)
	UIBlockMgr.instance:endAll()
	PostProcessingMgr.instance:forceRefreshCloseBlur()
end

function var_0_0.getVirtualSummonResult(arg_71_0, arg_71_1, arg_71_2, arg_71_3)
	arg_71_2 = arg_71_2 or false

	local var_71_0 = {}

	if not arg_71_1 then
		return var_71_0
	end

	local var_71_1 = #arg_71_1

	if var_71_1 <= 0 then
		return var_71_0
	end

	local var_71_2 = {}
	local var_71_3 = {}

	for iter_71_0 = 1, var_71_1 do
		local var_71_4 = arg_71_1[iter_71_0]

		if var_71_3[var_71_4] then
			var_71_3[var_71_4] = var_71_3[var_71_4] + 1
		else
			var_71_3[var_71_4] = 1
		end
	end

	for iter_71_1 = 1, var_71_1 do
		local var_71_5 = arg_71_1[iter_71_1]
		local var_71_6 = arg_71_0:haveHero(var_71_5)
		local var_71_7 = arg_71_0:getHeroDuplicateCount(var_71_5)

		if arg_71_3 then
			local var_71_8 = var_71_3[var_71_5]

			var_71_7 = math.max(0, var_71_7 - var_71_8)
			var_71_6 = var_71_7 > 0
		end

		if var_71_2[var_71_5] then
			var_71_7 = var_71_2[var_71_5] + 1
			var_71_2[var_71_5] = var_71_7
		else
			var_71_2[var_71_5] = var_71_7
		end

		local var_71_9 = not var_71_6
		local var_71_10 = {
			heroId = var_71_5,
			duplicateCount = var_71_7,
			isNew = var_71_9
		}

		table.insert(var_71_0, var_71_10)
	end

	if arg_71_2 then
		SummonModel.sortResult(var_71_0, nil)
	end

	return var_71_0
end

function var_0_0.haveHero(arg_72_0, arg_72_1)
	local var_72_0 = HeroModel.instance:getByHeroId(arg_72_1)

	return var_72_0 ~= nil and var_72_0.exSkillLevel >= 0
end

function var_0_0.getHeroDuplicateCount(arg_73_0, arg_73_1)
	local var_73_0 = HeroModel.instance:getByHeroId(arg_73_1)

	if var_73_0 then
		return var_73_0.duplicateCount + 1
	end

	return 0
end

function var_0_0.getSummonEndOpenCallBack(arg_74_0)
	return arg_74_0.summonEndOpenCallBack
end

function var_0_0.setSummonEndOpenCallBack(arg_75_0, arg_75_1, arg_75_2)
	if arg_75_0.summonEndOpenCallBack then
		LuaGeneralCallback.getPool():putObject(arg_75_0.summonEndOpenCallBack)

		arg_75_0.summonEndOpenCallBack = nil
	end

	if arg_75_1 ~= nil and arg_75_2 ~= nil then
		local var_75_0 = LuaGeneralCallback.getPool():getObject()

		var_75_0.callback = arg_75_1

		var_75_0:setCbObj(arg_75_2)

		arg_75_0.summonEndOpenCallBack = var_75_0
	end
end

function var_0_0.getLimitedHeroSkinIdsByPopupParam(arg_76_0)
	if not arg_76_0._popupParams then
		return
	end

	local var_76_0 = {}

	if #arg_76_0._popupParams <= 0 then
		for iter_76_0 = 1, 10 do
			local var_76_1, var_76_2 = SummonModel.instance:openSummonResult(iter_76_0)

			if var_76_1 then
				local var_76_3 = var_76_1.heroId
				local var_76_4 = arg_76_0:getMvSkinIdByHeroId(var_76_3)

				if var_76_4 then
					var_76_0[var_76_3] = var_76_4
				end
			end
		end
	end

	for iter_76_1 = 1, #arg_76_0._popupParams do
		local var_76_5 = arg_76_0._popupParams[iter_76_1]

		if var_76_5.viewName == ViewName.CharacterGetView then
			local var_76_6 = var_76_5.param.heroId
			local var_76_7 = arg_76_0:getMvSkinIdByHeroId(var_76_6)

			if var_76_7 then
				var_76_0[var_76_6] = var_76_7
			end
		end
	end

	return var_76_0
end

function var_0_0.getMvSkinIdByHeroId(arg_77_0, arg_77_1)
	if VersionValidator.instance:isInReviewing() then
		return nil
	end

	if not arg_77_1 then
		return nil
	end

	local var_77_0 = HeroModel.instance:getByHeroId(arg_77_1)

	if var_77_0 and var_77_0.config then
		local var_77_1 = var_77_0.config
		local var_77_2 = lua_character_limited.configDict[var_77_1.mvskinId]

		if var_77_1 and var_77_1.mvskinId and var_77_2 and not string.nilorempty(var_77_2.entranceMv) then
			return var_77_1.mvskinId
		end
	end

	return nil
end

function var_0_0._trackSummonClientEvent(arg_78_0, arg_78_1, arg_78_2, arg_78_3)
	SDKDataTrackMgr.instance:track("summon_client", {
		poolid = arg_78_1 or -1,
		entrance = arg_78_2 or "",
		position_list = arg_78_3 or ""
	})
end

function var_0_0.trackSummonClientEvent(arg_79_0, arg_79_1, arg_79_2)
	local var_79_0 = var_0_1
	local var_79_1 = arg_79_1 and "skip" or "rotate"
	local var_79_2 = ""

	if arg_79_1 then
		if type(arg_79_2) == "table" then
			local var_79_3 = arg_79_2.st
			local var_79_4 = string.format("%0.2f", var_79_3.x)
			local var_79_5 = string.format("%0.2f", var_79_3.y)

			var_79_2 = string.format("[(%s, %s)]", var_79_4, var_79_5)
		end

		var_0_0.instance:_trackSummonClientEvent(var_79_0, var_79_1, var_79_2)
	else
		if type(arg_79_2) == "table" then
			local var_79_6 = arg_79_2.st
			local var_79_7 = arg_79_2.ed
			local var_79_8 = string.format("%0.2f", var_79_6.x)
			local var_79_9 = string.format("%0.2f", var_79_6.y)
			local var_79_10 = string.format("%0.2f", var_79_7.x)
			local var_79_11 = string.format("%0.2f", var_79_7.y)

			var_79_2 = string.format("[(%s, %s), (%s, %s)]", var_79_8, var_79_9, var_79_10, var_79_11)
		end

		var_0_0.instance:_trackSummonClientEvent(var_79_0, var_79_1, var_79_2)
	end
end

function var_0_0.simpleEnterSummonScene(arg_80_0, arg_80_1, arg_80_2)
	GameUtil.onDestroyViewMember(arg_80_0, "_simpleFlow")

	arg_80_0._simpleFlow = VirtualSummonBehaviorFlow.New()

	arg_80_0._simpleFlow:start(arg_80_1, arg_80_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
