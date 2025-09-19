module("modules.logic.survival.view.map.comp.SurvivalInitTeamHeroItem", package.seeall)

local var_0_0 = class("SurvivalInitTeamHeroItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._heroAnim = gohelper.findChildAnim(arg_1_1, "#go_HaveHero")
	arg_1_0._goHeroRoot = gohelper.findChild(arg_1_1, "#go_HaveHero")
	arg_1_0._goEmpty = gohelper.findChild(arg_1_1, "#go_Empty")
	arg_1_0._goLock = gohelper.findChild(arg_1_1, "#go_Locked")
	arg_1_0._goNew = gohelper.findChild(arg_1_1, "#go_New")
	arg_1_0._goAssit = gohelper.findChild(arg_1_0._goHeroRoot, "assit")

	local var_1_0 = gohelper.findChild(arg_1_0._goHeroRoot, "hero")

	arg_1_0._heroItem = IconMgr.instance:getCommonHeroItem(var_1_0)

	arg_1_0._heroItem:setStyle_CharacterBackpack()
	arg_1_0._heroItem:hideFavor(true)

	arg_1_0._clickThis = gohelper.getClick(arg_1_0.go)

	gohelper.setActive(arg_1_0._goLock, false)

	arg_1_0._healthPart = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0._goHeroRoot, SurvivalHeroHealthPart)
end

function var_0_0.setIndex(arg_2_0, arg_2_1)
	arg_2_0._index = arg_2_1
end

function var_0_0.setParentView(arg_3_0, arg_3_1)
	arg_3_0._teamView = arg_3_1
end

function var_0_0.addEventListeners(arg_4_0)
	arg_4_0._clickThis:AddClickListener(arg_4_0._onClickThis, arg_4_0)
end

function var_0_0.removeEventListeners(arg_5_0)
	arg_5_0._clickThis:RemoveClickListener()
end

function var_0_0.getHeroMo(arg_6_0)
	return arg_6_0._heroMO
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0._heroMO = arg_7_1

	local var_7_0 = arg_7_0._heroMO ~= nil

	gohelper.setActive(arg_7_0._goEmpty, not var_7_0)
	gohelper.setActive(arg_7_0._goHeroRoot, var_7_0)

	if var_7_0 then
		arg_7_0._heroItem:onUpdateMO(arg_7_0._heroMO)
		arg_7_0._heroItem:setNewShow(false)

		local var_7_1 = SurvivalBalanceHelper.getHeroBalanceLv(arg_7_0._heroMO.heroId)

		if var_7_1 > arg_7_0._heroMO.level then
			arg_7_0._heroItem:setBalanceLv(var_7_1)
		end

		arg_7_0._healthPart:setHeroId(arg_7_1.heroId)
		arg_7_0._heroItem.rootAnim:Play("idle", 0, 0)
	end
end

function var_0_0.setTrialValue(arg_8_0, arg_8_1)
	arg_8_0._isTrial = arg_8_1

	gohelper.setActive(arg_8_0._goAssit, arg_8_1)
end

function var_0_0.setIsLock(arg_9_0, arg_9_1)
	arg_9_0._isLock = arg_9_1

	if arg_9_1 then
		gohelper.setActive(arg_9_0._goLock, true)
		gohelper.setActive(arg_9_0._goHeroRoot, false)
		gohelper.setActive(arg_9_0._goEmpty, false)
	end
end

function var_0_0.setNew(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0._goNew, arg_10_1)
end

function var_0_0.showSelectEffect(arg_11_0)
	arg_11_0._heroAnim:Play("open", 0, 0)
end

function var_0_0._onClickThis(arg_12_0)
	if arg_12_0._isTrial or arg_12_0._isLock then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Team_Open)

	SurvivalMapModel.instance:getInitGroup().curClickHeroIndex = arg_12_0._index

	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.Survival)
	SurvivalMapModel.instance:getInitGroup():initHeroList()
	ViewMgr.instance:openView(ViewName.SurvivalInitHeroSelectView)
end

function var_0_0.onDestroy(arg_13_0)
	arg_13_0._teamView = nil
end

return var_0_0
