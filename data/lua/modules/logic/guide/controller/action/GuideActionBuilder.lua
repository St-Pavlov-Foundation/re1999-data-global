module("modules.logic.guide.controller.action.GuideActionBuilder", package.seeall)

slot0 = class("GuideActionBuilder")

function slot0.ctor(slot0)
	slot0._ActionType2Impl = {}
	uv0.ActionType2Impl = slot0._ActionType2Impl
	slot0._ActionType2Impl[101] = GuideActionPlayStory
	slot0._ActionType2Impl[102] = GuideActionEnterEpisode
	slot0._ActionType2Impl[103] = GuideActionExitEpisode
	slot0._ActionType2Impl[104] = GuideActionCloseView
	slot0._ActionType2Impl[105] = GuideActionOpenView
	slot0._ActionType2Impl[106] = GuideActionEnterScene
	slot0._ActionType2Impl[107] = GuideActionOpenHelpView
	slot0._ActionType2Impl[108] = GuideActionSkillContinue
	slot0._ActionType2Impl[109] = GuideActionEntityDeadContinue
	slot0._ActionType2Impl[110] = GuideActionJump
	slot0._ActionType2Impl[111] = GuideActionEnableClick
	slot0._ActionType2Impl[112] = GuideActionEnablePress
	slot0._ActionType2Impl[113] = GuideActionDispatchFightEvent
	slot0._ActionType2Impl[114] = GuideActionTriggerGuide
	slot0._ActionType2Impl[115] = GuideActionDispatchEvent
	slot0._ActionType2Impl[116] = GuideActionSetFlag
	slot0._ActionType2Impl[117] = GuideActionPlayEffect
	slot0._ActionType2Impl[118] = GuideActionPlayAnimator
	slot0._ActionType2Impl[119] = GuideActionFightVictory
	slot0._ActionType2Impl[120] = GuideActionLockGuide
	slot0._ActionType2Impl[121] = GuideActionRoomFixBlockMaskPos
	slot0._ActionType2Impl[122] = GuideActionRoomFocusBlock
	slot0._ActionType2Impl[123] = GuideActionOpenCommonPropView
	slot0._ActionType2Impl[125] = GuideActionSetNextStepGOPath
	slot0._ActionType2Impl[126] = GuideActionShowToast
	slot0._ActionType2Impl[127] = GuideActionExploreShowOutline
	slot0._ActionType2Impl[128] = GuideActionFinishMapElement
	slot0._ActionType2Impl[129] = GuideActionExploreUseItem
	slot0._ActionType2Impl[130] = GuideActionRoomFocusBlockBuildingPut
	slot0._ActionType2Impl[131] = GuideActionCondition
	slot0._ActionType2Impl[132] = GuideActionAdditionCondition
	slot0._ActionType2Impl[201] = WaitGuideActionClickMask
	slot0._ActionType2Impl[202] = WaitGuideActionClickAnywhere
	slot0._ActionType2Impl[203] = WaitGuideActionStoryStart
	slot0._ActionType2Impl[204] = WaitGuideActionStoryFinish
	slot0._ActionType2Impl[205] = WaitGuideActionEnterEpisode
	slot0._ActionType2Impl[206] = WaitGuideActionOpenFinishView
	slot0._ActionType2Impl[207] = WaitGuideActionEnterScene
	slot0._ActionType2Impl[208] = WaitGuideActionBackToMain
	slot0._ActionType2Impl[209] = WaitGuideActionCloseView
	slot0._ActionType2Impl[210] = WaitGuideActionWaitSeconds
	slot0._ActionType2Impl[211] = WaitGuideActionOpenView
	slot0._ActionType2Impl[212] = WaitGuideActionAnyTouch
	slot0._ActionType2Impl[213] = WaitGuideActionEnterPassedEpisode
	slot0._ActionType2Impl[214] = WaitGuideActionEnterFightSubEntity
	slot0._ActionType2Impl[215] = WaitGuideActionBreakFightResultClose
	slot0._ActionType2Impl[216] = WaitGuideActionOpenViewWithEpisode
	slot0._ActionType2Impl[217] = WaitGuideActionOpenViewWithCondition
	slot0._ActionType2Impl[218] = WaitGuideActionRoomBlockClick
	slot0._ActionType2Impl[219] = WaitGuideActionRoomEnterMode
	slot0._ActionType2Impl[220] = WaitGuideActionRoomPlaceBlock
	slot0._ActionType2Impl[221] = WaitGuideActionWaitForGuideFinish
	slot0._ActionType2Impl[222] = WaitGuideActionRoomCanGetResources
	slot0._ActionType2Impl[223] = WaitGuideActionRoomInitBuildingLvUp
	slot0._ActionType2Impl[224] = WaitGuideActionHasEnoughMaterial
	slot0._ActionType2Impl[225] = WaitGuideActionRoomBlockSatisfy
	slot0._ActionType2Impl[226] = WaitGuideActionEnterRoomOrOpenView
	slot0._ActionType2Impl[227] = WaitGuideActionOpenDungeonMapView
	slot0._ActionType2Impl[228] = WaitGuideActionRoomLineLvUpSatisfy
	slot0._ActionType2Impl[229] = WaitGuideNotPressing
	slot0._ActionType2Impl[230] = WaitGuideActionOpenViewInFirstWithCondition
	slot0._ActionType2Impl[231] = WaitGuideActionSeasonRetail
	slot0._ActionType2Impl[232] = WaitGuideActionExploreLoaded
	slot0._ActionType2Impl[233] = WaitGuideActionExploreTweenCamera
	slot0._ActionType2Impl[234] = WaitGuideActionExploreClickNode
	slot0._ActionType2Impl[235] = WaitGuideActionExploreTrigger
	slot0._ActionType2Impl[236] = WaitGuideActionExploreSetFov
	slot0._ActionType2Impl[237] = WaitGuideActionExploreHeroStopMove
	slot0._ActionType2Impl[238] = WaitGuideActionExploreTransferFinish
	slot0._ActionType2Impl[239] = WaitGuideActionEnterBattle
	slot0._ActionType2Impl[240] = WaitGuideActionRoleStoryTicketExchange
	slot0._ActionType2Impl[241] = WaitGuideActionRoomGetBuilding
	slot0._ActionType2Impl[242] = WaitGuideActionRoomPutBuilding
	slot0._ActionType2Impl[243] = WaitGuideActionRoomBuildingClick
	slot0._ActionType2Impl[244] = WaitGuideActionGetCritter
	slot0._ActionType2Impl[245] = WaitGuideActionRoomCritterMood
	slot0._ActionType2Impl[246] = WaitGuideActionRoomBuildingPlaceBlock
	slot0._ActionType2Impl[247] = WaitGuideActionRoomPlan
	slot0._ActionType2Impl[248] = WaitGuideActionRoomTransport
	slot0._ActionType2Impl[301] = WaitGuideActionFightRoundBegin
	slot0._ActionType2Impl[302] = WaitGuideActionFightRoundEnd
	slot0._ActionType2Impl[303] = WaitGuideActionFightResultClose
	slot0._ActionType2Impl[304] = WaitGuideActionFightDragCard
	slot0._ActionType2Impl[305] = WaitGuideActionFightEnd
	slot0._ActionType2Impl[306] = WaitGuideActionSkillPause
	slot0._ActionType2Impl[307] = WaitGuideActionEntityDeadPause
	slot0._ActionType2Impl[308] = WaitGuideActionUseActPoint
	slot0._ActionType2Impl[309] = WaitGuideActionFightWaveBegin
	slot0._ActionType2Impl[310] = WaitGuideActionFightSkillPlayFinish
	slot0._ActionType2Impl[311] = WaitGuideActionFightEvent
	slot0._ActionType2Impl[312] = WaitGuideActionCardEndPause
	slot0._ActionType2Impl[313] = WaitGuideActionAnyEvent
	slot0._ActionType2Impl[314] = WaitGuideActionFightEndPause
	slot0._ActionType2Impl[315] = WaitGuideActionFightPauseGeneral
	slot0._ActionType2Impl[316] = WaitGuideActionFightRoundXFail
	slot0._ActionType2Impl[317] = WaitGuideActionFightEndPause_sp
	slot0._ActionType2Impl[318] = WaitGuideActionPauseGeneral
	slot0._ActionType2Impl[319] = WaitGuideActionFightGetSpecificCard
	slot0._ActionType2Impl[401] = WaitGuideActionSpecialEvent
	slot0._ActionType2Impl[402] = GuideActionPreloadFirstFight
	slot0._ActionType2Impl[998] = GuideActionAppendStep
	slot0._ActionType2Impl[999] = GuideActionEmptyStep
