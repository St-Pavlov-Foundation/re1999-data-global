module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateTeamChessView", package.seeall)

slot0 = class("EliminateTeamChessView", BaseView)

function slot0.onInitView(slot0)
	slot0._viewGO = slot0.viewGO
	slot0.viewGO = gohelper.findChild(slot0._viewGO, "#go_cameraMain/Middle/#go_teamchess")
	slot0._gostrongHolds = gohelper.findChild(slot0.viewGO, "#go_strongHolds")
	slot0._gostrongHold = gohelper.findChild(slot0.viewGO, "#go_strongHolds/#go_strongHold")
	slot0._goinfo = gohelper.findChild(slot0.viewGO, "#go_strongHolds/#go_strongHold/#go_info")
	slot0._imageslotBGColor = gohelper.findChildImage(slot0.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#image_slotBGColor")
	slot0._simageslotBG = gohelper.findChildSingleImage(slot0.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#simage_slotBG")
	slot0._imageInfoTextBG = gohelper.findChildImage(slot0.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#image_InfoTextBG")
	slot0._txtInfo = gohelper.findChildText(slot0.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#image_InfoTextBG/#scroll_ver/viewport/#txt_Info")
	slot0._goEnemyPower = gohelper.findChild(slot0.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#go_EnemyPower")
	slot0._imageEnemyPower = gohelper.findChildImage(slot0.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#go_EnemyPower/#image_EnemyPower")
	slot0._imageEnemyPower2 = gohelper.findChildImage(slot0.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#go_EnemyPower/#image_EnemyPower2")
	slot0._txtEnemyPower = gohelper.findChildText(slot0.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#go_EnemyPower/#txt_Enemy_Power")
	slot0._txtEnemyPower1 = gohelper.findChildText(slot0.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#go_EnemyPower/#txt_Enemy_Power1")
	slot0._goPlayerPower = gohelper.findChild(slot0.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#go_PlayerPower")
	slot0._imagePlayerPower = gohelper.findChildImage(slot0.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#go_PlayerPower/#image_PlayerPower")
	slot0._imagePlayerPower2 = gohelper.findChildImage(slot0.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#go_PlayerPower/#image_PlayerPower2")
	slot0._txtPlayerPower = gohelper.findChildText(slot0.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#go_PlayerPower/#txt_Player_Power")
	slot0._txtPlayerPower1 = gohelper.findChildText(slot0.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#go_PlayerPower/#txt_Player_Power1")
	slot0._goEnemy = gohelper.findChild(slot0.viewGO, "#go_strongHolds/#go_strongHold/#go_Enemy")
	slot0._goEnemyWin = gohelper.findChild(slot0.viewGO, "#go_strongHolds/#go_strongHold/#go_EnemyWin")
	slot0._goPlayer = gohelper.findChild(slot0.viewGO, "#go_strongHolds/#go_strongHold/#go_Player")
	slot0._goPlayerWin = gohelper.findChild(slot0.viewGO, "#go_strongHolds/#go_strongHold/#go_PlayerWin")
	slot0._goLine4 = gohelper.findChild(slot0.viewGO, "#go_strongHolds/#go_strongHold/#go_Line4")
	slot0._goLine6 = gohelper.findChild(slot0.viewGO, "#go_strongHolds/#go_strongHold/#go_Line6")
	slot0._gopower = gohelper.findChild(slot0.viewGO, "#go_strongHolds/#go_power")
	slot0._imagechessPower = gohelper.findChildImage(slot0.viewGO, "#go_strongHolds/#go_power/#image_chessPower")
	slot0._txtchessPower = gohelper.findChildText(slot0.viewGO, "#go_strongHolds/#go_power/#image_chessPower/#txt_chessPower")
	slot0._goHP = gohelper.findChild(slot0.viewGO, "#go_strongHolds/#go_HP")
	slot0._btnresult = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_result")
	slot0._goreslutvx = gohelper.findChild(slot0.viewGO, "#btn_result/#go_reslut_vx")
	slot0._goreslutvxloop = gohelper.findChild(slot0.viewGO, "#btn_result/#go_reslut_vx_loop")
	slot0._goSlot = gohelper.findChild(slot0.viewGO, "Bottom/#go_Slot")
	slot0._goresources = gohelper.findChild(slot0.viewGO, "Bottom/#go_resources")
	slot0._goresource = gohelper.findChild(slot0.viewGO, "Bottom/#go_resources/#go_resource")
	slot0._imageQuality = gohelper.findChildImage(slot0.viewGO, "Bottom/#go_resources/#go_resource/#image_Quality")
	slot0._txtResourceNum = gohelper.findChildText(slot0.viewGO, "Bottom/#go_resources/#go_resource/#image_Quality/#txt_ResourceNum")
	slot0._goResourceTips = gohelper.findChild(slot0.viewGO, "Bottom/#go_ResourceTips")
	slot0._txtopt = gohelper.findChildText(slot0.viewGO, "Bottom/#go_ResourceTips/#txt_opt")
	slot0._goaddResources = gohelper.findChild(slot0.viewGO, "Bottom/#go_ResourceTips/#go_addResources")
	slot0._goaddResource = gohelper.findChild(slot0.viewGO, "Bottom/#go_ResourceTips/#go_addResources/#go_addResource")
	slot0._btnmask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_mask")
	slot0._gomask = gohelper.findChild(slot0.viewGO, "#go_mask")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnresult:AddClickListener(slot0._btnresultOnClick, slot0)
	slot0._btnmask:AddClickListener(slot0._btnmaskOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnresult:RemoveClickListener()
	slot0._btnmask:RemoveClickListener()
end

function slot0._btnmaskOnClick(slot0)
	slot0:hideSoliderChessTip()
end

function slot0._btnresultOnClick(slot0)
	if not slot0._canClickResult then
		return
	end

	slot0._canClickResult = false

	EliminateTeamChessController.instance:sendWarChessRoundEndRequest(function ()
		uv0:refreshViewByRoundState()

		uv0._canClickResult = true
	end, slot0)
end

function slot0.setTipViewParent(slot0, slot1, slot2)
	slot0._btnmask.transform:SetParent(slot1.transform)
	EliminateTeamChessModel.instance:setTipViewParent(slot1)

	slot0._powerParent = gohelper.create2d(slot1, "powerParent")

	gohelper.setAsFirstSibling(slot0._powerParent)

	slot0._powerParentTr = slot0._powerParent.transform
end

function slot0._editableInitView(slot0)
	slot0._soliderTipView = nil

	slot0:hideSoliderChessTip()

	slot0._teamChessViewAni = slot0._viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(slot0._gostrongHolds, true)
	gohelper.setActive(slot0._gostrongHold, false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.TeamChessWarInfoInit, slot0.initInfo, slot0)
	slot0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.EliminateRoundStateChangeEnd, slot0.updateViewStateEnd, slot0)
	slot0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.EliminateRoundStateChange, slot0.updateViewState, slot0)
	slot0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.TeamChessViewWatchView, slot0.updateTeamChessViewWatchState, slot0)
	slot0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.TeamChessSelectEffectEnd, slot0.onTeamChessSkillRelease, slot0)
	slot0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.TeamChessItemBeginModelUpdated, slot0.teamChessItemDragBegin, slot0)
	slot0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.TeamChessItemDragModelUpdated, slot0.teamChessItemDrag, slot0)
	slot0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.TeamChessItemDragEndModelUpdated, slot0.teamChessItemDragEnd, slot0)
	slot0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.AddStrongholdChess, slot0.addStrongholdChess, slot0)
	slot0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.TeamChessPowerChange, slot0.teamChessPowerChange, slot0)
	slot0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.StrongHoldPowerChange, slot0.strongHoldPowerChange, slot0)
	slot0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.ResourceDataChange, slot0.resourceDataChange, slot0)
	slot0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.TeamChessOnFlowEnd, slot0.flowEnd, slot0)
	slot0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.RemoveStrongholdChess, slot0.removeStrongholdChess, slot0)
	slot0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.StrongHoldSettle, slot0.strongHoldSettle, slot0)
	slot0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.SoliderChessModelClick, slot0.soliderChessModelClick, slot0)
	slot0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.ShowChessView, slot0.showSoliderChessTip, slot0)
	slot0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.StrongHoldPerformReduction, slot0.strongHoldPerformReduction, slot0)
	slot0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.TeamChessUpdateActiveMoveState, slot0.teamChessUpdateActiveMoveState, slot0)
	slot0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.TeamChessGrowUpSkillChange, slot0.teamChessGrowUpValueChange, slot0)
	slot0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.TeamChessOnFlowStart, slot0.teamChessOnFlowStart, slot0)
	slot0:initInfo()
