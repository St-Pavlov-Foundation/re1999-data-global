module("modules.logic.versionactivity3_1.nationalgift.model.NationalGiftMO", package.seeall)

local var_0_0 = pureTable("NationalGiftMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0.actId = VersionActivity3_1Enum.ActivityId.NationalGift
	arg_1_0.isActive = false
	arg_1_0.bonuses = {}
	arg_1_0.endTime = 0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.actId = arg_2_1.activityId
	arg_2_0.isActive = arg_2_1.isActive
	arg_2_0.bonuses = arg_2_0:setBonusList(arg_2_1.bonuss)
	arg_2_0.endTime = arg_2_1.endTime
end

function var_0_0.setBonusList(arg_3_0, arg_3_1)
	local var_3_0 = {}

	if arg_3_1 then
		for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
			local var_3_1 = NationalGiftBonusMO.New()

			var_3_1:init(iter_3_1)

			var_3_0[var_3_1.id] = var_3_1
		end
	end

	return var_3_0
end

function var_0_0.updateBonusStatus(arg_4_0, arg_4_1, arg_4_2)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.bonuses) do
		if iter_4_1.id == arg_4_1 then
			iter_4_1:updateStatus(arg_4_2)
		end
	end
end

function var_0_0.updateActActive(arg_5_0, arg_5_1)
	arg_5_0.isActive = arg_5_1
end

function var_0_0.updateBonuses(arg_6_0, arg_6_1)
	arg_6_0.bonuses = arg_6_0:setBonusList(arg_6_1)
end

function var_0_0.isBonusGet(arg_7_0, arg_7_1)
	return arg_7_0.bonuses[arg_7_1] and arg_7_0.bonuses[arg_7_1].status == NationalGiftEnum.Status.HasGet
end

function var_0_0.isBonusCouldGet(arg_8_0, arg_8_1)
	return arg_8_0.bonuses[arg_8_1] and arg_8_0.bonuses[arg_8_1].status == NationalGiftEnum.Status.CouldGet
end

return var_0_0
