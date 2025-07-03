module("modules.logic.fight.view.FightViewDissolveCard", package.seeall)

local var_0_0 = class("FightViewDissolveCard", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.cardContainer = gohelper.findChild(arg_1_0.viewGO, "root/dissolveCard")
	arg_1_0.goCardItem = gohelper.findChild(arg_1_0.viewGO, "root/dissolveCard/#scroll_cards/Viewport/Content/cardItem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

var_0_0.CardScale = 0.62
var_0_0.ShowCardDuration = 0.5
var_0_0.DissolveCardDuration = 1

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0.cardContainer, false)
	gohelper.setActive(arg_4_0.goCardItem, false)

	arg_4_0.cardItemList = {}
end

function var_0_0.onDeleteCard(arg_5_0, arg_5_1)
	if not arg_5_1 then
		return arg_5_0:dissolveCardDone()
	end

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.cardItemList) do
		gohelper.setActive(iter_5_1.go, false)
	end

	gohelper.setActive(arg_5_0.cardContainer, true)

	for iter_5_2, iter_5_3 in ipairs(arg_5_1) do
		local var_5_0 = arg_5_0:getCardItem(iter_5_2)

		gohelper.setActive(var_5_0.innerCardGo, true)
		var_5_0.innerCardItem:updateItem(iter_5_3.uid, iter_5_3.skillId, iter_5_3)

		local var_5_1 = FightCardDataHelper.isBigSkill(iter_5_3.skillId)

		gohelper.setActive(var_5_0.goPlaySkillEffect, not var_5_1)
		gohelper.setActive(var_5_0.goPlayBigSkillEffect, var_5_1)
	end

	TaskDispatcher.cancelTask(arg_5_0.dissolveCardDone, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.startDissolve, arg_5_0)
	TaskDispatcher.runDelay(arg_5_0.startDissolve, arg_5_0, arg_5_0.ShowCardDuration / FightModel.instance:getUISpeed())
end

function var_0_0.startDissolve(arg_6_0)
	local var_6_0 = arg_6_0.CardScale

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.cardItemList) do
		iter_6_1.innerCardItem:dissolveCard(var_6_0)
		gohelper.setActive(iter_6_1.goPlaySkillEffect, false)
		gohelper.setActive(iter_6_1.goPlayBigSkillEffect, false)
	end

	TaskDispatcher.cancelTask(arg_6_0.dissolveCardDone, arg_6_0)
	TaskDispatcher.runDelay(arg_6_0.dissolveCardDone, arg_6_0, arg_6_0.DissolveCardDuration / FightModel.instance:getUISpeed())
end

function var_0_0.getCardItem(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.cardItemList[arg_7_1]

	if var_7_0 then
		gohelper.setActive(var_7_0.go, true)

		return var_7_0
	end

	local var_7_1 = arg_7_0:getUserDataTb_()

	var_7_1.go = gohelper.cloneInPlace(arg_7_0.goCardItem)

	gohelper.setActive(var_7_1.go, true)

	local var_7_2 = arg_7_0.viewContainer:getSetting().otherRes[1]

	var_7_1.innerCardGo = arg_7_0:getResInst(var_7_2, var_7_1.go, "card")
	var_7_1.innerCardItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_1.innerCardGo, FightViewCardItem)

	local var_7_3 = arg_7_0.CardScale

	transformhelper.setLocalScale(var_7_1.innerCardGo.transform, var_7_3, var_7_3, var_7_3)

	var_7_1.goPlaySkillEffect = arg_7_0:addPlaySkillEffect(var_7_1.go)
	var_7_1.goPlayBigSkillEffect = arg_7_0:addPlayBigSkillEffect(var_7_1.go)

	gohelper.setActive(var_7_1.goPlaySkillEffect, false)
	gohelper.setActive(var_7_1.goPlayBigSkillEffect, false)
	transformhelper.setLocalScale(var_7_1.goPlaySkillEffect.transform, var_7_3, var_7_3, var_7_3)
	transformhelper.setLocalScale(var_7_1.goPlayBigSkillEffect.transform, var_7_3, var_7_3, var_7_3)
	table.insert(arg_7_0.cardItemList, var_7_1)

	return var_7_1
end

function var_0_0.addPlaySkillEffect(arg_8_0, arg_8_1)
	local var_8_0 = ResUrl.getUIEffect(FightPreloadViewWork.ui_chupai_02)
	local var_8_1 = FightHelper.getPreloadAssetItem(var_8_0)

	return gohelper.clone(var_8_1:GetResource(var_8_0), arg_8_1)
end

function var_0_0.addPlayBigSkillEffect(arg_9_0, arg_9_1)
	local var_9_0 = ResUrl.getUIEffect(FightPreloadViewWork.ui_chupai_03)
	local var_9_1 = FightHelper.getPreloadAssetItem(var_9_0)

	return gohelper.clone(var_9_1:GetResource(var_9_0), arg_9_1)
end

function var_0_0.dissolveCardDone(arg_10_0)
	gohelper.setActive(arg_10_0.cardContainer, false)
	FightController.instance:dispatchEvent(FightEvent.CardDeckDeleteDone)
end

function var_0_0.onDestroyView(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.dissolveCardDone, arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.startDissolve, arg_11_0)
end

return var_0_0