end

function slot0.onClose(slot0)
end

function slot0.onOpenFinish(slot0)
end

function slot0.initInfo(slot0)
	slot0._canClickResult = true

	slot0:initSlot()
	slot0:initStrongHold()
	slot0:initResource()
	slot0:refreshViewByRoundState()
end

function slot0.updateViewState(slot0)
	if not (EliminateLevelModel.instance:getCurRoundType() == EliminateEnum.RoundType.TeamChess) and not gohelper.isNil(slot0._powerParent) then
		gohelper.setActive(slot0._powerParent, slot2)
	end

	TeamChessUnitEntityMgr.instance:setAllEntityCanClick(slot2)
	TeamChessUnitEntityMgr.instance:setAllEntityCanDrag(slot2)
end

function slot0.updateViewStateEnd(slot0)
	if EliminateLevelModel.instance:getCurRoundType() == EliminateEnum.RoundType.TeamChess then
		slot0:updateResourceDataChange()
		slot0:refreshAndSortSlot()

		if not gohelper.isNil(slot0._powerParent) then
			gohelper.setActive(slot0._powerParent, true)
		end

		slot0:refreshViewByRoundState()
		slot0:refreshActiveMoveState()
		slot0:refreshTotalScoreState()

		for slot6 = 1, #slot0._strongHoldItems do
			slot0._strongHoldItems[slot6]:refreshAni(true)
		end
	end

	if slot2 and slot0._teamChessViewAni then
		slot0._teamChessViewAni:Play("open")
		TaskDispatcher.runDelay(slot0.refreshViewActive, slot0, 0.33)
	end

	EliminateTeamChessController.instance:setStartStepFlow(slot2)
