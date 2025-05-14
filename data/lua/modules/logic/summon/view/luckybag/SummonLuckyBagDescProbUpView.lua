module("modules.logic.summon.view.luckybag.SummonLuckyBagDescProbUpView", package.seeall)

local var_0_0 = class("SummonLuckyBagDescProbUpView", BaseView)

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
	arg_4_0._scrollroot = gohelper.findChildScrollRect(arg_4_0.viewGO, "infoScroll")
	arg_4_0._goscrollcontent = gohelper.findChild(arg_4_0.viewGO, "infoScroll/Viewport/#go_Content")
	arg_4_0._rectscrollcontent = arg_4_0._goscrollcontent.transform
	arg_4_0._probUpItemMap = {}
end

function var_0_0.onDestroyView(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.delayJumpToLuckyBag, arg_5_0)

	if arg_5_0._probUpItemMap then
		for iter_5_0, iter_5_1 in pairs(arg_5_0._probUpItemMap) do
			for iter_5_2, iter_5_3 in pairs(iter_5_1.heroIcons) do
				iter_5_3.simageHero:UnLoadImage()
				iter_5_3.btn:RemoveClickListener()
			end

			for iter_5_4, iter_5_5 in pairs(iter_5_1.equipIcons) do
				iter_5_5.simageEquip:UnLoadImage()
				iter_5_5.btn:RemoveClickListener()
			end
		end

		arg_5_0._probUpItemMap = nil
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
	arg_7_0:checkJumpToTarget()
end

function var_0_0.checkJumpToTarget(arg_8_0)
	if SummonPoolDetailCategoryListModel.instance:getJumpLuckyBag() ~= nil then
		TaskDispatcher.runDelay(arg_8_0.delayJumpToLuckyBag, arg_8_0, 0.01)
	end
end

function var_0_0.delayJumpToLuckyBag(arg_9_0)
	if not arg_9_0._probUpItemMap then
		return
	end

	local var_9_0 = SummonPoolDetailCategoryListModel.instance:getJumpLuckyBag()
	local var_9_1 = arg_9_0._probUpItemMap[var_9_0]

	if var_9_1 then
		local var_9_2 = var_9_1.go.transform
		local var_9_3 = recthelper.getHeight(arg_9_0._rectscrollcontent)
		local var_9_4, var_9_5 = recthelper.getAnchor(var_9_2)
		local var_9_6 = var_9_5 + recthelper.getHeight(var_9_2) * 0.5

		recthelper.setAnchorY(arg_9_0._rectscrollcontent, var_9_6)

		local var_9_7 = arg_9_0._scrollroot.verticalNormalizedPosition - 1

		arg_9_0._scrollroot.verticalNormalizedPosition = 1 - var_9_7
		var_0_0._test = arg_9_0._scrollroot
	end
end

function var_0_0.refreshUI(arg_10_0)
	arg_10_0._resultIds, arg_10_0._resultArrs = SummonPoolDetailCategoryListModel.buildLuckyBagDict(arg_10_0._poolId)

	arg_10_0:refreshPropUpAD()
end

function var_0_0.refreshPropUpAD(arg_11_0)
	local var_11_0 = SummonConfig.instance:getSummonPool(arg_11_0._poolId)
	local var_11_1 = next(arg_11_0._resultIds) ~= nil

	if var_11_1 then
		for iter_11_0, iter_11_1 in ipairs(arg_11_0._resultIds) do
			arg_11_0:addProbUpItemByLuckyBagId(iter_11_0, iter_11_1)
		end
	end

	gohelper.setActive(arg_11_0._goheroitem, var_11_1)
end

