module("modules.logic.survival.view.map.comp.SurvivalHeroHealthPart", package.seeall)

local var_0_0 = class("SurvivalHeroHealthPart", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._states = arg_1_0:getUserDataTb_()
	arg_1_0._statesimage = arg_1_0:getUserDataTb_()

	for iter_1_0 = 1, 3 do
		arg_1_0._states[iter_1_0] = gohelper.findChild(arg_1_1, "#go_hp/#go_State" .. iter_1_0)
		arg_1_0._statesimage[iter_1_0] = arg_1_0._states[iter_1_0].transform:GetChild(iter_1_0 - 1).gameObject:GetComponent(gohelper.Type_Image)
	end

	arg_1_0._goFrame1 = gohelper.findChild(arg_1_1, "#go_Frame/frame_hp1")
	arg_1_0._goFrame2 = gohelper.findChild(arg_1_1, "#go_Frame/frame_hp2")
	arg_1_0._goDead = gohelper.findChild(arg_1_1, "#go_dead")
	arg_1_0._txtHealth = gohelper.findChildTextMesh(arg_1_1, "#go_hp/txt_Health")
end

function var_0_0.setHeroId(arg_2_0, arg_2_1)
	local var_2_0 = SurvivalShelterModel.instance:getWeekInfo():getHeroMo(arg_2_1)
	local var_2_1, var_2_2 = var_2_0:getCurState()

	if var_2_2 > 0 and var_2_2 < 0.1 then
		var_2_2 = 0.1
	end

	for iter_2_0 = 1, 3 do
		gohelper.setActive(arg_2_0._states[iter_2_0], var_2_1 == iter_2_0)
	end

	if arg_2_0._statesimage[var_2_1] then
		arg_2_0._statesimage[var_2_1].fillAmount = var_2_2
	end

	gohelper.setActive(arg_2_0._goDead, var_2_1 == 0)
	gohelper.setActive(arg_2_0._goFrame1, var_2_0.status == SurvivalEnum.HeroStatu.Normal and var_2_1 == 2)
	gohelper.setActive(arg_2_0._goFrame2, var_2_0.status == SurvivalEnum.HeroStatu.Hurt and var_2_1 ~= 0)
end

function var_0_0.setTxtHealthWhite(arg_3_0)
	if gohelper.isNil(arg_3_0._txtHealth) then
		return
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_3_0._txtHealth, "#FFFFFF")
end

return var_0_0
