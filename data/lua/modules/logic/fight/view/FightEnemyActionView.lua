module("modules.logic.fight.view.FightEnemyActionView", package.seeall)

slot0 = class("FightEnemyActionView", BaseView)
slot1 = "buff/buff_outline_orange"

function slot0.onInitView(slot0)
	slot0._txtskillname = gohelper.findChildText(slot0.viewGO, "skill/#txt_skillname")
	slot0._scrollskill = gohelper.findChildScrollRect(slot0.viewGO, "skill/#scroll_skill")
	slot0._txtskilldec = gohelper.findChildText(slot0.viewGO, "skill/#scroll_skill/viewport/content/#txt_skilldec")
	slot0._btnclose = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "#btn_close")
	slot0._scrollcard = gohelper.findChildScrollRect(slot0.viewGO, "card/#scroll_card")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0.cardPrefab = slot0.viewContainer:getRes(slot0.viewContainer:getSetting().otherRes[1])
	slot0.goCardItem = gohelper.findChild(slot0.viewGO, "card/#scroll_card/viewport/content/carditem")

	gohelper.setActive(slot0.goCardItem, false)

	slot0.cardItemList = {}
	slot0.unitCamera = CameraMgr.instance:getUnitCamera()
	slot0.tempVector4 = Vector4(0, 0, 0, 0)
	slot0.startVector3 = Vector3(0, 0, 0)
	slot0.targetVector3 = Vector3(0, 0, 0)

	slot0:initRate()
	slot0:initLine()
	slot0:initSelectItem()
	SkillHelper.addHyperLinkClick(slot0._txtskilldec)
	slot0:addEventCb(FightController.instance, FightEvent.OnEnemyActionStatusChange, slot0.onEnemyActionStatusChange, slot0)
end

function slot0.initRate(slot0)
	if UnityEngine.Screen.width / UnityEngine.Screen.height - 1.7777777777777777 > 0.01 then
		slot5 = recthelper.getHeight(slot0.viewGO.transform)
		slot0.halfPxHeight = slot5 / 2
		slot0.hRate = slot5 / slot3
		slot6 = slot4 * slot5
		slot0.halfPxWidth = slot6 / 2
		slot0.wRate = slot6 / slot2
	else
		slot5 = recthelper.getWidth(slot0.viewGO.transform)
		slot0.halfPxWidth = slot5 / 2
		slot0.wRate = slot5 / slot2
		slot6 = slot5 / slot4
		slot0.halfPxHeight = slot6 / 2
		slot0.hRate = slot6 / slot3
	end
end

function slot0.initLine(slot0)
	slot0.goRedFullLine = gohelper.findChild(slot0.viewGO, "lineContainer/red_fullline")

	gohelper.setActive(slot0.goRedFullLine, false)

	slot0.goRedDottedLine = gohelper.findChild(slot0.viewGO, "lineContainer/red_dottedline")

	gohelper.setActive(slot0.goRedDottedLine, false)

	slot0.goYellowFullLine = gohelper.findChild(slot0.viewGO, "lineContainer/yellow_fullline")

	gohelper.setActive(slot0.goYellowFullLine, false)

	slot0.goYellowDottedLine = gohelper.findChild(slot0.viewGO, "lineContainer/yellow_dottedline")

	gohelper.setActive(slot0.goYellowDottedLine, false)

	slot0.redFullLineList = slot0:getUserDataTb_()

	table.insert(slot0.redFullLineList, slot0.goRedFullLine)

	slot0.redDottedLineList = slot0:getUserDataTb_()

	table.insert(slot0.redDottedLineList, slot0.goRedDottedLine)

	slot0.yellowFullLineList = slot0:getUserDataTb_()

	table.insert(slot0.yellowFullLineList, slot0.goYellowFullLine)

	slot0.yellowDottedLineList = slot0:getUserDataTb_()

	table.insert(slot0.yellowDottedLineList, slot0.goYellowDottedLine)

	slot0.fullLineColor2LineList = {
		[FightEnum.SkillLineColor.Red] = slot0.redFullLineList,
		[FightEnum.SkillLineColor.Yellow] = slot0.yellowFullLineList
	}
	slot0.dottedLineColor2LineList = {
		[FightEnum.SkillLineColor.Red] = slot0.redDottedLineList,
		[FightEnum.SkillLineColor.Yellow] = slot0.yellowDottedLineList
	}
end

