module("modules.logic.herogrouppreset.controller.HeroGroupPresetHeroGroupNameController", package.seeall)

local var_0_0 = class("HeroGroupPresetHeroGroupNameController", BaseController)

function var_0_0.getName(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_1 == HeroGroupPresetEnum.HeroGroupType.Common then
		local var_1_0 = HeroGroupModel.instance:getCommonGroupList(arg_1_2)
		local var_1_1 = var_1_0 and var_1_0.name

		if string.nilorempty(var_1_1) then
			return formatLuaLang("herogroup_common_name", GameUtil.getNum2Chinese(arg_1_2))
		else
			return var_1_1
		end
	end

	local var_1_2 = HeroGroupPresetEnum.HeroGroupType2SnapshotType[arg_1_1]

	if var_1_2 then
		local var_1_3 = HeroGroupSnapshotModel.instance:getHeroGroupName(var_1_2, arg_1_2)

		if string.nilorempty(var_1_3) then
			return formatLuaLang("herogroup_common_name", GameUtil.getNum2Chinese(arg_1_2))
		else
			return var_1_3
		end
	end
end

function var_0_0.setName(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_3 == HeroGroupPresetEnum.HeroGroupType.Common then
		local var_2_0 = HeroGroupModel.instance:getCommonGroupList(arg_2_1)

		if var_2_0 then
			var_2_0.name = arg_2_2
		end
	end

	local var_2_1 = HeroGroupPresetEnum.HeroGroupType2SnapshotType[arg_2_3]

	if var_2_1 then
		HeroGroupSnapshotModel.instance:setHeroGroupName(var_2_1, arg_2_1, arg_2_2)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
