module("modules.logic.dungeon.view.rolestory.RoleStoryTank", package.seeall)

local var_0_0 = class("RoleStoryTank", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0._rootGo = arg_1_1
	arg_1_0._txtTaskDesc = gohelper.findChildTextMesh(arg_1_0._rootGo, "bg/taskDesc")
	arg_1_0._imageIcon = gohelper.findChildImage(arg_1_0._rootGo, "bg/icon")
	arg_1_0._btnTaskReward = gohelper.findChildButtonWithAudio(arg_1_0._rootGo, "bg/reward/btnReward")
	arg_1_0._goRewardFinished = gohelper.findChild(arg_1_0._rootGo, "bg/reward/#go_rewardFinished")
	arg_1_0._goRewardRed = gohelper.findChild(arg_1_0._rootGo, "bg/reward/btnReward/reddoticon")

	arg_1_0:addClickCb(arg_1_0._btnTaskReward, arg_1_0._btntaskOnClick, arg_1_0)
	arg_1_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.WeekTaskChange, arg_1_0.refreshTask, arg_1_0)
	arg_1_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_1_0._onCurrencyChange, arg_1_0)
end

function var_0_0.onOpen(arg_2_0)
	arg_2_0:refreshTask()
	arg_2_0:checkGetTask()
end

function var_0_0._onCurrencyChange(arg_3_0)
	arg_3_0:refreshTask()
end

function var_0_0.refreshTask(arg_4_0)
	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_4_0._imageIcon, "216_1")

	local var_4_0 = RoleStoryModel.instance:getWeekHasGet()
	local var_4_1 = RoleStoryModel.instance:getWeekProgress()
	local var_4_2 = 1

	if var_4_2 <= var_4_1 then
		arg_4_0._txtTaskDesc.text = formatLuaLang("rolestory_weektask_desc", string.format(" <color=#D26636>(%s/%s)</color>", var_4_1, var_4_2))
	else
		arg_4_0._txtTaskDesc.text = formatLuaLang("rolestory_weektask_desc", string.format(" (%s<color=#D26636>/%s</color>)", var_4_1, var_4_2))
	end

	local var_4_3 = 1

	if var_4_0 then
		var_4_3 = 3
	elseif var_4_2 <= var_4_1 then
		var_4_3 = 2
	end

	gohelper.setActive(arg_4_0._goRewardFinished, var_4_3 == 3)
	gohelper.setActive(arg_4_0._btnTaskReward, var_4_3 == 2)

	if var_4_3 == 2 then
		local var_4_4 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.RoleStory)
		local var_4_5 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.RoleStory).maxLimit

		gohelper.setActive(arg_4_0._goRewardRed, var_4_4 < var_4_5)
	else
		gohelper.setActive(arg_4_0._goRewardRed, false)
	end
end

function var_0_0.checkGetTask(arg_5_0)
	local var_5_0 = RoleStoryModel.instance:getWeekHasGet()

	if RoleStoryModel.instance:getWeekProgress() >= 1 and not var_5_0 and ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.RoleStory) < CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.RoleStory).maxLimit then
		HeroStoryRpc.instance:sendHeroStoryWeekTaskGetRequest()
	end
end

function var_0_0._btntaskOnClick(arg_6_0)
	local var_6_0 = RoleStoryModel.instance:getWeekHasGet()

	if RoleStoryModel.instance:getWeekProgress() >= 1 and not var_6_0 then
		if ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.RoleStory) >= CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.RoleStory).maxLimit then
			GameFacade.showToast(ToastEnum.RoleStoryTickMaxCount)
		else
			HeroStoryRpc.instance:sendHeroStoryWeekTaskGetRequest()
		end
	end
end

function var_0_0.onDestroy(arg_7_0)
	arg_7_0:__onDispose()
end

var_0_0.prefabPath = "ui/viewres/dungeon/rolestory/rolestorytank.prefab"

return var_0_0
