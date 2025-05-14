module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotStoreItem", package.seeall)

local var_0_0 = class("V1a6_CachotStoreItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._txtname = gohelper.findChildTextMesh(arg_1_1, "txt_name")
	arg_1_0._txtcost = gohelper.findChildTextMesh(arg_1_1, "txt_cost")
	arg_1_0._gosoldout = gohelper.findChild(arg_1_1, "go_soldout")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_1, "simage_icon")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_1, "image_icon")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_1, "btn_click")
	arg_1_0._goenchantlist = gohelper.findChild(arg_1_1, "go_enchantlist")
	arg_1_0._gohole = gohelper.findChild(arg_1_1, "go_enchantlist/go_hole")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._onClickItem, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1

	local var_4_0 = lua_rogue_goods.configDict[arg_4_1.id]

	gohelper.setActive(arg_4_0._simageicon, false)
	gohelper.setActive(arg_4_0._goenchantlist, false)

	arg_4_0._imageicon.enabled = false

	if var_4_0.creator ~= 0 then
		gohelper.setActive(arg_4_0._simageicon, true)

		local var_4_1 = lua_rogue_collection.configDict[var_4_0.creator]

		if not var_4_1 then
			logError("商店出售不存在的藏品" .. var_4_0.creator)

			return
		end

		arg_4_0._txtname.text = var_4_1.name

		arg_4_0._simageicon:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. var_4_1.icon))
		gohelper.setActive(arg_4_0._goenchantlist, true)
		V1a6_CachotCollectionHelper.createCollectionHoles(var_4_1, arg_4_0._goenchantlist, arg_4_0._gohole)
	elseif var_4_0.event ~= 0 then
		arg_4_0._imageicon.enabled = true

		local var_4_2 = V1a6_CachotEventConfig.instance:getDescCoByEventId(var_4_0.event)

		if var_4_2 then
			arg_4_0._txtname.text = var_4_2.title

			UISpriteSetMgr.instance:setV1a6CachotSprite(arg_4_0._imageicon, var_4_2.icon)
		else
			logError("未处理事件 " .. var_4_0.event)
		end
	else
		logError("肉鸽商品配置错误 id" .. var_4_0.id)
	end

	arg_4_0._txtcost.text = var_4_0.price

	gohelper.setActive(arg_4_0._gosoldout, arg_4_1.buyCount > 0)
end

function var_0_0._onClickItem(arg_5_0)
	ViewMgr.instance:openView(ViewName.V1a6_CachotNormalStoreGoodsView, lua_rogue_goods.configDict[arg_5_0._mo.id])
end

function var_0_0.onDestroy(arg_6_0)
	if arg_6_0._simageicon then
		arg_6_0._simageicon:UnLoadImage()
	end
end

return var_0_0
