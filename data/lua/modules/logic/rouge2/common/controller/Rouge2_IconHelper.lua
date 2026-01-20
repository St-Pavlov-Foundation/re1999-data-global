-- chunkname: @modules/logic/rouge2/common/controller/Rouge2_IconHelper.lua

module("modules.logic.rouge2.common.controller.Rouge2_IconHelper", package.seeall)

local Rouge2_IconHelper = class("Rouge2_IconHelper")

function Rouge2_IconHelper.setItemIconAndRare(itemId, simageIcon, imageRare)
	Rouge2_IconHelper.setGameItemIcon(itemId, simageIcon)
	Rouge2_IconHelper.setGameItemRare(itemId, imageRare)
end

function Rouge2_IconHelper.setGameItemIcon(itemId, simageIcon)
	local itemType = Rouge2_BackpackHelper.itemId2BagType(itemId)

	if itemType == Rouge2_Enum.BagType.Relics then
		Rouge2_IconHelper.setRelicsIcon(itemId, simageIcon)
	elseif itemType == Rouge2_Enum.BagType.Buff then
		Rouge2_IconHelper.setBuffIcon(itemId, simageIcon)
	elseif itemType == Rouge2_Enum.BagType.ActiveSkill then
		Rouge2_IconHelper.setActiveSkillIcon(itemId, simageIcon)
	else
		logError(string.format("肉鸽构筑物图标加载失败: 未定义的构筑物类型: itemId = %s, itemType = %s", itemId, itemType))
	end
end

function Rouge2_IconHelper.setGameItemRare(itemId, imageRare)
	local itemType = Rouge2_BackpackHelper.itemId2BagType(itemId)

	if itemType == Rouge2_Enum.BagType.Relics then
		Rouge2_IconHelper.setRelicsRareIcon(itemId, imageRare)
	elseif itemType == Rouge2_Enum.BagType.Buff then
		Rouge2_IconHelper.setBuffRareIcon(itemId, imageRare)
	elseif itemType == Rouge2_Enum.BagType.ActiveSkill then
		gohelper.setActive(imageRare.gameObject, false)
	else
		logError(string.format("肉鸽构筑物图标加载失败: 未定义的构筑物类型: itemId = %s, itemType = %s", itemId, itemType))
	end
end

function Rouge2_IconHelper.setAttributeIcon(attrId, imageIcon, suffix)
	if not attrId or string.nilorempty(attrId) or tonumber(attrId) == 0 then
		gohelper.setActive(imageIcon.gameObject, false)

		return
	end

	gohelper.setActive(imageIcon.gameObject, true)

	local attrCo = Rouge2_AttributeConfig.instance:getAttributeConfig(attrId)

	if not attrCo then
		return
	end

	if not imageIcon then
		logError("Rouge2_IconHelper.setAttributeIcon error imageIcon is nil")

		return
	end

	suffix = suffix or Rouge2_Enum.AttrIconSuffix.Small

	local iconFullName = string.format("%s%s", attrCo.icon, suffix)

	UISpriteSetMgr.instance:setRouge6Sprite(imageIcon, iconFullName, true)
end

function Rouge2_IconHelper.setActiveSkillIcon(skillId, simageIcon)
	local skillCo = Rouge2_CollectionConfig.instance:getActiveSkillConfig(skillId)

	if not skillCo then
		return
	end

	if not simageIcon then
		logError("Rouge2_IconHelper.setActiveSkillIcon error iconImageComp is nil")

		return
	end

	simageIcon:LoadImage(ResUrl.getRougeIcon("collection/" .. skillCo.icon))
end

function Rouge2_IconHelper.setPassiveSkillIcon(skillId, iconImageComp)
	local skillCo = Rouge2_AttributeConfig.instance:getPassiveSkillConfig(skillId)

	if not skillCo then
		return
	end

	if not iconImageComp then
		logError("Rouge2_IconHelper.setPassiveSkillIcon error iconImageComp is nil")

		return
	end
end

function Rouge2_IconHelper.setRelicsIcon(relicsId, simageIcon)
	local relicsCo = Rouge2_CollectionConfig.instance:getRelicsConfig(relicsId)

	if not relicsCo then
		return
	end

	if not simageIcon then
		logError("Rouge2_IconHelper.setRelicsIcon error simageIcon is nil")

		return
	end

	simageIcon:LoadImage(ResUrl.getRougeIcon("collection/" .. relicsCo.icon))
end

function Rouge2_IconHelper.setRelicsRareIcon(relicsId, imageIcon, iconType)
	local relicsCo = Rouge2_CollectionConfig.instance:getRelicsConfig(relicsId)

	if not relicsCo then
		return
	end

	if not imageIcon then
		logError("Rouge2_IconHelper.setRelicsRareIcon error imageIcon is nil")

		return
	end

	iconType = iconType or Rouge2_Enum.ItemRareIconType.Default

	if iconType == Rouge2_Enum.ItemRareIconType.Default then
		UISpriteSetMgr.instance:setRouge6Sprite(imageIcon, string.format("rouge2_backpackrelics_rare%02d", relicsCo.rare), true)
	elseif iconType == Rouge2_Enum.ItemRareIconType.Bg then
		imageIcon:LoadImage(ResUrl.getRouge2Icon("map/rouge2_relics_panelbg_" .. relicsCo.rare))
	elseif iconType == Rouge2_Enum.ItemRareIconType.NameBg then
		UISpriteSetMgr.instance:setRouge7Sprite(imageIcon, "rouge2_backpackrelics_itemnamebg_" .. relicsCo.rare)
	else
		logError(string.format("肉鸽未定义造物品质图标类型 buffId = %s, iconType = %s", relicsId, iconType))
	end
