module("modules.logic.character.view.recommed.CharacterDevelopGoalsView", package.seeall)

local var_0_0 = class("CharacterDevelopGoalsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollgroup = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_group")
	arg_1_0._gomax = gohelper.findChild(arg_1_0.viewGO, "#go_max")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(CharacterRecommedController.instance, CharacterRecommedEvent.OnCutHeroAnimCB, arg_2_0._refreshHero, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0._refreshItems, arg_2_0)
	arg_2_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_2_0._refreshItems, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_2_0._refreshItems, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_2_0._refreshItems, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_2_0._refreshItems, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(CharacterRecommedController.instance, CharacterRecommedEvent.OnCutHeroAnimCB, arg_3_0._refreshHero, arg_3_0)
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0._refreshItems, arg_3_0)
	arg_3_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_3_0._refreshItems, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_3_0._refreshItems, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_3_0._refreshItems, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_3_0._refreshItems, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._heroId = nil

	arg_6_0:_refreshHero(arg_6_0.viewParam.heroId)
	arg_6_0:playViewAnim(CharacterRecommedEnum.AnimName.Open, 0, 0)
end

function var_0_0._refreshHero(arg_7_0, arg_7_1)
	if arg_7_0._heroId == arg_7_1 then
		return
	end

	arg_7_0._heroId = arg_7_1
	arg_7_0._heroRecommendMO = CharacterRecommedModel.instance:getHeroRecommendMo(arg_7_1)

	arg_7_0:_refreshItems()
end

function var_0_0._refreshItems(arg_8_0)
	local var_8_0 = arg_8_0._heroRecommendMO:getNextDevelopMaterial()

	if not arg_8_0._goGoalsItem then
		arg_8_0._goGoalsItem = arg_8_0.viewContainer:getGoalsItemRes()
	end

	local var_8_1 = {}

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		local var_8_2 = iter_8_1:getItemList()

		if var_8_2 and #var_8_2 > 0 then
			table.insert(var_8_1, iter_8_1)
		end
	end

	table.sort(var_8_1, function(arg_9_0, arg_9_1)
		return arg_9_0:getDevelopGoalsType() < arg_9_1:getDevelopGoalsType()
	end)
	gohelper.CreateObjList(arg_8_0, arg_8_0._goalsItemCB, var_8_1, arg_8_0._scrollgroup.content.gameObject, arg_8_0._goGoalsItem, CharacterDevelopGoalsItem)
	gohelper.setActive(arg_8_0._gomax.gameObject, #var_8_1 == 0)
	gohelper.setActive(arg_8_0._scrollgroup.gameObject, #var_8_1 > 0)
end

function var_0_0._goalsItemCB(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_1:onUpdateMO(arg_10_2)
end

function var_0_0.playViewAnim(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if not arg_11_0._viewAnim then
		arg_11_0._viewAnim = arg_11_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	end

	if arg_11_0._viewAnim then
		arg_11_0._viewAnim:Play(arg_11_1, arg_11_2, arg_11_3)
	end
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
