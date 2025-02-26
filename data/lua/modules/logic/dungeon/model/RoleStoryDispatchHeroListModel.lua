module("modules.logic.dungeon.model.RoleStoryDispatchHeroListModel", package.seeall)

slot0 = class("RoleStoryDispatchHeroListModel", ListScrollModel)

function slot0.onOpenDispatchView(slot0, slot1, slot2)
	slot0.storyMo = slot1
	slot0.dispatchMo = slot2
	slot0.maxSelectCount = slot2.config.count

	slot0:refreshEffectHero()
	slot0:initHeroList()
end

function slot0.canShowTalk(slot0, slot1)
	if not slot1 then
		return false
	end

	if not tonumber(slot1.heroid) and not 0 or slot2 == 0 then
		return true
	end

	return slot0:getSelectedIndex(slot2) ~= nil
end

function slot0.refreshEffectHero(slot0)
	slot0.effectHeroDict = slot0.dispatchMo:getEffectHeros()
end

function slot0.isEffectHero(slot0, slot1)
	return slot0.effectHeroDict[slot1]
end

function slot0.refreshHero(slot0)
	slot0:resortHeroList()
	slot0:setList(slot0.heroList)
end

function slot0.resortHeroList(slot0)
	table.sort(slot0.heroList, uv0._sortFunc)
end

function slot0._sortFunc(slot0, slot1)
	if slot0:isDispatched() ~= slot1:isDispatched() then
		return slot3
	end

	if slot0:isEffectHero() ~= slot1:isEffectHero() then
		return slot4
	end

	if slot0.rare ~= slot1.rare then
		return slot1.rare < slot0.rare
	end

	if slot0.level ~= slot1.level then
		return slot1.level < slot0.level
	end

	return slot1.heroId < slot0.heroId
end

function slot0.initHeroList(slot0)
	if slot0.heroList then
		return
	end

	slot0.heroList = {}
	slot0.heroDict = {}

	for slot4, slot5 in ipairs(HeroModel.instance:getList()) do
		if not slot0.heroDict[slot5.heroId] then
			slot6 = RoleStoryDispatchHeroMo.New()

			slot6:init(slot5, slot0.storyMo.id, slot0:isEffectHero(slot5.heroId))
			table.insert(slot0.heroList, slot6)

			slot0.heroDict[slot6.heroId] = slot6
		end
	end
end

function slot0.initSelectedHeroList(slot0, slot1)
	slot0.selectedHeroList = {}
	slot0.selectedHeroIndexDict = {}

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			if slot0:getDispatchHeroMo(slot6) then
				table.insert(slot0.selectedHeroList, slot7)

				slot0.selectedHeroIndexDict[slot6] = slot5
			else
				logError("not found dispatched hero id : " .. tostring(slot6))
			end
		end
	end
end

function slot0.sendDispatch(slot0)
	if not slot0.storyMo or not slot0.dispatchMo then
		return
	end

	if slot0.dispatchMo:getDispatchState() ~= RoleStoryEnum.DispatchState.Normal then
		return
	end

	slot4 = {}

	for slot8, slot9 in ipairs(GameUtil.splitString2(slot0.dispatchMo.config.consume, true)) do
		table.insert(slot4, {
			type = slot9[1],
			id = slot9[2],
			quantity = slot9[3] * 1
		})
	end

	slot5, slot6, slot7 = ItemModel.instance:hasEnoughItems(slot4)

	if not slot6 then
		if RoleStoryModel.instance:checkTodayCanExchange() then
			GameFacade.showToastWithIcon(ToastEnum.RoleStoryTickNoEnough1, slot7, slot5)
		else
			GameFacade.showToastWithIcon(ToastEnum.RoleStoryTickNoEnough2, slot7, slot5)
		end

		return
	end

	if #slot0:getDispatchHeros() ~= slot0.maxSelectCount then
		GameFacade.showToast(ToastEnum.RoleStoryDispatchLessMinHero)

		return
	end

	for slot13, slot14 in ipairs(slot8) do
		table.insert({}, slot14.heroId)
	end

	if slot0.storyMo:isScoreFull() then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoleStoryDispatchTips, MsgBoxEnum.BoxType.Yes_No, function ()
			HeroStoryRpc.instance:sendHeroStoryDispatchRequest(uv0.storyMo.id, uv0.dispatchMo.id, uv1)
		end)

		return
	end

	HeroStoryRpc.instance:sendHeroStoryDispatchRequest(slot0.storyMo.id, slot0.dispatchMo.id, slot9)
