module("modules.logic.fight.view.FightViewRedAndBlueArea", package.seeall)

slot0 = class("FightViewRedAndBlueArea", BaseView)
slot0.LoadStatus = {
	Loaded = 3,
	Loading = 2,
	None = 1
}
slot0.PointIndexList = {
	{},
	{
		3
	},
	{
		2,
		3
	},
	{
		2,
		3,
		4
	},
	{
		1,
		2,
		3,
		4
	},
	{
		1,
		2,
		3,
		4,
		5
	},
	{
		1,
		2,
		3,
		4,
		5,
		6
	}
}

function slot0.onInitView(slot0)
	slot0._scrollViewObj = gohelper.findChild(slot0.viewGO, "root/playcards/#scroll_cards")
	slot0._rectTrScrollView = slot0._scrollViewObj:GetComponent(gohelper.Type_RectTransform)
	slot0._playCardItemRoot = gohelper.findChild(slot0.viewGO, "root/playcards/#scroll_cards/Viewport/Content")
	slot0._playCardItemTransform = slot0._playCardItemRoot:GetComponent(gohelper.Type_RectTransform)
	slot0.LY_cardLoadStatus = uv0.LoadStatus.None
	slot0._goLyCardContainer = gohelper.findChild(slot0.viewGO, "root/playcards/#go_LYcard")
	slot0._rectTrLyCardContainer = slot0._goLyCardContainer:GetComponent(gohelper.Type_RectTransform)
	slot0.LY_cardLoadStatus = uv0.LoadStatus.None

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.LY_HadRedAndBluePointChange, slot0.onLY_HadRedAndBluePointChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.LY_PointAreaSizeChange, slot0.refreshLYCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SetBlockCardOperate, slot0.refreshLYCard, slot0, LuaEventSystem.Low)
	slot0:addEventCb(FightController.instance, FightEvent.OnPlayCardFlowDone, slot0.refreshLYCard, slot0, LuaEventSystem.Low)
	slot0:addEventCb(FightController.instance, FightEvent.OnPlayAssistBossCardFlowDone, slot0.refreshLYCard, slot0, LuaEventSystem.Low)
	slot0:addEventCb(FightController.instance, FightEvent.StageChanged, slot0.onStageChange, slot0, LuaEventSystem.Low)
	slot0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, slot0.refreshLYCard, slot0, LuaEventSystem.Low)
end

function slot0.onStageChange(slot0)
	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Normal then
		FightDataHelper.LYDataMgr:refreshPointList(true)

		return slot0:refreshLYCard()
	end
end

function slot0.onLY_HadRedAndBluePointChange(slot0)
	if slot0.LY_cardLoadStatus == uv0.LoadStatus.Loading then
		return
	end

	if slot0.LY_cardLoadStatus == uv0.LoadStatus.Loaded then
		return slot0:refreshLYCard()
	end

	slot0.LY_cardLoadStatus = uv0.LoadStatus.Loading
	slot0.LYLoader = PrefabInstantiate.Create(slot0._goLyCardContainer)

	slot0.LYLoader:startLoad(FightLYWaitAreaCard.LY_CardPath, slot0.onLoadLYCardDone, slot0)
end

function slot0.onLoadLYCardDone(slot0, slot1)
	slot0.LY_cardLoadStatus = uv0.LoadStatus.Loaded
	slot2 = slot0.LYLoader:getInstGO()
	slot0.LY_instanceGo = slot2
	slot0.LY_goCardBack = gohelper.findChild(slot2, "current/back")

	gohelper.setActive(slot0.LY_goCardBack, false)

	slot0.LY_pointItemList = {}

	for slot6 = 1, FightLYWaitAreaCard.LY_MAXPoint do
		slot7 = slot0:getUserDataTb_()
		slot7.go = gohelper.findChild(slot2, "current/font/energy/" .. slot6)
		slot7.goRed = gohelper.findChild(slot7.go, "red")
		slot7.goBlue = gohelper.findChild(slot7.go, "green")
		slot7.goBoth = gohelper.findChild(slot7.go, "both")
		slot7.animator = slot7.go:GetComponent(gohelper.Type_Animator)

		table.insert(slot0.LY_pointItemList, slot7)
	end

	slot0:refreshLYCard()
