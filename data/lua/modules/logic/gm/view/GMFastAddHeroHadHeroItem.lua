module("modules.logic.gm.view.GMFastAddHeroHadHeroItem", package.seeall)

local var_0_0 = class("GMFastAddHeroHadHeroItem", ListScrollCell)

var_0_0.SelectBgColor = GameUtil.parseColor("#EA4F4F")
var_0_0.NotSelectBgColor = GameUtil.parseColor("#B0B0B0")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.goClick = gohelper.getClick(arg_1_1)

	arg_1_0.goClick:AddClickListener(arg_1_0.onClickItem, arg_1_0)

	arg_1_0.bgImg = arg_1_1:GetComponent(gohelper.Type_Image)
	arg_1_0._txtName = gohelper.findChildText(arg_1_1, "#txt_heroname")
	arg_1_0._txtherolv = gohelper.findChildText(arg_1_1, "#txt_herolv")
	arg_1_0._txtherolabel = gohelper.findChildText(arg_1_1, "#txt_herolv/label")
	arg_1_0._txtranklv = gohelper.findChildText(arg_1_1, "#txt_ranklv")
	arg_1_0._txtranklabel = gohelper.findChildText(arg_1_1, "#txt_ranklv/label")
	arg_1_0._txttalentlv = gohelper.findChildText(arg_1_1, "#txt_talentlv")
	arg_1_0._txttalentlabel = gohelper.findChildText(arg_1_1, "#txt_talentlv/label")
	arg_1_0._txtexskilllv = gohelper.findChildText(arg_1_1, "#txt_exskilllv")
	arg_1_0._txtexskilllabel = gohelper.findChildText(arg_1_1, "#txt_exskilllv/label")
	arg_1_0.isSelect = false

	GMController.instance:registerCallback(GMController.Event.ChangeSelectHeroItem, arg_1_0.refreshSelect, arg_1_0)
end

function var_0_0.onUpdateMO(arg_2_0, arg_2_1)
	arg_2_0.mo = arg_2_1

	if GMFastAddHeroHadHeroItemModel.instance:getShowType() == GMFastAddHeroHadHeroItemModel.ShowType.Hero then
		local var_2_0 = arg_2_1

		arg_2_0._txtName.text = var_2_0.config.name .. "#" .. tostring(var_2_0.config.id)
		arg_2_0._txtherolv.text = var_2_0.level
		arg_2_0._txtranklabel.text = "洞悉:"
		arg_2_0._txtranklv.text = var_2_0.rank - 1
		arg_2_0._txttalentlabel.text = "共鸣:"
		arg_2_0._txttalentlv.text = var_2_0.talent
		arg_2_0._txtexskilllabel.text = "塑造:"
		arg_2_0._txtexskilllv.text = var_2_0.exSkillLevel
	else
		local var_2_1 = arg_2_1

		arg_2_0._txtName.text = var_2_1.config.name .. "#" .. tostring(var_2_1.config.id)
		arg_2_0._txtherolv.text = var_2_1.level
		arg_2_0._txtranklabel.text = "精炼:"
		arg_2_0._txtranklv.text = var_2_1.refineLv
		arg_2_0._txttalentlabel.text = "突破:"
		arg_2_0._txttalentlv.text = var_2_1.breakLv
		arg_2_0._txtexskilllabel.text = "uid:"
		arg_2_0._txtexskilllv.text = var_2_1.uid
	end

	arg_2_0:refreshSelect()
end

function var_0_0.onClickItem(arg_3_0)
	arg_3_0.isSelect = not arg_3_0.isSelect

	if arg_3_0.isSelect then
		GMFastAddHeroHadHeroItemModel.instance:changeSelectHeroItem(arg_3_0.mo)
		GMFastAddHeroHadHeroItemModel.instance:setSelectMo(arg_3_0.mo)
	else
		GMFastAddHeroHadHeroItemModel.instance:changeSelectHeroItem(nil)
		GMFastAddHeroHadHeroItemModel.instance:setSelectMo(nil)
	end
end

function var_0_0.refreshSelect(arg_4_0)
	local var_4_0 = GMFastAddHeroHadHeroItemModel.instance:getSelectMo()

	if var_4_0 then
		arg_4_0.isSelect = arg_4_0.mo.uid == var_4_0.uid
	else
		arg_4_0.isSelect = false
	end

	if arg_4_0.isSelect then
		arg_4_0.bgImg.color = var_0_0.SelectBgColor
	else
		arg_4_0.bgImg.color = var_0_0.NotSelectBgColor
	end
end

function var_0_0.onDestroy(arg_5_0)
	arg_5_0.goClick:RemoveClickListener()
	GMController.instance:unregisterCallback(GMController.Event.ChangeSelectHeroItem, arg_5_0.refreshSelect, arg_5_0)
end

return var_0_0
