module("modules.logic.seasonver.act123.view1_8.Season123_1_8PickHeroItem", package.seeall)

local var_0_0 = class("Season123_1_8PickHeroItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._heroGOParent = gohelper.findChild(arg_1_1, "hero")
	arg_1_0._goOrder = gohelper.findChild(arg_1_1, "#go_orderbg")
	arg_1_0._txtorder = gohelper.findChildText(arg_1_1, "#go_orderbg/#txt_level")
	arg_1_0._heroItem = IconMgr.instance:getCommonHeroItem(arg_1_0._heroGOParent)

	arg_1_0._heroItem:addClickListener(arg_1_0.onItemClick, arg_1_0)
	arg_1_0:initHeroItem(arg_1_1)
end

function var_0_0.initHeroItem(arg_2_0, arg_2_1)
	arg_2_0._animator = arg_2_0._heroItem.go:GetComponent(typeof(UnityEngine.Animator))

	transformhelper.setLocalScale(arg_2_1.transform, 0.8, 0.8, 1)
end

function var_0_0.addEventListeners(arg_3_0)
	return
end

function var_0_0.removeEventListeners(arg_4_0)
	return
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0._mo = arg_5_1

	local var_5_0 = HeroModel.instance:getById(arg_5_0._mo.id)

	arg_5_0._heroItem:onUpdateMO(var_5_0)
	arg_5_0._heroItem:setNewShow(false)

	local var_5_1 = Season123PickHeroModel.instance:isHeroSelected(arg_5_0._mo.id)

	arg_5_0._heroItem:setSelect(var_5_1)
	gohelper.setActive(arg_5_0._goOrder, var_5_1)

	if var_5_1 then
		local var_5_2 = Season123PickHeroModel.instance:getSelectedIndex(arg_5_0._mo.id)

		arg_5_0._txtorder.text = tostring(var_5_2)
	end
end

function var_0_0.onItemClick(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	local var_6_0 = Season123PickHeroModel.instance:isHeroSelected(arg_6_0._mo.id)

	Season123PickHeroController.instance:setHeroSelect(arg_6_0._mo.id, not var_6_0)
end

function var_0_0.onDestroy(arg_7_0)
	if arg_7_0._heroItem then
		arg_7_0._heroItem:onDestroy()

		arg_7_0._heroItem = nil
	end
end

function var_0_0.getAnimator(arg_8_0)
	return arg_8_0._animator
end

return var_0_0