function slot0.initSelectItem(slot0)
	slot0.goSelectContainer = gohelper.findChild(slot0.viewGO, "selectcontainer")

	gohelper.setActive(slot0.goSelectContainer, true)

	slot0.selectContainerTr = slot0.goSelectContainer:GetComponent(gohelper.Type_RectTransform)
	slot0.goSelectItem = gohelper.findChild(slot0.viewGO, "selectcontainer/selectitem")
	slot0.selectGoList = slot0:getUserDataTb_()

	table.insert(slot0.selectGoList, slot0.goSelectItem)
end

function slot0.onEnemyActionStatusChange(slot0, slot1)
	if slot1 == FightEnum.EnemyActionStatus.Select then
		return
	end

	slot0:closeThis()
end

function slot0.onOpen(slot0)
	FightViewPartVisible.set(false, false, false, false, false)
	slot0:initBossList()

	slot0.cardList = tabletool.copy(FightModel.instance:getCurRoundMO() and slot1:getAIUseCardMOList() or {})

	slot0:filterValidCard()
	slot0:refreshCardList()
	slot0:selectCard(slot0.cardList[1])
end

function slot0.filterValidCard(slot0)
	for slot5 = #slot0.cardList, 1, -1 do
		if not FightDataHelper.entityMgr:getById(slot0.cardList[slot5].uid) then
			table.remove(slot0.cardList, slot5)
		end
	end
end

function slot0.initBossList(slot0)
	slot2 = FightModel.instance:getBattleId() and lua_battle.configDict[slot1]

	if not string.nilorempty(slot2 and slot2.monsterGroupIds) then
		slot0.groupBossIdList = {}

		for slot8, slot9 in ipairs(string.splitToNumber(slot3, "#")) do
			slot0.groupBossIdList[slot8] = lua_monster_group.configDict[slot9] and string.splitToNumber(slot10.bossId, "#")
		end
	end
end

function slot0.refreshCardList(slot0)
	for slot4, slot5 in ipairs(slot0.cardList) do
		if FightDataHelper.entityMgr:getById(slot5.uid) then
			slot0:refreshCardItem(slot0:getCardItem(slot5))
		end
	end
end

function slot0.getCardItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = gohelper.cloneInPlace(slot0.goCardItem)

	gohelper.setActive(slot2.go, true)

	slot2.imageQualityBg = gohelper.findChildImage(slot2.go, "go_enemy/#image_qualitybg")
	slot2.simageHeadIcon = gohelper.findChildSingleImage(slot2.go, "go_enemy/#simage_enemyicon")
	slot2.imageHeadIcon = gohelper.findChildImage(slot2.go, "go_enemy/#simage_enemyicon")
	slot2.imageQualityBg = gohelper.findChildImage(slot2.go, "go_enemy/#image_qualitybg")
	slot2.goSelectBig = gohelper.findChild(slot2.go, "select_big")
	slot2.goSelectSmall = gohelper.findChild(slot2.go, "select_small")
	slot2.click = gohelper.findChildClickWithDefaultAudio(slot2.go, "clickarea")

	slot2.click:AddClickListener(slot0.onClickCard, slot0, slot1)

	slot2.goCard = gohelper.findChild(slot2.go, "go_card")
	slot2.actionCardItem = FightEnemyActionCardItem.get(gohelper.clone(slot0.cardPrefab, slot2.goCard), slot1)
	slot2.cardMo = slot1

	table.insert(slot0.cardItemList, slot2)

	return slot2
end

function slot0.refreshCardItem(slot0, slot1)
	if not FightDataHelper.entityMgr:getById(slot1.cardMo.uid) then
		logError("刷新卡牌未找到entity 数据 : " .. tostring(slot2.uid))

		return
	end

	slot5 = slot3.modelId

	if slot3.skin and FightConfig.instance:getSkinCO(slot4) then
		slot1.simageHeadIcon:LoadImage(ResUrl.monsterHeadIcon(slot6.headIcon))

		if not FightEntityDataHelper.isPlayerUid(slot3.id) then
			IconMaterialMgr.instance:loadMaterialAddSet(IconMaterialMgr.instance:getMaterialPathWithRound(slot3:getCO().heartVariantId), slot1.imageHeadIcon)
		end
	end

	UISpriteSetMgr.instance:setFightSprite(slot1.imageQualityBg, slot0:isBoss(slot5) and "fight_enemyaction_headbg3" or "fight_enemyaction_headbg1")
	slot1.actionCardItem:refreshCard()
end

function slot0.isBoss(slot0, slot1)
	if not slot0.groupBossIdList then
		return false
	end

	if not slot0.groupBossIdList[FightModel.instance:getCurWaveId()] then
		return false
	end

	for slot7, slot8 in ipairs(slot3) do
		if slot1 == slot8 then
			return true
		end
	end

	return false
