module("modules.logic.sp01.odyssey.controller.OdysseyHeroGroupController", package.seeall)

local var_0_0 = class("OdysseyHeroGroupController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.saveHeroGroupInfo(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_1 = arg_4_1 or HeroGroupModel.instance:getCurGroupMO()

	local var_4_0 = OdysseyHeroGroupModel.instance:getCurFormInfo()

	var_4_0.clothId = arg_4_1.clothId
	arg_4_2 = arg_4_2 or OdysseyEnum.HeroGroupSaveType.FormUpdate

	OdysseyHeroGroupModel.instance:setSaveType(arg_4_2)

	for iter_4_0, iter_4_1 in ipairs(var_4_0.heroes) do
		local var_4_1 = iter_4_1.position
		local var_4_2 = arg_4_1:getHeroByIndex(var_4_1)
		local var_4_3 = arg_4_1:getPosEquips(var_4_1 - 1)
		local var_4_4 = HeroSingleGroupModel.instance:getById(var_4_1)

		if not string.nilorempty(var_4_2) then
			local var_4_5 = tonumber(var_4_2)

			if var_4_5 > 0 then
				local var_4_6 = HeroModel.instance:getById(var_4_2)

				if var_4_6 == nil then
					logError("奥德赛活动角色保存 uid：" .. var_4_2 .. "不存在")
				else
					iter_4_1.heroId = var_4_6.heroId
					iter_4_1.trialId = 0
				end
			elseif var_4_5 == 0 then
				iter_4_1.heroId = 0
				iter_4_1.trialId = 0
			else
				local var_4_7 = var_4_4.trial

				iter_4_1.heroId = 0
				iter_4_1.trialId = tonumber(var_4_7)
			end

			tabletool.clear(iter_4_1.equips)

			local var_4_8 = arg_4_1:getOdysseyEquips(var_4_1 - 1)

			for iter_4_2, iter_4_3 in ipairs(var_4_8.equipUid) do
				local var_4_9 = OdysseyDef_pb.OdysseyFormEquip()

				var_4_9.slotId = iter_4_2
				var_4_9.equipUid = tonumber(iter_4_3)

				table.insert(iter_4_1.equips, var_4_9)
			end
		end

		if var_4_3 ~= nil and var_4_3.equipUid ~= nil and not string.nilorempty(var_4_3.equipUid[1]) then
			iter_4_1.mindId = tonumber(var_4_3.equipUid[1])
		end
	end

	logNormal(tostring(var_4_0))
	OdysseyRpc.instance:sendOdysseyFormSaveRequest(var_4_0, arg_4_3, arg_4_4)
end

function var_0_0.switchHeroGroup(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	OdysseyRpc.instance:sendOdysseyFormSwitchRequest(arg_5_1, arg_5_2, arg_5_3)
end

function var_0_0.setOdysseyEquip(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = OdysseyHeroGroupModel.instance:getCurHeroGroup()

	var_6_0:setOdysseyEquip(arg_6_1, arg_6_2, arg_6_3)
	arg_6_0:saveHeroGroupInfo(var_6_0, OdysseyEnum.HeroGroupSaveType.ItemEquip)
end

function var_0_0.replaceOdysseyEquip(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = OdysseyHeroGroupModel.instance:getCurHeroGroup()

	var_7_0:replaceOdysseyEquip(arg_7_1, arg_7_2, arg_7_3)
	arg_7_0:saveHeroGroupInfo(var_7_0, OdysseyEnum.HeroGroupSaveType.ItemReplace)
end

function var_0_0.unloadOdysseyEquip(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = OdysseyHeroGroupModel.instance:getCurHeroGroup()

	var_8_0:unloadOdysseyEquip(arg_8_1, arg_8_2)
	arg_8_0:saveHeroGroupInfo(var_8_0, OdysseyEnum.HeroGroupSaveType.ItemUnload)
end

function var_0_0.swapOdysseyEquip(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = OdysseyHeroGroupModel.instance:getCurHeroGroup()

	var_9_0:swapOdysseyEquip(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	arg_9_0:saveHeroGroupInfo(var_9_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