end

function slot0.refreshLYCard(slot0)
	if slot0.LY_cardLoadStatus ~= uv0.LoadStatus.Loaded then
		return
	end

	if not FightDataHelper.LYDataMgr:getPointList() then
		gohelper.setActive(slot0._goLyCardContainer, false)

		return
	end

	gohelper.setActive(slot0._goLyCardContainer, true)
	slot0:getOpRedOrBlueList(FightCardModel.instance:getCardOps())
	slot0:resetAllPoint()

	for slot8 = 1, slot3 do
		if (uv0.PointIndexList[math.min(math.max(0, FightDataHelper.LYDataMgr.LYPointAreaSize), FightLYWaitAreaCard.LY_MAXPoint) + 1] or {})[slot8] and slot0.LY_pointItemList[slot9] then
			gohelper.setActive(slot10.go, true)

			slot11 = nil

			if slot8 <= #slot1 then
				slot11 = slot1[slot8]

				slot10.animator:Play("empty", 0, 0)
			elseif slot0.tempPointList[slot8 - slot2] and slot11 ~= FightEnum.CardColor.None then
				slot10.animator:Play("loop", 0, 0)
			else
				slot10.animator:Play("empty", 0, 0)
			end

			gohelper.setActive(slot10.goRed, slot11 == FightEnum.CardColor.Red)
			gohelper.setActive(slot10.goBlue, slot11 == FightEnum.CardColor.Blue)
			gohelper.setActive(slot10.goBoth, slot11 == FightEnum.CardColor.Both)
		end
	end

	slot0:refreshLYContainerAnchorX()
end

function slot0.resetAllPoint(slot0)
	for slot4 = 1, FightLYWaitAreaCard.LY_MAXPoint do
		gohelper.setActive(slot0.LY_pointItemList[slot4].go, false)
	end
end

slot0.AddRedOrBlueBehaviorId = 60154

function slot0.getOpRedOrBlueList(slot0, slot1)
	slot0.tempPointList = slot0.tempPointList or {}

	tabletool.clear(slot0.tempPointList)

	for slot5, slot6 in ipairs(slot1) do
		slot7 = slot6 and slot6.cardInfoMO
		slot8 = slot7 and slot7.skillId

		if slot8 and lua_skill.configDict[slot8] then
			for slot13 = 1, FightEnum.MaxBehavior do
				if not string.nilorempty(slot9["behavior" .. slot13]) and FightStrUtil.instance:getSplitToNumberCache(slot14, "#") and slot15[1] == uv0.AddRedOrBlueBehaviorId then
					for slot21 = 1, slot15[3] do
						table.insert(slot0.tempPointList, slot15[2])
					end
				end
			end
		end

		if slot6 and slot6.cardColor ~= FightEnum.CardColor.None then
			table.insert(slot0.tempPointList, slot6.cardColor)
		end
	end

	return slot0.tempPointList
end

function slot0.refreshLYContainerAnchorX(slot0)
	if slot0.LY_cardLoadStatus ~= uv0.LoadStatus.Loaded then
		return
	end

	recthelper.setAnchorX(slot0._rectTrLyCardContainer, math.min(recthelper.getWidth(slot0._playCardItemTransform), recthelper.getWidth(slot0._rectTrScrollView)) / 2 + FightEnum.LYPlayCardAreaOffset)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0.LYLoader then
		slot0.LYLoader:dispose()

		slot0.LYLoader = nil

		gohelper.destroy(slot0.LY_instanceGo)
	end

	slot0.LY_cardLoadStatus = uv0.LoadStatus.None
end

return slot0