end

function slot0.refreshViewActive(slot0)
	TaskDispatcher.cancelTask(slot0.refreshViewActive, slot0)
	EliminateTeamChessController.instance:startSeqStepFlow()
end

function slot0.updateInfo(slot0)
end

function slot0.initSlot(slot0)
	slot0._slotList = slot0:getUserDataTb_()

	for slot6, slot7 in ipairs(EliminateTeamChessModel.instance:getSlotIds()) do
		slot9 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._goSlot), EliminateTeamChessItem)

		table.insert(slot0._slotList, slot9)
		slot9:setSoliderId(slot7)
	end

	slot0:refreshAndSortSlot()
end

function slot0.refreshAndSortSlot(slot0)
	if slot0._slotList == nil or #slot0._slotList < 1 then
		return
	end

	for slot4 = 1, #slot0._slotList do
		slot5 = slot0._slotList[slot4]

		slot5:refreshView()
		slot5:setChildIndex(slot4 - 1)
	end
end

function slot0.initStrongHold(slot0)
	slot0._strongHoldItems = slot0:getUserDataTb_()

	for slot6 = 1, #EliminateTeamChessModel.instance:getStrongholds() do
		slot7 = slot1[slot6]

		MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.clone(slot0._gostrongHold, slot0._gostrongHolds, slot7.id), EliminateStrongHoldItem):initData(slot7, slot6, slot2)

		if slot7:getStrongholdConfig() then
			slot10:initStrongHoldChess(slot0:getResInst(slot0:_getResPathByCapacity(slot11.friendCapacity), slot10._goPlayer), slot0:getResInst(slot0:_getResPathByCapacity(slot11.enemyCapacity), slot10._goEnemy), slot0._gopower, slot0._goHP)
		end

		gohelper.setActive(slot9, true)

		slot0._strongHoldItems[#slot0._strongHoldItems + 1] = slot10
	end

	ZProj.UGUIHelper.RebuildLayout(slot0._gostrongHolds.transform)

	for slot6, slot7 in ipairs(slot0._strongHoldItems) do
		if slot7 then
			slot7:setPowerTrParent(slot0._powerParentTr)
		end
	end
end

function slot0.initResource(slot0)
	slot0._resourceItem = slot0:getUserDataTb_()

	for slot5, slot6 in pairs(EliminateTeamChessEnum.ResourceType) do
		slot7 = gohelper.clone(slot0._goresource, slot0._goresources, slot5)
		slot8 = gohelper.findChildImage(slot7, "#image_Quality")
		slot9 = gohelper.findChildText(slot7, "#image_Quality/#txt_ResourceNum")

		UISpriteSetMgr.instance:setV2a2EliminateSprite(slot8, EliminateTeamChessEnum.ResourceTypeToImagePath[slot5], false)
		gohelper.setActive(slot7, true)

		slot9.text = EliminateTeamChessModel.instance:getResourceNumber(slot5) and slot11 or 0
		slot0._resourceItem[slot5] = {
			item = slot7,
			resourceImage = slot8,
			resourceNumberText = slot9,
			ani = slot7:GetComponent(typeof(UnityEngine.Animator))
		}
	end
end

function slot0._getResPathByCapacity(slot0, slot1)
	slot3 = slot0.viewContainer:getSetting().otherRes[2]

	if slot1 > 4 and slot1 <= 6 then
		slot3 = slot2[3]
	end

	if slot1 > 6 then
		slot3 = slot2[7]
	end

	return slot3
end

function slot0.teamChessItemDragBegin(slot0, slot1, slot2, slot3)
	slot4 = TeamChessUnitEntityMgr.instance:getEmptyEntity(nil, slot1)
end

function slot0.teamChessItemDrag(slot0, slot1, slot2, slot3, slot4, slot5)
	slot7 = false

	if slot0:_checkStrongHoldInRect(slot4, slot5) and slot3 and slot6 == slot3 then
		-- Nothing
	end

	slot0:setStrongHoldSelect(slot1, slot6)

	if TeamChessUnitEntityMgr.instance:getEmptyEntity(nil, slot1) then
		if slot2 == nil then
			if slot6 then
				slot7 = not EliminateTeamChessModel.instance:strongHoldIsFull(slot6)
			end

			slot0:updateViewPositionByEntity(slot1, EliminateTeamChessEnum.ChessTipType.showDragTip, slot8, nil, slot7)
		end

		slot8:setShowModeType((slot6 ~= nil or slot3 ~= nil) and EliminateTeamChessEnum.ModeType.Outline or EliminateTeamChessEnum.ModeType.Normal)
	end

	slot0:setViewCanvasGroupActive(slot6 ~= nil)
end

function slot0.teamChessItemDragEnd(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot0:_checkStrongHoldInRect(slot4, slot5) and slot3 and slot6 == slot3 then
		slot6 = nil
	end

	if slot6 ~= nil and (EliminateTeamChessModel.instance:isCanPlaceByStrongHoldRule(slot6, slot1) or slot2 ~= nil) then
		EliminateTeamChessController.instance:createPlaceSkill(slot1, slot2, slot6)

		slot0._placeSkillReleaseSuccess = EliminateTeamChessController.instance:checkAndReleasePlaceSkill()

		if not slot0._placeSkillReleaseSuccess then
			EliminateTeamChessController.instance:addTempChessAndPlace(slot1, slot2, slot6)

			slot8 = slot0._gostrongHolds.transform

			EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.TeamChessSelectEffectBegin, recthelper.getWidth(slot8), recthelper.getHeight(slot8))
		end
	end

	if TeamChessUnitEntityMgr.instance:getEmptyEntity(nil, slot1) then
		slot7:setShowModeType(EliminateTeamChessEnum.ModeType.Normal)
	end

	slot0:teamChessUpdateActiveMoveState(slot2)
	slot0:setStrongHoldSelect(slot1, nil)
	slot0:hideSoliderChessTip()
end

function slot0._checkStrongHoldInRect(slot0, slot1, slot2)
	if slot0._strongHoldItems == nil then
		return nil
	end

	slot3 = nil

	for slot7, slot8 in pairs(slot0._strongHoldItems) do
		if slot8:checkInPlayerChessRect(slot1, slot2) and slot8._data then
			slot3 = slot8._data.id

			break
		end
	end

	return slot3
end

function slot0.setStrongHoldSelect(slot0, slot1, slot2)
	if slot0._strongHoldItems == nil then
		return
	end

	for slot6 = 1, #slot0._strongHoldItems do
		slot0._strongHoldItems[slot6]:setStrongHoldSelect(slot1, slot2)
	end
end

function slot0.addStrongholdChess(slot0, slot1, slot2, slot3)
	if slot0._strongHoldItems == nil then
		return
	end

	for slot7 = 1, #slot0._strongHoldItems do
		slot0._strongHoldItems[slot7]:addStrongholdChess(slot1, slot2, slot3)
	end

	slot0:refreshTotalScoreState()
end

function slot0.removeStrongholdChess(slot0, slot1, slot2, slot3, slot4)
	if slot0._strongHoldItems == nil then
		return
	end

	for slot8 = 1, #slot0._strongHoldItems do
		slot0._strongHoldItems[slot8]:removeStrongholdChess(slot1, slot2, slot3, slot4)
	end

	slot0:refreshTotalScoreState()
end

function slot0.strongHoldSettle(slot0, slot1)
	if slot0._strongHoldItems == nil then
		return
	end

	for slot5 = 1, #slot0._strongHoldItems do
		slot0._strongHoldItems[slot5]:strongHoldSettle(slot1)
	end
end

function slot0.strongHoldPerformReduction(slot0)
	if slot0._strongHoldItems == nil then
		return
	end

	for slot4 = 1, #slot0._strongHoldItems do
		slot0._strongHoldItems[slot4]:strongHoldSettleResetShow()
	end
end

function slot0.teamChessUpdateActiveMoveState(slot0, slot1)
	if slot0._strongHoldItems == nil then
		return
	end

	for slot5 = 1, #slot0._strongHoldItems do
		slot0._strongHoldItems[slot5]:teamChessUpdateActiveMoveState(slot1)
	end
end

function slot0.refreshActiveMoveState(slot0)
	TeamChessUnitEntityMgr.instance:refreshShowModeStateByTeamType(EliminateTeamChessEnum.TeamChessTeamType.player)
end

function slot0.teamChessPowerChange(slot0, slot1, slot2)
	if slot0._strongHoldItems == nil then
		return
	end

	for slot6 = 1, #slot0._strongHoldItems do
		slot0._strongHoldItems[slot6]:teamChessPowerChange(slot1, slot2)
	end
end

function slot0.teamChessGrowUpValueChange(slot0, slot1, slot2, slot3)
	if slot0._strongHoldItems == nil then
		return
	end

	for slot7 = 1, #slot0._strongHoldItems do
		slot0._strongHoldItems[slot7]:teamChessGrowUpValueChange(slot1, slot2, slot3)
	end
end

function slot0.strongHoldPowerChange(slot0, slot1, slot2, slot3)
	if slot0._strongHoldItems == nil then
		return
	end

	for slot7 = 1, #slot0._strongHoldItems do
		slot0._strongHoldItems[slot7]:strongHoldPowerChange(slot1, slot2, slot3)
	end

	slot0:refreshTotalScoreState()
end

function slot0.resourceDataChange(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		if not slot0._resourceItem or not slot0._resourceItem[slot5] then
			return
		end
	end

	slot0:showAddResourceView(slot0.updateResourceDataChange, slot0, slot1)
	slot0:refreshAndSortSlot()
	slot0:refreshTotalScoreState()
end

function slot0.showAddResourceView(slot0, slot1, slot2, slot3)
	slot4 = tabletool.len(slot3)
	slot5 = 1

	if slot0._addResourceItem == nil then
		slot0._addResourceItem = slot0:getUserDataTb_()
	end

	for slot9, slot10 in pairs(slot3) do
		slot0._txtopt.text = slot10 > 0 and "＋" or "－"

		if slot0._addResourceItem[slot5] == nil then
			slot11 = gohelper.clone(slot0._goaddResource, slot0._goaddResources, slot9)
			slot13 = gohelper.findChildText(slot11, "#image_Quality/#txt_ResourceNum")

			UISpriteSetMgr.instance:setV2a2EliminateSprite(gohelper.findChildImage(slot11, "#image_Quality"), EliminateTeamChessEnum.ResourceTypeToImagePath[slot9], false)

			slot13.text = math.abs(slot10 and slot10 or 0)

			gohelper.setActive(slot11, true)
			table.insert(slot0._addResourceItem, {
				item = slot11,
				resourceImage = slot12,
				resourceNumberText = slot13
			})
		elseif slot11.resourceImage and slot11.resourceNumberText then
			UISpriteSetMgr.instance:setV2a2EliminateSprite(slot11.resourceImage, EliminateTeamChessEnum.ResourceTypeToImagePath[slot9], false)

			slot11.resourceNumberText.text = math.abs(slot10 and slot10 or 0)

			gohelper.setActive(slot11.item, true)
		end

		slot5 = slot5 + 1
	end

	gohelper.setActive(slot0._goResourceTips, true)
	TaskDispatcher.runDelay(function ()
		slot3 = false

		gohelper.setActive(uv0._goResourceTips, slot3)

		for slot3 = 1, #uv0._addResourceItem do
			gohelper.setActive(uv0._addResourceItem[slot3].item, false)
		end

		if uv1 then
			uv1(uv2, uv3)
		end
	end, nil, EliminateTeamChessEnum.addResourceTipTime)
end

function slot0.updateResourceDataChange(slot0, slot1)
	if slot0._resourceItem == nil then
		return
	end

	if slot1 ~= nil then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_sources_lit)
	end

	for slot5, slot6 in pairs(slot0._resourceItem) do
		if slot6.resourceNumberText then
			slot6.resourceNumberText.text = EliminateTeamChessModel.instance:getResourceNumber(slot5)
		end
	end

	if slot1 then
		for slot5, slot6 in pairs(slot1) do
			if slot0._resourceItem[slot5] and slot7.ani then
				slot7.ani:Play("add", 0, 0)
			end
		end
	end
end

function slot0.showSoliderChessTip(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if slot0._soliderTipView == nil then
		slot0._soliderTipView = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[6], slot0._btnmask.gameObject), EliminateChessTipView)

		slot0._soliderTipView:setSellCb(slot0.hideSoliderChessTip, slot0)
	end

	slot0._soliderTipView:setChessUidAndStrongHoldId(slot2, slot3)
	slot0._soliderTipView:setSoliderIdAndShowType(slot1, slot4)

	if slot0._soliderTipView then
		slot0._soliderTipView:updateViewPositionByEntity(slot5, slot6)
	end

	gohelper.setActive(slot0._btnmask, true)
