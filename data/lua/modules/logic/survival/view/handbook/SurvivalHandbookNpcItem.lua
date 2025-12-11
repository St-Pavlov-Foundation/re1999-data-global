module("modules.logic.survival.view.handbook.SurvivalHandbookNpcItem", package.seeall)

local var_0_0 = class("SurvivalHandbookNpcItem", LuaCompBase)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.animGo = gohelper.findComponentAnim(arg_2_1)
	arg_2_0.empty = gohelper.findChild(arg_2_1, "#empty")
	arg_2_0.normal = gohelper.findChild(arg_2_1, "#normal")
	arg_2_0.image_quality = gohelper.findChildImage(arg_2_1, "#normal/#image_quality")
	arg_2_0.image_Chess = gohelper.findChildSingleImage(arg_2_1, "#normal/#image_Chess")
	arg_2_0.txt_PartnerName = gohelper.findChildTextMesh(arg_2_1, "#txt_PartnerName")
	arg_2_0.btnClick = gohelper.findChildButtonWithAudio(arg_2_1, "#btnClick")
	arg_2_0.go_rewardinherit = gohelper.findChild(arg_2_1, "#normal/#go_rewardinherit")
	arg_2_0.go_Selected = gohelper.findChild(arg_2_0.go_rewardinherit, "#go_Selected")
	arg_2_0.go_Mark = gohelper.findChild(arg_2_1, "#go_Mark")
	arg_2_0.go_score = gohelper.findChild(arg_2_1, "#normal/#go_score")
	arg_2_0.txt_score = gohelper.findChildTextMesh(arg_2_0.go_score, "#txt_score")
end

function var_0_0.onStart(arg_3_0)
	return
end

function var_0_0.updateMo(arg_4_0, arg_4_1)
	if arg_4_1 == nil then
		gohelper.setActive(arg_4_0.go, false)

		return
	end

	gohelper.setActive(arg_4_0.go, true)

	arg_4_0.mo = arg_4_1
	arg_4_0.itemMo = arg_4_1:getSurvivalBagItemMo()

	gohelper.setActive(arg_4_0.empty, not arg_4_0.mo.isUnlock)
	gohelper.setActive(arg_4_0.normal, arg_4_0.mo.isUnlock)

	if not arg_4_0.mo.isUnlock then
		gohelper.setActive(arg_4_0.txt_PartnerName, false)

		return
	end

	UISpriteSetMgr.instance:setSurvivalSprite(arg_4_0.image_quality, string.format("survival_bag_itemquality2_%s", arg_4_0.itemMo.npcCo.rare))
	SurvivalUnitIconHelper.instance:setNpcIcon(arg_4_0.image_Chess, arg_4_0.itemMo.npcCo.headIcon)
	arg_4_0:refreshName()
end

function var_0_0.showExtendCost(arg_5_0)
	gohelper.setActive(arg_5_0.go_score, true)

	arg_5_0.txt_score.text = arg_5_0.itemMo:getExtendCost()
end

function var_0_0.refreshName(arg_6_0)
	local var_6_0 = SLFramework.UGUI.GuiHelper.GetPreferredWidth(arg_6_0.txt_PartnerName, "...") + 0.1
	local var_6_1 = GameUtil.getBriefNameByWidth(arg_6_0.itemMo.npcCo.name, arg_6_0.txt_PartnerName, var_6_0, "...")

	gohelper.setActive(arg_6_0.txt_PartnerName, true)

	arg_6_0.txt_PartnerName.text = var_6_1
end

function var_0_0.addEventListeners(arg_7_0)
	arg_7_0.btnClick:AddClickListener(arg_7_0._onItemClick, arg_7_0)
end

function var_0_0.removeEventListeners(arg_8_0)
	arg_8_0.btnClick:RemoveClickListener()
end

function var_0_0.onDestroy(arg_9_0)
	return
end

function var_0_0.setClickCallback(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._callBack = arg_10_1
	arg_10_0._callObj = arg_10_2
end

function var_0_0._onItemClick(arg_11_0)
	if arg_11_0._callBack then
		arg_11_0._callBack(arg_11_0._callObj, arg_11_0)
	end
end

function var_0_0.setRewardInherit(arg_12_0, arg_12_1)
	gohelper.setActive(arg_12_0.go_rewardinherit, true)
	gohelper.setActive(arg_12_0.go_Selected, arg_12_1)
end

function var_0_0.setSelect(arg_13_0, arg_13_1)
	gohelper.setActive(arg_13_0.go_Mark, arg_13_1)
end

return var_0_0