function var_0_0.addProbUpItemByLuckyBagId(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0._resultArrs[arg_12_1]

	if not var_12_0 or not next(var_12_0) then
		return
	end

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		local var_12_1 = arg_12_0:getProbUpItem(arg_12_2)

		gohelper.setActive(var_12_1.go, true)
		arg_12_0:applyRareStar(var_12_1, -1)
		arg_12_0:refreshProbIcons(var_12_1, var_12_0)

		local var_12_2 = SummonConfig.instance:getLuckyBag(arg_12_0._poolId, arg_12_2)
		local var_12_3 = ConstEnum.SummonSSRUpProb

		var_12_1.txtProbabilityLabel.text = string.format(luaLang("summonpooldetail_luckybag_prop_all"), var_12_2.name)
		var_12_1.txtProbability.text = ""
	end
end

function var_0_0.getProbUpItem(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._probUpItemMap[arg_13_1]

	if not var_13_0 then
		var_13_0 = arg_13_0:getUserDataTb_()
		var_13_0.heroIcons = {}
		var_13_0.equipIcons = {}

		local var_13_1 = gohelper.clone(arg_13_0._godesctitle, arg_13_0._goheroitem, "prob_up_item_" .. tostring(arg_13_1))

		var_13_0.go = var_13_1
		var_13_0.starList = arg_13_0:getUserDataTb_()
		var_13_0.iconContainerGo = gohelper.findChild(var_13_1, "heroshowlist")
		var_13_0.iconEquipContainerGo = gohelper.findChild(var_13_1, "equipshowlist")
		var_13_0.iconTemplateGo = gohelper.findChild(var_13_1, "heroshowlist/summonpooldetailheroitem")
		var_13_0.iconEquipTemplateGo = gohelper.findChild(var_13_1, "equipshowlist/summonpooldetailequipitem")
		var_13_0.starContainerGo = gohelper.findChild(var_13_1, "#go_starList")

		for iter_13_0 = 1, var_0_1 + 1 do
			var_13_0.starList[iter_13_0] = gohelper.findChild(var_13_0.starContainerGo, "star" .. tostring(iter_13_0))
		end

		var_13_0.txtProbability = gohelper.findChildText(var_13_0.starContainerGo, "probability/#txt_probability")
		var_13_0.txtProbabilityLabel = gohelper.findChildText(var_13_0.starContainerGo, "probability")
		arg_13_0._probUpItemMap[arg_13_1] = var_13_0
	end

	return var_13_0
end

function var_0_0.applyRareStar(arg_14_0, arg_14_1, arg_14_2)
	for iter_14_0 = 1, var_0_1 + 1 do
		gohelper.setActive(arg_14_1.starList[iter_14_0], iter_14_0 <= arg_14_2 + 1)
	end
end

function var_0_0.refreshProbIcons(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0._resultType == SummonEnum.ResultType.Char then
		arg_15_0:refreshHeroProbIcons(arg_15_1, arg_15_2)
	elseif arg_15_0._resultType == SummonEnum.ResultType.Equip then
		arg_15_0:refreshEquipProbIcons(arg_15_1, arg_15_2)
	end

	gohelper.setActive(arg_15_1.iconContainerGo, arg_15_0._resultType == SummonEnum.ResultType.Char)
	gohelper.setActive(arg_15_1.iconEquipContainerGo, arg_15_0._resultType == SummonEnum.ResultType.Equip)
end

function var_0_0.refreshHeroProbIcons(arg_16_0, arg_16_1, arg_16_2)
	for iter_16_0, iter_16_1 in ipairs(arg_16_2) do
		local var_16_0 = arg_16_0:getProbUpHeroIconItem(arg_16_1, iter_16_0)

		gohelper.setActive(var_16_0.go, true)
		arg_16_0:refreshProbUpHeroIconItem(iter_16_1, var_16_0)
	end
end

function var_0_0.refreshEquipProbIcons(arg_17_0, arg_17_1, arg_17_2)
	for iter_17_0, iter_17_1 in ipairs(arg_17_2) do
		local var_17_0 = arg_17_0:getProbUpEquipIconItem(arg_17_1, iter_17_0)

		gohelper.setActive(var_17_0.go, true)
		arg_17_0:refreshProbUpEquipIconItem(iter_17_1, var_17_0)
	end
end

function var_0_0.getProbUpHeroIconItem(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_1.heroIcons[arg_18_2]

	if not var_18_0 then
		var_18_0 = arg_18_0:getUserDataTb_()

		local var_18_1 = gohelper.clone(arg_18_1.iconTemplateGo, arg_18_1.iconContainerGo, "prob_up_item")

		var_18_0.go = var_18_1
		var_18_0.imageRare = gohelper.findChildImage(var_18_1, "image_rare")
		var_18_0.imageCareer = gohelper.findChildImage(var_18_1, "image_career")
		var_18_0.simageHero = gohelper.findChildSingleImage(var_18_1, "simage_hero")
		var_18_0.imageNameEn = gohelper.findChildImage(var_18_1, "image_nameen")
		var_18_0.txtNameCn = gohelper.findChildText(var_18_1, "txt_namecn")
		var_18_0.data = {}
		var_18_0.btn = gohelper.findChildButtonWithAudio(var_18_1, "simage_hero")

		var_18_0.btn:AddClickListener(arg_18_0.onClickHeroItem, arg_18_0, var_18_0.data)

		arg_18_1.heroIcons[arg_18_2] = var_18_0
	end

	return var_18_0
end

function var_0_0.refreshProbUpHeroIconItem(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = HeroConfig.instance:getHeroCO(arg_19_1)

	UISpriteSetMgr.instance:setSummonSprite(arg_19_2.imageRare, var_19_0.rare < var_0_2 and "bg_choukahuang" or "bg_choukaju")
	UISpriteSetMgr.instance:setCommonSprite(arg_19_2.imageCareer, "lssx_" .. tostring(var_19_0.career))
	arg_19_2.simageHero:LoadImage(ResUrl.getHandbookheroIcon(var_19_0.skinId))

	arg_19_2.data.clickId = arg_19_1
	arg_19_2.txtNameCn.text = var_19_0.name
end

function var_0_0.getProbUpEquipIconItem(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_1.equipIcons[arg_20_2]

	if not var_20_0 then
		var_20_0 = arg_20_0:getUserDataTb_()

		local var_20_1 = gohelper.clone(arg_20_1.iconEquipTemplateGo, arg_20_1.iconEquipContainerGo, "prob_up_equip_item")

		var_20_0.go = var_20_1
		var_20_0.imageCareer = gohelper.findChildImage(var_20_1, "txt_namecn/image_career")
		var_20_0.simageEquip = gohelper.findChildSingleImage(var_20_1, "simage_equip")
		var_20_0.imageNameEn = gohelper.findChildImage(var_20_1, "image_nameen")
		var_20_0.txtNameCn = gohelper.findChildText(var_20_1, "txt_namecn")
		var_20_0.data = {}
		var_20_0.btn = gohelper.findChildButtonWithAudio(var_20_1, "simage_equip")

		var_20_0.btn:AddClickListener(arg_20_0.onClickEquipItem, arg_20_0, var_20_0.data)

		arg_20_1.equipIcons[arg_20_2] = var_20_0
	end

	return var_20_0
end

function var_0_0.refreshProbUpEquipIconItem(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = EquipConfig.instance:getEquipCo(arg_21_1)

	arg_21_2.simageEquip:LoadImage(ResUrl.getEquipSuit(var_21_0.icon))
	transformhelper.setLocalScale(arg_21_2.simageEquip.transform, 0.39, 0.39, 1)

	local var_21_1 = EquipHelper.createMaxLevelEquipMo(arg_21_1)
	local var_21_2 = EquipHelper.getEquipSkillCareer(arg_21_1, var_21_1.refineLv)

	if not string.nilorempty(var_21_2) then
		gohelper.setActive(arg_21_2.imageCareer.gameObject, true)

		local var_21_3 = "jinglian_" .. var_21_2

		UISpriteSetMgr.instance:setCommonSprite(arg_21_2.imageCareer, var_21_3)
	else
		gohelper.setActive(arg_21_2.imageCareer.gameObject, false)
	end

	arg_21_2.data.clickId = arg_21_1
	arg_21_2.txtNameCn.text = var_21_0.name
end

function var_0_0.onClickHeroItem(arg_22_0, arg_22_1)
	if arg_22_1.clickId ~= nil then
		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			heroId = arg_22_1.clickId
		})
	end
end

function var_0_0.onClickEquipItem(arg_23_0, arg_23_1)
	if arg_23_1.clickId ~= nil then
		local var_23_0 = {
			equipId = arg_23_1.clickId
		}

		EquipController.instance:openEquipView(var_23_0)
	end
end

return var_0_0
