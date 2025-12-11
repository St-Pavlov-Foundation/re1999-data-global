module("modules.logic.fight.view.FightEnemyActionView", package.seeall)

local var_0_0 = class("FightEnemyActionView", BaseView)
local var_0_1 = "buff/buff_outline_orange"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtskillname = gohelper.findChildText(arg_1_0.viewGO, "skill/#txt_skillname")
	arg_1_0._scrollskill = gohelper.findChildScrollRect(arg_1_0.viewGO, "skill/#scroll_skill")
	arg_1_0._txtskilldec = gohelper.findChildText(arg_1_0.viewGO, "skill/#scroll_skill/viewport/content/#txt_skilldec")
	arg_1_0._btnclose = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._scrollcard = gohelper.findChildScrollRect(arg_1_0.viewGO, "card/#scroll_card")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	local var_5_0 = arg_5_0.viewContainer:getSetting().otherRes[1]

	arg_5_0.cardPrefab = arg_5_0.viewContainer:getRes(var_5_0)
	arg_5_0.goCardItem = gohelper.findChild(arg_5_0.viewGO, "card/#scroll_card/viewport/content/carditem")

	gohelper.setActive(arg_5_0.goCardItem, false)

	arg_5_0.cardItemList = {}
	arg_5_0.unitCamera = CameraMgr.instance:getUnitCamera()
	arg_5_0.tempVector4 = Vector4(0, 0, 0, 0)
	arg_5_0.startVector3 = Vector3(0, 0, 0)
	arg_5_0.targetVector3 = Vector3(0, 0, 0)

	arg_5_0:initRate()
	arg_5_0:initLine()
	arg_5_0:initSelectItem()
	SkillHelper.addHyperLinkClick(arg_5_0._txtskilldec)
	arg_5_0:addEventCb(FightController.instance, FightEvent.OnEnemyActionStatusChange, arg_5_0.onEnemyActionStatusChange, arg_5_0)
end

function var_0_0.initRate(arg_6_0)
	local var_6_0 = 1.7777777777777777
	local var_6_1 = UnityEngine.Screen.width
	local var_6_2 = UnityEngine.Screen.height
	local var_6_3 = var_6_1 / var_6_2

	if var_6_3 - var_6_0 > 0.01 then
		local var_6_4 = recthelper.getHeight(arg_6_0.viewGO.transform)

		arg_6_0.halfPxHeight = var_6_4 / 2
		arg_6_0.hRate = var_6_4 / var_6_2

		local var_6_5 = var_6_3 * var_6_4

		arg_6_0.halfPxWidth = var_6_5 / 2
		arg_6_0.wRate = var_6_5 / var_6_1
	else
		local var_6_6 = recthelper.getWidth(arg_6_0.viewGO.transform)

		arg_6_0.halfPxWidth = var_6_6 / 2
		arg_6_0.wRate = var_6_6 / var_6_1

		local var_6_7 = var_6_6 / var_6_3

		arg_6_0.halfPxHeight = var_6_7 / 2
		arg_6_0.hRate = var_6_7 / var_6_2
	end
end

function var_0_0.initLine(arg_7_0)
	arg_7_0.goRedFullLine = gohelper.findChild(arg_7_0.viewGO, "lineContainer/red_fullline")

	gohelper.setActive(arg_7_0.goRedFullLine, false)

	arg_7_0.goRedDottedLine = gohelper.findChild(arg_7_0.viewGO, "lineContainer/red_dottedline")

	gohelper.setActive(arg_7_0.goRedDottedLine, false)

	arg_7_0.goYellowFullLine = gohelper.findChild(arg_7_0.viewGO, "lineContainer/yellow_fullline")

	gohelper.setActive(arg_7_0.goYellowFullLine, false)

	arg_7_0.goYellowDottedLine = gohelper.findChild(arg_7_0.viewGO, "lineContainer/yellow_dottedline")

	gohelper.setActive(arg_7_0.goYellowDottedLine, false)

	arg_7_0.redFullLineList = arg_7_0:getUserDataTb_()

	table.insert(arg_7_0.redFullLineList, arg_7_0.goRedFullLine)

	arg_7_0.redDottedLineList = arg_7_0:getUserDataTb_()

	table.insert(arg_7_0.redDottedLineList, arg_7_0.goRedDottedLine)

	arg_7_0.yellowFullLineList = arg_7_0:getUserDataTb_()

	table.insert(arg_7_0.yellowFullLineList, arg_7_0.goYellowFullLine)

	arg_7_0.yellowDottedLineList = arg_7_0:getUserDataTb_()

	table.insert(arg_7_0.yellowDottedLineList, arg_7_0.goYellowDottedLine)

	arg_7_0.fullLineColor2LineList = {
		[FightEnum.SkillLineColor.Red] = arg_7_0.redFullLineList,
		[FightEnum.SkillLineColor.Yellow] = arg_7_0.yellowFullLineList
	}
	arg_7_0.dottedLineColor2LineList = {
		[FightEnum.SkillLineColor.Red] = arg_7_0.redDottedLineList,
		[FightEnum.SkillLineColor.Yellow] = arg_7_0.yellowDottedLineList
	}