end

function slot0.selectCard(slot0, slot1)
	if FightHelper.isSameCardMo(slot1, slot0.selectCardMo) then
		return
	end

	slot0.selectCardMo = slot1

	FightController.instance:dispatchEvent(FightEvent.OnSelectMonsterCardMo, slot0.selectCardMo)
	slot0:refreshSelectStatus()
	slot0:refreshSelectText()
	slot0:refreshSelectLine()
	slot0:refreshEnemyOutLine()
end

function slot0.refreshSelectStatus(slot0)
	for slot4, slot5 in ipairs(slot0.cardList) do
		if slot0.cardItemList[slot4] then
			if slot5 == slot0.selectCardMo then
				slot8 = slot5:isUniqueSkill()

				gohelper.setActive(slot6.goSelectBig, slot8)
				gohelper.setActive(slot6.goSelectSmall, not slot8)
			else
				gohelper.setActive(slot6.goSelectBig, false)
				gohelper.setActive(slot6.goSelectSmall, false)
			end
		end
	end
end

function slot0.refreshSelectText(slot0)
	if not lua_skill.configDict[slot0.selectCardMo.skillId] then
		return
	end

	slot0._txtskillname.text = slot1.name
	slot0._txtskilldec.text = SkillHelper.getSkillDesc(FightDataHelper.entityMgr:getById(slot0.selectCardMo.uid) and slot2:getEntityName() or nil, slot1)
end

function slot0.refreshSelectLine(slot0)
	if not lua_skill.configDict[slot0.selectCardMo.skillId] then
		return
	end

	slot0:hideAllLine()
	slot0:hideAllSelectUI()

	if slot0:getTargetType() == FightEnum.SkillTargetType.Single then
		slot0:drawSingleLine()
	elseif slot2 == FightEnum.SkillTargetType.Multi then
		slot0:drawMultiLine(slot1.targetLimit)
	elseif slot2 == FightEnum.SkillTargetType.Side then
		slot0:drawSideLine(slot1.targetLimit)
	else
		logError("暂不支持全场")
	end
end

function slot0.refreshEnemyOutLine(slot0)
	if not slot0.selectCardMo then
		return
	end

	slot0:hideAllOutLine()

	if not FightHelper.getEntity(slot0.selectCardMo.uid) then
		return
	end

	if slot1.effect:getEffectWrap(uv0) then
		slot2:setActive(true)
	else
		slot2 = slot1.effect:addHangEffect(uv0, ModuleEnum.SpineHangPointRoot, nil, , , true)

		slot2:setActive(true)
		slot2:setLocalPos(0, 0, 0)
		FightRenderOrderMgr.instance:onAddEffectWrap(slot1.id, slot2)
	end
end

function slot0.hideAllOutLine(slot0)
	for slot6, slot7 in pairs(GameSceneMgr.instance:getCurScene().entityMgr:getTagUnitDict(SceneTag.UnitMonster)) do
		if slot7.effect:getEffectWrap(uv0) then
			slot8:setActive(false)
		end
	end
end

function slot0.getTargetType(slot0)
	if not lua_skill.configDict[slot0.selectCardMo.skillId] then
		return FightEnum.SkillTargetType.Single
	end

	slot3 = slot1.logicTarget and lua_ai_monster_target.configDict[slot2]

	return slot3 and slot3.targetNumber or FightEnum.SkillTargetType.Single
end

function slot0.getLineColor(slot0)
	if not lua_skill.configDict[slot0.selectCardMo.skillId] then
		return FightEnum.SkillLineColor.Red
	end

	slot3 = slot1.showTag and lua_ai_monster_card_tag.configDict[slot2]

	return slot3 and slot3.lineColor or FightEnum.SkillLineColor.Red
end

slot0.StartParam = UnityEngine.Shader.PropertyToID("_StartVec")
slot0.TargetParam = UnityEngine.Shader.PropertyToID("_EndVec")

function slot0.drawSingleLine(slot0)
	slot3 = slot0:getEntityTopScreenPos(slot0.selectCardMo.targetUid)

	if not slot0:getCardScreenPos(slot0.selectCardMo) or not slot3 then
		return
	end

	slot4 = slot0:getLineColor()

	slot0:drawLine(slot0:getLineGo(1, slot0:canUseSkill(slot0.selectCardMo) and slot0.fullLineColor2LineList[slot4] or slot0.dottedLineColor2LineList[slot4]), slot2, slot3)
	slot0:showSelectUI(1, slot1)
