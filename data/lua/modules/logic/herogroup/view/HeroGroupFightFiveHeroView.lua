module("modules.logic.herogroup.view.HeroGroupFightFiveHeroView", package.seeall)

local var_0_0 = class("HeroGroupFightFiveHeroView", HeroGroupFightView)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0:checkHeroList()
	var_0_0.super._editableInitView(arg_1_0)
end

function var_0_0.checkHeroList(arg_2_0)
	local var_2_0 = ModuleEnum.FiveHeroEnum.MaxHeroNum
	local var_2_1 = HeroGroupModel.instance:getCurGroupMO()

	HeroSingleGroupModel.instance:setMaxHeroCount(var_2_0)
	HeroSingleGroupModel.instance:setSingleGroup(var_2_1)
end

function var_0_0._getKey()
	return (string.format("%s_%s", PlayerPrefsKey.FiveHeroGroupSelectIndex, PlayerModel.instance:getPlayinfo().userId))
end

function var_0_0._initFightGroupDrop(arg_4_0)
	arg_4_0:_initFightGroupDropFiveHero()
	arg_4_0:_checkEquipClothSkill()
end

function var_0_0._initFightGroupDropFiveHero(arg_5_0)
	if not arg_5_0:_noAidHero() then
		return
	end

	local var_5_0 = {}

	for iter_5_0 = 1, 4 do
		local var_5_1 = HeroGroupSnapshotModel.instance:getHeroGroupInfo(ModuleEnum.HeroGroupSnapshotType.FiveHero, iter_5_0)
		local var_5_2 = var_5_1 and var_5_1.name

		var_5_0[iter_5_0] = not string.nilorempty(var_5_2) and var_5_2 or formatLuaLang("herogroup_common_name", GameUtil.getNum2Chinese(iter_5_0))
	end

	local var_5_3 = PlayerPrefsHelper.getNumber(arg_5_0:_getKey(), 0)

	arg_5_0:_setHeroGroupSelectIndex(var_5_3 == 0 and ModuleEnum.FiveHeroEnum.FifthIndex or var_5_3)
	gohelper.setActive(arg_5_0._btnmodifyname, var_5_3 ~= 0)

	local var_5_4 = HeroGroupModel.instance:getGroupTypeName()

	if var_5_4 then
		table.insert(var_5_0, 1, var_5_4)
	else
		var_5_3 = var_5_3 - 1
	end

	arg_5_0._dropherogroup:ClearOptions()
	arg_5_0._dropherogroup:AddOptions(var_5_0)
	arg_5_0._dropherogroup:SetValue(var_5_3)
	gohelper.setActive(arg_5_0._dropherogroup, false)
end

function var_0_0._groupDropValueChanged(arg_6_0, arg_6_1)
	PlayerPrefsHelper.setNumber(arg_6_0:_getKey(), arg_6_1)

	local var_6_0 = arg_6_1

	gohelper.setActive(arg_6_0._btnmodifyname, var_6_0 ~= 0)

	local var_6_1 = arg_6_1 == 0 and ModuleEnum.FiveHeroEnum.FifthIndex or arg_6_1

	if arg_6_0:_setHeroGroupSelectIndex(var_6_1) then
		arg_6_0:_checkEquipClothSkill()
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
		gohelper.setActive(arg_6_0._goherogroupcontain, false)
		gohelper.setActive(arg_6_0._goherogroupcontain, true)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyGroupSelectIndex)
	end
end

function var_0_0._setHeroGroupSelectIndex(arg_7_0, arg_7_1)
	HeroGroupSnapshotModel.instance:setSelectIndex(ModuleEnum.HeroGroupSnapshotType.FiveHero, arg_7_1)
	HeroGroupModel.instance:_setSingleGroup()

	return true
end

function var_0_0.onClose(arg_8_0)
	var_0_0.super.onClose(arg_8_0)
	HeroSingleGroupModel.instance:setMaxHeroCount()
end

function var_0_0._refreshBtns(arg_9_0, arg_9_1)
	var_0_0.super._refreshBtns(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0._dropherogroup, false)
end

return var_0_0