end

function var_0_0.initSelectItem(arg_8_0)
	arg_8_0.goSelectContainer = gohelper.findChild(arg_8_0.viewGO, "selectcontainer")

	gohelper.setActive(arg_8_0.goSelectContainer, true)

	arg_8_0.selectContainerTr = arg_8_0.goSelectContainer:GetComponent(gohelper.Type_RectTransform)
	arg_8_0.goSelectItem = gohelper.findChild(arg_8_0.viewGO, "selectcontainer/selectitem")
	arg_8_0.selectGoList = arg_8_0:getUserDataTb_()

	table.insert(arg_8_0.selectGoList, arg_8_0.goSelectItem)
end

function var_0_0.onEnemyActionStatusChange(arg_9_0, arg_9_1)
	if arg_9_1 == FightEnum.EnemyActionStatus.Select then
		return
	end

	arg_9_0:closeThis()
end

function var_0_0.onOpen(arg_10_0)
	FightViewPartVisible.set(false, false, false, false, false)
	arg_10_0:initBossList()

	local var_10_0 = FightDataHelper.roundMgr:getRoundData()
	local var_10_1 = var_10_0 and var_10_0:getAIUseCardMOList() or {}

	arg_10_0.cardList = tabletool.copy(var_10_1)

	arg_10_0:filterValidCard()
	arg_10_0:refreshCardList()
	arg_10_0:selectCard(arg_10_0.cardList[1])
end

function var_0_0.filterValidCard(arg_11_0)
	for iter_11_0 = #arg_11_0.cardList, 1, -1 do
		local var_11_0 = arg_11_0.cardList[iter_11_0]

		if not FightDataHelper.entityMgr:getById(var_11_0.uid) then
			table.remove(arg_11_0.cardList, iter_11_0)
		end
	end
end

function var_0_0.initBossList(arg_12_0)
	local var_12_0 = FightModel.instance:getBattleId()
	local var_12_1 = var_12_0 and lua_battle.configDict[var_12_0]
	local var_12_2 = var_12_1 and var_12_1.monsterGroupIds

	if not string.nilorempty(var_12_2) then
		arg_12_0.groupBossIdList = {}

		local var_12_3 = string.splitToNumber(var_12_2, "#")

		for iter_12_0, iter_12_1 in ipairs(var_12_3) do
			local var_12_4 = lua_monster_group.configDict[iter_12_1]
			local var_12_5 = var_12_4 and string.splitToNumber(var_12_4.bossId, "#")

			arg_12_0.groupBossIdList[iter_12_0] = var_12_5
		end
	end
end

function var_0_0.refreshCardList(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.cardList) do
		if FightDataHelper.entityMgr:getById(iter_13_1.uid) then
			local var_13_0 = arg_13_0:getCardItem(iter_13_1)

			arg_13_0:refreshCardItem(var_13_0)
		end
	end
end

