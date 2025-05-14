module("modules.ugui.icon.common.CommonHeroIcon", package.seeall)

local var_0_0 = class("CommonHeroIcon", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tr = arg_1_1.transform
	arg_1_0._callback = nil
	arg_1_0._callbackObj = nil
	arg_1_0._btnClick = nil
	arg_1_0._lvTxt = gohelper.findChildText(arg_1_1, "lvltxt")
	arg_1_0._starObj = gohelper.findChild(arg_1_1, "starobj")
	arg_1_0._maskObj = gohelper.findChild(arg_1_1, "mask")
	arg_1_0._breakObj = gohelper.findChild(arg_1_1, "breakobj")
	arg_1_0._rareObj = gohelper.findChild(arg_1_1, "rareobj")
	arg_1_0._cardIcon = gohelper.findChildSingleImage(arg_1_1, "charactericon")
	arg_1_0._careerIcon = gohelper.findChildImage(arg_1_1, "career")
	arg_1_0._careerFrame = gohelper.findChildImage(arg_1_1, "frame")
	arg_1_0._rareIcon = gohelper.findChildImage(arg_1_1, "cardrare")
	arg_1_0._isShowStar = true
	arg_1_0._isShowBreak = true
	arg_1_0._isShowRate = true

	arg_1_0:_initObj()
end

function var_0_0.setLvVisible(arg_2_0, arg_2_1)
	gohelper.setActive(arg_2_0._lvTxt.gameObject, arg_2_1)
end

function var_0_0.setMaskVisible(arg_3_0, arg_3_1)
	gohelper.setActive(arg_3_0._maskObj, arg_3_1)
end

function var_0_0.isShowStar(arg_4_0, arg_4_1)
	arg_4_0._isShowStar = arg_4_1

	gohelper.setActive(arg_4_0._starObj, arg_4_1)
end

function var_0_0.isShowBreak(arg_5_0, arg_5_1)
	arg_5_0._isShowBreak = arg_5_1

	gohelper.setActive(arg_5_0._breakObj, arg_5_1)
end

function var_0_0.isShowRare(arg_6_0, arg_6_1)
	arg_6_0._isShowRare = arg_6_1

	gohelper.setActive(arg_6_0._rareObj, arg_6_1)
end

function var_0_0.isShowRareIcon(arg_7_0, arg_7_1)
	arg_7_0._isShowRareIcon = arg_7_1

	gohelper.setActive(arg_7_0._rareIcon.gameObject, arg_7_1)
end

function var_0_0.isShowCareerIcon(arg_8_0, arg_8_1)
	arg_8_0._isShowCareer = arg_8_1

	gohelper.setActive(arg_8_0._careerIcon.gameObject, arg_8_1)
end

function var_0_0.setScale(arg_9_0, arg_9_1)
	transformhelper.setLocalScale(arg_9_0.tr, arg_9_1, arg_9_1, arg_9_1)
end

function var_0_0.setAnchor(arg_10_0, arg_10_1, arg_10_2)
	recthelper.setAnchor(arg_10_0.tr, arg_10_1, arg_10_2)
end

function var_0_0._initObj(arg_11_0)
	arg_11_0._rareGos = arg_11_0:getUserDataTb_()

	for iter_11_0 = 1, 6 do
		arg_11_0._rareGos[iter_11_0] = gohelper.findChild(arg_11_0._rareObj, "rare" .. tostring(iter_11_0))
	end

	arg_11_0._starImgs = arg_11_0:getUserDataTb_()

	for iter_11_1 = 1, 5 do
		arg_11_0._starImgs[iter_11_1] = gohelper.findChildImage(arg_11_0._starObj, "star" .. tostring(iter_11_1))
	end

	arg_11_0._breakImgs = arg_11_0:getUserDataTb_()

	for iter_11_2 = 1, 6 do
		arg_11_0._breakImgs[iter_11_2] = gohelper.findChildImage(arg_11_0._breakObj, "break" .. tostring(iter_11_2))
	end
end

function var_0_0.addClickListener(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0._callback = arg_12_1
	arg_12_0._callbackObj = arg_12_2

	if not arg_12_0._btnClick then
		arg_12_0._btnClick = SLFramework.UGUI.UIClickListener.Get(arg_12_0.go)
	end

	arg_12_0._btnClick:AddClickListener(arg_12_0._onItemClick, arg_12_0)
end

function var_0_0.removeClickListener(arg_13_0)
	arg_13_0._callback = nil
	arg_13_0._callbackObj = nil

	if arg_13_0._btnClick then
		arg_13_0._btnClick:RemoveClickListener()
	end
end

function var_0_0.removeEventListeners(arg_14_0)
	if arg_14_0._btnClick then
		arg_14_0._btnClick:RemoveClickListener()
	end
end

function var_0_0.onUpdateHeroId(arg_15_0, arg_15_1)
	local var_15_0 = HeroConfig.instance:getHeroCO(arg_15_1)
	local var_15_1 = SkinConfig.instance:getSkinCo(var_15_0.skinId)

	arg_15_0._cardIcon:LoadImage(ResUrl.getHeadIconSmall(var_15_1.retangleIcon))
	UISpriteSetMgr.instance:setCommonSprite(arg_15_0._careerIcon, "lssx_" .. tostring(var_15_0.career))
	arg_15_0:_fillRareContent(CharacterEnum.Star[var_15_0.rare])
end

function var_0_0.onUpdateMO(arg_16_0, arg_16_1)
	arg_16_0._mo = arg_16_1

	local var_16_0 = HeroConfig.instance:getShowLevel(arg_16_1.level)

	arg_16_0._lvTxt.text = var_16_0

	arg_16_0:_fillRareContent(CharacterEnum.Star[arg_16_1.config.rare])
	arg_16_0:_fillBreakContent(arg_16_1.exSkillLevel)
	arg_16_0:_fillStarContent(arg_16_1.rank)

	local var_16_1 = HeroModel.instance:getByHeroId(arg_16_1.heroId)
	local var_16_2 = SkinConfig.instance:getSkinCo(var_16_1.skin)

	arg_16_0._cardIcon:LoadImage(ResUrl.getHeadIconSmall(var_16_2.retangleIcon))
	UISpriteSetMgr.instance:setCommonSprite(arg_16_0._careerIcon, "lssx_" .. tostring(arg_16_1.config.career))
end

function var_0_0.updateMonster(arg_17_0, arg_17_1)
	arg_17_0._monsterConfig = arg_17_1

	local var_17_0 = HeroConfig.instance:getShowLevel(arg_17_1.level)

	arg_17_0._lvTxt.text = var_17_0

	arg_17_0:_fillRareContent(1)
	gohelper.setActive(arg_17_0._breakObj, false)
	gohelper.setActive(arg_17_0._starObj, false)

	local var_17_1 = FightConfig.instance:getSkinCO(arg_17_1.skinId)

	arg_17_0._cardIcon:LoadImage(ResUrl.getHeadIconSmall(var_17_1.retangleIcon))
	UISpriteSetMgr.instance:setCommonSprite(arg_17_0._careerIcon, "lssx_" .. tostring(arg_17_1.career))
end

function var_0_0._fillRareContent(arg_18_0, arg_18_1)
	arg_18_1 = arg_18_1 and math.max(arg_18_1, 1) or 1

	if arg_18_0._rareObj then
		UISpriteSetMgr.instance:setCommonSprite(arg_18_0._rareIcon, "bp_quality_0" .. tostring(arg_18_1))

		if arg_18_0._isShowRare then
			for iter_18_0 = 1, 6 do
				gohelper.setActive(arg_18_0._rareGos[iter_18_0], iter_18_0 <= arg_18_1)
			end
		end

		gohelper.setActive(arg_18_0._rareObj, arg_18_0._isShowRare)
	end
end

function var_0_0._fillBreakContent(arg_19_0, arg_19_1)
	arg_19_1 = arg_19_1 and math.max(arg_19_1, 1) or 1

	if arg_19_0._breakObj then
		if arg_19_0._isShowBreak then
			for iter_19_0 = 1, 6 do
				if iter_19_0 <= arg_19_1 then
					SLFramework.UGUI.GuiHelper.SetColor(arg_19_0._breakImgs[iter_19_0], "#d7a93d")
				else
					SLFramework.UGUI.GuiHelper.SetColor(arg_19_0._breakImgs[iter_19_0], "#626467")
				end
			end
		end

		gohelper.setActive(arg_19_0._breakObj, arg_19_0._isShowBreak)
	end
end

function var_0_0._fillStarContent(arg_20_0, arg_20_1)
	arg_20_1 = arg_20_1 and math.max(arg_20_1, 1) or 1

	if arg_20_0._starObj then
		if arg_20_0._isShowStar then
			for iter_20_0 = 1, 5 do
				if iter_20_0 <= arg_20_1 then
					SLFramework.UGUI.GuiHelper.SetColor(arg_20_0._starImgs[iter_20_0], "#d7a93d")
				else
					SLFramework.UGUI.GuiHelper.SetColor(arg_20_0._starImgs[iter_20_0], "#626467")
				end
			end
		end

		gohelper.setActive(arg_20_0._starObj, arg_20_0._isShowStar)
	end
end

function var_0_0._onItemClick(arg_21_0)
	if arg_21_0._callback then
		if arg_21_0._callbackObj then
			arg_21_0._callback(arg_21_0._callbackObj, arg_21_0._mo)
		else
			arg_21_0._callback(arg_21_0._mo)
		end
	end
end

function var_0_0.onDestroy(arg_22_0)
	arg_22_0._cardIcon:UnLoadImage()
end

return var_0_0
