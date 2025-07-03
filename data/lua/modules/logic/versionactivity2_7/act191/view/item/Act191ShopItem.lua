module("modules.logic.versionactivity2_7.act191.view.item.Act191ShopItem", package.seeall)

local var_0_0 = class("Act191ShopItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.shopView = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.anim = arg_2_1:GetComponent(gohelper.Type_Animator)
	arg_2_0.type1 = gohelper.findChild(arg_2_1, "type1")
	arg_2_0.type2 = gohelper.findChild(arg_2_1, "type2")
	arg_2_0.type3 = gohelper.findChild(arg_2_1, "type3")
	arg_2_0.txtCost = gohelper.findChildText(arg_2_1, "cost/txt_Cost")
	arg_2_0.goSoldOut = gohelper.findChild(arg_2_1, "go_SellOut")
	arg_2_0.goMax = gohelper.findChild(arg_2_1, "go_Max")
	arg_2_0.goUp = gohelper.findChild(arg_2_1, "go_Up")
	arg_2_0.goSelect = gohelper.findChild(arg_2_1, "go_Select")
	arg_2_0.btnClick = gohelper.findChildButtonWithAudio(arg_2_1, "btn_Click")
	arg_2_0.headItemList = {}

	local var_2_0 = {
		noClick = true,
		noFetter = true
	}

	for iter_2_0 = 1, 4 do
		local var_2_1 = iter_2_0 == 1 and arg_2_0.type1 or arg_2_0.type2
		local var_2_2 = iter_2_0 == 1 and iter_2_0 or iter_2_0 - 1
		local var_2_3 = gohelper.findChild(var_2_1, "role" .. var_2_2)
		local var_2_4 = arg_2_0.shopView:getResInst(Activity191Enum.PrefabPath.HeroHeadItem, var_2_3)
		local var_2_5 = MonoHelper.addNoUpdateLuaComOnceToGo(var_2_4, Act191HeroHeadItem, var_2_0)

		arg_2_0.headItemList[iter_2_0] = var_2_5
	end

	arg_2_0.simageCollection = gohelper.findChildSingleImage(arg_2_1, "type3/collectionicon")
	arg_2_0.goTag1 = gohelper.findChild(arg_2_1, "type3/go_Tag1")
	arg_2_0.txtTag1 = gohelper.findChildText(arg_2_1, "type3/go_Tag1/txt_Tag1")
	arg_2_0.goTag2 = gohelper.findChild(arg_2_1, "type3/go_Tag2")
	arg_2_0.txtTag2 = gohelper.findChildText(arg_2_1, "type3/go_Tag2/txt_Tag2")
	arg_2_0.goFetter = gohelper.findChild(arg_2_1, "fetter/go_Fetter")
	arg_2_0.fetterItemList = {}
	arg_2_0.highLightGoList = arg_2_0:getUserDataTb_()

	for iter_2_1 = 1, 3 do
		local var_2_6 = gohelper.cloneInPlace(arg_2_0.goFetter)
		local var_2_7 = MonoHelper.addNoUpdateLuaComOnceToGo(var_2_6, Act191FetterIconItem)

		var_2_7:setExtraParam({
			fromView = "Act191ShopView"
		})

		arg_2_0.fetterItemList[iter_2_1] = var_2_7
		arg_2_0.highLightGoList[iter_2_1] = gohelper.findChild(var_2_6, "go_select")
	end
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0:addClickCb(arg_3_0.btnClick, arg_3_0.onClick, arg_3_0)
end

function var_0_0.setIndex(arg_4_0, arg_4_1)
	arg_4_0.index = arg_4_1
end

function var_0_0.setData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.maxMark = false
	arg_5_0.expMark = false

	for iter_5_0 = 1, 3 do
		gohelper.setActive(arg_5_0["type" .. iter_5_0], false)
	end

	local var_5_0 = Activity191Model.instance:getActInfo():getGameInfo()

	arg_5_0.bestTag = var_5_0:getBestFetterTag()
	arg_5_0.soldOut = arg_5_2
	arg_5_0.cost = arg_5_1.cost
	arg_5_0.heroList = arg_5_1.heroList
	arg_5_0.itemList = arg_5_1.itemList
	arg_5_0.heroCnt = #arg_5_0.heroList
	arg_5_0.itemCnt = #arg_5_0.itemList
	arg_5_0.isHeroShop = arg_5_0.heroCnt > 0

	if arg_5_0.isHeroShop then
		if arg_5_0.heroCnt == 1 then
			local var_5_1 = arg_5_0.heroList[1]

			arg_5_0.headItemList[1]:setData(nil, var_5_1)

			if not arg_5_0.soldOut then
				local var_5_2 = arg_5_0.headItemList[1].config.roleId
				local var_5_3 = var_5_0:getHeroInfoInWarehouse(var_5_2, true)

				if var_5_3 then
					arg_5_0.maxMark = var_5_3.star == Activity191Enum.CharacterMaxStar
					arg_5_0.expMark = var_5_3.star ~= Activity191Enum.CharacterMaxStar
				end
			end

			arg_5_0:refreshFetter(arg_5_0.headItemList[1].config)
			gohelper.setActive(arg_5_0.type1, true)
		else
			arg_5_0.headItemList[2]:setData(nil, arg_5_0.heroList[1])
			arg_5_0.headItemList[3]:setData(nil, arg_5_0.heroList[2])
			arg_5_0.headItemList[4]:setData(nil, arg_5_0.heroList[3])
			arg_5_0:refreshFetter(arg_5_0.headItemList[2].config)
			gohelper.setActive(arg_5_0.type2, true)
		end
	else
		local var_5_4 = Activity191Config.instance:getCollectionCo(arg_5_0.itemList[1])

		if var_5_4 then
			arg_5_0.simageCollection:LoadImage(ResUrl.getRougeSingleBgCollection(var_5_4.icon))
			gohelper.setActive(arg_5_0.type3, true)

			if string.nilorempty(var_5_4.label) then
				gohelper.setActive(arg_5_0.goTag1, false)
				gohelper.setActive(arg_5_0.goTag2, false)
			else
				local var_5_5 = string.split(var_5_4.label, "#")

				for iter_5_1 = 1, 2 do
					local var_5_6 = var_5_5[iter_5_1]

					arg_5_0["txtTag" .. iter_5_1].text = var_5_6

					gohelper.setActive(arg_5_0["goTag" .. iter_5_1], var_5_6)
				end
			end

			arg_5_0:refreshFetter(var_5_4)
		end
	end

	if var_5_0.coin < arg_5_0.cost then
		SLFramework.UGUI.GuiHelper.SetColor(arg_5_0.txtCost, "#be4343")
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_5_0.txtCost, "#211f1f")
	end

	arg_5_0.txtCost.text = arg_5_0.cost

	gohelper.setActive(arg_5_0.goMax, arg_5_0.maxMark)
	gohelper.setActive(arg_5_0.goUp, arg_5_0.expMark)
	gohelper.setActive(arg_5_0.goSoldOut, arg_5_0.soldOut)
	gohelper.setActive(arg_5_0.go, true)
