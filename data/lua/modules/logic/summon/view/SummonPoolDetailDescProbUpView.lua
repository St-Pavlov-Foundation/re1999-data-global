module("modules.logic.summon.view.SummonPoolDetailDescProbUpView", package.seeall)

slot0 = class("SummonPoolDetailDescProbUpView", BaseView)

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
	slot0._probUpItemMap = {}
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0._probUpItemMap) do
		for slot9, slot10 in pairs(slot5.heroIcons) do
			slot10.simageHero:UnLoadImage()
			slot10.btn:RemoveClickListener()
		end
	end

	for slot4, slot5 in pairs(slot0._probUpItemMap) do
		for slot9, slot10 in pairs(slot5.equipIcons) do
			slot10.simageEquip:UnLoadImage()
			slot10.btn:RemoveClickListener()
		end
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
	slot0._probUpRareIds, slot0._probUpIds, slot0._hasProbUpItem = SummonPoolDetailCategoryListModel.buildProbUpDict(slot0._poolId)

	slot0:refreshPropUpAD()
end

function slot0.refreshPropUpAD(slot0)
	if SummonMainModel.isProbUp(SummonConfig.instance:getSummonPool(slot0._poolId)) then
		for slot6 = uv0, 1, -1 do
			slot0:addProbUpItemByRare(slot6)
		end
	end

	gohelper.setActive(slot0._goheroitem, slot2 and slot0._hasProbUpItem)
end

function slot0.addProbUpItemByRare(slot0, slot1)
	if not slot0._probUpRareIds[slot1] then
		return
	end

	for slot6, slot7 in ipairs(slot2) do
		slot8 = slot0:getProbUpItem(slot1)

		gohelper.setActive(slot8.go, true)
		slot0:applyRareStar(slot8, slot1)
		slot0:refreshProbIcons(slot8, slot2)

		slot9 = slot1 == uv0 and ConstEnum.SummonSSRUpProb or ConstEnum.SummonSRUpProb

		if slot0._poolType == SummonEnum.Type.MultiProbUp4 and slot1 == uv0 then
			slot8.txtProbability.text = ""
			slot8.txtProbabilityLabel.text = GameUtil.getSubPlaceholderLuaLang(luaLang("summon_multiup4_rule_title"), {
				slot1 + 1,
				tostring(SummonEnum.MultiProbUp4ShowRate)
			})
		elseif slot0._poolType == SummonEnum.Type.DoubleSsrUp then
			slot8.txtProbability.text = ""
			slot8.txtProbabilityLabel.text = GameUtil.getSubPlaceholderLuaLang(luaLang("p_summonpooldetail_up_probability"), {
				slot1 + 1,
				CommonConfig.instance:getConstNum(ConstEnum.SummonPoolDoubleSSRRate) / 10
			})
		else
			slot8.txtProbability.text = ""
			slot8.txtProbabilityLabel.text = GameUtil.getSubPlaceholderLuaLang(luaLang("p_summonpooldetail_up_probability"), {
				slot1 + 1,
				CommonConfig.instance:getConstNum(ConstEnum.SummonSSRUpProb) / 10
			})
		end
	end
end