end

function slot0.drawMultiLine(slot0, slot1)
	if not slot0:getCardScreenPos(slot0.selectCardMo) then
		return
	end

	slot3 = nil
	slot4 = GameSceneMgr.instance:getCurScene().entityMgr

	for slot11, slot12 in pairs((slot1 ~= FightEnum.TargetLimit.EnemySide or slot4:getTagUnitDict(SceneTag.UnitPlayer)) and slot4:getTagUnitDict(SceneTag.UnitMonster)) do
		if not slot12.isSub then
			if slot0:getEntityTopScreenPos(slot11) then
				slot7 = 0 + 1

				slot0:drawLine(slot0:getLineGo(slot7, (slot0:canUseSkill(slot0.selectCardMo) and slot0.selectCardMo.targetUid == slot11 and slot0.fullLineColor2LineList or slot0.dottedLineColor2LineList)[slot0:getLineColor()]), slot2, slot15)
				slot0:showSelectUI(slot7, slot12.id)
			end
		end
	end
end

function slot0.drawSideLine(slot0, slot1)
	if not slot0:getCardScreenPos(slot0.selectCardMo) then
		return
	end

	slot3 = nil
	slot4 = GameSceneMgr.instance:getCurScene().entityMgr
	slot5 = slot0:getLineColor()

	for slot11, slot12 in pairs((slot1 ~= FightEnum.TargetLimit.EnemySide or slot4:getTagUnitDict(SceneTag.UnitPlayer)) and slot4:getTagUnitDict(SceneTag.UnitMonster)) do
		if not slot12.isSub then
			if slot0:getEntityTopScreenPos(slot11) then
				slot7 = 0 + 1

				slot0:drawLine(slot0:getLineGo(slot7, slot0:canUseSkill(slot0.selectCardMo) and slot0.fullLineColor2LineList[slot5] or slot0.dottedLineColor2LineList[slot5]), slot2, slot14)
				slot0:showSelectUI(slot7, slot12.id)
			end
		end
	end
end

function slot0.drawLine(slot0, slot1, slot2, slot3)
	slot0:setArrowPosition(slot1, slot2, slot3)

	slot2, slot3 = slot0:getFormatPos(slot2, slot3)

	if not gohelper.isNil(gohelper.findChild(slot1, "fulllineeffect")) and slot4:GetComponent(typeof(UnityEngine.Renderer)) and slot5.material then
		slot0:setMatByScreenPos(slot6, uv0.StartParam, slot2)
		slot0:setMatByScreenPos(slot6, uv0.TargetParam, slot3)
	end

	slot6 = slot1:GetComponent(typeof(UnityEngine.Renderer)).material

	slot0:setMatByScreenPos(slot6, uv0.StartParam, slot2)
	slot0:setMatByScreenPos(slot6, uv0.TargetParam, slot3)
end

slot0.Orient = {
	Right = 1,
	Left = 2
}
slot0.RotationZ = 140

function slot0.setArrowPosition(slot0, slot1, slot2, slot3)
	if gohelper.findChild(slot1, "#tou") then
		transformhelper.setLocalRotation(slot4.transform, 0, 0, (slot2.x <= slot3.x and uv0.Orient.Right or uv0.Orient.Left) == uv0.Orient.Right and -uv0.RotationZ or uv0.RotationZ)

		slot7, slot8 = recthelper.screenPosToAnchorPos2(slot3, slot1.transform)

		recthelper.setAnchor(slot4.transform, slot7, slot8)
	end
end

function slot0.setMatByScreenPos(slot0, slot1, slot2, slot3)
	slot0.tempVector4:Set(slot3.x * slot0.wRate - slot0.halfPxWidth, slot3.y * slot0.hRate - slot0.halfPxHeight, 0, 0)
	slot1:SetVector(slot2, slot0.tempVector4)
end

function slot0.getFormatPos(slot0, slot1, slot2)
	if slot2.x < slot1.x then
		return slot2, slot1
	end

	return slot1, slot2
end

function slot0.getLineGo(slot0, slot1, slot2)
	if not slot2[slot1] then
		table.insert(slot2, gohelper.cloneInPlace(slot2[1]))
	end

	gohelper.setActive(slot3, true)

	return slot3
end

