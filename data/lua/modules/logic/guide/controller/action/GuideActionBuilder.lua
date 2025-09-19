module("modules.logic.guide.controller.action.GuideActionBuilder", package.seeall)

local var_0_0 = class("GuideActionBuilder")

function var_0_0.ctor(arg_1_0)
	arg_1_0._ActionType2Impl = {}
	var_0_0.ActionType2Impl = arg_1_0._ActionType2Impl
	arg_1_0._ActionType2Impl[101] = GuideActionPlayStory
	arg_1_0._ActionType2Impl[102] = GuideActionEnterEpisode
	arg_1_0._ActionType2Impl[103] = GuideActionExitEpisode
	arg_1_0._ActionType2Impl[104] = GuideActionCloseView
	arg_1_0._ActionType2Impl[105] = GuideActionOpenView
	arg_1_0._ActionType2Impl[106] = GuideActionEnterScene
	arg_1_0._ActionType2Impl[107] = GuideActionOpenHelpView
	arg_1_0._ActionType2Impl[108] = GuideActionSkillContinue
	arg_1_0._ActionType2Impl[109] = GuideActionEntityDeadContinue
	arg_1_0._ActionType2Impl[110] = GuideActionJump
	arg_1_0._ActionType2Impl[111] = GuideActionEnableClick
	arg_1_0._ActionType2Impl[112] = GuideActionEnablePress
	arg_1_0._ActionType2Impl[113] = GuideActionDispatchFightEvent
	arg_1_0._ActionType2Impl[114] = GuideActionTriggerGuide
	arg_1_0._ActionType2Impl[115] = GuideActionDispatchEvent
	arg_1_0._ActionType2Impl[116] = GuideActionSetFlag
	arg_1_0._ActionType2Impl[117] = GuideActionPlayEffect
	arg_1_0._ActionType2Impl[118] = GuideActionPlayAnimator
	arg_1_0._ActionType2Impl[119] = GuideActionFightVictory
	arg_1_0._ActionType2Impl[120] = GuideActionLockGuide
	arg_1_0._ActionType2Impl[121] = GuideActionRoomFixBlockMaskPos
	arg_1_0._ActionType2Impl[122] = GuideActionRoomFocusBlock
	arg_1_0._ActionType2Impl[123] = GuideActionOpenCommonPropView
	arg_1_0._ActionType2Impl[125] = GuideActionSetNextStepGOPath
	arg_1_0._ActionType2Impl[126] = GuideActionShowToast
	arg_1_0._ActionType2Impl[127] = GuideActionExploreShowOutline
	arg_1_0._ActionType2Impl[128] = GuideActionFinishMapElement
	arg_1_0._ActionType2Impl[129] = GuideActionExploreUseItem
	arg_1_0._ActionType2Impl[130] = GuideActionRoomFocusBlockBuildingPut
	arg_1_0._ActionType2Impl[131] = GuideActionCondition
	arg_1_0._ActionType2Impl[132] = GuideActionAdditionCondition
	arg_1_0._ActionType2Impl[201] = WaitGuideActionClickMask
	arg_1_0._ActionType2Impl[202] = WaitGuideActionClickAnywhere
	arg_1_0._ActionType2Impl[203] = WaitGuideActionStoryStart
	arg_1_0._ActionType2Impl[204] = WaitGuideActionStoryFinish
	arg_1_0._ActionType2Impl[205] = WaitGuideActionEnterEpisode
	arg_1_0._ActionType2Impl[206] = WaitGuideActionOpenFinishView
	arg_1_0._ActionType2Impl[207] = WaitGuideActionEnterScene
	arg_1_0._ActionType2Impl[208] = WaitGuideActionBackToMain
	arg_1_0._ActionType2Impl[209] = WaitGuideActionCloseView
	arg_1_0._ActionType2Impl[210] = WaitGuideActionWaitSeconds
	arg_1_0._ActionType2Impl[211] = WaitGuideActionOpenView
	arg_1_0._ActionType2Impl[212] = WaitGuideActionAnyTouch
	arg_1_0._ActionType2Impl[213] = WaitGuideActionEnterPassedEpisode
	arg_1_0._ActionType2Impl[214] = WaitGuideActionEnterFightSubEntity
	arg_1_0._ActionType2Impl[215] = WaitGuideActionBreakFightResultClose
	arg_1_0._ActionType2Impl[216] = WaitGuideActionOpenViewWithEpisode
	arg_1_0._ActionType2Impl[217] = WaitGuideActionOpenViewWithCondition
	arg_1_0._ActionType2Impl[218] = WaitGuideActionRoomBlockClick
	arg_1_0._ActionType2Impl[219] = WaitGuideActionRoomEnterMode
	arg_1_0._ActionType2Impl[220] = WaitGuideActionRoomPlaceBlock
	arg_1_0._ActionType2Impl[221] = WaitGuideActionWaitForGuideFinish
	arg_1_0._ActionType2Impl[222] = WaitGuideActionRoomCanGetResources
	arg_1_0._ActionType2Impl[223] = WaitGuideActionRoomInitBuildingLvUp
	arg_1_0._ActionType2Impl[224] = WaitGuideActionHasEnoughMaterial
	arg_1_0._ActionType2Impl[225] = WaitGuideActionRoomBlockSatisfy
	arg_1_0._ActionType2Impl[226] = WaitGuideActionEnterRoomOrOpenView
	arg_1_0._ActionType2Impl[227] = WaitGuideActionOpenDungeonMapView
	arg_1_0._ActionType2Impl[228] = WaitGuideActionRoomLineLvUpSatisfy
	arg_1_0._ActionType2Impl[229] = WaitGuideNotPressing
	arg_1_0._ActionType2Impl[230] = WaitGuideActionOpenViewInFirstWithCondition
	arg_1_0._ActionType2Impl[231] = WaitGuideActionSeasonRetail
	arg_1_0._ActionType2Impl[232] = WaitGuideActionExploreLoaded
	arg_1_0._ActionType2Impl[233] = WaitGuideActionExploreTweenCamera
	arg_1_0._ActionType2Impl[234] = WaitGuideActionExploreClickNode
	arg_1_0._ActionType2Impl[235] = WaitGuideActionExploreTrigger
	arg_1_0._ActionType2Impl[236] = WaitGuideActionExploreSetFov
	arg_1_0._ActionType2Impl[237] = WaitGuideActionExploreHeroStopMove
	arg_1_0._ActionType2Impl[238] = WaitGuideActionExploreTransferFinish
	arg_1_0._ActionType2Impl[239] = WaitGuideActionEnterBattle
	arg_1_0._ActionType2Impl[240] = WaitGuideActionRoleStoryTicketExchange
	arg_1_0._ActionType2Impl[241] = WaitGuideActionRoomGetBuilding
	arg_1_0._ActionType2Impl[242] = WaitGuideActionRoomPutBuilding
	arg_1_0._ActionType2Impl[243] = WaitGuideActionRoomBuildingClick
	arg_1_0._ActionType2Impl[244] = WaitGuideActionGetCritter
	arg_1_0._ActionType2Impl[245] = WaitGuideActionRoomCritterMood
	arg_1_0._ActionType2Impl[246] = WaitGuideActionRoomBuildingPlaceBlock
	arg_1_0._ActionType2Impl[247] = WaitGuideActionRoomPlan
	arg_1_0._ActionType2Impl[248] = WaitGuideActionRoomTransport
	arg_1_0._ActionType2Impl[249] = WaitGuideActionPlayStoryStep
	arg_1_0._ActionType2Impl[250] = WaitGuideActionEnterChapter
	arg_1_0._ActionType2Impl[251] = WaitGuideActionSurvivalBuildingLv
	arg_1_0._ActionType2Impl[301] = WaitGuideActionFightRoundBegin
	arg_1_0._ActionType2Impl[302] = WaitGuideActionFightRoundEnd
	arg_1_0._ActionType2Impl[303] = WaitGuideActionFightResultClose
	arg_1_0._ActionType2Impl[304] = WaitGuideActionFightDragCard
	arg_1_0._ActionType2Impl[305] = WaitGuideActionFightEnd
	arg_1_0._ActionType2Impl[306] = WaitGuideActionSkillPause
	arg_1_0._ActionType2Impl[307] = WaitGuideActionEntityDeadPause
	arg_1_0._ActionType2Impl[308] = WaitGuideActionUseActPoint
	arg_1_0._ActionType2Impl[309] = WaitGuideActionFightWaveBegin
	arg_1_0._ActionType2Impl[310] = WaitGuideActionFightSkillPlayFinish
	arg_1_0._ActionType2Impl[311] = WaitGuideActionFightEvent
	arg_1_0._ActionType2Impl[312] = WaitGuideActionCardEndPause
	arg_1_0._ActionType2Impl[313] = WaitGuideActionAnyEvent
	arg_1_0._ActionType2Impl[314] = WaitGuideActionFightEndPause
	arg_1_0._ActionType2Impl[315] = WaitGuideActionFightPauseGeneral
	arg_1_0._ActionType2Impl[316] = WaitGuideActionFightRoundXFail
	arg_1_0._ActionType2Impl[317] = WaitGuideActionFightEndPause_sp
	arg_1_0._ActionType2Impl[318] = WaitGuideActionPauseGeneral
	arg_1_0._ActionType2Impl[319] = WaitGuideActionFightGetSpecificCard
	arg_1_0._ActionType2Impl[320] = WaitGuideActionAnyEventWithCondition
	arg_1_0._ActionType2Impl[401] = WaitGuideActionSpecialEvent
	arg_1_0._ActionType2Impl[402] = GuideActionPreloadFirstFight
	arg_1_0._ActionType2Impl[998] = GuideActionAppendStep
	arg_1_0._ActionType2Impl[999] = GuideActionEmptyStep
