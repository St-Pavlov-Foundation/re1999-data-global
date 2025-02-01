module("modules.logic.rouge.map.view.map.RougeMapNodeRightView", package.seeall)

slot0 = class("RougeMapNodeRightView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtChapterName = gohelper.findChildText(slot0.viewGO, "#go_node_right/Title/#txt_ChapterName")
	slot0._txtChapterNameEn = gohelper.findChildText(slot0.viewGO, "#go_node_right/Title/#txt_ChapterNameEn")
	slot0._txtDesc = gohelper.findChildText(slot0.viewGO, "#go_node_right/#txt_Desc")
	slot0._btnMoveBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_node_right/#btn_MoveBtn")
	slot0._gocareer = gohelper.findChild(slot0.viewGO, "#go_node_right/#go_career")
	slot0._gocareeritem = gohelper.findChild(slot0.viewGO, "#go_node_right/#go_career/bg/go_careeritem")
	slot0._simageDefaultPic = gohelper.findChildSingleImage(slot0.viewGO, "#go_node_right/#go_DefaultPic")
	slot0._simageMonsterMaskPic = gohelper.findChildSingleImage(slot0.viewGO, "#go_node_right/#go_MonsterMaskPic")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnMoveBtn:AddClickListener(slot0._btnMoveBtnOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnMoveBtn:RemoveClickListener()
end

function slot0._btnMoveBtnOnClick(slot0)
	if slot0.nodeMo.arriveStatus == RougeMapEnum.Arrive.CanArrive then
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onBeforeSendMoveRpc)
		RougeRpc.instance:sendRougeRoundMoveRequest(slot0.nodeMo.nodeId)

		return
	end

	RougeMapChoiceEventHelper.triggerEventHandle(slot0.nodeMo)
end

function slot0._editableInitView(slot0)
	slot0.goDefaultPic = slot0._simageDefaultPic.gameObject
	slot0.goMonsterMaskPic = slot0._simageMonsterMaskPic.gameObject
	slot0.goNodeRight = gohelper.findChild(slot0.viewGO, "#go_node_right")
	slot0.rightAnimator = slot0.goNodeRight:GetComponent(gohelper.Type_Animator)
	slot0.txtBtn = gohelper.findChildText(slot0.viewGO, "#go_node_right/#btn_MoveBtn/txt_Move")
	slot0.txtBtnEn = gohelper.findChildText(slot0.viewGO, "#go_node_right/#btn_MoveBtn/txt_MoveEn")

	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onSelectNode, slot0.onSelectNode, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onNormalActorBeforeMove, slot0.onNormalActorBeforeMove, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onActorMovingDone, slot0.onActorMovingDone, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onChangeMapInfo, slot0.onChangeMapInfo, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onShowContinueFight, slot0.onShowContinueFight, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onUpdateMapInfo, slot0.onUpdateMapInfo, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onPopViewDone, slot0.onPopViewDone, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onClearInteract, slot0.onClearInteract, slot0)

	slot0.goCareerList = slot0:getUserDataTb_()
	slot0.careerList = {}

	table.insert(slot0.goCareerList, slot0._gocareeritem)
	slot0:hideDescContainer()
end

function slot0.onOpen(slot0)
	slot0:autoContinueEvent()
end

function slot0.autoContinueEvent(slot0)
	if RougeMapModel.instance:getCurNode() and slot1:isStartedEvent() then
		slot0:_triggerHandle()
	end
end

function slot0.onUpdateMapInfo(slot0)
	if not slot0.nodeMo then
		return
	end

	if slot0.nodeMo.eventId == slot0.eventId then
		return
	end

	slot0:updateData(slot0.nodeMo)
	slot0:refreshRight()
end

function slot0.onChangeMapInfo(slot0)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectNode, nil)
end

function slot0.onSelectNode(slot0, slot1)
	if not slot1 then
		slot0:updateData()
		slot0:hideDescContainer()

		return
	end

	if slot1 == slot0.nodeMo then
		return
	end

	slot0:updateData(slot1)

	if slot0.nodeMo.arriveStatus == RougeMapEnum.Arrive.CanArrive then
		slot0:switchNode()
	else
		RougeMapChoiceEventHelper.triggerContinueEventHandle(slot0.nodeMo)
	end
end

function slot0.switchNode(slot0)
	slot0.rightAnimator:Play("switch", 0, 0)
	TaskDispatcher.cancelTask(slot0.refreshRight, slot0)
	TaskDispatcher.runDelay(slot0.refreshRight, slot0, RougeMapEnum.WaitMapRightRefreshTime)
end

function slot0.onShowContinueFight(slot0)
	slot0:refreshRight(true)
end

function slot0.updateData(slot0, slot1)
	if not slot1 then
		slot0.nodeMo = nil
		slot0.eventCo = nil
		slot0.eventMo = nil
		slot0.eventId = nil

		return
	end

	slot0.nodeMo = slot1
	slot0.eventCo = slot0.nodeMo:getEventCo()
	slot0.eventMo = slot0.nodeMo.eventMo
	slot0.eventId = slot0.nodeMo.eventId
end

