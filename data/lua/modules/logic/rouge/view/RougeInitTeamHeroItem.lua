module("modules.logic.rouge.view.RougeInitTeamHeroItem", package.seeall)

local var_0_0 = class("RougeInitTeamHeroItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._clickGO = gohelper.findChild(arg_1_1, "clickarea")
	arg_1_0._emptyGO = gohelper.findChild(arg_1_1, "empty")
	arg_1_0._selectedEffect = gohelper.findChild(arg_1_1, "selectedeffect")
	arg_1_0._clickThis = gohelper.getClick(arg_1_0._clickGO)
	arg_1_0._heroGOParent = gohelper.findChild(arg_1_1, "heroitem")
end

function var_0_0.setIndex(arg_2_0, arg_2_1)
	arg_2_0._index = arg_2_1
end

function var_0_0.setRougeInitTeamView(arg_3_0, arg_3_1)
	arg_3_0._teamView = arg_3_1
end

function var_0_0.setHeroItem(arg_4_0, arg_4_1)
	arg_4_0._heroItemGo = gohelper.clone(arg_4_1, arg_4_0._heroGOParent)

	local var_4_0 = gohelper.findChild(arg_4_0._heroItemGo, "hero")
	local var_4_1 = gohelper.findChild(arg_4_0._heroItemGo, "#go_hp")

	gohelper.setActive(var_4_1, false)

	arg_4_0._heroItem = IconMgr.instance:getCommonHeroItem(var_4_0)

	arg_4_0._heroItem:setStyle_CharacterBackpack()
	arg_4_0._heroItem:hideFavor(true)

	arg_4_0._heroAnimator = arg_4_0._heroItem.go:GetComponent(typeof(UnityEngine.Animator))

	arg_4_0:_initCapacity()
end

function var_0_0._initCapacity(arg_5_0)
	local var_5_0 = gohelper.findChild(arg_5_0._heroItemGo, "volume")

	arg_5_0._capacityComp = RougeCapacityComp.Add(var_5_0, nil, nil, true)

	arg_5_0._capacityComp:setSpriteType(RougeCapacityComp.SpriteType3, RougeCapacityComp.SpriteType3)
end

function var_0_0.addEventListeners(arg_6_0)
	arg_6_0._clickThis:AddClickListener(arg_6_0._onClickThis, arg_6_0)
end

function var_0_0.removeEventListeners(arg_7_0)
	arg_7_0._clickThis:RemoveClickListener()
end

function var_0_0.getHeroMo(arg_8_0)
	return arg_8_0._heroMO
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	arg_9_0.mo = arg_9_1
	arg_9_0._heroMO = arg_9_1:getHeroMO()

	local var_9_0 = arg_9_0._heroMO ~= nil

	gohelper.setActive(arg_9_0._emptyGO, not var_9_0)
	gohelper.setActive(arg_9_0._heroGOParent, var_9_0)

	arg_9_0._capacity = 0

	if var_9_0 then
		arg_9_0._heroItem:onUpdateMO(arg_9_0._heroMO)
		arg_9_0._heroItem:setNewShow(false)

		arg_9_0._capacity = RougeController.instance:getRoleStyleCapacity(arg_9_0._heroMO)

		arg_9_0._capacityComp:updateMaxNum(arg_9_0._capacity)

		local var_9_1 = RougeHeroGroupBalanceHelper.getHeroBalanceLv(arg_9_0._heroMO.heroId)

		if var_9_1 > arg_9_0._heroMO.level then
			arg_9_0._heroItem:setBalanceLv(var_9_1)
		end

		arg_9_0:updateTrialTag()
	end
end

function var_0_0.setTrialValue(arg_10_0, arg_10_1)
	arg_10_0._isTrial = arg_10_1
end

function var_0_0.updateTrialTag(arg_11_0)
	local var_11_0

	if arg_11_0._isTrial then
		var_11_0 = luaLang("herogroup_trial_tag0")
	end

	arg_11_0._heroItem:setTrialTxt(var_11_0)
end

function var_0_0.showSelectEffect(arg_12_0)
	arg_12_0._heroAnimator:Play(UIAnimationName.Idle, 0, 0)
	gohelper.setActive(arg_12_0._selectedEffect, false)
	gohelper.setActive(arg_12_0._selectedEffect, true)
end

function var_0_0.getCapacity(arg_13_0)
	return arg_13_0._capacity
end

function var_0_0._onClickThis(arg_14_0)
	if arg_14_0._isTrial then
		return
	end

	local var_14_0, var_14_1 = arg_14_0._teamView:getCapacityProgress()

	if var_14_1 <= var_14_0 and not arg_14_0._heroMO then
		GameFacade.showToast(ToastEnum.RougeTeamSelectHeroCapacityFull)

		return
	end

	arg_14_0:_openRougeHeroGroupEditView(arg_14_0.mo.id)
end

function var_0_0._openRougeHeroGroupEditView(arg_15_0, arg_15_1)
	local var_15_0, var_15_1 = arg_15_0._teamView:getNoneAssistCapacityProgress()
	local var_15_2 = {
		singleGroupMOId = arg_15_1,
		originalHeroUid = RougeHeroSingleGroupModel.instance:getHeroUid(arg_15_1),
		equips = {
			"0"
		},
		heroGroupEditType = RougeEnum.HeroGroupEditType.Init,
		selectHeroCapacity = arg_15_0._capacity,
		curCapacity = var_15_0,
		totalCapacity = var_15_1,
		assistCapacity = arg_15_0._teamView:getAssistCapacity(),
		assistPos = arg_15_0._teamView:getAssistPos(),
		assistHeroId = arg_15_0._teamView:getAssistHeroId()
	}

	ViewMgr.instance:openView(ViewName.RougeHeroGroupEditView, var_15_2)
end

function var_0_0.onDestroy(arg_16_0)
	arg_16_0._teamView = nil
end

return var_0_0