end

function var_0_0._noDisplay(arg_2_0, arg_2_1)
	return not string.nilorempty(arg_2_1.tipsContent) and not string.nilorempty(arg_2_1.uiInfo)
end

function var_0_0.buildActionFlow(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_3 > 0 and arg_3_3 or arg_3_1
	local var_3_1 = GuideActionFlow.New(arg_3_1, arg_3_2, arg_3_3)

	arg_3_0:addActionToFlow(var_3_1, var_3_0, arg_3_2)

	return var_3_1
end

function var_0_0.addActionToFlow(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if not arg_4_1 then
		return
	end

	local var_4_0 = arg_4_4 and GuideConfig.instance:getAddtionStepCfg(arg_4_2, arg_4_3) or GuideConfig.instance:getStepCO(arg_4_2, arg_4_3)

	if not var_4_0 then
		logError(string.format("guide_%d_%d stepCO is nil", arg_4_2, arg_4_3))

		return
	end

	local var_4_1 = GuideModel.instance:getStepGOPath(arg_4_2, arg_4_3)
	local var_4_2 = var_4_0.delay

	if var_4_2 > 0 then
		local var_4_3 = WaitGuideActionWaitSeconds.New(arg_4_2, arg_4_3, var_4_2)

		arg_4_1:addWork(var_4_3)
	end

	if not string.nilorempty(var_4_1) then
		local var_4_4 = GuideActionFindGO.New(arg_4_2, arg_4_3, var_4_1)

		arg_4_1:addWork(var_4_4)
	end

	if var_4_0.audio and var_4_0.audio > 0 then
		local var_4_5 = GuideActionPlayAudio.New(arg_4_2, arg_4_3, var_4_0.audio)

		arg_4_1:addWork(var_4_5)
	end

	if not string.nilorempty(var_4_0.tipsContent) or not string.nilorempty(var_4_1) or not string.nilorempty(var_4_0.storyContent) then
		local var_4_6 = GuideActionOpenMaskHole.New(arg_4_2, arg_4_3)

		arg_4_1:addWork(var_4_6)
	end

	if not string.nilorempty(var_4_0.action) then
		local var_4_7 = string.split(var_4_0.action, "|")

		for iter_4_0 = 1, #var_4_7 do
			local var_4_8, var_4_9 = string.find(var_4_7[iter_4_0], "#")
			local var_4_10
			local var_4_11

			if var_4_8 then
				var_4_10 = tonumber(string.sub(var_4_7[iter_4_0], 1, var_4_8 - 1))
				var_4_11 = string.sub(var_4_7[iter_4_0], var_4_8 + 1)
			else
				var_4_10 = tonumber(var_4_7[iter_4_0]) or var_4_7[iter_4_0]
			end

			local var_4_12 = arg_4_0._ActionType2Impl[var_4_10]

			if var_4_12 then
				local var_4_13 = var_4_12.New(arg_4_2, arg_4_3, var_4_11)

				arg_4_1:addWork(var_4_13)
			else
				logError("guide action type " .. var_4_10 .. " not exist")
			end
		end
	end

	if #arg_4_1:getWorkList() == 0 then
		logNormal(string.format("<color=#FFA500>guide_%d_%d has no action!</color>", arg_4_2, arg_4_3))
	end
end

function var_0_0.buildAction(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0, var_5_1 = string.find(arg_5_2, "#")
	local var_5_2
	local var_5_3

	if var_5_0 then
		var_5_2 = tonumber(string.sub(arg_5_2, 1, var_5_0 - 1))
		var_5_3 = string.sub(arg_5_2, var_5_0 + 1)
	else
		var_5_2 = tonumber(arg_5_2) or arg_5_2
	end

	local var_5_4 = var_0_0.ActionType2Impl[var_5_2]

	if var_5_4 then
		return (var_5_4.New(arg_5_0, arg_5_1, var_5_3))
	else
		logError("guide action type " .. var_5_2 .. " not exist")
	end
end

return var_0_0
