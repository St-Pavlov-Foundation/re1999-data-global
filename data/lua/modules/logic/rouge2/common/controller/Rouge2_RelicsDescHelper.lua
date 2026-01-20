-- chunkname: @modules/logic/rouge2/common/controller/Rouge2_RelicsDescHelper.lua

module("modules.logic.rouge2.common.controller.Rouge2_RelicsDescHelper", package.seeall)

local Rouge2_RelicsDescHelper = class("Rouge2_RelicsDescHelper")

Rouge2_RelicsDescHelper.ActiveEffectColor = "#201F1E"
Rouge2_RelicsDescHelper.DisactiveEffectColor = "#7E7E7E"

function Rouge2_RelicsDescHelper._type2GetDescFunc(descType)
	if not Rouge2_RelicsDescHelper._getDescFuncMap then
		Rouge2_RelicsDescHelper._getDescFuncMap = {}
		Rouge2_RelicsDescHelper._getDescFuncMap[Rouge2_Enum.RelicsDescType.Desc] = Rouge2_RelicsDescHelper._getDesc_Desc
		Rouge2_RelicsDescHelper._getDescFuncMap[Rouge2_Enum.RelicsDescType.UnlockDesc] = Rouge2_RelicsDescHelper._getDesc_UnlockDesc
		Rouge2_RelicsDescHelper._getDescFuncMap[Rouge2_Enum.RelicsDescType.NarrativeDesc] = Rouge2_RelicsDescHelper._getDesc_NarrativeDesc
		Rouge2_RelicsDescHelper._getDescFuncMap[Rouge2_Enum.RelicsDescType.LevelUp] = Rouge2_RelicsDescHelper._getDesc_LevelUp
		Rouge2_RelicsDescHelper._getDescFuncMap[Rouge2_Enum.RelicsDescType.NarrativeDescOutside] = Rouge2_RelicsDescHelper._getDesc_NarrativeDescOutside
	end

	local func = Rouge2_RelicsDescHelper._getDescFuncMap[descType]

	if not func then
		logError(string.format("肉鸽不存在获取指定造物描述的方法, descType = %s", descType))
	end

	return func
end

function Rouge2_RelicsDescHelper._getDesc_Desc(model, config, descType, descMode, resultDescList)
	local isSimply = descMode == Rouge2_Enum.ItemDescMode.Simply
	local descStr = isSimply and config.descSimply or config.desc

	if string.nilorempty(descStr) then
		return
	end

	local descList = Rouge2_RelicsDescHelper._tryProcessBandRelicsDesc(model, config, descStr)

	descList = descList or string.split(descStr, "|")

	local descNum = descList and #descList or 0

	for i = 1, descNum do
		local desc = descList[i]
		local descResult = Rouge2_ItemExpressionHelper.getDescResult(model, config, desc)
		local isTrigger = model == nil and true or model:isTriggerEffect(i)
		local descMo = Rouge2_ItemDescHelper._buildDescMo(descType, descMode, Rouge2_Enum.RelicsDescParam.Desc, descResult, Rouge2_Enum.RelicsDescParam.isTrigger, isTrigger)

		Rouge2_ItemDescHelper._addDescMo(resultDescList, descMo)
	end
end

function Rouge2_RelicsDescHelper._tryProcessBandRelicsDesc(model, config, descStr)
	if config.id == Rouge2_MapConfig.instance:getBandRelicsId() then
		local descList = {}
		local splitDescList = string.split(descStr, "|")

		for _, splitDescStr in ipairs(splitDescList) do
			local splitDescInfo = string.split(splitDescStr, ":")
			local attrId = tonumber(splitDescInfo[1])
			local desc = splitDescInfo[2]

			if not model then
				table.insert(descList, desc)
			elseif model:getAttrValue(attrId) > 0 then
				table.insert(descList, desc)
			end
		end

		return descList
	end
end