function slot0.refreshRight(slot0, slot1)
	if not slot0.eventCo then
		return
	end

	slot0._txtChapterName.text = slot0.eventCo.name
	slot0._txtChapterNameEn.text = slot0.eventCo.nameEn
	slot0._txtDesc.text = slot0.eventCo.desc

	slot0:showDescContainer()
	slot0:refreshBtn(slot1)
	slot0:refreshCareer()
	slot0:refreshPic()
end

function slot0.refreshCareer(slot0)
	if not slot0.eventCo.type then
		gohelper.setActive(slot0._gocareer, false)
	end

	slot2 = RougeMapHelper.isFightEvent(slot1)

	gohelper.setActive(slot0._gocareer, slot2)

	if slot2 then
		for slot7, slot8 in ipairs(slot0:getCareerList(slot0.eventId)) do
			if not slot0.goCareerList[slot7] then
				table.insert(slot0.goCareerList, gohelper.cloneInPlace(slot0._gocareeritem))
			end

			gohelper.setActive(slot9, true)
			UISpriteSetMgr.instance:setRougeSprite(slot9:GetComponent(gohelper.Type_Image), "rouge_map_career_" .. slot8)
		end

		for slot7 = #slot3 + 1, #slot0.goCareerList do
			gohelper.setActive(slot0.goCareerList[slot7], false)
		end
	end
end

function slot0.getCareerList(slot0, slot1)
	tabletool.clear(slot0.careerList)

	if not RougeMapConfig.instance:getFightEvent(slot1) then
		return slot0.careerList
	end

	if not DungeonConfig.instance:getEpisodeCO(slot2.episodeId) then
		return slot0.careerList
	end

	if not lua_battle.configDict[slot3.battleId] then
		return slot0.careerList
	end

	for slot9, slot10 in ipairs(string.splitToNumber(slot4.monsterGroupIds, "#")) do
		for slot16, slot17 in ipairs(string.splitToNumber(lua_monster_group.configDict[slot10].monster, "#")) do
			if not tabletool.indexOf(slot0.careerList, lua_monster.configDict[slot17].career) then
				table.insert(slot0.careerList, slot19)
			end
		end
	end

	return slot0.careerList
end

function slot0.refreshPic(slot0)
	if RougeMapEffectHelper.checkHadEffect(RougeMapEnum.EffectType.UnlockShowPassFightMask, slot0.eventCo.type) and RougeOutsideModel.instance:passedEventId(slot0.eventId) then
		slot0:refreshMonsterPic()
	else
		slot0:refreshDefaultPic()
	end
end

function slot0.refreshDefaultPic(slot0)
	gohelper.setActive(slot0.goDefaultPic, true)
	gohelper.setActive(slot0.goMonsterMaskPic, false)

	if not RougeMapEnum.EventDefaultPic[slot0.eventCo.type] then
		logError("event type not config default pic " .. tostring(slot1))

		return
	end

	slot0._simageDefaultPic:LoadImage(string.format(RougeMapEnum.PicFormat, slot2))
end

function slot0.refreshMonsterPic(slot0)
	gohelper.setActive(slot0.goDefaultPic, false)
	gohelper.setActive(slot0.goMonsterMaskPic, true)

	if string.nilorempty(RougeMapConfig.instance:getFightEvent(slot0.eventId) and slot1.monsterMask) then
		slot0:refreshDefaultPic()

		return
	end

	slot0._simageMonsterMaskPic:LoadImage(string.format(RougeMapEnum.RougeMapEnum.MonsterMaskFormat, slot2))
end

function slot0.onNormalActorBeforeMove(slot0)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectNode, nil)
end

function slot0.onActorMovingDone(slot0)
	if not RougeMapModel.instance:isNormalLayer() then
		return
	end

	slot0:_triggerHandle()
end

function slot0._triggerHandle(slot0)
	if RougePopController.instance:hadPopView() then
		slot0.waitPopDone = true

		return
	end

	if RougeMapModel.instance:isInteractiving() then
		slot0.waitInteract = true

		return
	end

	slot0.waitPopDone = nil
	slot0.waitInteract = nil

	RougeMapChoiceEventHelper.triggerEventHandle(RougeMapModel.instance:getCurNode())
end

function slot0.onClearInteract(slot0)
	if not slot0.waitInteract then
		return
	end

	slot0:_triggerHandle()
end

function slot0.onPopViewDone(slot0)
	if not slot0.waitPopDone then
		return
	end

	slot0:_triggerHandle()
end

function slot0.showDescContainer(slot0)
	gohelper.setActive(slot0.goNodeRight, true)
end

function slot0.refreshBtn(slot0, slot1)
	slot2, slot3 = nil

	if slot1 then
		slot2 = luaLang("rougemapview_txt_Fight")
		slot3 = "FIGHT"
	else
		slot2 = luaLang("rougemapview_txt_Move")
		slot3 = "MOVE"
	end

	slot0.txtBtn.text = slot2
	slot0.txtBtnEn.text = slot3
end

function slot0.hideDescContainer(slot0)
	gohelper.setActive(slot0.goNodeRight, false)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.refreshRight, slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.refreshRight, slot0)
	slot0._simageDefaultPic:UnLoadImage()
	slot0._simageMonsterMaskPic:UnLoadImage()
end

return slot0
