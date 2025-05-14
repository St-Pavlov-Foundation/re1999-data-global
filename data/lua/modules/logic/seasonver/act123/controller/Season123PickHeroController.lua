module("modules.logic.seasonver.act123.controller.Season123PickHeroController", package.seeall)

local var_0_0 = class("Season123PickHeroController", BaseController)

function var_0_0.onOpenView(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	arg_1_0._finishCall = arg_1_3
	arg_1_0._finishCallObj = arg_1_4

	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.HeroGroup)
	Season123PickHeroModel.instance:init(arg_1_1, arg_1_2, arg_1_5, arg_1_6)
end

function var_0_0.onCloseView(arg_2_0)
	Season123PickHeroModel.instance:release()
	CharacterBackpackCardListModel.instance:clearCardList()
end

function var_0_0.setHeroSelect(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_2 and Season123PickHeroModel.instance:getSelectCount() >= Season123PickHeroModel.instance:getLimitCount() then
		logNormal("max hero count!")

		return
	end

	Season123PickHeroModel.instance:setHeroSelect(arg_3_1, arg_3_2)
	arg_3_0:notifyView()
end

function var_0_0.pickOver(arg_4_0)
	local var_4_0 = Season123PickHeroModel.instance:getSelectMOList()

	if arg_4_0._finishCall then
		arg_4_0._finishCall(arg_4_0._finishCallObj, var_4_0)
	end
end

function var_0_0.updateFilter(arg_5_0)
	Season123PickHeroModel.instance:refreshList()
	Season123Controller.instance:dispatchEvent(Season123Event.PickViewRefresh)
end

function var_0_0.notifyView(arg_6_0)
	Season123PickHeroModel.instance:onModelUpdate()
	Season123Controller.instance:dispatchEvent(Season123Event.PickViewRefresh)
end

var_0_0.instance = var_0_0.New()

return var_0_0