end

function slot0.updateViewPositionByEntity(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot0._soliderTipView == nil or not slot0._btnmask.gameObject.activeSelf then
		slot0:showSoliderChessTip(slot1, nil, , slot2, slot3, slot4)
	end

	if slot0._soliderTipView then
		slot0._soliderTipView:updateViewPositionByEntity(slot3, slot4, slot5)
	end
end

function slot0.setViewCanvasGroupActive(slot0, slot1)
	if slot0._soliderTipView then
		slot0._soliderTipView:setViewActive(slot1)
	end
end

function slot0.hideSoliderChessTip(slot0)
	if slot0._soliderTipView then
		slot0._soliderTipView:hideView()
	end

	gohelper.setActive(slot0._btnmask, false)
end

function slot0.refreshViewByRoundState(slot0)
	gohelper.setActive(slot0._goSlot, EliminateTeamChessModel.instance:getCurTeamRoundStepState() == EliminateTeamChessEnum.TeamChessRoundType.player)
	gohelper.setActive(slot0._goresources, slot1 == EliminateTeamChessEnum.TeamChessRoundType.player)
	gohelper.setActive(slot0._btnresult, slot1 == EliminateTeamChessEnum.TeamChessRoundType.player)

	if slot0._strongHoldItems == nil then
		return
	end

	for slot5 = 1, #slot0._strongHoldItems do
		slot0._strongHoldItems[slot5]:refreshViewByRoundState(slot1)
	end
end

function slot0.updateTeamChessViewWatchState(slot0, slot1)
	gohelper.setActive(slot0._goSlot, not slot1)
	gohelper.setActive(slot0._goresources, not slot1)
	gohelper.setActive(slot0._btnresult, not slot1)

	if not gohelper.isNil(slot0._powerParent) then
		gohelper.setActive(slot0._powerParent, slot1)
	end

	if not slot1 then
		slot0:hideSoliderChessTip()
	end

	for slot5 = 1, #slot0._strongHoldItems do
		slot0._strongHoldItems[slot5]:refreshAni(slot1)
	end
end

function slot0.soliderChessModelClick(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if slot0._placeSkillReleaseSuccess == nil or slot0._placeSkillReleaseSuccess then
		slot0:showSoliderChessTip(slot1, slot2, slot3, slot4, slot5, slot6)

		return
	end

	if EliminateTeamChessController.instance:getPlaceSkill() and slot7:setSelectSoliderId(slot2) then
		slot0._placeSkillReleaseSuccess = EliminateTeamChessController.instance:checkAndReleasePlaceSkill()
	end
end

function slot0.onTeamChessSkillRelease(slot0)
	slot0._placeSkillReleaseSuccess = nil
end

function slot0.flowEnd(slot0)
	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.TeamChessRoundBeginAndPlayerSoliderCount, string.format("%s_%s", EliminateLevelModel.instance:getLevelId(), EliminateTeamChessModel.instance:getAllPlayerSoliderCount()))
	slot0:setClickMaskState(false)
end

function slot0.teamChessOnFlowStart(slot0)
	slot0:setClickMaskState(true)
end

function slot0.setClickMaskState(slot0, slot1)
	if EliminateTeamChessModel.instance:getWarFightResult() ~= nil then
		return
	end

	TeamChessUnitEntityMgr.instance:setAllEntityCanClick(not slot1)
	TeamChessUnitEntityMgr.instance:setAllEntityCanDrag(not slot1)
	gohelper.setActive(slot0._gomask.gameObject, slot1)
end

function slot0.refreshTotalScoreState(slot0)
	if EliminateTeamChessModel.instance:getCurTeamRoundStepState() == EliminateTeamChessEnum.TeamChessRoundType.player then
		slot2 = false

		if not EliminateTeamChessModel.instance:allStrongHoldIsIsFull() then
			slot3 = EliminateTeamChessModel.instance:haveEnoughResource()

			logNormal("haveEnoughResource", tostring(slot3), "canReleaseSkillAddResource", tostring(EliminateTeamChessModel.instance:canReleaseSkillAddResource()))

			slot2 = not slot3 and not slot4
		end

		gohelper.setActive(slot0._goreslutvxloop, slot2)
	end
end

function slot0.onDestroyView(slot0)
	slot0._powerParentTr = nil

	if slot0._powerParent then
		gohelper.destroy(slot0._powerParent)

		slot0._powerParent = nil
	end

	TaskDispatcher.cancelTask(slot0.refreshViewActive, slot0)

	if slot0._soliderTipView then
		slot0._soliderTipView:onDestroy()

		slot0._soliderTipView = nil
	end
end

return slot0