end

function Rouge2_IconHelper.setCareerIcon(careerId, imageIcon, suffix)
	local careerCo = Rouge2_CareerConfig.instance:getCareerConfig(careerId)

	if not careerCo then
		return
	end

	if not imageIcon then
		logError("Rouge2_IconHelper.setCareerIcon error imageIcon is nil")

		return
	end

	suffix = suffix or Rouge2_Enum.CareerIconSuffix.Tab

	local iconName = string.format("%s%s", careerCo.icon, suffix)

	UISpriteSetMgr.instance:setRouge6Sprite(imageIcon, iconName, true)
end

function Rouge2_IconHelper.setResultCareerIcon(careerId, imageIcon)
	local careerCo = Rouge2_CareerConfig.instance:getCareerConfig(careerId)

	if not careerCo then
		return
	end

	if not imageIcon then
		logError("Rouge2_IconHelper.setResultCareerIcon error imageIcon is nil")

		return
	end

	local iconName = string.format("rouge2_career_icon_%s", careerId)

	UISpriteSetMgr.instance:setRouge6Sprite(imageIcon, iconName, true)
end

function Rouge2_IconHelper.setBuffIcon(buffId, simageIcon)
	local buffCo = Rouge2_CollectionConfig.instance:getBuffCofing(buffId)

	if not buffCo then
		return
	end

	if not simageIcon then
		logError("Rouge2_IconHelper.setBuffIcon error simageIcon is nil")

		return
	end

	simageIcon:LoadImage(ResUrl.getRouge2Icon("buff/" .. buffCo.icon))
end

function Rouge2_IconHelper.setBuffRareIcon(buffId, imageIcon, iconType)
	local buffCo = Rouge2_CollectionConfig.instance:getBuffCofing(buffId)

	if not buffCo then
		return
	end

	if not imageIcon then
		logError("Rouge2_IconHelper.setBuffRareIcon error imageIcon is nil")

		return
	end

	iconType = iconType or Rouge2_Enum.ItemRareIconType.Default

	if iconType == Rouge2_Enum.ItemRareIconType.Default then
		UISpriteSetMgr.instance:setRouge6Sprite(imageIcon, "rouge2_buff_quality_" .. buffCo.rare, true)
	elseif iconType == Rouge2_Enum.ItemRareIconType.Bg then
		UISpriteSetMgr.instance:setRouge7Sprite(imageIcon, "rouge2_mapchoice_itembg_" .. buffCo.rare)
	elseif iconType == Rouge2_Enum.ItemRareIconType.NameBg then
		UISpriteSetMgr.instance:setRouge7Sprite(imageIcon, "rouge2_buff_namebg_" .. buffCo.rare)
	elseif iconType == Rouge2_Enum.ItemRareIconType.TagBg then
		UISpriteSetMgr.instance:setRouge7Sprite(imageIcon, "rouge2_bufftag_" .. buffCo.rare)
	else
		logError(string.format("肉鸽未定义谐波品质图标类型 buffId = %s, iconType = %s", buffId, iconType))
	end
end

function Rouge2_IconHelper.setTagIcon(tagId, iconImageComp)
	local tagCo = Rouge2_CollectionConfig.instance:getTagCofing(tagId)

	if not tagCo then
		return
	end

	if not iconImageComp then
		logError("Rouge2_IconHelper.setTagIcon error iconImageComp is nil")

		return
	end
end

function Rouge2_IconHelper.setWeatherIcon(weatherId, imageIcon, suffix)
	local weatherCo = Rouge2_MapConfig.instance:getWeatherConfig(weatherId)

	if not weatherCo then
		return
	end

	if not imageIcon then
		logError("Rouge2_IconHelper.setWeatherIcon error imageIcon is nil")

		return
	end

	suffix = suffix or Rouge2_MapEnum.WeatherIconSuffix.Normal

	local iconName = string.format("%s%s", weatherCo.icon, suffix)

	UISpriteSetMgr.instance:setRouge6Sprite(imageIcon, iconName)
end

function Rouge2_IconHelper.setBandHeroIcon(bandId, simageIcon)
	local bandCo = Rouge2_MapConfig.instance:getBandConfig(bandId)

	if not bandCo then
		return
	end

	if not simageIcon then
		logError("Rouge2_IconHelper.setWeatherIcon error simageIcon is nil")

		return
	end

	simageIcon:LoadImage(ResUrl.getHeadIconSmall(bandCo.icon))
end

