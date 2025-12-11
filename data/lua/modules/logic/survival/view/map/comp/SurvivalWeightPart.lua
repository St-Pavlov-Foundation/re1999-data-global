module("modules.logic.survival.view.map.comp.SurvivalWeightPart", package.seeall)

local var_0_0 = class("SurvivalWeightPart", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	if arg_1_1 == nil then
		arg_1_1 = SurvivalShelterModel.instance:getWeekInfo():getBag(SurvivalEnum.ItemSource.Map)
	end

	arg_1_0.bag = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._anim = gohelper.findChildAnim(arg_2_1, "")
	arg_2_0._scrollbar = gohelper.findChildScrollbar(arg_2_1, "Scrollbar Horizon")
	arg_2_0._image_zhizhen = gohelper.findChildImage(arg_2_1, "Scrollbar Horizon/Sliding Area/Handle/#image_zhizhen")
	arg_2_0._image_icon = gohelper.findChildImage(arg_2_1, "#image_icon")
	arg_2_0._txtmass1 = gohelper.findChildTextMesh(arg_2_1, "#go_mass/#txt_mass1")
	arg_2_0._txtmass2 = gohelper.findChildTextMesh(arg_2_1, "#go_mass/#txt_mass2")
	arg_2_0._txtmass3 = gohelper.findChildTextMesh(arg_2_1, "#go_mass/#txt_mass3")

	arg_2_0:refreshView()
end

function var_0_0.addEventListeners(arg_3_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapBagUpdate, arg_3_0.refreshView, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapBagUpdate, arg_4_0.refreshView, arg_4_0)
end

function var_0_0.refreshView(arg_5_0)
	local var_5_0 = arg_5_0.bag
	local var_5_1 = var_5_0.maxWeightLimit + SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.AttrWeight)
	local var_5_2 = var_5_0.totalMass / var_5_1
	local var_5_3 = string.format("%s/%s", var_5_0.totalMass, var_5_1)
	local var_5_4 = 1

	if var_5_2 > 1 then
		var_5_4 = 3
	end

	for iter_5_0 = 1, 3 do
		if iter_5_0 == var_5_4 then
			arg_5_0["_txtmass" .. iter_5_0].text = var_5_3
		else
			arg_5_0["_txtmass" .. iter_5_0].text = ""
		end
	end

	UISpriteSetMgr.instance:setSurvivalSprite(arg_5_0._image_icon, "survival_bag_heavyicon_" .. var_5_4)
	UISpriteSetMgr.instance:setSurvivalSprite(arg_5_0._image_zhizhen, "survival_bag_zhizhen_" .. var_5_4)

	local var_5_5 = Mathf.Clamp01(var_5_2)

	arg_5_0._scrollbar:SetValue(var_5_5)

	if arg_5_0._anim then
		arg_5_0._anim:Play("step" .. var_5_4, 0, 0)
	end
end

return var_0_0