function slot0.getProbUpItem(slot0, slot1)
	if not slot0._probUpItemMap[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.heroIcons = {}
		slot2.equipIcons = {}
		slot8 = tostring(slot1)
		slot3 = gohelper.clone(slot0._godesctitle, slot0._goheroitem, "prob_up_item_" .. slot8)
		slot2.go = slot3
		slot2.starList = slot0:getUserDataTb_()
		slot2.iconContainerGo = gohelper.findChild(slot3, "heroshowlist")
		slot2.iconEquipContainerGo = gohelper.findChild(slot3, "equipshowlist")
		slot2.iconTemplateGo = gohelper.findChild(slot3, "heroshowlist/summonpooldetailheroitem")
		slot2.iconEquipTemplateGo = gohelper.findChild(slot3, "equipshowlist/summonpooldetailequipitem")
		slot4 = gohelper.findChild(slot3, "#go_starList")

		for slot8 = 1, uv0 + 1 do
			slot2.starList[slot8] = gohelper.findChild(slot4, "star" .. tostring(slot8))
		end

		slot2.txtProbability = gohelper.findChildText(slot4, "probability/#txt_probability")
		slot2.txtProbabilityLabel = gohelper.findChildText(slot4, "probability")
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
	elseif slot0._resultType == SummonEnum.ResultType.Equip then
		slot0:refreshEquipProbIcons(slot1, slot2)
	end

	gohelper.setActive(slot1.iconContainerGo, slot0._resultType == SummonEnum.ResultType.Char)
	gohelper.setActive(slot1.iconEquipContainerGo, slot0._resultType == SummonEnum.ResultType.Equip)
end

function slot0.refreshHeroProbIcons(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot2) do
		slot8 = slot0:getProbUpHeroIconItem(slot1, slot6)

		gohelper.setActive(slot8.go, true)
		slot0:refreshProbUpHeroIconItem(slot7, slot8)
	end
end

function slot0.refreshEquipProbIcons(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot2) do
		slot8 = slot0:getProbUpEquipIconItem(slot1, slot6)

		gohelper.setActive(slot8.go, true)
		slot0:refreshProbUpEquipIconItem(slot7, slot8)
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
		slot3.data = {}
		slot3.btn = gohelper.findChildButtonWithAudio(slot4, "simage_hero")

		slot3.btn:AddClickListener(slot0.onClickHeroItem, slot0, slot3.data)

		slot1.heroIcons[slot2] = slot3
	end

	return slot3
end

function slot0.refreshProbUpHeroIconItem(slot0, slot1, slot2)
	UISpriteSetMgr.instance:setSummonSprite(slot2.imageRare, HeroConfig.instance:getHeroCO(slot1).rare < uv0 and "bg_choukahuang" or "bg_choukaju")
	UISpriteSetMgr.instance:setCommonSprite(slot2.imageCareer, "lssx_" .. tostring(slot3.career))
	slot2.simageHero:LoadImage(ResUrl.getHandbookheroIcon(slot3.skinId))

	slot2.data.clickId = slot1
	slot2.txtNameCn.text = slot3.name
end

function slot0.getProbUpEquipIconItem(slot0, slot1, slot2)
	if not slot1.equipIcons[slot2] then
		slot3 = slot0:getUserDataTb_()
		slot4 = gohelper.clone(slot1.iconEquipTemplateGo, slot1.iconEquipContainerGo, "prob_up_equip_item")
		slot3.go = slot4
		slot3.imageCareer = gohelper.findChildImage(slot4, "txt_namecn/image_career")
		slot3.simageEquip = gohelper.findChildSingleImage(slot4, "simage_equip")
		slot3.imageNameEn = gohelper.findChildImage(slot4, "image_nameen")
		slot3.txtNameCn = gohelper.findChildText(slot4, "txt_namecn")
		slot3.data = {}
		slot3.btn = gohelper.findChildButtonWithAudio(slot4, "simage_equip")

		slot3.btn:AddClickListener(slot0.onClickEquipItem, slot0, slot3.data)

		slot1.equipIcons[slot2] = slot3
	end

	return slot3
end

function slot0.refreshProbUpEquipIconItem(slot0, slot1, slot2)
	slot2.simageEquip:LoadImage(ResUrl.getEquipSuit(EquipConfig.instance:getEquipCo(slot1).icon))
	transformhelper.setLocalScale(slot2.simageEquip.transform, 0.39, 0.39, 1)

	if not string.nilorempty(EquipHelper.getEquipSkillCareer(slot1, EquipHelper.createMaxLevelEquipMo(slot1).refineLv)) then
		gohelper.setActive(slot2.imageCareer.gameObject, true)
		UISpriteSetMgr.instance:setCommonSprite(slot2.imageCareer, "jinglian_" .. slot5)
	else
		gohelper.setActive(slot2.imageCareer.gameObject, false)
	end

	slot2.data.clickId = slot1
	slot2.txtNameCn.text = slot3.name
end

function slot0.onClickHeroItem(slot0, slot1)
	if slot1.clickId ~= nil then
		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			heroId = slot1.clickId
		})
	end
end

function slot0.onClickEquipItem(slot0, slot1)
	if slot1.clickId ~= nil then
		EquipController.instance:openEquipView({
			equipId = slot1.clickId
		})
	end
end

return slot0
