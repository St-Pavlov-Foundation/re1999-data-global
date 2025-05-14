module("modules.logic.seasonver.act123.model.Season123PickAssistListModel", package.seeall)

local var_0_0 = class("Season123PickAssistListModel", ListScrollModel)
local var_0_1 = CharacterEnum.CareerType.Yan

function var_0_0.onInit(arg_1_0)
	arg_1_0:setCareer()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:setCareer()
end

function var_0_0.release(arg_3_0)
	arg_3_0:clear()

	arg_3_0.activityId = nil

	arg_3_0:setHeroSelect()
end

function var_0_0.init(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.activityId = arg_4_1

	if not arg_4_0.career then
		arg_4_0:setCareer(var_0_1)
	end

	arg_4_0:initSelectedMO(arg_4_2)
	arg_4_0:updateDatas()
end

function var_0_0.initSelectedMO(arg_5_0, arg_5_1)
	arg_5_0:setHeroSelect()

	local var_5_0 = DungeonAssistModel.instance:getAssistList(DungeonEnum.AssistType.Season123)

	if var_5_0 then
		for iter_5_0, iter_5_1 in ipairs(var_5_0) do
			if iter_5_1:getHeroUid() == arg_5_1 then
				local var_5_1 = Season123HeroUtils.createSeasonPickAssistMO(iter_5_1)

				arg_5_0:setHeroSelect(var_5_1, true)
			end
		end
	end
end

function var_0_0.updateDatas(arg_6_0)
	if not arg_6_0.activityId or not arg_6_0.career then
		return
	end

	arg_6_0:setListByCareer()
end

function var_0_0.setListByCareer(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = arg_7_0:getSelectedMO()

	arg_7_0:setHeroSelect()

	local var_7_2 = DungeonAssistModel.instance:getAssistList(DungeonEnum.AssistType.Season123, arg_7_0.career)

	if var_7_2 then
		for iter_7_0, iter_7_1 in ipairs(var_7_2) do
			local var_7_3 = Season123HeroUtils.createSeasonPickAssistMO(iter_7_1)

			if var_7_3 and var_7_3.heroMO and var_7_3.heroMO.config and var_7_3.heroMO.config.career == arg_7_0.career then
				table.insert(var_7_0, var_7_3)

				if var_7_1 and var_7_1:isSameHero(var_7_3) then
					arg_7_0:setHeroSelect(var_7_3, true)
				end
			end
		end
	end

	arg_7_0:setList(var_7_0)
	Season123Controller.instance:dispatchEvent(Season123Event.SetCareer)
end

function var_0_0.getCareer(arg_8_0)
	return arg_8_0.career
end

function var_0_0.getSelectedMO(arg_9_0)
	return arg_9_0.selectMO
end

function var_0_0.isHeroSelected(arg_10_0, arg_10_1)
	local var_10_0 = false
	local var_10_1 = arg_10_0:getSelectedMO()

	if var_10_1 then
		var_10_0 = var_10_1:isSameHero(arg_10_1)
	end

	return var_10_0
end

function var_0_0.isHasAssistList(arg_11_0)
	local var_11_0 = false
	local var_11_1 = arg_11_0:getList()

	if var_11_1 then
		var_11_0 = #var_11_1 > 0
	end

	return var_11_0
end

function var_0_0.setCareer(arg_12_0, arg_12_1)
	if arg_12_0.career ~= arg_12_1 then
		arg_12_0.career = arg_12_1

		arg_12_0:updateDatas()
	end
end

function var_0_0.setHeroSelect(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_2 then
		arg_13_0.selectMO = arg_13_1
	else
		arg_13_0.selectMO = nil
	end

	Season123Controller.instance:dispatchEvent(Season123Event.RefreshSelectAssistHero)
end

var_0_0.instance = var_0_0.New()

return var_0_0