end

function slot0.isEnoughHeroCount(slot0)
	return slot0.maxSelectCount <= #slot0:getDispatchHeros()
end

function slot0.sendReset(slot0)
	if not slot0.storyMo or not slot0.dispatchMo then
		return
	end

	if slot0.dispatchMo:getDispatchState() ~= RoleStoryEnum.DispatchState.Dispatching then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.RoleStoryDispatchResetTips, MsgBoxEnum.BoxType.Yes_No, function ()
		if uv0.dispatchMo:getDispatchState() == RoleStoryEnum.DispatchState.Dispatching then
			HeroStoryRpc.instance:sendHeroStoryDispatchResetRequest(uv0.storyMo.id, uv0.dispatchMo.id)
		end
	end)
end

function slot0.sendGetReward(slot0)
	if not slot0.storyMo or not slot0.dispatchMo then
		return
	end

	if slot0.dispatchMo:getDispatchState() ~= RoleStoryEnum.DispatchState.Canget then
		return
	end

	if slot0.storyMo:isScoreFull() then
		GameFacade.showToast(ToastEnum.RoleStoryDispatchRewardTips)
	end

	HeroStoryRpc.instance:sendHeroStoryDispatchCompleteRequest(slot0.storyMo.id, slot0.dispatchMo.id)
end

function slot0.clickHeroMo(slot0, slot1)
	if not slot1 then
		return
	end

	if slot1:isDispatched() then
		GameFacade.showToast(ToastEnum.RoleStoryDispatchSelectTips)

		return
	end

	if slot0.selectedHeroIndexDict[slot1.heroId] then
		slot0:deselectMo(slot1)
	else
		slot0:selectMo(slot1)
	end
end

function slot0.selectMo(slot0, slot1)
	if not slot1 then
		return
	end

	if slot0.selectedHeroIndexDict[slot1.heroId] then
		return
	end

	if #slot0.selectedHeroList == slot0.maxSelectCount then
		return
	end

	table.insert(slot0.selectedHeroList, slot1)

	slot0.selectedHeroIndexDict[slot1.heroId] = #slot0.selectedHeroList

	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.ChangeSelectedHero)
end

function slot0.deselectMo(slot0, slot1)
	if not slot1 then
		return
	end

	if not slot0.selectedHeroIndexDict[slot1.heroId] then
		return
	end

	table.remove(slot0.selectedHeroList, slot2)

	slot0.selectedHeroIndexDict[slot1.heroId] = nil

	for slot6, slot7 in ipairs(slot0.selectedHeroList) do
		slot0.selectedHeroIndexDict[slot7.heroId] = slot6
	end

	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.ChangeSelectedHero)
end

function slot0.getDispatchHeroMo(slot0, slot1)
	return slot0.heroDict[slot1]
end

function slot0.getSelectedIndex(slot0, slot1)
	return slot0.selectedHeroIndexDict[slot1]
end

function slot0.getDispatchHeros(slot0)
	return slot0.selectedHeroList
end

function slot0.getDispatchHeroIndexDict(slot0)
	return slot0.selectedHeroIndexDict
end

function slot0.resetSelectHeroList(slot0)
	slot0.selectedHeroList = {}
	slot0.selectedHeroIndexDict = {}
end

function slot0.onCloseDispatchView(slot0)
	slot0:clear()
end

function slot0.clearSelectedHeroList(slot0)
	slot0.selectedHeroList = nil
	slot0.selectedHeroIndexDict = nil
end

function slot0.clear(slot0)
	slot0:clearSelectedHeroList()

	slot0.heroList = nil
	slot0.heroDict = nil

	uv0.super.clear(slot0)
end

slot0.instance = slot0.New()

return slot0
