module("modules.logic.herogrouppreset.controller.HeroGroupPresetHeroGroupSelectIndexController", package.seeall)

local var_0_0 = class("HeroGroupPresetHeroGroupSelectIndexController", BaseController)

function var_0_0.getCommonSelectedIndex(arg_1_0, arg_1_1)
	if HeroGroupModel.instance:getCommonGroupList(arg_1_1) then
		return arg_1_1
	end

	arg_1_1 = HeroGroupSnapshotModel.instance:getSortSubIds(ModuleEnum.HeroGroupSnapshotType.Common)[1] or 1

	if HeroGroupModel.instance:getCommonGroupList(arg_1_1) then
		return arg_1_1
	end

	for iter_1_0 = HeroGroupPresetEnum.MinNum, HeroGroupPresetEnum.MaxNum do
		if HeroGroupModel.instance:getCommonGroupList(iter_1_0) then
			return iter_1_0
		end
	end

	logError(string.format("HeroGroupPresetHeroGroupSelectIndexController:getCommonSelectedIndex id:%s 没有可用的索引", arg_1_1))
end

function var_0_0.getSnapshotTypeSelectedIndex(arg_2_0, arg_2_1, arg_2_2)
	if HeroGroupSnapshotModel.instance:getHeroGroupInfo(arg_2_1, arg_2_2) then
		return arg_2_2
	end

	arg_2_2 = HeroGroupSnapshotModel.instance:getSortSubIds(arg_2_1)[1] or 1

	if HeroGroupSnapshotModel.instance:getHeroGroupInfo(arg_2_1, arg_2_2) then
		return arg_2_2
	end

	for iter_2_0 = HeroGroupPresetEnum.MinNum, HeroGroupPresetEnum.MaxNum do
		if not HeroGroupSnapshotModel.instance:getHeroGroupInfo(arg_2_1, iter_2_0) then
			return iter_2_0
		end
	end

	logError(string.format("HeroGroupPresetHeroGroupSelectIndexController:getSnapshotTypeSelectedIndex snapshotType:%s,id:%s 没有可用的索引", arg_2_1, arg_2_2))
end

var_0_0.instance = var_0_0.New()

return var_0_0
