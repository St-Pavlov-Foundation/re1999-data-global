module("modules.ugui.icon.common.CommonMonsterItem", package.seeall)

local var_0_0 = class("CommonMonsterItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._callback = nil
	arg_1_0._callbackObj = nil
	arg_1_0._btnClick = nil
	arg_1_0._lvTxt = gohelper.findChildText(arg_1_1, "lvltxt") or gohelper.findChildText(arg_1_1, "verticalList/lvnum")
	arg_1_0._nameCnTxt = gohelper.findChildText(arg_1_1, "namecn")
	arg_1_0._cardIcon = gohelper.findChildSingleImage(arg_1_1, "charactericon")
	arg_1_0._careerIcon = gohelper.findChildImage(arg_1_1, "career")
	arg_1_0._rareObj = gohelper.findChild(arg_1_1, "rareobj")
	arg_1_0._rareIconImage = gohelper.findChildImage(arg_1_1, "cardrare")
	arg_1_0._front = gohelper.findChildImage(arg_1_1, "front")
	arg_1_0._rankObj = gohelper.findChild(arg_1_1, "rankobj")

	arg_1_0:_initObj()
end

function var_0_0._initObj(arg_2_0)
	if arg_2_0._rareObj then
		arg_2_0._rareGos = arg_2_0:getUserDataTb_()

		for iter_2_0 = 1, 5 do
			arg_2_0._rareGos[iter_2_0] = gohelper.findChild(arg_2_0._rareObj, "rare" .. tostring(iter_2_0))
		end
	end

	arg_2_0._rankGOs = arg_2_0:getUserDataTb_()

	for iter_2_1 = 1, 3 do
		local var_2_0 = gohelper.findChild(arg_2_0._rankObj, "rank" .. iter_2_1)

		table.insert(arg_2_0._rankGOs, var_2_0)
	end
end

function var_0_0._fillStarContent(arg_3_0, arg_3_1)
	local var_3_0, var_3_1 = HeroConfig.instance:getShowLevel(arg_3_1)

	for iter_3_0 = 1, 3 do
		local var_3_2 = arg_3_0._rankGOs[iter_3_0]

		gohelper.setActive(var_3_2, iter_3_0 == var_3_1 - 1)
	end
end

function var_0_0.addClickListener(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._callback = arg_4_1
	arg_4_0._callbackObj = arg_4_2

	if not arg_4_0._btnClick then
		arg_4_0._btnClick = SLFramework.UGUI.UIClickListener.Get(arg_4_0.go)
	end

	arg_4_0._btnClick:AddClickListener(arg_4_0._onItemClick, arg_4_0)
end

function var_0_0.removeClickListener(arg_5_0)
	arg_5_0._callback = nil
	arg_5_0._callbackObj = nil

	if arg_5_0._btnClick then
		arg_5_0._btnClick:RemoveClickListener()
	end
end

function var_0_0.removeEventListeners(arg_6_0)
	if arg_6_0._btnClick then
		arg_6_0._btnClick:RemoveClickListener()
	end
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0._monsterCO = arg_7_1

	local var_7_0 = HeroConfig.instance:getShowLevel(arg_7_1.level)

	arg_7_0._lvTxt.text = var_7_0

	if arg_7_0._nameCnTxt then
		arg_7_0._nameCnTxt.text = arg_7_1.name
	end

	local var_7_1 = FightConfig.instance:getSkinCO(arg_7_1.skinId)

	if var_7_1 then
		arg_7_0._cardIcon:LoadImage(ResUrl.getHeadIconLarge(var_7_1.retangleIcon))
	end

	UISpriteSetMgr.instance:setCommonSprite(arg_7_0._careerIcon, "lssx_" .. tostring(arg_7_1.career))
	UISpriteSetMgr.instance:setHeroGroupSprite(arg_7_0._front, "bg_pz00" .. "1")

	if arg_7_0._rareObj then
		arg_7_0:_fillRareContent(arg_7_1.rare)
		gohelper.setActive(arg_7_0._rareObj, arg_7_1.rare >= 0)
	end

	if arg_7_0._nameCnTxt then
		gohelper.setActive(arg_7_0._nameCnTxt.gameObject, not string.nilorempty(arg_7_1.name))
	end

	if arg_7_0._rankObj then
		arg_7_0:_fillStarContent(arg_7_1.level)
	end
end

function var_0_0._fillRareContent(arg_8_0, arg_8_1)
	for iter_8_0 = 1, 5 do
		gohelper.setActive(arg_8_0._rareGos[iter_8_0], iter_8_0 <= arg_8_1)
	end
end

function var_0_0._onItemClick(arg_9_0)
	if arg_9_0._callback then
		if arg_9_0._callbackObj then
			arg_9_0._callback(arg_9_0._callbackObj, arg_9_0._monsterCO)
		else
			arg_9_0._callback(arg_9_0._monsterCO)
		end
	end
end

function var_0_0.onDestroy(arg_10_0)
	arg_10_0._cardIcon:UnLoadImage()
end

return var_0_0
