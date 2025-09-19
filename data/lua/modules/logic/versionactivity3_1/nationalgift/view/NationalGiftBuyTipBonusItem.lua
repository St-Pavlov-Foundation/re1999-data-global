module("modules.logic.versionactivity3_1.nationalgift.view.NationalGiftBuyTipBonusItem", package.seeall)

local var_0_0 = class("NationalGiftBuyTipBonusItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.go = arg_1_1
	arg_1_0._config = arg_1_2
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.go, "go_rewards/rewarditem")
	arg_1_0._imageNum = gohelper.findChildImage(arg_1_0.go, "image_Num")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.go, "go_tips")

	arg_1_0:_initItem()
end

function var_0_0._initItem(arg_2_0)
	gohelper.setActive(arg_2_0.go, true)
	UISpriteSetMgr.instance:setStoreGoodsSprite(arg_2_0._imageNum, "releasegift_img_num" .. tostring(arg_2_0._config.id), true)

	arg_2_0._rewardItems = {}
end

function var_0_0.refresh(arg_3_0)
	local var_3_0 = NationalGiftModel.instance:isGiftHasBuy()

	gohelper.setActive(arg_3_0._gotips, not var_3_0 and arg_3_0._config.id == 1)
	arg_3_0:_refreshRewards()
end

function var_0_0._refreshRewards(arg_4_0)
	local var_4_0 = string.split(arg_4_0._config.bonus, "|")

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if not arg_4_0._rewardItems[iter_4_0] then
			local var_4_1 = {
				go = gohelper.cloneInPlace(arg_4_0._gorewarditem)
			}

			var_4_1.imgquality = gohelper.findChildImage(var_4_1.go, "img_quality")
			var_4_1.simageitem = gohelper.findChildSingleImage(var_4_1.go, "simage_Item")
			var_4_1.txtnum = gohelper.findChildText(var_4_1.go, "image_NumBG/txt_Num")
			arg_4_0._rewardItems[iter_4_0] = var_4_1
		end

		gohelper.setActive(arg_4_0._rewardItems[iter_4_0].go, true)

		local var_4_2 = string.splitToNumber(iter_4_1, "#")
		local var_4_3, var_4_4 = ItemModel.instance:getItemConfigAndIcon(var_4_2[1], var_4_2[2])

		UISpriteSetMgr.instance:setNationalGiftSprite(arg_4_0._rewardItems[iter_4_0].imgquality, "bg_pinjidi_" .. tostring(var_4_3.rare), true)
		arg_4_0._rewardItems[iter_4_0].simageitem:LoadImage(var_4_4)

		arg_4_0._rewardItems[iter_4_0].txtnum.text = luaLang("multiple") .. var_4_2[3]
	end
end

function var_0_0.destroy(arg_5_0)
	if arg_5_0._rewardItems then
		for iter_5_0, iter_5_1 in pairs(arg_5_0._rewardItems) do
			iter_5_1.simageitem:UnLoadImage()
		end

		arg_5_0._rewardItems = nil
	end
end

return var_0_0