function var_0_0.getCardItem(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getUserDataTb_()

	var_14_0.go = gohelper.cloneInPlace(arg_14_0.goCardItem)

	gohelper.setActive(var_14_0.go, true)

	var_14_0.imageQualityBg = gohelper.findChildImage(var_14_0.go, "go_enemy/#image_qualitybg")
	var_14_0.simageHeadIcon = gohelper.findChildSingleImage(var_14_0.go, "go_enemy/#simage_enemyicon")
	var_14_0.imageHeadIcon = gohelper.findChildImage(var_14_0.go, "go_enemy/#simage_enemyicon")
	var_14_0.imageQualityBg = gohelper.findChildImage(var_14_0.go, "go_enemy/#image_qualitybg")
	var_14_0.goSelectBig = gohelper.findChild(var_14_0.go, "select_big")
	var_14_0.goSelectSmall = gohelper.findChild(var_14_0.go, "select_small")
	var_14_0.click = gohelper.findChildClickWithDefaultAudio(var_14_0.go, "clickarea")

	var_14_0.click:AddClickListener(arg_14_0.onClickCard, arg_14_0, arg_14_1)

	var_14_0.goCard = gohelper.findChild(var_14_0.go, "go_card")

	local var_14_1 = gohelper.clone(arg_14_0.cardPrefab, var_14_0.goCard)

	var_14_0.actionCardItem = FightEnemyActionCardItem.get(var_14_1, arg_14_1)
	var_14_0.cardMo = arg_14_1

	table.insert(arg_14_0.cardItemList, var_14_0)

	return var_14_0
end

function var_0_0.refreshCardItem(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.cardMo
	local var_15_1 = FightDataHelper.entityMgr:getById(var_15_0.uid)

	if not var_15_1 then
		logError("刷新卡牌未找到entity 数据 : " .. tostring(var_15_0.uid))

		return
	end

	local var_15_2 = var_15_1.skin
	local var_15_3 = var_15_1.modelId
	local var_15_4 = var_15_2 and FightConfig.instance:getSkinCO(var_15_2)

	if var_15_4 then
		arg_15_1.simageHeadIcon:LoadImage(ResUrl.monsterHeadIcon(var_15_4.headIcon))

		if not FightEntityDataHelper.isPlayerUid(var_15_1.id) then
			local var_15_5 = var_15_1:getCO()
			local var_15_6 = IconMaterialMgr.instance:getMaterialPathWithRound(var_15_5.heartVariantId)

			IconMaterialMgr.instance:loadMaterialAddSet(var_15_6, arg_15_1.imageHeadIcon)
		end
	end

	local var_15_7 = arg_15_0:isBoss(var_15_3) and "fight_enemyaction_headbg3" or "fight_enemyaction_headbg1"

	UISpriteSetMgr.instance:setFightSprite(arg_15_1.imageQualityBg, var_15_7)
	arg_15_1.actionCardItem:refreshCard()
end

function var_0_0.isBoss(arg_16_0, arg_16_1)
	if not arg_16_0.groupBossIdList then
		return false
	end

	local var_16_0 = FightModel.instance:getCurWaveId()
	local var_16_1 = arg_16_0.groupBossIdList[var_16_0]

	if not var_16_1 then
		return false
	end

	for iter_16_0, iter_16_1 in ipairs(var_16_1) do
		if arg_16_1 == iter_16_1 then
			return true
		end
	end

	return false
end

function var_0_0.selectCard(arg_17_0, arg_17_1)
	if FightHelper.isSameCardMo(arg_17_1, arg_17_0.selectCardMo) then
		return
	end

	arg_17_0.selectCardMo = arg_17_1

	FightController.instance:dispatchEvent(FightEvent.OnSelectMonsterCardMo, arg_17_0.selectCardMo)
	arg_17_0:refreshSelectStatus()
	arg_17_0:refreshSelectText()
	arg_17_0:refreshSelectLine()
	arg_17_0:refreshEnemyOutLine()
end

function var_0_0.refreshSelectStatus(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0.cardList) do
		local var_18_0 = arg_18_0.cardItemList[iter_18_0]

		if var_18_0 then
			if iter_18_1 == arg_18_0.selectCardMo then
				local var_18_1 = iter_18_1:isBigSkill()

				gohelper.setActive(var_18_0.goSelectBig, var_18_1)
				gohelper.setActive(var_18_0.goSelectSmall, not var_18_1)
			else
				gohelper.setActive(var_18_0.goSelectBig, false)
				gohelper.setActive(var_18_0.goSelectSmall, false)
			end
		end
	end
end

function var_0_0.refreshSelectText(arg_19_0)
	local var_19_0 = lua_skill.configDict[arg_19_0.selectCardMo.skillId]

	if not var_19_0 then
		return
	end

	local var_19_1 = FightDataHelper.entityMgr:getById(arg_19_0.selectCardMo.uid)

	arg_19_0._txtskillname.text = var_19_0.name
	arg_19_0._txtskilldec.text = SkillHelper.getSkillDesc(var_19_1 and var_19_1:getEntityName() or nil, var_19_0)
end

function var_0_0.refreshSelectLine(arg_20_0)
	local var_20_0 = lua_skill.configDict[arg_20_0.selectCardMo.skillId]

	if not var_20_0 then
		return
	end

	local var_20_1 = arg_20_0:getTargetType()

	arg_20_0:hideAllLine()
	arg_20_0:hideAllSelectUI()

	if var_20_1 == FightEnum.SkillTargetType.Single then
		arg_20_0:drawSingleLine()
	elseif var_20_1 == FightEnum.SkillTargetType.Multi then
		arg_20_0:drawMultiLine(var_20_0.targetLimit)
	elseif var_20_1 == FightEnum.SkillTargetType.Side then
		arg_20_0:drawSideLine(var_20_0.targetLimit)
	else
		logError("暂不支持全场")
	end
end

function var_0_0.refreshEnemyOutLine(arg_21_0)
	if not arg_21_0.selectCardMo then
		return
	end

	arg_21_0:hideAllOutLine()

	local var_21_0 = FightHelper.getEntity(arg_21_0.selectCardMo.uid)

	if not var_21_0 then
		return
	end

	local var_21_1 = var_21_0.effect:getEffectWrap(var_0_1)

	if var_21_1 then
		var_21_1:setActive(true)
	else
		local var_21_2 = var_21_0.effect:addHangEffect(var_0_1, ModuleEnum.SpineHangPointRoot, nil, nil, nil, true)

		var_21_2:setActive(true)
		var_21_2:setLocalPos(0, 0, 0)
		FightRenderOrderMgr.instance:onAddEffectWrap(var_21_0.id, var_21_2)
	end
end

function var_0_0.hideAllOutLine(arg_22_0)
	local var_22_0 = GameSceneMgr.instance:getCurScene().entityMgr:getTagUnitDict(SceneTag.UnitMonster)

	for iter_22_0, iter_22_1 in pairs(var_22_0) do
		local var_22_1 = iter_22_1.effect:getEffectWrap(var_0_1)

		if var_22_1 then
			var_22_1:setActive(false)
		end
	end
end

function var_0_0.getTargetType(arg_23_0)
	local var_23_0 = lua_skill.configDict[arg_23_0.selectCardMo.skillId]

	if not var_23_0 then
		return FightEnum.SkillTargetType.Single
	end

	local var_23_1 = var_23_0.logicTarget
	local var_23_2 = var_23_1 and lua_ai_monster_target.configDict[var_23_1]

	return var_23_2 and var_23_2.targetNumber or FightEnum.SkillTargetType.Single
end

function var_0_0.getLineColor(arg_24_0)
	local var_24_0 = lua_skill.configDict[arg_24_0.selectCardMo.skillId]

	if not var_24_0 then
		return FightEnum.SkillLineColor.Red
	end

	local var_24_1 = var_24_0.showTag
	local var_24_2 = var_24_1 and lua_ai_monster_card_tag.configDict[var_24_1]

	return var_24_2 and var_24_2.lineColor or FightEnum.SkillLineColor.Red
end

var_0_0.StartParam = UnityEngine.Shader.PropertyToID("_StartVec")
var_0_0.TargetParam = UnityEngine.Shader.PropertyToID("_EndVec")

function var_0_0.drawSingleLine(arg_25_0)
	local var_25_0 = arg_25_0.selectCardMo.targetUid
	local var_25_1 = arg_25_0:getCardScreenPos(arg_25_0.selectCardMo)
	local var_25_2 = arg_25_0:getEntityTopScreenPos(var_25_0)

	if not var_25_1 or not var_25_2 then
		return
	end

	local var_25_3 = arg_25_0:getLineColor()
	local var_25_4 = arg_25_0:canUseSkill(arg_25_0.selectCardMo) and arg_25_0.fullLineColor2LineList[var_25_3] or arg_25_0.dottedLineColor2LineList[var_25_3]
	local var_25_5 = arg_25_0:getLineGo(1, var_25_4)

	arg_25_0:drawLine(var_25_5, var_25_1, var_25_2)
	arg_25_0:showSelectUI(1, var_25_0)
end

function var_0_0.drawMultiLine(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:getCardScreenPos(arg_26_0.selectCardMo)

	if not var_26_0 then
		return
	end

	local var_26_1
	local var_26_2 = GameSceneMgr.instance:getCurScene().entityMgr

	if arg_26_1 == FightEnum.TargetLimit.EnemySide then
		var_26_1 = var_26_2:getTagUnitDict(SceneTag.UnitPlayer)
	else
		var_26_1 = var_26_2:getTagUnitDict(SceneTag.UnitMonster)
	end

	local var_26_3 = arg_26_0:getLineColor()
	local var_26_4 = arg_26_0:canUseSkill(arg_26_0.selectCardMo)
	local var_26_5 = 0

	for iter_26_0, iter_26_1 in pairs(var_26_1) do
		if not iter_26_1.isSub then
			local var_26_6 = (var_26_4 and arg_26_0.selectCardMo.targetUid == iter_26_0 and arg_26_0.fullLineColor2LineList or arg_26_0.dottedLineColor2LineList)[var_26_3]
			local var_26_7 = arg_26_0:getEntityTopScreenPos(iter_26_0)

			if var_26_7 then
				var_26_5 = var_26_5 + 1

				local var_26_8 = arg_26_0:getLineGo(var_26_5, var_26_6)

				arg_26_0:drawLine(var_26_8, var_26_0, var_26_7)
				arg_26_0:showSelectUI(var_26_5, iter_26_1.id)
			end
		end
	end
end

function var_0_0.drawSideLine(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0:getCardScreenPos(arg_27_0.selectCardMo)

	if not var_27_0 then
		return
	end

	local var_27_1
	local var_27_2 = GameSceneMgr.instance:getCurScene().entityMgr

	if arg_27_1 == FightEnum.TargetLimit.EnemySide then
		var_27_1 = var_27_2:getTagUnitDict(SceneTag.UnitPlayer)
	else
		var_27_1 = var_27_2:getTagUnitDict(SceneTag.UnitMonster)
	end

	local var_27_3 = arg_27_0:getLineColor()
	local var_27_4 = arg_27_0:canUseSkill(arg_27_0.selectCardMo)
	local var_27_5 = 0

	for iter_27_0, iter_27_1 in pairs(var_27_1) do
		if not iter_27_1.isSub then
			local var_27_6 = var_27_4 and arg_27_0.fullLineColor2LineList[var_27_3] or arg_27_0.dottedLineColor2LineList[var_27_3]
			local var_27_7 = arg_27_0:getEntityTopScreenPos(iter_27_0)

			if var_27_7 then
				var_27_5 = var_27_5 + 1

				local var_27_8 = arg_27_0:getLineGo(var_27_5, var_27_6)

				arg_27_0:drawLine(var_27_8, var_27_0, var_27_7)
				arg_27_0:showSelectUI(var_27_5, iter_27_1.id)
			end
		end
	end
end

function var_0_0.drawLine(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	arg_28_0:setArrowPosition(arg_28_1, arg_28_2, arg_28_3)

	arg_28_2, arg_28_3 = arg_28_0:getFormatPos(arg_28_2, arg_28_3)

	local var_28_0 = gohelper.findChild(arg_28_1, "fulllineeffect")

	if not gohelper.isNil(var_28_0) then
		local var_28_1 = var_28_0:GetComponent(typeof(UnityEngine.Renderer))
		local var_28_2 = var_28_1 and var_28_1.material

		if var_28_2 then
			arg_28_0:setMatByScreenPos(var_28_2, var_0_0.StartParam, arg_28_2)
			arg_28_0:setMatByScreenPos(var_28_2, var_0_0.TargetParam, arg_28_3)
		end
	end

	local var_28_3 = arg_28_1:GetComponent(typeof(UnityEngine.Renderer)).material

	arg_28_0:setMatByScreenPos(var_28_3, var_0_0.StartParam, arg_28_2)
	arg_28_0:setMatByScreenPos(var_28_3, var_0_0.TargetParam, arg_28_3)
end

var_0_0.Orient = {
	Right = 1,
	Left = 2
}
var_0_0.RotationZ = 140

function var_0_0.setArrowPosition(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = gohelper.findChild(arg_29_1, "#tou")

	if var_29_0 then
		local var_29_1 = (arg_29_2.x <= arg_29_3.x and var_0_0.Orient.Right or var_0_0.Orient.Left) == var_0_0.Orient.Right and -var_0_0.RotationZ or var_0_0.RotationZ

		transformhelper.setLocalRotation(var_29_0.transform, 0, 0, var_29_1)

		local var_29_2, var_29_3 = recthelper.screenPosToAnchorPos2(arg_29_3, arg_29_1.transform)

		recthelper.setAnchor(var_29_0.transform, var_29_2, var_29_3)
	end
end

function var_0_0.setMatByScreenPos(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = arg_30_3.x * arg_30_0.wRate - arg_30_0.halfPxWidth
	local var_30_1 = arg_30_3.y * arg_30_0.hRate - arg_30_0.halfPxHeight

	arg_30_0.tempVector4:Set(var_30_0, var_30_1, 0, 0)
	arg_30_1:SetVector(arg_30_2, arg_30_0.tempVector4)
end

function var_0_0.getFormatPos(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_1.x > arg_31_2.x then
		return arg_31_2, arg_31_1
	end

	return arg_31_1, arg_31_2
end

function var_0_0.getLineGo(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_2[arg_32_1]

	if not var_32_0 then
		var_32_0 = gohelper.cloneInPlace(arg_32_2[1])

		table.insert(arg_32_2, var_32_0)
	end

	gohelper.setActive(var_32_0, true)

	return var_32_0
end

function var_0_0.getCardScreenPos(arg_33_0, arg_33_1)
	local var_33_0 = FightHelper.getEntity(arg_33_1.uid)

	if not var_33_0 then
		return
	end

	local var_33_1 = FightMsgMgr.sendMsg(FightMsgId.GetEnemyAiUseCardItemList, var_33_0.id)

	if not var_33_1 then
		return
	end

	for iter_33_0, iter_33_1 in ipairs(var_33_1) do
		if FightHelper.isSameCardMo(iter_33_1.cardInfoMO, arg_33_1) then
			local var_33_2 = iter_33_1.topPosRectTr
			local var_33_3, var_33_4 = recthelper.uiPosToScreenPos2(var_33_2)

			arg_33_0.startVector3:Set(var_33_3, var_33_4)

			return arg_33_0.startVector3
		end
	end
end

function var_0_0.getEntityTopScreenPos(arg_34_0, arg_34_1)
	local var_34_0 = FightHelper.getEntity(arg_34_1)

	if not var_34_0 then
		return
	end

	local var_34_1 = var_34_0.nameUI

	if not var_34_1 then
		return
	end

	local var_34_2 = var_34_1.careerTopRectTr
	local var_34_3, var_34_4 = recthelper.uiPosToScreenPos2(var_34_2)

	arg_34_0.targetVector3:Set(var_34_3, var_34_4)

	return arg_34_0.targetVector3
end

function var_0_0.hideAllLine(arg_35_0)
	arg_35_0:hideLineList(arg_35_0.redFullLineList)
	arg_35_0:hideLineList(arg_35_0.redDottedLineList)
	arg_35_0:hideLineList(arg_35_0.yellowFullLineList)
	arg_35_0:hideLineList(arg_35_0.yellowDottedLineList)
end

function var_0_0.hideLineList(arg_36_0, arg_36_1)
	for iter_36_0, iter_36_1 in ipairs(arg_36_1) do
		gohelper.setActive(iter_36_1, false)
	end
end

function var_0_0.hideAllSelectUI(arg_37_0)
	for iter_37_0, iter_37_1 in ipairs(arg_37_0.selectGoList) do
		gohelper.setActive(iter_37_1, false)
	end
end

function var_0_0.showSelectUI(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = arg_38_0.selectGoList[arg_38_1]

	if not var_38_0 then
		var_38_0 = gohelper.cloneInPlace(arg_38_0.goSelectItem)

		table.insert(arg_38_0.selectGoList, var_38_0)
	end

	local var_38_1 = FightHelper.getEntity(arg_38_2)

	if not var_38_1 then
		gohelper.setActive(var_38_0, false)

		return
	end

	gohelper.setActive(var_38_0, true)

	local var_38_2 = var_38_0:GetComponent(gohelper.Type_RectTransform)

	if FightHelper.isAssembledMonster(var_38_1) then
		local var_38_3 = var_38_1:getMO()
		local var_38_4 = lua_fight_assembled_monster.configDict[var_38_3.skin]
		local var_38_5, var_38_6, var_38_7 = transformhelper.getPos(var_38_1.go.transform)
		local var_38_8, var_38_9 = recthelper.worldPosToAnchorPosXYZ(var_38_5 + var_38_4.selectPos[1], var_38_6 + var_38_4.selectPos[2], var_38_7, arg_38_0.selectContainerTr)

		recthelper.setAnchor(var_38_2, var_38_8, var_38_9)

		return
	end

	local var_38_10 = var_38_1:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle)

	if var_38_10 and var_38_10.name == ModuleEnum.SpineHangPoint.mountmiddle then
		local var_38_11, var_38_12, var_38_13 = transformhelper.getPos(var_38_10.transform)
		local var_38_14, var_38_15 = recthelper.worldPosToAnchorPosXYZ(var_38_11, var_38_12, var_38_13, arg_38_0.selectContainerTr)

		recthelper.setAnchor(var_38_2, var_38_14, var_38_15)

		return
	end

	local var_38_16, var_38_17, var_38_18, var_38_19 = arg_38_0:_calcRect(var_38_1)

	recthelper.setAnchor(var_38_2, (var_38_16 + var_38_18) / 2, (var_38_17 + var_38_19) / 2)
end

function var_0_0._calcRect(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_1:getHangPoint(ModuleEnum.SpineHangPoint.BodyStatic)
	local var_39_1, var_39_2, var_39_3 = transformhelper.getPos(var_39_0.transform)
	local var_39_4, var_39_5 = FightHelper.getEntityBoxSizeOffsetV2(arg_39_1)
	local var_39_6 = arg_39_1:isMySide() and 1 or -1
	local var_39_7, var_39_8 = recthelper.worldPosToAnchorPosXYZ(var_39_1 - var_39_4.x * 0.5, var_39_2 - var_39_4.y * 0.5 * var_39_6, var_39_3, arg_39_0.selectContainerTr)
	local var_39_9, var_39_10 = recthelper.worldPosToAnchorPosXYZ(var_39_1 + var_39_4.x * 0.5, var_39_2 + var_39_4.y * 0.5 * var_39_6, var_39_3, arg_39_0.selectContainerTr)

	return var_39_7, var_39_8, var_39_9, var_39_10
end

function var_0_0.canUseSkill(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_1.skillId
	local var_40_1 = FightHelper.getEntity(arg_40_1.uid)

	if not var_40_1 then
		return true
	end

	local var_40_2 = var_40_1:getMO()
	local var_40_3 = FightViewHandCardItemLock.canUseCardSkill(var_40_1.id, var_40_0)

	if FightCardDataHelper.isBigSkill(var_40_0) then
		local var_40_4 = var_40_2.exPoint
		local var_40_5 = var_40_2:getUniqueSkillPoint()

		var_40_3 = var_40_3 and var_40_5 <= var_40_4
	end

	return var_40_3
end

function var_0_0.onClickCard(arg_41_0, arg_41_1)
	arg_41_0:selectCard(arg_41_1)
end

function var_0_0.onClose(arg_42_0)
	FightViewPartVisible.set(true, true, true, false, false)
	arg_42_0:hideAllOutLine()
end

function var_0_0.onDestroyView(arg_43_0)
	for iter_43_0, iter_43_1 in ipairs(arg_43_0.cardItemList) do
		iter_43_1.click:RemoveClickListener()
		iter_43_1.simageHeadIcon:UnLoadImage()
		iter_43_1.actionCardItem:destroy()
	end
end

return var_0_0
