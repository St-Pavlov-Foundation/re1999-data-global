module("modules.logic.fight.view.FightViewTempOperateCardItem", package.seeall)

local var_0_0 = class("FightViewTempOperateCardItem", UserDataDispose)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0:__onInit()

	arg_1_0.viewGo = arg_1_1
	arg_1_0.cardGo = gohelper.findChild(arg_1_1, "card")
	arg_1_0.skillId = arg_1_2
	arg_1_0.entityId = arg_1_3

	arg_1_0:initView()
end

function var_0_0.initView(arg_2_0)
	arg_2_0.lvGoList = arg_2_0:getUserDataTb_()
	arg_2_0.lvImgCompList = arg_2_0:getUserDataTb_()

	for iter_2_0 = 0, 4 do
		local var_2_0 = gohelper.findChild(arg_2_0.cardGo, "lv" .. iter_2_0)
		local var_2_1 = gohelper.findChildSingleImage(var_2_0, "imgIcon")

		gohelper.setActive(var_2_0, true)

		arg_2_0.lvGoList[iter_2_0] = var_2_0
		arg_2_0.lvImgCompList[iter_2_0] = var_2_1
	end
end

function var_0_0.refreshCardIcon(arg_3_0)
	local var_3_0 = lua_skill.configDict[arg_3_0.skillId]
	local var_3_1 = FightCardDataHelper.getSkillLv(arg_3_0.entityId, arg_3_0.skillId)

	for iter_3_0, iter_3_1 in pairs(arg_3_0.lvGoList) do
		gohelper.setActive(iter_3_1, true)
		gohelper.setActiveCanvasGroup(iter_3_1, var_3_1 == iter_3_0)
	end

	local var_3_2 = ResUrl.getSkillIcon(var_3_0.icon)

	for iter_3_2, iter_3_3 in pairs(arg_3_0.lvImgCompList) do
		iter_3_3:LoadImage(var_3_2)
	end
end

function var_0_0.onDispose(arg_4_0)
	if arg_4_0.lvImgCompList then
		for iter_4_0, iter_4_1 in pairs(arg_4_0.lvImgCompList) do
			iter_4_1:UnLoadImage()
		end
	end

	arg_4_0:__onDispose()
end

return var_0_0
