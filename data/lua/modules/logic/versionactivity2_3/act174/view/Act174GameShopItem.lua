module("modules.logic.versionactivity2_3.act174.view.Act174GameShopItem", package.seeall)

local var_0_0 = class("Act174GameShopItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.anim = arg_1_1:GetComponent(gohelper.Type_Animator)
	arg_1_0.btnClick = gohelper.findChildButtonWithAudio(arg_1_1, "btn_Click")
	arg_1_0.txtCost = gohelper.findChildText(arg_1_1, "btn_Buy/txt_Cost")
	arg_1_0.goSoldOut = gohelper.findChild(arg_1_1, "go_SellOut")

	for iter_1_0 = 1, 7 do
		arg_1_0["goType" .. iter_1_0] = gohelper.findChild(arg_1_1, "type" .. iter_1_0)
	end

	arg_1_0.roleItemList = {}

	for iter_1_1 = 1, 3 do
		for iter_1_2 = 1, iter_1_1 do
			local var_1_0 = gohelper.findChild(arg_1_0["goType" .. iter_1_1], "role" .. iter_1_2)
			local var_1_1 = arg_1_0:getUserDataTb_()

			var_1_1.imageRare = gohelper.findChildImage(var_1_0, "rare")
			var_1_1.heroIcon = gohelper.findChildSingleImage(var_1_0, "heroicon")
			var_1_1.imageCareer = gohelper.findChildImage(var_1_0, "career")
			arg_1_0.roleItemList[#arg_1_0.roleItemList + 1] = var_1_1
		end
	end

	arg_1_0.roleCareerList = {}

	for iter_1_3 = 4, 7 do
		for iter_1_4 = 1, 3 do
			local var_1_2 = gohelper.findChild(arg_1_0["goType" .. iter_1_3], iter_1_4)
			local var_1_3 = gohelper.findChildImage(var_1_2, "career")

			arg_1_0.roleCareerList[#arg_1_0.roleCareerList + 1] = var_1_3
		end
	end

	arg_1_0.collectionRare = gohelper.findChildImage(arg_1_0.goType4, "collection/rare")
	arg_1_0.collectionIcon = gohelper.findChildSingleImage(arg_1_0.goType4, "collection/collectionicon")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClick, arg_2_0.onClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnClick)
end

function var_0_0.onDestroy(arg_4_0)
	arg_4_0.collectionIcon:UnLoadImage()

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.roleItemList) do
		iter_4_1.heroIcon:UnLoadImage()
	end
end

function var_0_0.setData(arg_5_0, arg_5_1)
	arg_5_0.goodInfo = arg_5_1

	if arg_5_1 then
		arg_5_0.actId = Activity174Model.instance:getCurActId()
		arg_5_0.gameInfo = Activity174Model.instance:getActInfo():getGameInfo()
		arg_5_0.type = arg_5_0:inferBagType()

		arg_5_0:refreshCost()

		local var_5_0 = arg_5_1.bagInfo.heroId

		table.sort(var_5_0, var_0_0.sortFunc)

		if arg_5_0.type == 1 then
			arg_5_0:refreshRoleItem(arg_5_0.roleItemList[1], var_5_0[1])
		elseif arg_5_0.type == 2 then
			arg_5_0:refreshRoleItem(arg_5_0.roleItemList[2], var_5_0[1])
			arg_5_0:refreshRoleItem(arg_5_0.roleItemList[3], var_5_0[2])
		elseif arg_5_0.type == 3 then
			arg_5_0:refreshRoleItem(arg_5_0.roleItemList[4], var_5_0[1])
			arg_5_0:refreshRoleItem(arg_5_0.roleItemList[5], var_5_0[2])
			arg_5_0:refreshRoleItem(arg_5_0.roleItemList[6], var_5_0[3])
		elseif arg_5_0.type == 4 then
			local var_5_1 = arg_5_1.bagInfo.itemId[1]
			local var_5_2 = lua_activity174_collection.configDict[var_5_1]

			UISpriteSetMgr.instance:setAct174Sprite(arg_5_0.collectionRare, "act174_propitembg_" .. var_5_2.rare)
			arg_5_0.collectionIcon:LoadImage(ResUrl.getRougeSingleBgCollection(var_5_2.icon))
		elseif arg_5_0.type == 5 then
			arg_5_0:refreshRoleCareer(arg_5_0.roleCareerList[1], var_5_0[1])
		elseif arg_5_0.type == 6 then
			arg_5_0:refreshRoleCareer(arg_5_0.roleCareerList[2], var_5_0[1])
			arg_5_0:refreshRoleCareer(arg_5_0.roleCareerList[3], var_5_0[2])
		elseif arg_5_0.type == 7 then
			arg_5_0:refreshRoleCareer(arg_5_0.roleCareerList[4], var_5_0[1])
			arg_5_0:refreshRoleCareer(arg_5_0.roleCareerList[5], var_5_0[2])
			arg_5_0:refreshRoleCareer(arg_5_0.roleCareerList[6], var_5_0[3])
		end

		for iter_5_0 = 1, 7 do
			gohelper.setActive(arg_5_0["goType" .. iter_5_0], iter_5_0 == arg_5_0.type)
		end
	end

	gohelper.setActive(arg_5_0.go, arg_5_1)
end

function var_0_0.refreshCost(arg_6_0)
	local var_6_0 = "#211F1F"
	local var_6_1 = arg_6_0.goodInfo.buyCost

	if var_6_1 > arg_6_0.gameInfo.coin then
		var_6_0 = "#be4343"
	end

	gohelper.setActive(arg_6_0.goSoldOut, arg_6_0.goodInfo.finish)
	SLFramework.UGUI.GuiHelper.SetColor(arg_6_0.txtCost, var_6_0)

	arg_6_0.txtCost.text = var_6_1
end

function var_0_0.onClick(arg_7_0)
	if arg_7_0.goodInfo.finish then
		return
	end

	if arg_7_0.type == 4 then
		local var_7_0 = arg_7_0.goodInfo.bagInfo.itemId[1]
		local var_7_1 = {
			type = Activity174Enum.ItemTipType.Collection,
			co = Activity174Config.instance:getCollectionCo(var_7_0),
			pos = Vector2.New(518, 0)
		}

		var_7_1.showMask = true
		var_7_1.goodInfo = arg_7_0.goodInfo

		Activity174Controller.instance:openItemTipView(var_7_1)
	elseif arg_7_0.type == 1 or arg_7_0.type == 2 or arg_7_0.type == 3 then
		local var_7_2 = {
			type = Activity174Enum.ItemTipType.Character1,
			co = arg_7_0.goodInfo.bagInfo.heroId,
			pos = Vector2.New(479, 0)
		}

		var_7_2.showMask = true
		var_7_2.goodInfo = arg_7_0.goodInfo

		Activity174Controller.instance:openItemTipView(var_7_2)
	elseif arg_7_0.type == 5 or arg_7_0.type == 6 or arg_7_0.type == 7 then
		local var_7_3 = arg_7_0.goodInfo.bagInfo
		local var_7_4 = {
			type = Activity174Enum.ItemTipType.Character2,
			co = lua_activity174_bag.configDict[var_7_3.bagId],
			pos = Vector2.New(518, 0)
		}

		var_7_4.showMask = true
		var_7_4.goodInfo = arg_7_0.goodInfo

		Activity174Controller.instance:openItemTipView(var_7_4)
	end
end

function var_0_0.inferBagType(arg_8_0)
	local var_8_0 = arg_8_0.goodInfo.bagInfo
	local var_8_1 = lua_activity174_bag.configDict[var_8_0.bagId]

	if var_8_1.type == Activity174Enum.BagType.Hero then
		if var_8_1.heroType == "quality" then
			return #var_8_0.heroId + 4
		end

		return #var_8_0.heroId
	elseif var_8_1.type == Activity174Enum.BagType.Collection then
		return 4
	end
end

function var_0_0.refreshRoleItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = Activity174Config.instance:getRoleCo(arg_9_2)

	arg_9_1.heroIcon:LoadImage(ResUrl.getHeadIconSmall(var_9_0.skinId))
	UISpriteSetMgr.instance:setCommonSprite(arg_9_1.imageRare, "bgequip" .. tostring(CharacterEnum.Color[var_9_0.rare]))
	UISpriteSetMgr.instance:setCommonSprite(arg_9_1.imageCareer, "lssx_" .. var_9_0.career)
end

function var_0_0.refreshRoleCareer(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = Activity174Config.instance:getRoleCo(arg_10_2)

	UISpriteSetMgr.instance:setCommonSprite(arg_10_1, "lssx_" .. var_10_0.career)
end

function var_0_0.sortFunc(arg_11_0, arg_11_1)
	local var_11_0 = Activity174Config.instance:getRoleCo(arg_11_0)
	local var_11_1 = Activity174Config.instance:getRoleCo(arg_11_1)

	if var_11_0.rare == var_11_1.rare then
		return arg_11_1 < arg_11_0
	else
		return var_11_0.rare > var_11_1.rare
	end
end

return var_0_0
