module("modules.logic.fight.view.FightItemSkillInfosItemView", package.seeall)

local var_0_0 = class("FightItemSkillInfosItemView", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.transform = arg_1_0.viewGO.transform
	arg_1_0.iconImg = gohelper.findChildImage(arg_1_0.viewGO, "#image_icon")
	arg_1_0.select = gohelper.findChild(arg_1_0.viewGO, "#go_select")
	arg_1_0.cd = gohelper.findChild(arg_1_0.viewGO, "#go_cd")
	arg_1_0.cdText = gohelper.findChildText(arg_1_0.viewGO, "#go_cd/#txt_cd")
	arg_1_0.lock = gohelper.findChild(arg_1_0.viewGO, "#go_lock")

	gohelper.setActive(arg_1_0.lock, false)

	arg_1_0.textNum = gohelper.findChildText(arg_1_0.viewGO, "num/#txt_num")
	arg_1_0.click = gohelper.findChildClick(arg_1_0.viewGO, "#btn_click")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0.tweenComp = arg_2_0:addComponent(FightTweenComponent)

	arg_2_0:com_registClick(arg_2_0.click, arg_2_0.onClick)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onClick(arg_4_0)
	arg_4_0.PARENT_VIEW:onItemClick(arg_4_0.data, arg_4_0.index)
end

function var_0_0.onConstructor(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.data = arg_5_1
	arg_5_0.index = arg_5_2
end

function var_0_0.onSelect(arg_6_0, arg_6_1)
	gohelper.setActive(arg_6_0.select, arg_6_1)

	local var_6_0 = 0.35
	local var_6_1 = EaseType.OutQuart

	if arg_6_1 then
		local var_6_2 = arg_6_0.transform.parent.localPosition.normalized
		local var_6_3 = 0

		if var_6_2.x < 0 then
			var_6_3 = -20
		elseif var_6_2.x > 0 then
			var_6_3 = 20
		end

		local var_6_4 = 0

		if var_6_2.y < 0 then
			var_6_4 = -20
		elseif var_6_2.y > 0 then
			var_6_4 = 20
		end

		arg_6_0.tweenComp:DOAnchorPos(arg_6_0.transform, var_6_3, var_6_4, var_6_0, nil, nil, nil, var_6_1)
	else
		arg_6_0.tweenComp:DOAnchorPos(arg_6_0.transform, 0, 0, var_6_0, nil, nil, nil, var_6_1)
	end
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = AssassinConfig.instance:getAssassinItemIcon(arg_7_0.data.itemId)

	UISpriteSetMgr.instance:setSp01AssassinSprite(arg_7_0.iconImg, var_7_0 .. "_1")

	local var_7_1 = arg_7_0.data.count > 0 and arg_7_0.data.count or string.format("<#dc5640>%d</color>", arg_7_0.data.count)

	arg_7_0.textNum.text = var_7_1

	gohelper.setActive(arg_7_0.cd, arg_7_0.data.cd > 0)

	arg_7_0.cdText.text = arg_7_0.data.cd
end

return var_0_0
