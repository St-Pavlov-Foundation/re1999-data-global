module("modules.logic.character.view.CharacterBackpackCardListItem", package.seeall)

local var_0_0 = class("CharacterBackpackCardListItem", ListScrollCell)

var_0_0.PressColor = GameUtil.parseColor("#C8C8C8")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._heroGO = arg_1_1
	arg_1_0._heroItem = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0._heroGO, CommonHeroItem)

	arg_1_0._heroItem:addClickListener(arg_1_0._onItemClick, arg_1_0)
	arg_1_0._heroItem:addClickDownListener(arg_1_0._onItemClickDown, arg_1_0)
	arg_1_0._heroItem:addClickUpListener(arg_1_0._onItemClickUp, arg_1_0)
	arg_1_0:_initObj()
end

function var_0_0._initObj(arg_2_0)
	arg_2_0._animator = arg_2_0._heroGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.addEventListeners(arg_3_0)
	RedDotController.instance:registerCallback(RedDotEvent.RefreshClientCharacterDot, arg_3_0._refreshRedDot, arg_3_0)
	PlayerController.instance:registerCallback(PlayerEvent.UpdateSimpleProperty, arg_3_0._refreshRedDot, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	RedDotController.instance:unregisterCallback(RedDotEvent.RefreshClientCharacterDot, arg_4_0._refreshRedDot, arg_4_0)
	PlayerController.instance:unregisterCallback(PlayerEvent.UpdateSimpleProperty, arg_4_0._refreshRedDot, arg_4_0)
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0._mo = arg_5_1

	arg_5_0._heroItem:onUpdateMO(arg_5_1)
	arg_5_0._heroItem:setStyle_CharacterBackpack()
	arg_5_0:_refreshRedDot()

	if arg_5_0._heroItemContainer then
		arg_5_0._heroItemContainer.spines = nil
	end
end

function var_0_0._refreshRedDot(arg_6_0)
	if CharacterModel.instance:isHeroCouldExskillUp(arg_6_0._mo.heroId) or CharacterModel.instance:hasCultureRewardGet(arg_6_0._mo.heroId) or CharacterModel.instance:hasItemRewardGet(arg_6_0._mo.heroId) or arg_6_0:_isShowDestinyReddot() or arg_6_0._mo.extraMo:showReddot() or arg_6_0:_isShowNuodikaReddot() then
		arg_6_0._heroItem:setRedDotShow(true)
	else
		arg_6_0._heroItem:setRedDotShow(false)
	end
end

function var_0_0._onrefreshItem(arg_7_0)
	return
end

function var_0_0._onItemClick(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	CharacterController.instance:openCharacterView(arg_8_0._mo)

	if arg_8_0:_isShowDestinyReddot() then
		HeroRpc.instance:setHeroRedDotReadRequest(arg_8_0._mo.heroId, 1)
	end
end

function var_0_0._onItemClickDown(arg_9_0)
	arg_9_0:_setHeroItemPressState(true)
end

function var_0_0._onItemClickUp(arg_10_0)
	arg_10_0:_setHeroItemPressState(false)
end

function var_0_0._setHeroItemPressState(arg_11_0, arg_11_1)
	if not arg_11_0._heroItemContainer then
		arg_11_0._heroItemContainer = arg_11_0:getUserDataTb_()

		local var_11_0 = arg_11_0._heroGO:GetComponentsInChildren(gohelper.Type_Image, true)

		arg_11_0._heroItemContainer.images = var_11_0

		local var_11_1 = arg_11_0._heroGO:GetComponentsInChildren(gohelper.Type_TextMesh, true)

		arg_11_0._heroItemContainer.tmps = var_11_1
		arg_11_0._heroItemContainer.compColor = {}

		local var_11_2 = var_11_0:GetEnumerator()

		while var_11_2:MoveNext() do
			arg_11_0._heroItemContainer.compColor[var_11_2.Current] = var_11_2.Current.color
		end

		local var_11_3 = var_11_1:GetEnumerator()

		while var_11_3:MoveNext() do
			arg_11_0._heroItemContainer.compColor[var_11_3.Current] = var_11_3.Current.color
		end
	end

	if not arg_11_0._heroItemContainer.spines then
		local var_11_4 = arg_11_0._heroGO:GetComponentsInChildren(GuiSpine.TypeSkeletonGraphic, true)

		arg_11_0._heroItemContainer.spines = var_11_4

		local var_11_5 = var_11_4:GetEnumerator()

		while var_11_5:MoveNext() do
			arg_11_0._heroItemContainer.compColor[var_11_5.Current] = var_11_5.Current.color
		end
	end

	if arg_11_0._heroItemContainer then
		arg_11_0:_setUIPressState(arg_11_0._heroItemContainer.images, arg_11_1, arg_11_0._heroItemContainer.compColor)
		arg_11_0:_setUIPressState(arg_11_0._heroItemContainer.tmps, arg_11_1, arg_11_0._heroItemContainer.compColor)
		arg_11_0:_setUIPressState(arg_11_0._heroItemContainer.spines, arg_11_1, arg_11_0._heroItemContainer.compColor)
	end
end

function var_0_0._setUIPressState(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if not arg_12_1 then
		return
	end

	local var_12_0 = arg_12_1:GetEnumerator()

	while var_12_0:MoveNext() do
		local var_12_1

		if arg_12_2 then
			var_12_1 = arg_12_3 and arg_12_3[var_12_0.Current] * 0.7 or var_0_0.PressColor
			var_12_1.a = var_12_0.Current.color.a
		else
			var_12_1 = arg_12_3 and arg_12_3[var_12_0.Current] or Color.white
		end

		var_12_0.Current.color = var_12_1
	end
end

function var_0_0.onDestroy(arg_13_0)
	if arg_13_0._heroItem then
		arg_13_0._heroItem:onDestroy()

		arg_13_0._heroItem = nil
	end
end

function var_0_0.getAnimator(arg_14_0)
	return arg_14_0._animator
end

function var_0_0._isShowDestinyReddot(arg_15_0)
	if arg_15_0._mo and arg_15_0._mo.destinyStoneMo then
		return arg_15_0._mo:isCanOpenDestinySystem() and arg_15_0._mo.destinyStoneMo:getRedDot() < 1
	end
end

function var_0_0._isShowNuodikaReddot(arg_16_0)
	local var_16_0, var_16_1 = CharacterModel.instance:isNeedShowNewSkillReddot(arg_16_0._mo)

	return var_16_0 and var_16_1
end

return var_0_0
