module("modules.logic.summon.view.custompick.SummonCustomPickDescProbUpView", package.seeall)

slot0 = class("SummonCustomPickDescProbUpView", BaseView)

function slot0.onInitView(slot0)
	slot0._goheroitem = gohelper.findChild(slot0.viewGO, "infoScroll/Viewport/#go_Content/#go_heroItem")
	slot0._godesctitle = gohelper.findChild(slot0.viewGO, "infoScroll/Viewport/#go_Content/#go_heroItem/#go_desctitle")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot1 = 5
slot2 = 5

function slot0._editableInitView(slot0)
	slot0._scrollroot = gohelper.findChildScrollRect(slot0.viewGO, "infoScroll")
	slot0._goscrollcontent = gohelper.findChild(slot0.viewGO, "infoScroll/Viewport/#go_Content")
	slot0._rectscrollcontent = slot0._goscrollcontent.transform
	slot0._probUpItemMap = {}
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.delayJumpToLuckyBag, slot0)

	if slot0._probUpItemMap then
		for slot4, slot5 in pairs(slot0._probUpItemMap) do
			for slot9, slot10 in pairs(slot5.heroIcons) do
				slot10.simageHero:UnLoadImage()
				slot10.simageHero2:UnLoadImage()
				slot10.btn:RemoveClickListener()
			end

			for slot9, slot10 in pairs(slot5.equipIcons) do
				slot10.simageEquip:UnLoadImage()
				slot10.btn:RemoveClickListener()
			end
		end

		slot0._probUpItemMap = nil
	end
end

function slot0.onUpdateParam(slot0)
	slot0:onOpen()
end

function slot0.onOpen(slot0)
	slot0._poolParam = SummonController.instance:getPoolInfo()
	slot0._poolDetailId = slot0._poolParam.poolDetailId
	slot0._poolId = slot0._poolParam.poolId
	slot1 = SummonConfig.instance:getSummonPool(slot0._poolId)
	slot0._resultType = SummonMainModel.getResultType(slot1)
	slot0._poolType = slot1.type

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0._resultIds = SummonPoolDetailCategoryListModel.buildCustomPickDict(slot0._poolId)

	slot0:refreshPropUpAD()
end

function slot0.refreshPropUpAD(slot0)
	slot1 = SummonConfig.instance:getSummonPool(slot0._poolId)
	slot2 = slot0:getProbUpItem(1)

	gohelper.setActive(slot2.go, true)
	slot0:applyRareStar(slot2, SummonEnum.CustomPickRare)
	slot0:refreshProbIcons(slot2, slot0._resultIds)

	slot3, slot4, slot5 = SummonMainModel.instance:getCustomPickProbability(slot0._poolId)

	gohelper.setActive(slot2.txtProbability, slot4 ~= 0 or not slot5)

	if slot4 ~= 0 then
		slot2.txtProbabilityLabel.text = GameUtil.getSubPlaceholderLuaLangThreeParam(luaLang(slot4 ~= 0 and "summonpooldetail_up_probability_total" or "p_summonpooldetail_up_probability"), SummonEnum.CustomPickRare + 1, slot3, slot4 / 10)
	elseif slot5 then
		slot2.txtProbabilityLabel.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("summonpooldetail_up_probability_StrongCustomOnePick"), slot6, slot3)
	else
		slot2.txtProbability.text = ""
		slot2.txtProbabilityLabel.text = GameUtil.getSubPlaceholderLuaLang(luaLang("p_summonpooldetail_up_probability"), {
			SummonEnum.CustomPickRare + 1,
			SummonMainModel.instance:getCustomPickProbability(slot0._poolId)
		})
	end
end