function slot0.getCardScreenPos(slot0, slot1)
	if not FightHelper.getEntity(slot1.uid) then
		return
	end

	if not (slot2.nameUI and slot3:getOpCtrl()) then
		return
	end

	for slot9, slot10 in ipairs(slot4:getOpItemList()) do
		if FightHelper.isSameCardMo(slot10.cardInfoMO, slot1) then
			slot12, slot13 = recthelper.uiPosToScreenPos2(slot10.topPosRectTr)

			slot0.startVector3:Set(slot12, slot13)

			return slot0.startVector3
		end
	end
end

function slot0.getEntityTopScreenPos(slot0, slot1)
	if not FightHelper.getEntity(slot1) then
		return
	end

	if not slot2.nameUI then
		return
	end

	slot5, slot6 = recthelper.uiPosToScreenPos2(slot3.careerTopRectTr)

	slot0.targetVector3:Set(slot5, slot6)

	return slot0.targetVector3
end

function slot0.hideAllLine(slot0)
	slot0:hideLineList(slot0.redFullLineList)
	slot0:hideLineList(slot0.redDottedLineList)
	slot0:hideLineList(slot0.yellowFullLineList)
	slot0:hideLineList(slot0.yellowDottedLineList)
end

function slot0.hideLineList(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		gohelper.setActive(slot6, false)
	end
end

function slot0.hideAllSelectUI(slot0)
	for slot4, slot5 in ipairs(slot0.selectGoList) do
		gohelper.setActive(slot5, false)
	end
end

function slot0.showSelectUI(slot0, slot1, slot2)
	if not slot0.selectGoList[slot1] then
		table.insert(slot0.selectGoList, gohelper.cloneInPlace(slot0.goSelectItem))
	end

	if not FightHelper.getEntity(slot2) then
		gohelper.setActive(slot3, false)

		return
	end

	gohelper.setActive(slot3, true)

	if FightHelper.isAssembledMonster(slot4) then
		slot7 = lua_fight_assembled_monster.configDict[slot4:getMO().skin]
		slot8, slot9, slot10 = transformhelper.getPos(slot4.go.transform)
		slot11, slot12 = recthelper.worldPosToAnchorPosXYZ(slot8 + slot7.selectPos[1], slot9 + slot7.selectPos[2], slot10, slot0.selectContainerTr)

		recthelper.setAnchor(slot3:GetComponent(gohelper.Type_RectTransform), slot11, slot12)

		return
	end

	if slot4:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle) and slot6.name == ModuleEnum.SpineHangPoint.mountmiddle then
		slot7, slot8, slot9 = transformhelper.getPos(slot6.transform)
		slot10, slot11 = recthelper.worldPosToAnchorPosXYZ(slot7, slot8, slot9, slot0.selectContainerTr)

		recthelper.setAnchor(slot5, slot10, slot11)

		return
	end

	slot7, slot8, slot9, slot10 = slot0:_calcRect(slot4)

	recthelper.setAnchor(slot5, (slot7 + slot9) / 2, (slot8 + slot10) / 2)
end

function slot0._calcRect(slot0, slot1)
	slot3, slot4, slot5 = transformhelper.getPos(slot1:getHangPoint(ModuleEnum.SpineHangPoint.BodyStatic).transform)
	slot6, slot7 = FightHelper.getEntityBoxSizeOffsetV2(slot1)
	slot8 = slot1:isMySide() and 1 or -1
	slot9, slot10 = recthelper.worldPosToAnchorPosXYZ(slot3 - slot6.x * 0.5, slot4 - slot6.y * 0.5 * slot8, slot5, slot0.selectContainerTr)
	slot11, slot12 = recthelper.worldPosToAnchorPosXYZ(slot3 + slot6.x * 0.5, slot4 + slot6.y * 0.5 * slot8, slot5, slot0.selectContainerTr)

	return slot9, slot10, slot11, slot12
end

function slot0.canUseSkill(slot0, slot1)
	slot2 = slot1.skillId

	if not FightHelper.getEntity(slot1.uid) then
		return true
	end

	slot4 = slot3:getMO()

	if FightCardModel.instance:isUniqueSkill(slot3.id, slot2) then
		slot5 = FightViewHandCardItemLock.canUseCardSkill(slot3.id, slot2) and slot4:getUniqueSkillPoint() <= slot4.exPoint
	end

	return slot5
end

function slot0.onClickCard(slot0, slot1)
	slot0:selectCard(slot1)
end

function slot0.onClose(slot0)
	FightViewPartVisible.set(true, true, true, false, false)
	slot0:hideAllOutLine()
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.cardItemList) do
		slot5.click:RemoveClickListener()
		slot5.simageHeadIcon:UnLoadImage()
		slot5.actionCardItem:destroy()
	end
end

return slot0
