module("modules.logic.rouge.map.view.fightsucc.RougeFightSuccessHeroItem", package.seeall)

local var_0_0 = class("RougeFightSuccessHeroItem", RougeLuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0.go = arg_1_1
	arg_1_0.slider = gohelper.findChildSlider(arg_1_1, "#slider_hp")
	arg_1_0.simageRole = gohelper.findChildSingleImage(arg_1_1, "hero/#simage_rolehead")
	arg_1_0.goDead = gohelper.findChild(arg_1_1, "#go_dead")
end

function var_0_0.refreshHero(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1 and arg_2_1.heroId

	if var_2_0 ~= 0 then
		gohelper.setActive(arg_2_0.go, true)

		local var_2_1 = arg_2_0:getHeroHeadIcon(var_2_0)

		arg_2_0.simageRole:LoadImage(ResUrl.getRoomHeadIcon(var_2_1))

		local var_2_2 = RougeModel.instance:getFightResultInfo()
		local var_2_3 = var_2_2 and var_2_2:getLife(var_2_0)

		if var_2_3 <= 0 then
			arg_2_0.slider:SetValue(0)
			gohelper.setActive(arg_2_0.goDead, true)
		else
			arg_2_0.slider:SetValue(var_2_3 / 1000)
			gohelper.setActive(arg_2_0.goDead, false)
		end

		arg_2_0:tickUpdateDLCs(arg_2_1)
	end
end

function var_0_0.getHeroHeadIcon(arg_3_0, arg_3_1)
	local var_3_0 = RougeModel.instance:getTeamInfo()
	local var_3_1 = var_3_0 and var_3_0:isAssistHero(arg_3_1)
	local var_3_2

	if var_3_1 then
		var_3_2 = var_3_0:getAssistHeroMo()
	else
		var_3_2 = HeroModel.instance:getByHeroId(arg_3_1)
	end

	local var_3_3 = var_3_2 and var_3_2.skin
	local var_3_4 = var_3_3 and lua_skin.configDict[var_3_3]

	return var_3_4 and var_3_4.headIcon or arg_3_1 .. "01"
end

function var_0_0.onDestroyView(arg_4_0)
	arg_4_0.simageRole:UnLoadImage()
end

return var_0_0
