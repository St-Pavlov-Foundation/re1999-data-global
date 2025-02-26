module("modules.logic.season.view1_2.Season1_2FightSuccView", package.seeall)

slot0 = class("Season1_2FightSuccView", FightSuccView)

function slot0.onInitView(slot0)
	slot0._btnData = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnData")
	slot0._simagecharacterbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_characterbg")
	slot0._simagemaskImage = gohelper.findChildSingleImage(slot0.viewGO, "#simage_maskImage")
	slot0._godetails = gohelper.findChild(slot0.viewGO, "#go_details")
	slot0._gocoverrecordpart = gohelper.findChild(slot0.viewGO, "#go_cover_record_part")
	slot0._btncoverrecord = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_cover_record_part/#btn_cover_record")
	slot0._txtcurroundcount = gohelper.findChildText(slot0.viewGO, "#go_cover_record_part/tipbg/container/current/#txt_curroundcount")
	slot0._txtmaxroundcount = gohelper.findChildText(slot0.viewGO, "#go_cover_record_part/tipbg/container/memory/#txt_maxroundcount")
	slot0._goCoverLessThan = gohelper.findChild(slot0.viewGO, "#go_cover_record_part/tipbg/container/middle/#go_lessthan")
	slot0._goCoverMuchThan = gohelper.findChild(slot0.viewGO, "#go_cover_record_part/tipbg/container/middle/#go_muchthan")
	slot0._goCoverEqual = gohelper.findChild(slot0.viewGO, "#go_cover_record_part/tipbg/container/middle/#go_equal")
	slot0._bonusItemGo = gohelper.findChild(slot0.viewGO, "scroll/item")
	slot0._favorIcon = gohelper.findChild(slot0.viewGO, "scroll/viewport/content/favor")
	slot0._txtFbName = gohelper.findChildText(slot0.viewGO, "txtFbName")
	slot0._txtFbNameEn = gohelper.findChildText(slot0.viewGO, "txtFbNameen")
	slot0._goallist = gohelper.findChild(slot0.viewGO, "goalcontent/goallist")
	slot0._txtLv = gohelper.findChildText(slot0.viewGO, "goalcontent/txtLv")
	slot0._sliderExp = gohelper.findChildSlider(slot0.viewGO, "goalcontent/txtLv/progress")
	slot0._txtExp = gohelper.findChildText(slot0.viewGO, "goalcontent/txtLv/txtExp")
	slot0._txtAddExp = gohelper.findChildText(slot0.viewGO, "goalcontent/txtLv/progress/txtAddExp")
	slot0._gospine = gohelper.findChild(slot0.viewGO, "spineContainer/spine")
	slot0._uiSpine = GuiModelAgent.Create(slot0._gospine, true)
	slot0._goCondition = gohelper.findChild(slot0.viewGO, "goalcontent/goallist/fightgoal")
	slot0._goPlatCondition = gohelper.findChild(slot0.viewGO, "goalcontent/goallist/platinum")
	slot0._goPlatCondition2 = gohelper.findChild(slot0.viewGO, "goalcontent/goallist/platinum2")
	slot0._bonusItemContainer = gohelper.findChild(slot0.viewGO, "scroll/viewport/content")
	slot0._bonusItemGo = gohelper.findChild(slot0.viewGO, "scroll/item")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnData:AddClickListener(slot0._onClickData, slot0)
	slot0._click:AddClickListener(slot0._onClickClose, slot0)
	slot0._btncoverrecord:AddClickListener(slot0._onBtnCoverRecordClick, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnCoverDungeonRecordReply, slot0._onCoverDungeonRecordReply, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnData:RemoveClickListener()
	slot0._click:RemoveClickListener()
	slot0._btncoverrecord:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

function slot0._editableInitView(slot0)
	slot0._click = gohelper.getClick(slot0.viewGO)
end

function slot0._onClickClose(slot0)
	if slot0._showEquipCard then
		return
	end

	uv0.super._onClickClose(slot0)
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)
	gohelper.setActive(slot0._bonusItemContainer, false)
	slot0:_dealGetCard()
	slot0:_showGoal()
end

function slot0._dealGetCard(slot0)
	slot1 = {}

	tabletool.addValues(slot1, FightResultModel.instance:getFirstMaterialDataList())
	tabletool.addValues(slot1, FightResultModel.instance:getExtraMaterialDataList())
	tabletool.addValues(slot1, FightResultModel.instance:getMaterialDataList())

	slot2 = {}

	for slot6 = #slot1, 1, -1 do
		if slot1[slot6].materilType == MaterialEnum.MaterialType.EquipCard then
			table.insert(slot2, table.remove(slot1, slot6).materilId)
		end
	end

	slot0._showEquipCard = {}
	slot0._choiceCards = {}
	slot0._newCardDic = {}

	for slot6, slot7 in ipairs(slot2) do
		if SeasonConfig.instance:getEquipIsOptional(slot7) then
			table.insert(slot0._choiceCards, slot7)
		elseif Activity104Model.instance:isNew104Equip(slot7) then
			table.insert(slot0._showEquipCard, slot7)

			slot0._newCardDic[slot7] = true
		end
	end

	if #slot0._showEquipCard > 0 then
		for slot7 = #slot0._showEquipCard, 1, -1 do
			if ({})[slot0._showEquipCard[slot7]] then
				table.remove(slot0._showEquipCard, slot7)
			else
				slot3[slot8] = true
			end
		end

		TaskDispatcher.runDelay(slot0._showGetCardView, slot0, 2)
	elseif #slot0._choiceCards > 0 then
		TaskDispatcher.runDelay(slot0._showChoiceCardView, slot0, 2)
	else
		slot0:_showRewardPart()
	end
