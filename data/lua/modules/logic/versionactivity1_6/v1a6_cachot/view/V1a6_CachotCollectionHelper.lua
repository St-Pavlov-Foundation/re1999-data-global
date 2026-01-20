-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotCollectionHelper.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionHelper", package.seeall)

local V1a6_CachotCollectionHelper = class("V1a6_CachotCollectionHelper")

function V1a6_CachotCollectionHelper.refreshSkillDesc(collectionCfg, parentGo, skillItemGo, overrideSkillCB, overrideEffectCB, overrideCallBackObj)
	local skillList, effectList = V1a6_CachotCollectionConfig.instance:getCollectionSkillsInfo(collectionCfg)
	local skillCount = skillList and #skillList or 0

	tabletool.addValues(skillList, effectList)

	local skillCallBack = overrideSkillCB or V1a6_CachotCollectionHelper._refreshSingleSkillDesc
	local effectCallBack = overrideEffectCB or V1a6_CachotCollectionHelper._refreshSingleEffectDesc
	local callBackObj = overrideCallBackObj or V1a6_CachotCollectionHelper

	gohelper.CreateObjList(callBackObj, skillCallBack, skillList, parentGo, skillItemGo, nil, 1, skillCount)
	gohelper.CreateObjList(callBackObj, effectCallBack, skillList, parentGo, skillItemGo, nil, skillCount + 1)
end

function V1a6_CachotCollectionHelper.refreshSkillDescWithoutEffectDesc(collectionCfg, parentGo, skillItemGo, overrideSkillCB, overrideCallBackObj)
	local skillList = V1a6_CachotCollectionConfig.instance:getCollectionSkillsByConfig(collectionCfg)
	local skillCount = skillList and #skillList or 0
	local skillCallBack = overrideSkillCB or V1a6_CachotCollectionHelper._refreshSingleSkillDesc
	local callBackObj = overrideCallBackObj or V1a6_CachotCollectionHelper

	gohelper.CreateObjList(callBackObj, skillCallBack, skillList, parentGo, skillItemGo, nil, 1, skillCount)
end

function V1a6_CachotCollectionHelper:_refreshSingleSkillDesc(obj, skillId, index)
	local skillCfg = lua_rule.configDict[skillId]
	local skillDesc = skillCfg and skillCfg.desc or ""
	local txtEffectDesc = gohelper.findChildText(obj, "txt_desc")

	txtEffectDesc.text = HeroSkillModel.instance:skillDesToSpot(skillDesc)
end

function V1a6_CachotCollectionHelper:_refreshSingleEffectDesc(obj, effectId, index)
	local effectCfg = SkillConfig.instance:getSkillEffectDescCo(effectId)

	if effectCfg then
		local txtEffectDesc = gohelper.findChildText(obj, "txt_desc")
		local info = string.format("[%s]: %s", effectCfg.name, effectCfg.desc)

		txtEffectDesc.text = HeroSkillModel.instance:skillDesToSpot(info)
	end
end

function V1a6_CachotCollectionHelper.refreshEnchantDesc(collectionCfg, parentGo, spDescItemGo, overrideCallBack, overrideCallBackObj)
	local spDescs = V1a6_CachotCollectionConfig.instance:getCollectionSpDescsByConfig(collectionCfg)
	local callBack = overrideCallBack or V1a6_CachotCollectionHelper._refreshSingleEnchantDesc
	local callBackObj = overrideCallBackObj or V1a6_CachotCollectionHelper

	gohelper.CreateObjList(callBackObj, callBack, spDescs, parentGo, spDescItemGo)
end

function V1a6_CachotCollectionHelper:_refreshSingleEnchantDesc(obj, enchantDesc, index)
	local txtDesc = gohelper.findChildText(obj, "txt_desc")

	txtDesc.text = HeroSkillModel.instance:skillDesToSpot(enchantDesc)
end

function V1a6_CachotCollectionHelper.isCollectionBagCanEnchant()
	local isCollectionHoleEmpty = false
	local isCollectionUnEnchant = false
	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if rogueInfo then
		local collections = rogueInfo.collections
		local enchants = rogueInfo.enchants
		local enchantNum = enchants and #enchants or 0
		local collectionNum = collections and #collections or 0

		if enchantNum <= 0 or collectionNum <= 0 then
			return false
		end

		for index = 1, collectionNum do
			local collection = collections[index]

			isCollectionHoleEmpty, isCollectionUnEnchant = V1a6_CachotCollectionHelper.isCollectionHoleEmptyOrUnEnchant(collection, isCollectionHoleEmpty, isCollectionUnEnchant)

			if isCollectionHoleEmpty and isCollectionUnEnchant then
				break
			end
		end
	end

	return isCollectionHoleEmpty and isCollectionUnEnchant
end

function V1a6_CachotCollectionHelper.isCollectionHoleEmptyOrUnEnchant(collectionMO, isCollectionHoleEmpty, isCollectionUnEnchant)
	local collectionCfg = V1a6_CachotCollectionConfig.instance:getCollectionConfig(collectionMO.cfgId)
	local collectionType = collectionCfg.type

	if collectionType ~= V1a6_CachotEnum.CollectionType.Enchant and not isCollectionHoleEmpty then
		local holeNum = collectionCfg.holeNum
		local enchantCount = collectionMO:getEnchantCount()

		isCollectionHoleEmpty = isCollectionHoleEmpty or enchantCount < holeNum
	elseif collectionType == V1a6_CachotEnum.CollectionType.Enchant and not isCollectionUnEnchant then
		local isEnchant = collectionMO:isEnchant()

		isCollectionUnEnchant = isCollectionUnEnchant or not isEnchant
	end

	return isCollectionHoleEmpty, isCollectionUnEnchant
end

function V1a6_CachotCollectionHelper.createCollectionHoles(collectionCfg, holeParentGO, sourceHoleGO)
	local holeNum = collectionCfg and collectionCfg.holeNum or 0

	gohelper.CreateNumObjList(holeParentGO, sourceHoleGO, holeNum)
end

function V1a6_CachotCollectionHelper.refreshCollectionUniqueTip(collectionCfg, txtTipComp, goTipParent)
	local isUnique = collectionCfg and collectionCfg.unique == 1

	if isUnique then
		local uniqueTips = ""

		if collectionCfg.showRare == V1a6_CachotEnum.CollectionShowRare.Boss then
			uniqueTips = luaLang("v1a6_cachotcollection_bossunique")
		else
			uniqueTips = luaLang("p_v1a6_cachot_collectionbagview_txt_uniquetips")
		end

		if txtTipComp then
			txtTipComp.text = uniqueTips
		end
	end

	if goTipParent then
		gohelper.setActive(goTipParent, isUnique)
	end
end

return V1a6_CachotCollectionHelper
