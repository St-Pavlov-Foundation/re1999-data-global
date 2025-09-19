module("modules.logic.survival.view.map.SurvivalHeroHealthView", package.seeall)

local var_0_0 = class("SurvivalHeroHealthView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._slider2 = gohelper.findChildImage(arg_1_0.viewGO, "Bottom/#go_resistance/bg2")
	arg_1_0._imagebg = gohelper.findChildImage(arg_1_0.viewGO, "Bottom/#go_resistance/resistance")
	arg_1_0._anim = arg_1_0._imagebg:GetComponent(typeof(UnityEngine.Animation))
	arg_1_0._txtstatu = gohelper.findChildTextMesh(arg_1_0.viewGO, "Bottom/#go_resistance/resistance/#txt_resistance")
	arg_1_0._scrollbar = gohelper.findChildScrollbar(arg_1_0.viewGO, "Bottom/#go_resistance/Scrollbar Horizon")
end

function var_0_0.addEvents(arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnSurvivalHeroHealthUpdate, arg_2_0._refreshHealth, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnSurvivalHeroHealthUpdate, arg_3_0._refreshHealth, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0:_refreshHealth()
end

local var_0_1 = {
	"#C84827",
	"#C3C827",
	"#38CF6F"
}

function var_0_0._refreshHealth(arg_5_0)
	local var_5_0 = SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.HeroHealthMax)
	local var_5_1 = SurvivalShelterModel.instance:getWeekInfo()
	local var_5_2 = SurvivalMapModel.instance:getSceneMo().teamInfo
	local var_5_3 = 0
	local var_5_4 = 0

	for iter_5_0, iter_5_1 in ipairs(var_5_2.heros) do
		local var_5_5 = var_5_2:getHeroMo(iter_5_1)

		var_5_3 = var_5_3 + var_5_1:getHeroMo(var_5_5.heroId).health
		var_5_4 = var_5_4 + var_5_0
	end

	local var_5_6 = var_5_3 / var_5_4
	local var_5_7, var_5_8 = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.TeamHealthState)
	local var_5_9 = 1
	local var_5_10 = string.splitToNumber(var_5_7, "#")
	local var_5_11 = string.split(var_5_8, "#")

	for iter_5_2, iter_5_3 in ipairs(var_5_10) do
		if var_5_6 >= iter_5_3 / 100 then
			var_5_9 = iter_5_2
		end
	end

	local var_5_12 = var_5_11[var_5_9] or ""

	arg_5_0._scrollbar:SetValue(var_5_6)

	arg_5_0._slider2.fillAmount = var_5_6
	arg_5_0._imagebg.color = GameUtil.parseColor(var_0_1[var_5_9] or var_0_1[1])
	arg_5_0._txtstatu.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_mainview_teamhealth"), var_5_12)

	if arg_5_0.state and var_5_9 ~= arg_5_0.state then
		arg_5_0._anim:Play()
	end

	arg_5_0.state = var_5_9
end

return var_0_0
