module("modules.logic.dungeon.view.rolestory.RoleStoryTank", package.seeall)

slot0 = class("RoleStoryTank", UserDataDispose)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0._rootGo = slot1
	slot0._txtTaskDesc = gohelper.findChildTextMesh(slot0._rootGo, "bg/taskDesc")
	slot0._imageIcon = gohelper.findChildImage(slot0._rootGo, "bg/icon")
	slot0._btnTaskReward = gohelper.findChildButtonWithAudio(slot0._rootGo, "bg/reward/btnReward")
	slot0._goRewardFinished = gohelper.findChild(slot0._rootGo, "bg/reward/#go_rewardFinished")
	slot0._goRewardRed = gohelper.findChild(slot0._rootGo, "bg/reward/btnReward/reddoticon")

	slot0:addClickCb(slot0._btnTaskReward, slot0._btntaskOnClick, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.WeekTaskChange, slot0.refreshTask, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onCurrencyChange, slot0)
end

function slot0.onOpen(slot0)
	slot0:refreshTask()
	slot0:checkGetTask()
end

function slot0._onCurrencyChange(slot0)
	slot0:refreshTask()
end

function slot0.refreshTask(slot0)
	UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imageIcon, "216_1")

	slot1 = RoleStoryModel.instance:getWeekHasGet()

	if RoleStoryModel.instance:getWeekProgress() >= 1 then
		slot0._txtTaskDesc.text = formatLuaLang("rolestory_weektask_desc", string.format(" <color=#D26636>(%s/%s)</color>", slot2, slot3))
	else
		slot0._txtTaskDesc.text = formatLuaLang("rolestory_weektask_desc", string.format(" (%s<color=#D26636>/%s</color>)", slot2, slot3))
	end

	slot4 = 1

	if slot1 then
		slot4 = 3
	elseif slot3 <= slot2 then
		slot4 = 2
	end

	gohelper.setActive(slot0._goRewardFinished, slot4 == 3)
	gohelper.setActive(slot0._btnTaskReward, slot4 == 2)

	if slot4 == 2 then
		gohelper.setActive(slot0._goRewardRed, ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.RoleStory) < CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.RoleStory).maxLimit)
	else
		gohelper.setActive(slot0._goRewardRed, false)
	end
end

function slot0.checkGetTask(slot0)
	if RoleStoryModel.instance:getWeekProgress() >= 1 and not RoleStoryModel.instance:getWeekHasGet() and ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.RoleStory) < CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.RoleStory).maxLimit then
		HeroStoryRpc.instance:sendHeroStoryWeekTaskGetRequest()
	end
end

function slot0._btntaskOnClick(slot0)
	if RoleStoryModel.instance:getWeekProgress() >= 1 and not RoleStoryModel.instance:getWeekHasGet() then
		if CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.RoleStory).maxLimit <= ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.RoleStory) then
			GameFacade.showToast(ToastEnum.RoleStoryTickMaxCount)
		else
			HeroStoryRpc.instance:sendHeroStoryWeekTaskGetRequest()
		end
	end
end

function slot0.onDestroy(slot0)
	slot0:__onDispose()
end

slot0.prefabPath = "ui/viewres/dungeon/rolestory/rolestorytank.prefab"

return slot0