end

function slot0._loadBonusItems(slot0)
end

function slot0._showGetCardView(slot0)
	Activity104Controller.instance:openSeasonCelebrityCardGetlView({
		is_item_id = true,
		data = slot0._showEquipCard
	})
end

function slot0._onTipsClose(slot0)
	slot0:_showRewardPart()
	slot0:_showPlayerLevelUpView()
end

function slot0._showRewardPart(slot0)
	slot0._showEquipCard = nil

	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	gohelper.setActive(slot0._bonusItemContainer, true)
	uv0.super._loadBonusItems(slot0)
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == SeasonViewHelper.getViewName(Activity104Model.instance:getCurSeasonId(), Activity104Enum.ViewName.CelebrityCardGetlView) then
		if slot0:_showChoiceCardView() then
			return
		end

		slot0:_onTipsClose()
	end
end

function slot0._showChoiceCardView(slot0)
	if slot0._choiceCards and #slot0._choiceCards > 0 and Activity104Model.instance:getItemEquipUid(table.remove(slot0._choiceCards, 1)) then
		Activity104Controller.instance:openSeasonEquipSelectChoiceView({
			actId = Activity104Model.instance:getCurSeasonId(),
			costItemUid = slot2
		})

		return true
	end
end

function slot0._addItem(slot0, slot1)
	slot2 = gohelper.clone(slot0._bonusItemGo, slot0._bonusItemContainer, slot1.id)

	gohelper.setActive(gohelper.findChild(slot2, "container"), false)
	gohelper.setActive(gohelper.findChild(slot2, "container/tag"), slot1.bonusTag)

	if slot1.bonusTag then
		gohelper.setActive(gohelper.findChild(slot2, "container/tag/imgFirst"), slot1.bonusTag == FightEnum.FightBonusTag.FirstBonus and not slot0._hardMode)
		gohelper.setActive(gohelper.findChild(slot2, "container/tag/imgFirstHard"), slot1.bonusTag == FightEnum.FightBonusTag.FirstBonus and slot0._hardMode)
		gohelper.setActive(gohelper.findChild(slot2, "container/tag/imgNormal"), false)
		gohelper.setActive(gohelper.findChild(slot2, "container/tag/imgAdvance"), slot1.bonusTag == FightEnum.FightBonusTag.AdvencedBonus)
		gohelper.setActive(gohelper.findChild(slot2, "container/tag/imgEquipDaily"), slot1.bonusTag == FightEnum.FightBonusTag.EquipDailyFreeBonus)
	end

	slot1.isIcon = true

	if slot1.materilType == MaterialEnum.MaterialType.EquipCard then
		slot10 = slot0._newCardDic[slot1.materilId]

		if not slot0._equipCards then
			slot0._equipCards = {}
		end

		slot11 = Season1_2CelebrityCardItem.New()
		slot15 = slot1.materilId

		slot11:init(gohelper.findChild(slot2, "container/cardicon"), slot15)
		slot11:showNewFlag(slot10)
		table.insert(slot0._equipCards, slot11)

		for slot15 = 1, 5 do
			gohelper.setActive(gohelper.findChild(slot2, "container/cardicon/#vx_glow/" .. slot15), slot15 == SeasonConfig.instance:getSeasonEquipCo(slot1.materilId).rare)
		end
	else
		slot11 = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(slot2, "container/itemIcon"))

		slot11:onUpdateMO(slot1)
		slot11:setCantJump(true)
		slot11:setCountFontSize(40)
		slot11:setAutoPlay(true)
		slot11:isShowEquipRefineLv(true)
	end

	gohelper.setActive(slot2, false)

	slot3:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 0

	slot0:applyBonusVfx(slot1, slot2)

	return slot9, slot2
end

function slot0._setFbName(slot0, slot1)
	if slot1.type == DungeonEnum.EpisodeType.SeasonRetail then
		slot0._txtFbName.text = string.format("%s %s", SeasonConfig.instance:getSeasonTagDesc(Activity104Model.instance:getCurSeasonId(), Activity104Model.instance.curBattleRetail.tag) and slot5.name, GameUtil.getRomanNums(math.min(Activity104Model.instance:getAct104CurStage(), 6)))
	else
		slot0._txtFbName.text = slot1.name
	end
end

function slot0._showGoal(slot0)
	gohelper.setActive(slot0._goallist, false)

	if lua_episode.configDict[slot0._curEpisodeId] and slot1.type == DungeonEnum.EpisodeType.SeasonRetail and lua_condition.configDict[Activity104Model.instance.curBattleRetail.advancedId] then
		gohelper.setActive(slot0._goallist, true)
		gohelper.setActive(gohelper.findChild(slot0._goallist, "fightgoal"), true)

		gohelper.findChildText(slot0._goallist, "fightgoal/condition").text = slot4.desc
		slot6 = "#87898C"

		if slot2.star >= 2 then
			if slot2.advancedRare == 1 then
				slot6 = "#A3F14C"
			elseif slot2.advancedRare == 2 then
				slot6 = "#FF423F"
			end
		end

		SLFramework.UGUI.GuiHelper.SetColor(gohelper.findChildImage(slot0._goallist, "fightgoal/star"), slot6)
	end
end

function slot0._checkTypeDetails(slot0)
end

function slot0._hideGoDemand(slot0)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._showGetCardView, slot0)
	TaskDispatcher.cancelTask(slot0._showChoiceCardView, slot0)

	if slot0._equipCards then
		for slot4, slot5 in ipairs(slot0._equipCards) do
			slot5:destroy()
		end

		slot0._equipCards = nil
	end

	uv0.super.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	uv0.super.onDestroyView(slot0)
end

return slot0
