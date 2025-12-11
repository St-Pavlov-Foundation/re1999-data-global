module("modules.logic.survival.view.SurvivalBagItem", package.seeall)

local var_0_0 = class("SurvivalBagItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.goRoot = gohelper.findChild(arg_1_1, "root")
	arg_1_0._animGo = gohelper.findComponentAnim(arg_1_1)
	arg_1_0._animHas = gohelper.findChildAnim(arg_1_1, "root/has")
	arg_1_0._gonormal = gohelper.findChild(arg_1_1, "root/has")
	arg_1_0._goempty = gohelper.findChild(arg_1_1, "root/empty")
	arg_1_0._unknown = gohelper.findChild(arg_1_1, "root/unknown")
	arg_1_0._btnClick = gohelper.findChildButtonWithAudio(arg_1_1, "root/btn_Click")
	arg_1_0._txtnum = gohelper.findChildTextMesh(arg_1_1, "root/has/collection/#txt_num")
	arg_1_0._goqulity5 = gohelper.findChild(arg_1_1, "root/has/collection/#go_qulity")
	arg_1_0._goselect = gohelper.findChild(arg_1_1, "root/has/go_select")
	arg_1_0._goitem = gohelper.findChild(arg_1_0._gonormal, "collection")
	arg_1_0._imagerare = gohelper.findChildImage(arg_1_0._goitem, "image_Rare")
	arg_1_0._effect6 = gohelper.findChild(arg_1_0._goitem, "#go_deceffect")
	arg_1_0._simageitemicon = gohelper.findChildSingleImage(arg_1_0._goitem, "simage_Icon")
	arg_1_0._gotagitem = gohelper.findChild(arg_1_0._goitem, "go_tag/go_item")
	arg_1_0._gonpc = gohelper.findChild(arg_1_0._gonormal, "npc")
	arg_1_0._gotalent = gohelper.findChild(arg_1_0._gonormal, "Talent")
	arg_1_0._gosurvivalequiptag = gohelper.findChild(arg_1_0._gonormal, "go_tag")
	arg_1_0._simagenpcicon = gohelper.findChildSingleImage(arg_1_0._gonpc, "simage_Icon")
	arg_1_0._goadd = gohelper.findChild(arg_1_0.goRoot, "add")
	arg_1_0._goput = gohelper.findChild(arg_1_0.goRoot, "put")
	arg_1_0._goloading = gohelper.findChild(arg_1_1, "root/loading")
	arg_1_0._gosearching = gohelper.findChild(arg_1_1, "root/searching")
	arg_1_0._gocompose = gohelper.findChild(arg_1_0.goRoot, "compose")
	arg_1_0._goCollectionSelectTips = gohelper.findChild(arg_1_0._gonormal, "collection/#go_collection_select_Tips")
	arg_1_0._textName = gohelper.findChildTextMesh(arg_1_0.goRoot, "has/#textName")
	arg_1_0._go_rewardinherit = gohelper.findChild(arg_1_0.goRoot, "#go_rewardinherit")
	arg_1_0._go_rewardinherit_txt_name = gohelper.findChildTextMesh(arg_1_0._go_rewardinherit, "#txt_name")
	arg_1_0._go_rewardinherit_go_Selected = gohelper.findChild(arg_1_0._go_rewardinherit, "#go_Selected")

	gohelper.setActive(arg_1_0._go_rewardinherit, false)
	gohelper.setActive(arg_1_0._gotalent, false)
	gohelper.setActive(arg_1_0._goCollectionSelectTips, false)

	arg_1_0.defaultWidth = 172
	arg_1_0.defaultHeight = 172
	arg_1_0._goReputationShop = gohelper.findChild(arg_1_0.goRoot, "reputationShop")
	arg_1_0._go_canget = gohelper.findChild(arg_1_0._goReputationShop, "#go_canget")
	arg_1_0._go_receive = gohelper.findChild(arg_1_0._goReputationShop, "#go_receive")
	arg_1_0._go_hasget = gohelper.findChildAnim(arg_1_0._goReputationShop, "#go_receive/go_hasget")
	arg_1_0._go_price = gohelper.findChild(arg_1_0._goReputationShop, "#go_price")
	arg_1_0._text_price = gohelper.findChildTextMesh(arg_1_0._goReputationShop, "#go_price/#txt_price")
	arg_1_0._go_freeReward = gohelper.findChild(arg_1_0._goReputationShop, "#go_freeReward")
	arg_1_0.go_shop_price = gohelper.findChild(arg_1_0.goRoot, "#go_shop_price")
	arg_1_0.txt_price_shop = gohelper.findChildTextMesh(arg_1_0.go_shop_price, "#txt_price")
	arg_1_0.imagePrice = gohelper.findChildImage(arg_1_0.go_shop_price, "#txt_price/#imagePrice")
	arg_1_0.itemSubType_npc = gohelper.findChild(arg_1_0._gonormal, "itemSubType_npc")
	arg_1_0.recommend = gohelper.findChild(arg_1_0._gonormal, "recommend")
	arg_1_0.go_score = gohelper.findChild(arg_1_0.goRoot, "#go_score")
	arg_1_0.txt_score = gohelper.findChildTextMesh(arg_1_0.go_score, "#txt_score")
end

function var_0_0.getItemAnimators(arg_2_0)
	return {
		arg_2_0._animGo
	}
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btnClick:AddClickListener(arg_3_0._onItemClick, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnClick:RemoveClickListener()
end

function var_0_0.updateByItemId(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = SurvivalBagItemMo.New()

	var_5_0:init({
		id = arg_5_1,
		count = arg_5_2
	})
	arg_5_0:updateMo(var_5_0)
end

function var_0_0.updateMo(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2 = arg_6_2 or {}

	local var_6_0 = false

	if not arg_6_2.jumpAdd and arg_6_0._preUid and arg_6_1.uid == arg_6_0._preUid and arg_6_1.count > arg_6_0._preCount then
		var_6_0 = true
	end

	arg_6_0._mo = arg_6_1
	arg_6_0._preUid = arg_6_1.uid
	arg_6_0._preCount = arg_6_1.count

	local var_6_1 = arg_6_1:isEmpty() and not arg_6_2.forceShowIcon
	local var_6_2 = arg_6_1.isUnknown
	local var_6_3 = not var_6_1 and not var_6_2

	gohelper.setActive(arg_6_0._gonormal, var_6_3)

	if var_6_3 and arg_6_2.jumpAnimHas then
		arg_6_0._animHas:Play("open", 0, 1)
	end

	if not arg_6_2.jumpAnimHas and not var_6_1 and not var_6_2 then
		if arg_6_1.co.rare == 5 then
			arg_6_0._animHas:Play("opensp", 0, 1)
		else
			arg_6_0._animHas:Play("open", 0, 1)
		end
	end

	gohelper.setActive(arg_6_0._gocompose, false)
	gohelper.setActive(arg_6_0._gosearching, false)
	gohelper.setActive(arg_6_0._goput, false)
	gohelper.setActive(arg_6_0._goempty, var_6_1)
	gohelper.setActive(arg_6_0._unknown, var_6_2)
	gohelper.setActive(arg_6_0._goadd, false)
	gohelper.setActive(arg_6_0._gosurvivalequiptag, false)
	gohelper.setActive(arg_6_0._goadd, var_6_0)

	if not var_6_1 and not var_6_2 then
		local var_6_4 = arg_6_1.co.type == SurvivalEnum.ItemType.NPC
		local var_6_5 = arg_6_1.equipCo

		gohelper.setActive(arg_6_0._gonpc, var_6_4)
		gohelper.setActive(arg_6_0._gosurvivalequiptag, var_6_5 and arg_6_1.bagReason == 1)
		gohelper.setActive(arg_6_0._goitem, not var_6_4)
		gohelper.setActive(arg_6_0._goqulity5, not var_6_4 and arg_6_1.co.rare == 5)
		gohelper.setActive(arg_6_0._effect6, not var_6_4 and arg_6_1.co.rare == 6)

		arg_6_0._txtnum.text = arg_6_0._mo.count

		local var_6_6 = {}

		if not var_6_4 then
			UISpriteSetMgr.instance:setSurvivalSprite(arg_6_0._imagerare, "survival_bag_itemquality" .. arg_6_0._mo.co.rare)
			arg_6_0._simageitemicon:LoadImage(ResUrl.getSurvivalItemIcon(arg_6_0._mo.co.icon))
		else
			arg_6_0._simagenpcicon:LoadImage(ResUrl.getSurvivalNpcIcon(arg_6_0._mo.co.icon))
		end

		if var_6_5 then
			if var_6_5.equipType == 0 then
				local var_6_7 = string.splitToNumber(var_6_5.tag, "#") or {}

				for iter_6_0, iter_6_1 in ipairs(var_6_7) do
					local var_6_8 = lua_survival_equip_found.configDict[iter_6_1]

					if var_6_8 then
						table.insert(var_6_6, var_6_8.icon4)
					end
				end
			else
				var_6_6 = {
					"100"
				}
			end
		end

		gohelper.CreateObjList(arg_6_0, arg_6_0._createTagItem, var_6_6, nil, arg_6_0._gotagitem)
	end

	arg_6_0:setIsSelect(false)
end

function var_0_0._createTagItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = gohelper.findChildImage(arg_7_1, "#image_tag")

	UISpriteSetMgr.instance:setSurvivalSprite(var_7_0, arg_7_2)
end

function var_0_0.setShowNum(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0._txtnum, arg_8_1)
end

function var_0_0.setClickCallback(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._callback = arg_9_1
	arg_9_0._callobj = arg_9_2
end

function var_0_0.setIsSelect(arg_10_0, arg_10_1)
	if arg_10_1 == nil then
		arg_10_1 = false
	end

	gohelper.setActive(arg_10_0._goselect, arg_10_1)
end

function var_0_0.setCanClickEmpty(arg_11_0, arg_11_1)
	arg_11_0._canClickEmpty = arg_11_1
end

function var_0_0._onItemClick(arg_12_0)
	if arg_12_0._mo:isEmpty() and not arg_12_0._canClickEmpty then
		return
	end

	if arg_12_0._callback then
		arg_12_0._callback(arg_12_0._callobj, arg_12_0)

		return
	end
end

function var_0_0.showLoading(arg_13_0, arg_13_1)
	gohelper.setActive(arg_13_0._goloading, arg_13_1)

	if arg_13_1 then
		gohelper.setActive(arg_13_0._goempty, false)
		gohelper.setActive(arg_13_0._gonormal, false)
	else
		arg_13_0:updateMo(arg_13_0._mo)

		if arg_13_0._mo and arg_13_0._mo.co and arg_13_0._mo.co.rare == 5 then
			arg_13_0._animHas:Play("opensp", 0, 0)
			AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_binansuo_sougua_4)
		else
			arg_13_0._animHas:Play("open", 0, 0)
		end
	end
end

function var_0_0.playSearch(arg_14_0)
	gohelper.setActive(arg_14_0._gosearching, false)
	gohelper.setActive(arg_14_0._gosearching, true)
end

function var_0_0.playCompose(arg_15_0)
	gohelper.setActive(arg_15_0._gocompose, false)
	gohelper.setActive(arg_15_0._gocompose, true)
end

function var_0_0.playPut(arg_16_0)
	gohelper.setActive(arg_16_0._goput, false)
	gohelper.setActive(arg_16_0._goput, true)
end

function var_0_0.playComposeAnim(arg_17_0)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_qiutu_teleport)
	arg_17_0._animHas:Play("compose", 0, 0)
end

function var_0_0.playGainReputationFreeReward(arg_18_0)
	arg_18_0._go_hasget:Play("go_hasget_in")
end

function var_0_0.setItemSize(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_1 / arg_19_0.defaultWidth
	local var_19_1 = arg_19_2 / arg_19_0.defaultHeight

	recthelper.setSize(arg_19_0.go.transform, arg_19_1, arg_19_2)
	transformhelper.setLocalScale(arg_19_0.goRoot.transform, var_19_0, var_19_1, 1)
end

function var_0_0.playCloseAnim(arg_20_0)
	arg_20_0._animHas:Play("close", 0, 0)
end

function var_0_0.setTextName(arg_21_0, arg_21_1, arg_21_2)
	gohelper.setActive(arg_21_0._textName, arg_21_1)

	if arg_21_1 then
		arg_21_0._textName.text = arg_21_2
	end
end

function var_0_0.setExtraParam(arg_22_0, arg_22_1)
	arg_22_0.extraParam = arg_22_1
end

function var_0_0.showRewardInherit(arg_23_0, arg_23_1, arg_23_2)
	gohelper.setActive(arg_23_0._go_rewardinherit, true)

	arg_23_0._go_rewardinherit_txt_name.text = arg_23_1

	gohelper.setActive(arg_23_0._go_rewardinherit_go_Selected, arg_23_2)
end

function var_0_0.setReputationShopStyle(arg_24_0, arg_24_1)
	gohelper.setActive(arg_24_0._goReputationShop, true)
	gohelper.setActive(arg_24_0._go_canget, arg_24_1.isCanGet)
	gohelper.setActive(arg_24_0._go_receive, arg_24_1.isReceive)
	gohelper.setActive(arg_24_0._go_price, arg_24_1.price)

	if arg_24_1.price then
		arg_24_0._text_price.text = arg_24_1.price
	end

	gohelper.setActive(arg_24_0._go_freeReward, arg_24_1.isShowFreeReward)
end

function var_0_0.setShopStyle(arg_25_0, arg_25_1)
	gohelper.setActive(arg_25_0.go_shop_price, arg_25_1.isShow)

	arg_25_0.txt_price_shop.text = arg_25_1.price
end

function var_0_0.setItemSubType_npc(arg_26_0, arg_26_1)
	gohelper.setActive(arg_26_0.itemSubType_npc, arg_26_1)
end

function var_0_0.setRecommend(arg_27_0, arg_27_1)
	gohelper.setActive(arg_27_0.recommend, arg_27_1)
end

function var_0_0.showInheritScore(arg_28_0)
	gohelper.setActive(arg_28_0.go_score, true)

	arg_28_0.txt_score.text = arg_28_0._mo:getExtendCost()
end

return var_0_0
