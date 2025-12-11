module("modules.logic.survival.view.shelter.SurvivalBootyChooseNpcItem", package.seeall)

local var_0_0 = class("SurvivalBootyChooseNpcItem", ShelterTentManagerNpcItem)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	arg_1_0._imgQuality = gohelper.findChildImage(arg_1_0.viewGO, "#image_quality")
end

function var_0_0.onClickNpcItem(arg_2_0)
	if not arg_2_0.mo then
		return
	end

	if SurvivalShelterChooseNpcListModel.instance:isQuickSelect() then
		SurvivalShelterChooseNpcListModel.instance:quickSelectNpc(arg_2_0.mo.id)
	else
		SurvivalShelterChooseNpcListModel.instance:setSelectNpc(arg_2_0.mo.id)
		arg_2_0._view.viewContainer:refreshNpcChooseView()
	end
end

function var_0_0.refreshItem(arg_3_0, arg_3_1)
	local var_3_0 = SurvivalShelterChooseNpcListModel.instance:getSelectNpc()
	local var_3_1 = SurvivalShelterChooseNpcListModel.instance:npcIdIsSelect(arg_3_1.id)
	local var_3_2 = SurvivalShelterChooseNpcListModel.instance:isQuickSelect()

	gohelper.setActive(arg_3_0.goSelected, var_3_0 == arg_3_1.id and not var_3_2)
	gohelper.setActive(arg_3_0.goTips, var_3_1 ~= nil)

	if var_3_1 ~= nil then
		arg_3_0.txtBuildName.text = luaLang("SurvivalShelterChooseNpcItem_Tips")
	end

	arg_3_0.txtName.text = arg_3_1.co.name

	if not string.nilorempty(arg_3_1.co.headIcon) then
		SurvivalUnitIconHelper.instance:setNpcIcon(arg_3_0.imageNpc, arg_3_1.co.headIcon)
	end

	if arg_3_1.co.rare ~= nil then
		UISpriteSetMgr.instance:setSurvivalSprite(arg_3_0._imgQuality, string.format("survival_bag_itemquality2_%s", arg_3_1.co.rare))
	end
end

return var_0_0