function slot0.getProbUpItem(slot0, slot1)
	if not slot0._probUpItemMap[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.heroIcons = {}
		slot2.equipIcons = {}
		slot7 = tostring(slot1)
		slot3 = gohelper.clone(slot0._godesctitle, slot0._goheroitem, "prob_up_item_" .. slot7)
		slot2.go = slot3
		slot2.starList = slot0:getUserDataTb_()
		slot2.iconContainerGo = gohelper.findChild(slot3, "heroshowlist")
		slot2.iconEquipContainerGo = gohelper.findChild(slot3, "equipshowlist")
		slot2.iconTemplateGo = gohelper.findChild(slot3, "heroshowlist/summonpooldetailheroitem")
		slot2.iconEquipTemplateGo = gohelper.findChild(slot3, "equipshowlist/summonpooldetailequipitem")
		slot2.starContainerGo = gohelper.findChild(slot3, "#go_starList")

		for slot7 = 1, uv0 + 1 do
			slot2.starList[slot7] = gohelper.findChild(slot2.starContainerGo, "star" .. tostring(slot7))
		end

		slot2.txtProbability = gohelper.findChildText(slot2.starContainerGo, "probability/#txt_probability")
		slot2.txtProbabilityLabel = gohelper.findChildText(slot2.starContainerGo, "probability")
		slot0._probUpItemMap[slot1] = slot2
	end

	return slot2
end

function slot0.applyRareStar(slot0, slot1, slot2)
	for slot6 = 1, uv0 + 1 do
		gohelper.setActive(slot1.starList[slot6], slot6 <= slot2 + 1)
	end
end

function slot0.refreshProbIcons(slot0, slot1, slot2)
	if slot0._resultType == SummonEnum.ResultType.Char then
		slot0:refreshHeroProbIcons(slot1, slot2)
	end

	gohelper.setActive(slot1.iconContainerGo, slot0._resultType == SummonEnum.ResultType.Char)
	gohelper.setActive(slot1.iconEquipContainerGo, slot0._resultType == SummonEnum.ResultType.Equip)
end

function slot0.refreshHeroProbIcons(slot0, slot1, slot2)
	slot6 = slot0._poolId

	for slot6 = 1, SummonCustomPickModel.instance:getMaxSelectCount(slot6) do
		slot8 = slot0:getProbUpHeroIconItem(slot1, slot6)

		gohelper.setActive(slot8.go, true)
		slot0:refreshProbUpHeroIconItem(slot2[slot6], slot8, slot6)
	end
end

function slot0.getProbUpHeroIconItem(slot0, slot1, slot2)
	if not slot1.heroIcons[slot2] then
		slot3 = slot0:getUserDataTb_()
		slot4 = gohelper.clone(slot1.iconTemplateGo, slot1.iconContainerGo, "prob_up_item")
		slot3.go = slot4
		slot3.imageRare = gohelper.findChildImage(slot4, "image_rare")
		slot3.imageCareer = gohelper.findChildImage(slot4, "image_career")
		slot3.simageHero = gohelper.findChildSingleImage(slot4, "simage_hero")
		slot3.imageNameEn = gohelper.findChildImage(slot4, "image_nameen")
		slot3.txtNameCn = gohelper.findChildText(slot4, "txt_namecn")
		slot3.simageHero2 = gohelper.findChildSingleImage(slot4, "simage_hero2")
		slot3.data = {}
		slot3.btn = gohelper.findChildButtonWithAudio(slot4, "simage_hero")

		slot3.btn:AddClickListener(slot0.onClickHeroItem, slot0, slot3.data)

		slot1.heroIcons[slot2] = slot3
	end

	return slot3
end

slot0.EmptyHeroIconList = {
	"306601_1",
	"302501_1"
}
slot0.PickOneEmptyHeroIcon = "306601_1"

function slot0.refreshProbUpHeroIconItem(slot0, slot1, slot2, slot3)
	if slot1 then
		gohelper.setActive(slot2.imageRare, true)
		gohelper.setActive(slot2.imageCareer, true)
		gohelper.setActive(slot2.txtNameCn, true)
		gohelper.setActive(slot2.imageNameEn, true)
		gohelper.setActive(slot2.simageHero2, false)
		UISpriteSetMgr.instance:setSummonSprite(slot2.imageRare, HeroConfig.instance:getHeroCO(slot1).rare < uv0 and "bg_choukahuang" or "bg_choukaju")
		UISpriteSetMgr.instance:setCommonSprite(slot2.imageCareer, "lssx_" .. tostring(slot4.career))
		slot2.simageHero:LoadImage(ResUrl.getHandbookheroIcon(slot4.skinId))

		slot2.data.clickId = slot1
		slot2.txtNameCn.text = slot4.name
	else
		gohelper.setActive(slot2.imageRare, false)
		gohelper.setActive(slot2.imageCareer, false)
		gohelper.setActive(slot2.txtNameCn, false)
		gohelper.setActive(slot2.imageNameEn, false)

		slot5 = SummonCustomPickModel.instance:getMaxSelectCount(slot0._poolId) == 1 or slot4 == 3

		gohelper.setActive(slot2.simageHero, not slot5)
		gohelper.setActive(slot2.simageHero2, slot5)

		slot6 = uv1.EmptyHeroIconList[slot3] or uv1.EmptyHeroIconList[1]

		if slot5 then
			slot2.simageHero2:LoadImage(ResUrl.getHandbookheroIcon(uv1.PickOneEmptyHeroIcon), slot0.handleLoadedImage, {
				imgTransform = slot2.simageHero2.gameObject.transform
			})
		else
			slot2.simageHero:LoadImage(ResUrl.getHandbookheroIcon(slot6))
		end
	end
end

function slot0.handleLoadedImage(slot0)
	ZProj.UGUIHelper.SetImageSize(slot0.imgTransform.gameObject)
end

function slot0.onClickHeroItem(slot0, slot1)
	if slot1.clickId ~= nil then
		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			heroId = slot1.clickId
		})
	end
end

return slot0
