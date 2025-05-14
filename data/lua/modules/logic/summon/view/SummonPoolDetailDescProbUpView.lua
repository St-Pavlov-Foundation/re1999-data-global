module("modules.logic.summon.view.SummonPoolDetailDescProbUpView", package.seeall)

local var_0_0 = class("SummonPoolDetailDescProbUpView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goheroitem = gohelper.findChild(arg_1_0.viewGO, "infoScroll/Viewport/#go_Content/#go_heroItem")
	arg_1_0._godesctitle = gohelper.findChild(arg_1_0.viewGO, "infoScroll/Viewport/#go_Content/#go_heroItem/#go_desctitle")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

local var_0_1 = 5
local var_0_2 = 5

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._probUpItemMap = {}
end

function var_0_0.onDestroyView(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0._probUpItemMap) do
		for iter_5_2, iter_5_3 in pairs(iter_5_1.heroIcons) do
			iter_5_3.simageHero:UnLoadImage()
			iter_5_3.btn:RemoveClickListener()
		end
	end

	for iter_5_4, iter_5_5 in pairs(arg_5_0._probUpItemMap) do
		for iter_5_6, iter_5_7 in pairs(iter_5_5.equipIcons) do
			iter_5_7.simageEquip:UnLoadImage()
			iter_5_7.btn:RemoveClickListener()
		end
	end
end

function var_0_0.onUpdateParam(arg_6_0)
	arg_6_0:onOpen()
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._poolParam = SummonController.instance:getPoolInfo()
	arg_7_0._poolDetailId = arg_7_0._poolParam.poolDetailId
	arg_7_0._poolId = arg_7_0._poolParam.poolId

	local var_7_0 = SummonConfig.instance:getSummonPool(arg_7_0._poolId)

	arg_7_0._resultType = SummonMainModel.getResultType(var_7_0)
	arg_7_0._poolType = var_7_0.type

	arg_7_0:refreshUI()
end

function var_0_0.refreshUI(arg_8_0)
	arg_8_0._probUpRareIds, arg_8_0._probUpIds, arg_8_0._hasProbUpItem = SummonPoolDetailCategoryListModel.buildProbUpDict(arg_8_0._poolId)

	arg_8_0:refreshPropUpAD()
end

function var_0_0.refreshPropUpAD(arg_9_0)
	local var_9_0 = SummonConfig.instance:getSummonPool(arg_9_0._poolId)
	local var_9_1 = SummonMainModel.isProbUp(var_9_0)

	if var_9_1 then
		for iter_9_0 = var_0_1, 1, -1 do
			arg_9_0:addProbUpItemByRare(iter_9_0)
		end
	end

	gohelper.setActive(arg_9_0._goheroitem, var_9_1 and arg_9_0._hasProbUpItem)
end

function var_0_0.addProbUpItemByRare(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._probUpRareIds[arg_10_1]

	if not var_10_0 then
		return
	end

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_1 = arg_10_0:getProbUpItem(arg_10_1)

		gohelper.setActive(var_10_1.go, true)
		arg_10_0:applyRareStar(var_10_1, arg_10_1)
		arg_10_0:refreshProbIcons(var_10_1, var_10_0)

		if arg_10_1 ~= var_0_2 or not ConstEnum.SummonSSRUpProb then
			local var_10_2 = ConstEnum.SummonSRUpProb
		end

		if arg_10_0._poolType == SummonEnum.Type.MultiProbUp4 and arg_10_1 == var_0_2 then
			var_10_1.txtProbability.text = ""

			local var_10_3 = {
				arg_10_1 + 1,
				tostring(SummonEnum.MultiProbUp4ShowRate)
			}

			var_10_1.txtProbabilityLabel.text = GameUtil.getSubPlaceholderLuaLang(luaLang("summon_multiup4_rule_title"), var_10_3)
		elseif arg_10_0._poolType == SummonEnum.Type.DoubleSsrUp then
			var_10_1.txtProbability.text = ""
			var_10_1.txtProbabilityLabel.text = GameUtil.getSubPlaceholderLuaLang(luaLang("p_summonpooldetail_up_probability"), {
				arg_10_1 + 1,
				CommonConfig.instance:getConstNum(ConstEnum.SummonPoolDoubleSSRRate) / 10
			})
		else
			var_10_1.txtProbability.text = ""
			var_10_1.txtProbabilityLabel.text = GameUtil.getSubPlaceholderLuaLang(luaLang("p_summonpooldetail_up_probability"), {
				arg_10_1 + 1,
				CommonConfig.instance:getConstNum(ConstEnum.SummonSSRUpProb) / 10
			})
		end
	end
end

function var_0_0.getProbUpItem(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._probUpItemMap[arg_11_1]

	if not var_11_0 then
		var_11_0 = arg_11_0:getUserDataTb_()
		var_11_0.heroIcons = {}
		var_11_0.equipIcons = {}

		local var_11_1 = gohelper.clone(arg_11_0._godesctitle, arg_11_0._goheroitem, "prob_up_item_" .. tostring(arg_11_1))

		var_11_0.go = var_11_1
		var_11_0.starList = arg_11_0:getUserDataTb_()
		var_11_0.iconContainerGo = gohelper.findChild(var_11_1, "heroshowlist")
		var_11_0.iconEquipContainerGo = gohelper.findChild(var_11_1, "equipshowlist")
		var_11_0.iconTemplateGo = gohelper.findChild(var_11_1, "heroshowlist/summonpooldetailheroitem")
		var_11_0.iconEquipTemplateGo = gohelper.findChild(var_11_1, "equipshowlist/summonpooldetailequipitem")

		local var_11_2 = gohelper.findChild(var_11_1, "#go_starList")

		for iter_11_0 = 1, var_0_1 + 1 do
			var_11_0.starList[iter_11_0] = gohelper.findChild(var_11_2, "star" .. tostring(iter_11_0))
		end

		var_11_0.txtProbability = gohelper.findChildText(var_11_2, "probability/#txt_probability")
		var_11_0.txtProbabilityLabel = gohelper.findChildText(var_11_2, "probability")
		arg_11_0._probUpItemMap[arg_11_1] = var_11_0
	end

	return var_11_0
end

function var_0_0.applyRareStar(arg_12_0, arg_12_1, arg_12_2)
	for iter_12_0 = 1, var_0_1 + 1 do
		gohelper.setActive(arg_12_1.starList[iter_12_0], iter_12_0 <= arg_12_2 + 1)
	end
end

function var_0_0.refreshProbIcons(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0._resultType == SummonEnum.ResultType.Char then
		arg_13_0:refreshHeroProbIcons(arg_13_1, arg_13_2)
	elseif arg_13_0._resultType == SummonEnum.ResultType.Equip then
		arg_13_0:refreshEquipProbIcons(arg_13_1, arg_13_2)
	end

	gohelper.setActive(arg_13_1.iconContainerGo, arg_13_0._resultType == SummonEnum.ResultType.Char)
	gohelper.setActive(arg_13_1.iconEquipContainerGo, arg_13_0._resultType == SummonEnum.ResultType.Equip)
end

function var_0_0.refreshHeroProbIcons(arg_14_0, arg_14_1, arg_14_2)
	for iter_14_0, iter_14_1 in ipairs(arg_14_2) do
		local var_14_0 = arg_14_0:getProbUpHeroIconItem(arg_14_1, iter_14_0)

		gohelper.setActive(var_14_0.go, true)
		arg_14_0:refreshProbUpHeroIconItem(iter_14_1, var_14_0)
	end
end

function var_0_0.refreshEquipProbIcons(arg_15_0, arg_15_1, arg_15_2)
	for iter_15_0, iter_15_1 in ipairs(arg_15_2) do
		local var_15_0 = arg_15_0:getProbUpEquipIconItem(arg_15_1, iter_15_0)

		gohelper.setActive(var_15_0.go, true)
		arg_15_0:refreshProbUpEquipIconItem(iter_15_1, var_15_0)
	end
end

function var_0_0.getProbUpHeroIconItem(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_1.heroIcons[arg_16_2]

	if not var_16_0 then
		var_16_0 = arg_16_0:getUserDataTb_()

		local var_16_1 = gohelper.clone(arg_16_1.iconTemplateGo, arg_16_1.iconContainerGo, "prob_up_item")

		var_16_0.go = var_16_1
		var_16_0.imageRare = gohelper.findChildImage(var_16_1, "image_rare")
		var_16_0.imageCareer = gohelper.findChildImage(var_16_1, "image_career")
		var_16_0.simageHero = gohelper.findChildSingleImage(var_16_1, "simage_hero")
		var_16_0.imageNameEn = gohelper.findChildImage(var_16_1, "image_nameen")
		var_16_0.txtNameCn = gohelper.findChildText(var_16_1, "txt_namecn")
		var_16_0.data = {}
		var_16_0.btn = gohelper.findChildButtonWithAudio(var_16_1, "simage_hero")

		var_16_0.btn:AddClickListener(arg_16_0.onClickHeroItem, arg_16_0, var_16_0.data)

		arg_16_1.heroIcons[arg_16_2] = var_16_0
	end

	return var_16_0
end

function var_0_0.refreshProbUpHeroIconItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = HeroConfig.instance:getHeroCO(arg_17_1)

	UISpriteSetMgr.instance:setSummonSprite(arg_17_2.imageRare, var_17_0.rare < var_0_2 and "bg_choukahuang" or "bg_choukaju")
	UISpriteSetMgr.instance:setCommonSprite(arg_17_2.imageCareer, "lssx_" .. tostring(var_17_0.career))
	arg_17_2.simageHero:LoadImage(ResUrl.getHandbookheroIcon(var_17_0.skinId))

	arg_17_2.data.clickId = arg_17_1
	arg_17_2.txtNameCn.text = var_17_0.name
end

function var_0_0.getProbUpEquipIconItem(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_1.equipIcons[arg_18_2]

	if not var_18_0 then
		var_18_0 = arg_18_0:getUserDataTb_()

		local var_18_1 = gohelper.clone(arg_18_1.iconEquipTemplateGo, arg_18_1.iconEquipContainerGo, "prob_up_equip_item")

		var_18_0.go = var_18_1
		var_18_0.imageCareer = gohelper.findChildImage(var_18_1, "txt_namecn/image_career")
		var_18_0.simageEquip = gohelper.findChildSingleImage(var_18_1, "simage_equip")
		var_18_0.imageNameEn = gohelper.findChildImage(var_18_1, "image_nameen")
		var_18_0.txtNameCn = gohelper.findChildText(var_18_1, "txt_namecn")
		var_18_0.data = {}
		var_18_0.btn = gohelper.findChildButtonWithAudio(var_18_1, "simage_equip")

		var_18_0.btn:AddClickListener(arg_18_0.onClickEquipItem, arg_18_0, var_18_0.data)

		arg_18_1.equipIcons[arg_18_2] = var_18_0
	end

	return var_18_0
end

function var_0_0.refreshProbUpEquipIconItem(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = EquipConfig.instance:getEquipCo(arg_19_1)

	arg_19_2.simageEquip:LoadImage(ResUrl.getEquipSuit(var_19_0.icon))
	transformhelper.setLocalScale(arg_19_2.simageEquip.transform, 0.39, 0.39, 1)

	local var_19_1 = EquipHelper.createMaxLevelEquipMo(arg_19_1)
	local var_19_2 = EquipHelper.getEquipSkillCareer(arg_19_1, var_19_1.refineLv)

	if not string.nilorempty(var_19_2) then
		gohelper.setActive(arg_19_2.imageCareer.gameObject, true)

		local var_19_3 = "jinglian_" .. var_19_2

		UISpriteSetMgr.instance:setCommonSprite(arg_19_2.imageCareer, var_19_3)
	else
		gohelper.setActive(arg_19_2.imageCareer.gameObject, false)
	end

	arg_19_2.data.clickId = arg_19_1
	arg_19_2.txtNameCn.text = var_19_0.name
end

function var_0_0.onClickHeroItem(arg_20_0, arg_20_1)
	if arg_20_1.clickId ~= nil then
		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			heroId = arg_20_1.clickId
		})
	end
end

function var_0_0.onClickEquipItem(arg_21_0, arg_21_1)
	if arg_21_1.clickId ~= nil then
		local var_21_0 = {
			equipId = arg_21_1.clickId
		}

		EquipController.instance:openEquipView(var_21_0)
	end
end

return var_0_0
