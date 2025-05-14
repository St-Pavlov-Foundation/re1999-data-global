module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotNormalStoreGoodsView", package.seeall)

local var_0_0 = class("V1a6_CachotNormalStoreGoodsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/propinfo/#simage_icon")
	arg_1_0._imageiconbg = gohelper.findChildImage(arg_1_0.viewGO, "root/propinfo/#image_iconbg")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "root/propinfo/#image_icon")
	arg_1_0._txtdesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/propinfo/scroll_info/Viewport/Content/#txt_goodsUseDesc")
	arg_1_0._txtname = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/propinfo/#txt_goodsNameCn")
	arg_1_0._txtorginalcost = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/#go_buy/cost/#txt_originalCost/#txt_salePrice")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")
	arg_1_0._btnBuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_buy/#btn_buy")
	arg_1_0._goenchantlist = gohelper.findChild(arg_1_0.viewGO, "root/propinfo/#go_enchantlist")
	arg_1_0._gohole = gohelper.findChild(arg_1_0.viewGO, "root/propinfo/#go_enchantlist/#go_hole")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0._btnBuy:AddClickListener(arg_2_0.onBuyClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnBuy:RemoveClickListener()
end

local var_0_1 = "#6F3C0F"
local var_0_2 = "#2B4E6C"

function var_0_0.onOpen(arg_4_0)
	local var_4_0 = arg_4_0.viewParam
	local var_4_1 = V1a6_CachotModel.instance:getRogueInfo().coin

	arg_4_0._enoughCoin = var_4_1 >= var_4_0.price

	if var_4_1 < var_4_0.price then
		arg_4_0._txtorginalcost.text = string.format("<color=#BF2E11>%s</color>", var_4_0.price)
	else
		arg_4_0._txtorginalcost.text = var_4_0.price
	end

	gohelper.setActive(arg_4_0._simageicon, false)
	gohelper.setActive(arg_4_0._goenchantlist, false)

	arg_4_0._imageicon.enabled = false

	if var_4_0.creator ~= 0 then
		gohelper.setActive(arg_4_0._simageicon, true)
		gohelper.setActive(arg_4_0._goenchantlist, true)

		local var_4_2 = lua_rogue_collection.configDict[var_4_0.creator]

		arg_4_0._txtdesc.text = V1a6_CachotCollectionConfig.instance:getCollectionSkillsContent(var_4_2, nil, var_0_1, var_0_2)
		arg_4_0._txtname.text = var_4_2.name

		arg_4_0._simageicon:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. var_4_2.icon))

		local var_4_3 = lua_rogue_event_drop_desc.configDict[V1a6_CachotEnum.DropType.Collection][1]

		UISpriteSetMgr.instance:setV1a6CachotSprite(arg_4_0._imageiconbg, var_4_3.iconbg)
		V1a6_CachotCollectionHelper.createCollectionHoles(var_4_2, arg_4_0._goenchantlist, arg_4_0._gohole)
	elseif var_4_0.event ~= 0 then
		arg_4_0._imageicon.enabled = true

		local var_4_4, var_4_5 = V1a6_CachotEventConfig.instance:getDescCoByEventId(var_4_0.event)

		if var_4_4 then
			arg_4_0._txtname.text = var_4_4.title
			arg_4_0._txtdesc.text = HeroSkillModel.instance:skillDesToSpot(var_4_5 or var_4_4.desc, var_0_1, var_0_2)

			UISpriteSetMgr.instance:setV1a6CachotSprite(arg_4_0._imageicon, var_4_4.icon)
			UISpriteSetMgr.instance:setV1a6CachotSprite(arg_4_0._imageiconbg, var_4_4.iconbg)
		else
			logError("未处理事件 " .. var_4_0.event)
		end
	else
		logError("肉鸽商品配置错误 id" .. var_4_0.id)
	end
end

function var_0_0.onBuyClick(arg_5_0)
	if not arg_5_0._enoughCoin then
		GameFacade.showToast(ToastEnum.V1a6CachotToast09)

		return
	end

	RogueRpc.instance:sendBuyRogueGoodsRequest(V1a6_CachotEnum.ActivityId, arg_5_0.viewParam.id, 1, arg_5_0.closeThis, arg_5_0)
end

function var_0_0.onClickModalMask(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0.onDestroyView(arg_7_0)
	arg_7_0._simageicon:UnLoadImage()
end

return var_0_0