end

function slot0._noDisplay(slot0, slot1)
	return not string.nilorempty(slot1.tipsContent) and not string.nilorempty(slot1.uiInfo)
end

function slot0.buildActionFlow(slot0, slot1, slot2, slot3)
	slot5 = GuideActionFlow.New(slot1, slot2, slot3)

	slot0:addActionToFlow(slot5, slot3 > 0 and slot3 or slot1, slot2)

	return slot5
end

function slot0.addActionToFlow(slot0, slot1, slot2, slot3, slot4)
	if not slot1 then
		return
	end

	if not (slot4 and GuideConfig.instance:getAddtionStepCfg(slot2, slot3) or GuideConfig.instance:getStepCO(slot2, slot3)) then
		logError(string.format("guide_%d_%d stepCO is nil", slot2, slot3))

		return
	end

	slot6 = GuideModel.instance:getStepGOPath(slot2, slot3)

	if slot5.delay > 0 then
		slot1:addWork(WaitGuideActionWaitSeconds.New(slot2, slot3, slot7))
	end

	if not string.nilorempty(slot6) then
		slot1:addWork(GuideActionFindGO.New(slot2, slot3, slot6))
	end

	if slot5.audio and slot5.audio > 0 then
		slot1:addWork(GuideActionPlayAudio.New(slot2, slot3, slot5.audio))
	end

	if not string.nilorempty(slot5.tipsContent) or not string.nilorempty(slot6) or not string.nilorempty(slot5.storyContent) then
		slot1:addWork(GuideActionOpenMaskHole.New(slot2, slot3))
	end

	if not string.nilorempty(slot5.action) then
		for slot12 = 1, #string.split(slot5.action, "|") do
			slot13, slot14 = string.find(slot8[slot12], "#")
			slot15, slot16 = nil

			if slot13 then
				slot15 = tonumber(string.sub(slot8[slot12], 1, slot13 - 1))
				slot16 = string.sub(slot8[slot12], slot13 + 1)
			else
				slot15 = tonumber(slot8[slot12]) or slot8[slot12]
			end

			if slot0._ActionType2Impl[slot15] then
				slot1:addWork(slot17.New(slot2, slot3, slot16))
			else
				logError("guide action type " .. slot15 .. " not exist")
			end
		end
	end

	if #slot1:getWorkList() == 0 then
		logNormal(string.format("<color=#FFA500>guide_%d_%d has no action!</color>", slot2, slot3))
	end
end

function slot0.buildAction(slot0, slot1, slot2)
	slot3, slot4 = string.find(slot2, "#")
	slot5, slot6 = nil

	if slot3 then
		slot5 = tonumber(string.sub(slot2, 1, slot3 - 1))
		slot6 = string.sub(slot2, slot3 + 1)
	else
		slot5 = tonumber(slot2) or slot2
	end

	if uv0.ActionType2Impl[slot5] then
		return slot7.New(slot0, slot1, slot6)
	else
		logError("guide action type " .. slot5 .. " not exist")
	end
end

return slot0
