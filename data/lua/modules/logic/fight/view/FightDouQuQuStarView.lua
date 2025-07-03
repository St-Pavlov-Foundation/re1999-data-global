module("modules.logic.fight.view.FightDouQuQuStarView", package.seeall)

local var_0_0 = class("FightDouQuQuStarView", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.img = gohelper.findChildImage(arg_1_0.viewGO, "root/quality/bg/#image_quality")
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.onConstructor(arg_3_0, arg_3_1)
	arg_3_0.entityMO = arg_3_1
end

function var_0_0.refreshEntityMO(arg_4_0, arg_4_1)
	arg_4_0.entityMO = arg_4_1

	if arg_4_0.viewGO then
		arg_4_0:refreshStar()
	end
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0.customData = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act191]

	arg_5_0:refreshStar()
end

function var_0_0.refreshStar(arg_6_0)
	local var_6_0 = arg_6_0.customData.teamAHeroInfo
	local var_6_1 = 0

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		if tonumber(iter_6_0) == arg_6_0.entityMO.modelId then
			var_6_1 = string.splitToNumber(iter_6_1, "#")[1]

			break
		end
	end

	if var_6_1 == 0 then
		gohelper.setActive(arg_6_0.viewGO, false)

		return
	end

	gohelper.setActive(arg_6_0.viewGO, true)

	arg_6_0.img.fillAmount = var_6_1 / Activity191Enum.CharacterMaxStar
end

return var_0_0
