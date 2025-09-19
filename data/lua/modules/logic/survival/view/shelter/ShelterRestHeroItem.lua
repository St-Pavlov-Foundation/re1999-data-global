module("modules.logic.survival.view.shelter.ShelterRestHeroItem", package.seeall)

local var_0_0 = class("ShelterRestHeroItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	local var_1_0 = arg_1_0.viewGO

	arg_1_0._goHeroRoot = gohelper.findChild(var_1_0, "#go_HaveHero")
	arg_1_0._goEmpty = gohelper.findChild(var_1_0, "#go_Empty")
	arg_1_0._goLock = gohelper.findChild(var_1_0, "#go_Locked")
	arg_1_0._goAssit = gohelper.findChild(arg_1_0._goHeroRoot, "assit")

	local var_1_1 = gohelper.findChild(arg_1_0._goHeroRoot, "hero")

	arg_1_0._heroItem = IconMgr.instance:getCommonHeroItem(var_1_1)

	arg_1_0._heroItem:setStyle_CharacterBackpack()
	arg_1_0._heroItem:hideFavor(true)
	arg_1_0._heroItem:setSelectFrameSize(245, 583, 0, -12)

	arg_1_0._clickThis = gohelper.getClick(var_1_0)

	gohelper.setActive(arg_1_0._goLock, false)

	arg_1_0._healthPart = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0._goHeroRoot, SurvivalHeroHealthPart)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0._clickThis, arg_2_0._onClickThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0._clickThis)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0._onClickThis(arg_5_0)
	if arg_5_0._isLock then
		return
	end

	if SurvivalShelterModel.instance:getWeekInfo():isAllHeroHealth() then
		GameFacade.showToast(ToastEnum.SurvivalRestTips)

		return
	end

	ViewMgr.instance:openView(ViewName.ShelterRestHeroSelectView, {
		index = arg_5_0._index,
		buildingId = arg_5_0.mo.buildingId
	})
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0.mo = arg_6_1

	local var_6_0 = arg_6_1.pos == nil

	arg_6_0._isLock = var_6_0

	local var_6_1 = arg_6_1.heroId or 0
	local var_6_2 = var_6_1 == 0

	gohelper.setActive(arg_6_0._goLock, var_6_0)
	gohelper.setActive(arg_6_0._goEmpty, not var_6_0 and var_6_2)
	gohelper.setActive(arg_6_0._goHeroRoot, not var_6_0 and not var_6_2)

	if var_6_2 then
		return
	end

	local var_6_3 = HeroModel.instance:getByHeroId(var_6_1)

	arg_6_0._heroItem:onUpdateMO(var_6_3)
	arg_6_0._heroItem:setNewShow(false)

	local var_6_4 = SurvivalBalanceHelper.getHeroBalanceLv(var_6_1)

	if var_6_4 > var_6_3.level then
		arg_6_0._heroItem:setBalanceLv(var_6_4)
	end

	arg_6_0._healthPart:setHeroId(var_6_1)
end

function var_0_0.onDestroyView(arg_7_0)
	return
end

return var_0_0
