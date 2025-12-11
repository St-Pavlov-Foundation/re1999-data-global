module("modules.logic.survival.util.SurvivalEquipRedDotHelper", package.seeall)

local var_0_0 = class("SurvivalEquipRedDotHelper")

function var_0_0.ctor(arg_1_0)
	arg_1_0.reddotType = -1
end

function var_0_0.checkRed(arg_2_0)
	local var_2_0 = arg_2_0.reddotType

	arg_2_0:_checkRed()

	if var_2_0 ~= arg_2_0.reddotType then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnEquipRedUpdate)
	end
end

function var_0_0._checkRed(arg_3_0)
	arg_3_0.reddotType = -1

	local var_3_0 = SurvivalShelterModel.instance:getWeekInfo()

	if not var_3_0 then
		return
	end

	local var_3_1 = false

	for iter_3_0, iter_3_1 in ipairs(var_3_0.equipBox.slots) do
		if iter_3_1.item:isEmpty() and iter_3_1.unlock then
			var_3_1 = true

			break
		end
	end

	local var_3_2 = false

	for iter_3_2, iter_3_3 in ipairs(var_3_0:getBag(SurvivalEnum.ItemSource.Shelter).items) do
		if iter_3_3.equipCo then
			var_3_2 = true
		end
	end

	local var_3_3 = SurvivalMapModel.instance:getSceneMo()

	if var_3_0.inSurvival and var_3_3 then
		for iter_3_4, iter_3_5 in ipairs(var_3_0:getBag(SurvivalEnum.ItemSource.Map).items) do
			if iter_3_5.equipCo then
				var_3_2 = true
			end
		end
	end

	if not var_3_2 then
		return
	end

	if var_3_1 and var_3_2 then
		arg_3_0.reddotType = 0

		return
	end

	local var_3_4 = {}

	for iter_3_6, iter_3_7 in ipairs(var_3_0.equipBox.slots) do
		if not iter_3_7.item:isEmpty() and arg_3_0:haveTag(iter_3_7.item.equipCo.tag, var_3_0.equipBox.maxTagId) then
			table.insert(var_3_4, iter_3_7.item)
		end
	end

	for iter_3_8, iter_3_9 in ipairs(var_3_0:getBag(SurvivalEnum.ItemSource.Shelter).items) do
		if iter_3_9.equipCo then
			for iter_3_10, iter_3_11 in ipairs(var_3_4) do
				if iter_3_11.equipCo.group == iter_3_9.equipCo.group and iter_3_11.equipCo.score < iter_3_9.equipCo.score then
					arg_3_0.reddotType = var_3_0.equipBox.maxTagId

					return
				end
			end
		end
	end

	if var_3_0.inSurvival and var_3_3 then
		for iter_3_12, iter_3_13 in ipairs(var_3_0:getBag(SurvivalEnum.ItemSource.Map).items) do
			if iter_3_13.equipCo then
				for iter_3_14, iter_3_15 in ipairs(var_3_4) do
					if iter_3_15.equipCo.group == iter_3_13.equipCo.group and iter_3_15.equipCo.score < iter_3_13.equipCo.score then
						arg_3_0.reddotType = var_3_0.equipBox.maxTagId

						return
					end
				end
			end
		end
	end
end

local var_0_1 = {}

setmetatable(var_0_1, {
	__mode = "v"
})

function var_0_0.haveTag(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_2 == 0 or string.nilorempty(arg_4_1) then
		return false
	end

	if not var_0_1[arg_4_1] then
		var_0_1[arg_4_1] = string.splitToNumber(arg_4_1, "#")
	end

	return tabletool.indexOf(var_0_1[arg_4_1], arg_4_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