end

function var_0_0.refreshFetter(arg_6_0, arg_6_1)
	if string.nilorempty(arg_6_1.tag) then
		for iter_6_0 = 1, 3 do
			gohelper.setActive(arg_6_0.fetterItemList[iter_6_0].go, false)
		end

		return
	end

	local var_6_0 = string.split(arg_6_1.tag, "#")

	for iter_6_1 = 1, 3 do
		if var_6_0[iter_6_1] then
			arg_6_0.fetterItemList[iter_6_1]:setData(var_6_0[iter_6_1])

			if not arg_6_0.soldOut and arg_6_0.bestTag and arg_6_0.bestTag == var_6_0[iter_6_1] then
				gohelper.setActive(arg_6_0.highLightGoList[iter_6_1], true)
			else
				gohelper.setActive(arg_6_0.highLightGoList[iter_6_1], false)
			end
		end

		gohelper.setActive(arg_6_0.fetterItemList[iter_6_1].go, iter_6_1 <= #var_6_0)
	end
end

function var_0_0.onClick(arg_7_0)
	if arg_7_0.soldOut then
		return
	end

	local var_7_0 = {
		showBuy = true,
		index = arg_7_0.index,
		cost = arg_7_0.cost,
		toastId = arg_7_0.expMark and ToastEnum.Act191LevelUp or ToastEnum.Act191BuyTip
	}

	if arg_7_0.isHeroShop then
		var_7_0.heroList = arg_7_0.heroList

		Activity191Controller.instance:openHeroTipView(var_7_0)
	else
		var_7_0.itemId = arg_7_0.itemList[1]

		Activity191Controller.instance:openCollectionTipView(var_7_0)
	end

	local var_7_1 = arg_7_0.isHeroShop and "hero" or "other"

	Act191StatController.instance:statButtonClick("Act191ShopView", string.format("shopItem_%s_%s", var_7_1, arg_7_0.index))
end

function var_0_0.playFreshAnim(arg_8_0)
	arg_8_0.anim:Play("fresh", 0, 0)
end

return var_0_0