function Rouge2_RelicsDescHelper._getDesc_UnlockDesc(model, config, descType, descMode, resultDescList)
	if string.nilorempty(config.unlockEffectDesc) then
		return
	end

	local isUnlock = model == nil and true or model:isTriggerUnlockEffect()
	local descMo = Rouge2_ItemDescHelper._buildDescMo(descType, descMode, Rouge2_Enum.RelicsDescParam.Desc, config.unlockEffectDesc, Rouge2_Enum.RelicsDescParam.Condition, config.unlockConditionDesc, Rouge2_Enum.RelicsDescParam.isTrigger, isUnlock)

	table.insert(resultDescList, descMo)
end

function Rouge2_RelicsDescHelper._getDesc_NarrativeDesc(model, config, descType, descMode, resultDescList)
	if string.nilorempty(config.narrativeDesc) then
		return
	end

	local descMo = Rouge2_ItemDescHelper._buildDescMo(descType, descMode, Rouge2_Enum.RelicsDescParam.Desc, config.narrativeDesc)

	table.insert(resultDescList, descMo)
end

function Rouge2_RelicsDescHelper._getDesc_NarrativeDescOutside(model, config, descType, descMode, resultDescList)
	if string.nilorempty(config.narrativeDesc) then
		return
	end

	local descMo = Rouge2_ItemDescHelper._buildDescMo(descType, descMode, Rouge2_Enum.RelicsDescParam.Desc, string.format("<color=#C2AA99><i>%s<i></color>", config.narrativeDesc))

	table.insert(resultDescList, descMo)
end

function Rouge2_RelicsDescHelper._getDesc_LevelUp(model, config, descType, descMode, resultDescList)
	if string.nilorempty(config.descUpdate) then
		return
	end

	local descMo = Rouge2_ItemDescHelper._buildDescMo(descType, descMode, Rouge2_Enum.RelicsDescParam.LevelUp, config.descUpdate)

	table.insert(resultDescList, descMo)
end

function Rouge2_RelicsDescHelper._descType2ShowType(descType)
	return Rouge2_Enum.RelicsDescType2ShowType[descType]
end

function Rouge2_RelicsDescHelper._type2SetDescFunc(showType)
	if not Rouge2_RelicsDescHelper._setDescFuncMap then
		Rouge2_RelicsDescHelper._setDescFuncMap = {}
		Rouge2_RelicsDescHelper._setDescFuncMap[Rouge2_Enum.RelicsDescShowType.OnlyDesc] = Rouge2_RelicsDescHelper._setDesc_OnlyDesc
		Rouge2_RelicsDescHelper._setDescFuncMap[Rouge2_Enum.RelicsDescShowType.DescWithCondition] = Rouge2_RelicsDescHelper._setDesc_DescWithCondition
		Rouge2_RelicsDescHelper._setDescFuncMap[Rouge2_Enum.RelicsDescShowType.SplitLineAndDesc] = Rouge2_RelicsDescHelper._setDesc_SplitLineAndDesc
		Rouge2_RelicsDescHelper._setDescFuncMap[Rouge2_Enum.RelicsDescShowType.LevelUp] = Rouge2_RelicsDescHelper._setDesc_LevelUp
	end

	local func = Rouge2_RelicsDescHelper._setDescFuncMap[showType]

	if not func then
		logError(string.format("肉鸽不存在获取指定造物描述的方法, showType = %s", showType))
	end

	return func
end

function Rouge2_RelicsDescHelper._setDesc_OnlyDesc(descMo, goItem)
	local txtDesc = gohelper.findChildText(goItem, "txt_desc")
	local imagePoint = gohelper.findChildImage(goItem, "txt_desc/image_point")
	local desc = descMo:getValue(Rouge2_Enum.RelicsDescParam.Desc)
	local isTrigger = descMo:getValue(Rouge2_Enum.RelicsDescParam.isTrigger)

	Rouge2_RelicsDescHelper._setPointImage(imagePoint, isTrigger)
	Rouge2_RelicsDescHelper._updateTxtComp(txtDesc, desc, isTrigger)
end