function Rouge2_IconHelper.setTalentIcon(talentId, simageIcon)
	local talentCo = Rouge2_OutSideConfig.instance:getTalentConfigById(talentId)

	if not talentCo then
		return
	end

	if not simageIcon then
		logError("Rouge2_IconHelper.setTalentIcon error iconImageComp is nil")

		return
	end

	simageIcon:LoadImage(ResUrl.getRouge2Icon("talent/" .. talentCo.icon))
end

function Rouge2_IconHelper.setFormulaIcon(formulaId, simageIcon)
	local formulaCo = Rouge2_OutSideConfig.instance:getFormulaConfig(formulaId)

	if not formulaCo then
		return
	end

	if not simageIcon then
		logError("Rouge2_IconHelper.setFormulaIcon error iconImageComp is nil")

		return
	end

	simageIcon:LoadImage(ResUrl.getRougeIcon("collection/" .. formulaCo.icon))
end

function Rouge2_IconHelper.setMaterialIcon(materialId, simageIcon)
	local materialCo = Rouge2_OutSideConfig.instance:getMaterialConfig(materialId)

	if not materialCo then
		return
	end

	if not simageIcon then
		logError("Rouge2_IconHelper.setMaterialIcon error iconImageComp is nil")

		return
	end

	simageIcon:LoadImage(ResUrl.getRougeIcon("collection/" .. materialCo.icon))
end

function Rouge2_IconHelper.setFormulaRareBg(rare, iconImageComp)
	if not iconImageComp then
		logError("Rouge2_IconHelper.setFormulaRareBg error iconImageComp is nil")

		return
	end

	local path = "rouge2_quality_circle_" .. rare

	UISpriteSetMgr.instance:setRouge6Sprite(iconImageComp, path)
end

function Rouge2_IconHelper.setMaterialRareBg(rare, iconImageComp)
	if not iconImageComp then
		logError("Rouge2_IconHelper.setMaterialRareBg error iconImageComp is nil")

		return
	end

	local path = "rouge2_quality_square_" .. rare

	UISpriteSetMgr.instance:setRouge6Sprite(iconImageComp, path)
end

function Rouge2_IconHelper.setAlchemyRareBg(rare, iconImageComp)
	if not iconImageComp then
		logError("Rouge2_IconHelper.setAlchemyRareBg error iconImageComp is nil")

		return
	end

	local path = "rouge2_quality_square_" .. rare

	UISpriteSetMgr.instance:setRouge6Sprite(iconImageComp, path)
end

function Rouge2_IconHelper.setRougeEventIcon2(id, iconImageComp)
	if not iconImageComp then
		logError("Rouge2_IconHelper.setRougeEventIcon error iconImageComp is nil")

		return
	end

	local path = string.format("rouge2_event_icon_%s_2", tostring(id))

	UISpriteSetMgr.instance:setRouge6Sprite(iconImageComp, path)
end

function Rouge2_IconHelper.setRougeIllustrationSmallIcon(id, simageIcon)
	local config = Rouge2_OutSideConfig.instance:getIllustrationConfig(id)

	if not config then
		return
	end

	if not simageIcon then
		logError("Rouge2_IconHelper.setRougeIllustrationSmallIcon error iconImageComp is nil")

		return
	end

	simageIcon:LoadImage(ResUrl.getRouge2Icon("small/" .. config.image))
end

function Rouge2_IconHelper.setRougeIllustrationBigIcon(id, simageIcon)
	local config = Rouge2_OutSideConfig.instance:getIllustrationConfig(id)

	if not config then
		return
	end

	if not simageIcon then
		logError("Rouge2_IconHelper.setRougeIllustrationSmallIcon error iconImageComp is nil")

		return
	end

	simageIcon:LoadImage(ResUrl.getRouge2Icon("choice/" .. config.fullImage))
end

function Rouge2_IconHelper.setItemIcon(itemId, simageIcon)
	local bagType = Rouge2_BackpackHelper.itemId2Tag(itemId)

	if not simageIcon then
		logError("Rouge2_IconHelper.setItemIcon error iconImageComp is nil")

		return
	end

	if bagType == Rouge2_OutsideEnum.CollectionListType.AutoBuff then
		Rouge2_IconHelper.setActiveSkillIcon(itemId, simageIcon)
	elseif bagType == Rouge2_OutsideEnum.CollectionListType.Buff then
		Rouge2_IconHelper.setBuffIcon(itemId, simageIcon)
	elseif bagType == Rouge2_OutsideEnum.CollectionListType.Collection then
		Rouge2_IconHelper.setRelicsIcon(itemId, simageIcon)
	else
		logError(string.format("Rouge2_BackpackHelper.getItemConfig 未定义背包类型, bagType = %s, itemId = %s", bagType, itemId))
	end
end

function Rouge2_IconHelper.setRougeAchievementIcon(id, simageIcon)
	local config = Rouge2_Config.instance:getRougeBadgeCO(id)

	if not config then
		return
	end

	if not simageIcon then
		logError("Rouge2_IconHelper.setRougeIllustrationSmallIcon error iconImageComp is nil")

		return
	end

	simageIcon:LoadImage(ResUrl.getRouge2Icon("achieve/" .. config.icon))
end

return Rouge2_IconHelper
