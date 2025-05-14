module("modules.logic.pickassist.model.PickAssistListModel", package.seeall)

local var_0_0 = class("PickAssistListModel", ListScrollModel)
local var_0_1 = CharacterEnum.CareerType.Yan
local var_0_2 = {}
local var_0_3 = {
	[PickAssistEnum.Type.Rouge] = "RougePickAssistView"
}

local function var_0_4(arg_1_0)
	if not arg_1_0 then
		return
	end

	local var_1_0 = arg_1_0:getHeroInfo()
	local var_1_1 = PickAssistHeroMO.New()

	var_1_1:init(var_1_0)

	return var_1_1
end

function var_0_0.onInit(arg_2_0)
	arg_2_0:clearData()
end

function var_0_0.reInit(arg_3_0)
	arg_3_0:onInit()
end

function var_0_0.clearData(arg_4_0)
	arg_4_0.activityId = nil
	arg_4_0.career = nil
	arg_4_0.selectMO = nil
end

function var_0_0.onCloseView(arg_5_0)
	arg_5_0:clear()
	arg_5_0:clearData()
end

function var_0_0.init(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.activityId = arg_6_1
	arg_6_0._assistType = arg_6_2

	if not arg_6_0.career then
		arg_6_0:setCareer(var_0_1)
	end

	arg_6_0:initSelectedMO(arg_6_3)
	arg_6_0:updateDatas()
end

function var_0_0.initSelectedMO(arg_7_0, arg_7_1)
	arg_7_0:setHeroSelect()

	local var_7_0 = arg_7_0:getAssistType()
	local var_7_1 = DungeonAssistModel.instance:getAssistList(var_7_0)

	if not var_7_1 then
		return
	end

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		if iter_7_1:getHeroUid() == arg_7_1 then
			local var_7_2 = var_0_4(iter_7_1)

			arg_7_0:setHeroSelect(var_7_2, true)

			break
		end
	end
end

function var_0_0.updateDatas(arg_8_0)
	if not arg_8_0.activityId or not arg_8_0.career then
		return
	end

	arg_8_0:setListByCareer()
end

function var_0_0.setListByCareer(arg_9_0)
	local var_9_0 = {}
	local var_9_1 = arg_9_0:getSelectedMO()

	arg_9_0:setHeroSelect()

	local var_9_2 = arg_9_0:getAssistType()
	local var_9_3 = DungeonAssistModel.instance:getAssistList(var_9_2, arg_9_0.career)

	if var_9_3 then
		for iter_9_0, iter_9_1 in ipairs(var_9_3) do
			local var_9_4 = var_0_4(iter_9_1)
			local var_9_5 = var_9_4 and var_9_4:getCareer()

			if var_9_4 and var_9_5 == arg_9_0.career then
				table.insert(var_9_0, var_9_4)

				if var_9_1 and var_9_1:isSameHero(var_9_4) then
					arg_9_0:setHeroSelect(var_9_4, true)
				end
			end
		end
	end

	arg_9_0:setList(var_9_0)
	PickAssistController.instance:dispatchEvent(PickAssistEvent.SetCareer)
end

function var_0_0.getPickAssistViewName(arg_10_0)
	local var_10_0 = ViewName.PickAssistView

	var_10_0 = arg_10_0.activityId and var_0_2[arg_10_0.activityId] or var_10_0
	var_10_0 = arg_10_0._assistType and var_0_3[arg_10_0._assistType] or var_10_0

	return var_10_0
end

function var_0_0.getCareer(arg_11_0)
	return arg_11_0.career
end

function var_0_0.getSelectedMO(arg_12_0)
	return arg_12_0.selectMO
end

function var_0_0.isHeroSelected(arg_13_0, arg_13_1)
	local var_13_0 = false
	local var_13_1 = arg_13_0:getSelectedMO()

	if var_13_1 then
		var_13_0 = var_13_1:isSameHero(arg_13_1)
	end

	return var_13_0
end

function var_0_0.isHasAssistList(arg_14_0)
	local var_14_0 = false
	local var_14_1 = arg_14_0:getList()

	if var_14_1 then
		var_14_0 = #var_14_1 > 0
	end

	return var_14_0
end

function var_0_0.getAssistType(arg_15_0)
	if not arg_15_0._assistType then
		logError("PickAssistListModel:getAssistType error, not set assistType")
	end

	return arg_15_0._assistType
end

function var_0_0.setCareer(arg_16_0, arg_16_1)
	if arg_16_0.career ~= arg_16_1 then
		arg_16_0.career = arg_16_1

		arg_16_0:updateDatas()
	end
end

function var_0_0.setHeroSelect(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_2 then
		arg_17_0.selectMO = arg_17_1
	else
		arg_17_0.selectMO = nil
	end

	PickAssistController.instance:dispatchEvent(PickAssistEvent.RefreshSelectAssistHero)
end

var_0_0.instance = var_0_0.New()

return var_0_0