function Rouge2_RelicsDescHelper._setDesc_DescWithCondition(descMo, goItem)
	local txtDesc = gohelper.findChildText(goItem, "txt_desc")
	local txtCondition = gohelper.findChildText(goItem, "txt_desc2")
	local imagePoint = gohelper.findChildImage(goItem, "txt_desc/image_point")

	SkillHelper.addHyperLinkClick(txtDesc)
	SkillHelper.addHyperLinkClick(txtCondition)

	local desc = descMo:getValue(Rouge2_Enum.RelicsDescParam.Desc)
	local condition = descMo:getValue(Rouge2_Enum.RelicsDescParam.Condition)
	local isTrigger = descMo:getValue(Rouge2_Enum.RelicsDescParam.isTrigger)

	Rouge2_RelicsDescHelper._setPointImage(imagePoint, isTrigger)
	Rouge2_RelicsDescHelper._updateTxtComp(txtDesc, desc, isTrigger)
	Rouge2_RelicsDescHelper._updateTxtComp(txtCondition, condition, isTrigger)
	gohelper.setActive(txtCondition.gameObject, not isTrigger)
end

function Rouge2_RelicsDescHelper._setDesc_SplitLineAndDesc(descMo, goItem)
	local txtDesc = gohelper.findChildText(goItem, "txt_desc")
	local desc = descMo:getValue(Rouge2_Enum.RelicsDescParam.Desc)

	txtDesc.text = Rouge2_ItemDescHelper.buildDesc(desc)

	SkillHelper.addHyperLinkClick(txtDesc)
	LuaUtil.updateTMPRectHeight_LayoutElement(txtDesc)
end

function Rouge2_RelicsDescHelper._setDesc_LevelUp(descMo, goItem)
	local txtDesc = gohelper.findChildText(goItem, "extra/txt_desc")
	local desc = descMo:getValue(Rouge2_Enum.RelicsDescParam.LevelUp)

	txtDesc.text = Rouge2_ItemDescHelper.buildDesc(desc)

	SkillHelper.addHyperLinkClick(txtDesc)
	LuaUtil.updateTMPRectHeight_LayoutElement(txtDesc)
end

function Rouge2_RelicsDescHelper._setPointImage(imagePoint, isTrigger)
	local pointImageName = isTrigger and "rouge_collection_point1" or "rouge_collection_point2"

	UISpriteSetMgr.instance:setRougeSprite(imagePoint, pointImageName)
end

function Rouge2_RelicsDescHelper._updateTxtComp(txtComp, content, isTrigger)
	if string.nilorempty(content) then
		txtComp.text = ""

		return
	end

	txtComp.text = Rouge2_ItemDescHelper.buildDesc(content)

	SkillHelper.addHyperLinkClick(txtComp)
	LuaUtil.updateTMPRectHeight_LayoutElement(txtComp)
	Rouge2_ItemDescHelper.addFixTmpBreakLine(txtComp)
	Rouge2_RelicsDescHelper._setTxtColor(txtComp, isTrigger)
end

function Rouge2_RelicsDescHelper._setTxtColor(txtComp, isTrigger)
	local color = isTrigger and Rouge2_RelicsDescHelper.ActiveEffectColor or Rouge2_RelicsDescHelper.DisactiveEffectColor

	SLFramework.UGUI.GuiHelper.SetColor(txtComp, color)
end

function Rouge2_RelicsDescHelper.getDefaultIncludeTypeList()
	if not Rouge2_RelicsDescHelper._defaultIncludeTypeList then
		Rouge2_RelicsDescHelper._defaultIncludeTypeList = {
			Rouge2_Enum.RelicsDescType.LevelUp,
			Rouge2_Enum.RelicsDescType.Desc,
			Rouge2_Enum.RelicsDescType.UnlockDesc,
			Rouge2_Enum.RelicsDescType.NarrativeDesc
		}
	end

	return Rouge2_RelicsDescHelper._defaultIncludeTypeList
end

return Rouge2_RelicsDescHelper
