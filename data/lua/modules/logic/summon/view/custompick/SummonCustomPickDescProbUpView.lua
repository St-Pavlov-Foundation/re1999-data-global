module("modules.logic.summon.view.custompick.SummonCustomPickDescProbUpView", package.seeall)

local var_0_0 = class("SummonCustomPickDescProbUpView", BaseView)

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
				iter_5_3.simageHero2:UnLoadImage()
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
end

function var_0_0.refreshUI(arg_8_0)
	arg_8_0._resultIds = SummonPoolDetailCategoryListModel.buildCustomPickDict(arg_8_0._poolId)

	arg_8_0:refreshPropUpAD()
end

function var_0_0.refreshPropUpAD(arg_9_0)
	local var_9_0 = SummonConfig.instance:getSummonPool(arg_9_0._poolId)
	local var_9_1 = arg_9_0:getProbUpItem(1)

	gohelper.setActive(var_9_1.go, true)
	arg_9_0:applyRareStar(var_9_1, SummonEnum.CustomPickRare)
	arg_9_0:refreshProbIcons(var_9_1, arg_9_0._resultIds)

	local var_9_2, var_9_3, var_9_4 = SummonMainModel.instance:getCustomPickProbability(arg_9_0._poolId)
	local var_9_5 = SummonEnum.CustomPickRare + 1
	local var_9_6 = luaLang(var_9_3 ~= 0 and "summonpooldetail_up_probability_total" or "p_summonpooldetail_up_probability")

	gohelper.setActive(var_9_1.txtProbability, var_9_3 == 0 and not var_9_4)

	if var_9_3 ~= 0 then
		var_9_1.txtProbabilityLabel.text = GameUtil.getSubPlaceholderLuaLangThreeParam(var_9_6, var_9_5, var_9_2, var_9_3 / 10)
	elseif var_9_4 then
		local var_9_7 = luaLang("summonpooldetail_up_probability_StrongCustomOnePick")

		var_9_1.txtProbabilityLabel.text = GameUtil.getSubPlaceholderLuaLangTwoParam(var_9_7, var_9_5, var_9_2)
	else
		var_9_1.txtProbability.text = ""

		local var_9_8 = SummonMainModel.instance:getCustomPickProbability(arg_9_0._poolId)

		var_9_1.txtProbabilityLabel.text = GameUtil.getSubPlaceholderLuaLang(luaLang("p_summonpooldetail_up_probability"), {
			SummonEnum.CustomPickRare + 1,
			var_9_8
		})
	end
end

