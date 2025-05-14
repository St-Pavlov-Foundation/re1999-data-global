module("modules.logic.player.view.ShowCharacterCardItem", package.seeall)

local var_0_0 = class("ShowCharacterCardItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._heroGOParent = gohelper.findChild(arg_1_1, "hero")
	arg_1_0._heroItem = IconMgr.instance:getCommonHeroItem(arg_1_0._heroGOParent)

	arg_1_0._heroItem:addClickListener(arg_1_0._onItemClick, arg_1_0)

	arg_1_0._mask = gohelper.findChild(arg_1_0._gocharactercarditem, "nummask")
	arg_1_0._masknum = gohelper.findChildText(arg_1_0._gocharactercarditem, "nummask/num")
	arg_1_0._shownum = 0

	arg_1_0:_initObj()
end

function var_0_0._initObj(arg_2_0)
	arg_2_0._animator = arg_2_0._heroItem.go:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.addEventListeners(arg_3_0)
	return
end

function var_0_0.removeEventListeners(arg_4_0)
	return
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0._mo = arg_5_1

	arg_5_0._heroItem:onUpdateMO(arg_5_1)
	arg_5_0._heroItem:setNewShow(false)
	arg_5_0:_initShowHeroList()
end

function var_0_0._initShowHeroList(arg_6_0)
	local var_6_0 = PlayerModel.instance:getShowHeros()
	local var_6_1 = 0
	local var_6_2 = arg_6_0:_clecknum(var_6_0)

	arg_6_0:_initnum(var_6_2)
end

function var_0_0._onItemClick(arg_7_0)
	local var_7_0 = PlayerModel.instance:getShowHeros()

	if arg_7_0._shownum ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_gone)
		arg_7_0._heroItem:setChoose(nil)
		PlayerModel.instance:setShowHero(arg_7_0._shownum, 0)

		arg_7_0._shownum = 0
	else
		arg_7_0:_addHeroShow(var_7_0)

		if arg_7_0._shownum ~= 0 then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_gone)
		end

		PlayerModel.instance:setShowHero(arg_7_0._shownum, arg_7_0._mo.heroId)
	end
end

function var_0_0._addHeroShow(arg_8_0, arg_8_1)
	for iter_8_0 = 1, #arg_8_1 do
		if arg_8_1[iter_8_0] == 0 then
			arg_8_0:_initnum(iter_8_0)

			return
		end
	end
end

function var_0_0._clecknum(arg_9_0, arg_9_1)
	local var_9_0 = 0

	for iter_9_0 = 1, #arg_9_1 do
		if arg_9_1[iter_9_0] ~= 0 and arg_9_0._mo.heroId == arg_9_1[iter_9_0].heroId then
			var_9_0 = iter_9_0
		end
	end

	return var_9_0
end

function var_0_0._initnum(arg_10_0, arg_10_1)
	if arg_10_1 == 0 then
		arg_10_0._heroItem:setChoose(nil)
	else
		arg_10_0._heroItem:setChoose(arg_10_1)
	end

	arg_10_0._shownum = arg_10_1
end

function var_0_0.getAnimator(arg_11_0)
	return arg_11_0._animator
end

function var_0_0.onDestroy(arg_12_0)
	return
end

return var_0_0
