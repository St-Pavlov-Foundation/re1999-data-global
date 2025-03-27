module("modules.logic.fight.view.FightSeasonSubHeroList", package.seeall)

slot0 = class("FightSeasonSubHeroList", FightBaseView)

function slot0.onInitView(slot0)
	slot0._scoreText = gohelper.findChildText(slot0.viewGO, "Score/#txt_num")
	slot0._scoreText1 = gohelper.findChildText(slot0.viewGO, "Score/#txt_num1")
	slot0._ani = SLFramework.AnimatorPlayer.Get(gohelper.findChild(slot0.viewGO, "Score"))
	slot0._goScore = gohelper.findChild(slot0.viewGO, "Score")
	slot0._scoreImg = gohelper.findChildImage(slot0.viewGO, "Score/#image_ScoreBG")
	slot0._itemRoot = gohelper.findChild(slot0.viewGO, "List")
	slot0._goItem = gohelper.findChild(slot0.viewGO, "List/#go_Item")
	slot0._itemClassList = {}
end

function slot0.addEvents(slot0)
	slot0:com_registFightEvent(FightEvent.ChangeWaveEnd, slot0._onChangeWaveEnd)
	slot0:com_registFightEvent(FightEvent.OnIndicatorChange, slot0._onIndicatorChange)
	slot0:com_registFightEvent(FightEvent.StageChanged, slot0._onStageChanged)
	slot0:com_registEvent(ViewMgr.instance, ViewEvent.OnOpenView, slot0.onOpenView)
	slot0:com_registEvent(ViewMgr.instance, ViewEvent.OnCloseView, slot0.onCloseView)
end

function slot0.removeEvents(slot0)
end

function slot0._onStageChanged(slot0, slot1, slot2)
	gohelper.setActive(slot0._itemRoot, slot1 ~= FightStageMgr.StageType.Play)
end

function slot0._enterOperate(slot0)
	slot0.PARENT_VIEW:_enterOperate()
end

function slot0._exitOperate(slot0, slot1)
	if slot0._selectItem then
		slot0._selectItem:playAni("select_out", true)

		slot0._selectItem = nil
	end

	if not slot1 then
		slot0:_refreshSubSpine()
	end
end

function slot0.sortScoreConfig(slot0, slot1)
	return slot0.level < slot1.level
end

function slot0.onOpen(slot0)
	slot0._scoreConfigList = {}

	for slot6, slot7 in ipairs(lua_activity166_score.configDict[Season166Model.instance:getCurSeasonId()]) do
		table.insert(slot0._scoreConfigList, slot7)
	end

	table.sort(slot0._scoreConfigList, uv0.sortScoreConfig)

	slot0._index2ImageName = {
		"season_scorebg_01",
		"season_scorebg_02",
		"season_scorebg_03",
		"season_scorebg_04"
	}
	slot0.entityMgr = GameSceneMgr.instance:getCurScene().entityMgr

	slot0:_refreshHeroList()

	slot0._score = FightDataHelper.fieldMgr:getIndicatorNum(FightEnum.IndicatorId.NewSeasonScore)

	slot0:_refreshScore()
end

function slot0._refreshHeroList(slot0)
	slot1 = FightDataHelper.entityMgr:getMySubList()

	table.sort(slot1, FightEntityDataHelper.sortSubEntityList)
	gohelper.CreateObjList(slot0, slot0._onItemShow, slot1, slot0._itemRoot, slot0._goItem)
end

function slot0._onItemShow(slot0, slot1, slot2, slot3)
	if not slot0._itemClassList[slot3] then
		slot0._itemClassList[slot3] = slot0:com_openSubView(FightSeasonSubHeroItem, slot1)
	end

	slot4:refreshData(slot2.id)
	slot4:playAni("normal_in", true)
end

function slot0.selectItem(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._itemClassList) do
		if slot6.viewGO.activeInHierarchy and slot0:selecting(slot6) then
			slot6:playAni("select_out", true)
		end
	end

	slot1:playAni("select_in", true)

	slot0._selectItem = slot1

	slot0.PARENT_VIEW:selectItem(slot1)
	slot0:_refreshSubSpine(slot1._entityId)
end

function slot0._refreshSubSpine(slot0, slot1)
	if not slot1 then
		slot3 = FightDataHelper.entityMgr:getMySubList()

		table.sort(slot3, FightEntityDataHelper.sortSubEntityList)

		slot2 = slot3[1] and slot4.id
	end

	if slot2 and FightDataHelper.entityMgr:getById(slot2) then
		if FightHelper.getSubEntity(FightEnum.EntitySide.MySide) then
			if slot4.id ~= slot2 then
				slot0.entityMgr:removeUnit(slot4:getTag(), slot4.id)
				slot0.entityMgr:buildSubSpine(slot3)
			end
		else
			slot0.entityMgr:buildSubSpine(slot3)
		end
	end
end

function slot0.selecting(slot0, slot1)
	return slot0._selectItem == slot1
end

function slot0._onIndicatorChange(slot0, slot1)
	if slot1 == FightEnum.IndicatorId.NewSeasonScoreOffset then
		slot0._score = slot0._score + FightDataHelper.fieldMgr:getIndicatorNum(FightEnum.IndicatorId.NewSeasonScoreOffset)

		slot0:_refreshScore()
		slot0._ani:Play("up", nil, )
	end
end

function slot0._refreshScore(slot0)
	gohelper.setActive(slot0._goScore, Season166Model.instance:checkIsBaseSpotEpisode())

	slot0._scoreText.text = slot0._score
	slot0._scoreText1.text = slot0._score
	slot1 = 1

	for slot5 = #slot0._scoreConfigList, 1, -1 do
		if slot0._scoreConfigList[slot5].needScore <= slot0._score then
			slot1 = slot5

			break
		end
	end

	if slot1 == slot0._lastIndex then
		return
	end

	slot0._lastIndex = slot1

	UISpriteSetMgr.instance:setFightSprite(slot0._scoreImg, slot0._index2ImageName[slot1])
end

function slot0.onOpenView(slot0, slot1)
	if slot1 == ViewName.FightEnemyActionView then
		gohelper.setActive(slot0._goScore, false)
	end
end

function slot0.onCloseView(slot0, slot1)
	if slot1 == ViewName.FightEnemyActionView then
		gohelper.setActive(slot0._goScore, Season166Model.instance:checkIsBaseSpotEpisode())
	end
end

function slot0._onChangeWaveEnd(slot0)
	slot0:onOpen()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