function var_0_0.getProbUpItem(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._probUpItemMap[arg_10_1]

	if not var_10_0 then
		var_10_0 = arg_10_0:getUserDataTb_()
		var_10_0.heroIcons = {}
		var_10_0.equipIcons = {}

		local var_10_1 = gohelper.clone(arg_10_0._godesctitle, arg_10_0._goheroitem, "prob_up_item_" .. tostring(arg_10_1))

		var_10_0.go = var_10_1
		var_10_0.starList = arg_10_0:getUserDataTb_()
		var_10_0.iconContainerGo = gohelper.findChild(var_10_1, "heroshowlist")
		var_10_0.iconEquipContainerGo = gohelper.findChild(var_10_1, "equipshowlist")
		var_10_0.iconTemplateGo = gohelper.findChild(var_10_1, "heroshowlist/summonpooldetailheroitem")
		var_10_0.iconEquipTemplateGo = gohelper.findChild(var_10_1, "equipshowlist/summonpooldetailequipitem")
		var_10_0.starContainerGo = gohelper.findChild(var_10_1, "#go_starList")

		for iter_10_0 = 1, var_0_1 + 1 do
			var_10_0.starList[iter_10_0] = gohelper.findChild(var_10_0.starContainerGo, "star" .. tostring(iter_10_0))
		end

		var_10_0.txtProbability = gohelper.findChildText(var_10_0.starContainerGo, "probability/#txt_probability")
		var_10_0.txtProbabilityLabel = gohelper.findChildText(var_10_0.starContainerGo, "probability")
		arg_10_0._probUpItemMap[arg_10_1] = var_10_0
	end

	return var_10_0
end

function var_0_0.applyRareStar(arg_11_0, arg_11_1, arg_11_2)
	for iter_11_0 = 1, var_0_1 + 1 do
		gohelper.setActive(arg_11_1.starList[iter_11_0], iter_11_0 <= arg_11_2 + 1)
	end
end

function var_0_0.refreshProbIcons(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0._resultType == SummonEnum.ResultType.Char then
		arg_12_0:refreshHeroProbIcons(arg_12_1, arg_12_2)
	end

	gohelper.setActive(arg_12_1.iconContainerGo, arg_12_0._resultType == SummonEnum.ResultType.Char)
	gohelper.setActive(arg_12_1.iconEquipContainerGo, arg_12_0._resultType == SummonEnum.ResultType.Equip)
end

function var_0_0.refreshHeroProbIcons(arg_13_0, arg_13_1, arg_13_2)
	for iter_13_0 = 1, SummonCustomPickModel.instance:getMaxSelectCount(arg_13_0._poolId) do
		local var_13_0 = arg_13_2[iter_13_0]
		local var_13_1 = arg_13_0:getProbUpHeroIconItem(arg_13_1, iter_13_0)

		gohelper.setActive(var_13_1.go, true)
		arg_13_0:refreshProbUpHeroIconItem(var_13_0, var_13_1, iter_13_0)
	end
end

function var_0_0.getProbUpHeroIconItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_1.heroIcons[arg_14_2]

	if not var_14_0 then
		var_14_0 = arg_14_0:getUserDataTb_()

		local var_14_1 = gohelper.clone(arg_14_1.iconTemplateGo, arg_14_1.iconContainerGo, "prob_up_item")

		var_14_0.go = var_14_1
		var_14_0.imageRare = gohelper.findChildImage(var_14_1, "image_rare")
		var_14_0.imageCareer = gohelper.findChildImage(var_14_1, "image_career")
		var_14_0.simageHero = gohelper.findChildSingleImage(var_14_1, "simage_hero")
		var_14_0.imageNameEn = gohelper.findChildImage(var_14_1, "image_nameen")
		var_14_0.txtNameCn = gohelper.findChildText(var_14_1, "txt_namecn")
		var_14_0.simageHero2 = gohelper.findChildSingleImage(var_14_1, "simage_hero2")
		var_14_0.data = {}
		var_14_0.btn = gohelper.findChildButtonWithAudio(var_14_1, "simage_hero")

		var_14_0.btn:AddClickListener(arg_14_0.onClickHeroItem, arg_14_0, var_14_0.data)

		arg_14_1.heroIcons[arg_14_2] = var_14_0
	end

	return var_14_0
end

var_0_0.EmptyHeroIconList = {
	"300301_1",
	"302501_1"
}
var_0_0.PickOneEmptyHeroIcon = "306601_1"

function var_0_0.refreshProbUpHeroIconItem(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if arg_15_1 then
		gohelper.setActive(arg_15_2.imageRare, true)
		gohelper.setActive(arg_15_2.imageCareer, true)
		gohelper.setActive(arg_15_2.txtNameCn, true)
		gohelper.setActive(arg_15_2.imageNameEn, true)
		gohelper.setActive(arg_15_2.simageHero2, false)

		local var_15_0 = HeroConfig.instance:getHeroCO(arg_15_1)

		UISpriteSetMgr.instance:setSummonSprite(arg_15_2.imageRare, var_15_0.rare < var_0_2 and "bg_choukahuang" or "bg_choukaju")
		UISpriteSetMgr.instance:setCommonSprite(arg_15_2.imageCareer, "lssx_" .. tostring(var_15_0.career))
		arg_15_2.simageHero:LoadImage(ResUrl.getHandbookheroIcon(var_15_0.skinId))

		arg_15_2.data.clickId = arg_15_1
		arg_15_2.txtNameCn.text = var_15_0.name
	else
		gohelper.setActive(arg_15_2.imageRare, false)
		gohelper.setActive(arg_15_2.imageCareer, false)
		gohelper.setActive(arg_15_2.txtNameCn, false)
		gohelper.setActive(arg_15_2.imageNameEn, false)

		local var_15_1 = SummonCustomPickModel.instance:getMaxSelectCount(arg_15_0._poolId)
		local var_15_2 = var_15_1 == 1 or var_15_1 == 3

		gohelper.setActive(arg_15_2.simageHero, not var_15_2)
		gohelper.setActive(arg_15_2.simageHero2, var_15_2)

		local var_15_3 = var_0_0.EmptyHeroIconList[arg_15_3] or var_0_0.EmptyHeroIconList[1]

		if var_15_2 then
			var_15_3 = var_0_0.PickOneEmptyHeroIcon

			arg_15_2.simageHero2:LoadImage(ResUrl.getHandbookheroIcon(var_15_3), arg_15_0.handleLoadedImage, {
				imgTransform = arg_15_2.simageHero2.gameObject.transform
			})
		else
			arg_15_2.simageHero:LoadImage(ResUrl.getHandbookheroIcon(var_15_3))
		end
	end
end

function var_0_0.handleLoadedImage(arg_16_0)
	local var_16_0 = arg_16_0.imgTransform

	ZProj.UGUIHelper.SetImageSize(var_16_0.gameObject)
end

function var_0_0.onClickHeroItem(arg_17_0, arg_17_1)
	if arg_17_1.clickId ~= nil then
		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			heroId = arg_17_1.clickId
		})
	end
end

return var_0_0
