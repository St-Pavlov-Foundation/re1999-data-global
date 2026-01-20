-- chunkname: @modules/logic/rouge2/common/controller/Rouge2_ItemDescHelper.lua

module("modules.logic.rouge2.common.controller.Rouge2_ItemDescHelper", package.seeall)

local Rouge2_ItemDescHelper = class("Rouge2_ItemDescHelper")

function Rouge2_ItemDescHelper._getItemDescList(helper, dataType, dataId, descMode, includeTypeList)
	includeTypeList = includeTypeList or helper.getDefaultIncludeTypeList()

	local resultDescList = {}
	local itemCo, itemMo = Rouge2_BackpackHelper.getItemCofigAndMo(dataType, dataId)

	for _, descType in ipairs(includeTypeList) do
		local func = helper._type2GetDescFunc(descType)

		if func then
			func(itemMo, itemCo, descType, descMode, resultDescList)
		end
	end

	return resultDescList
end

function Rouge2_ItemDescHelper._buildDescMo(descType, descMode, ...)
	local mo = Rouge2_ItemDescInfoMO.New()

	mo:init(descType, descMode, ...)

	return mo
end

function Rouge2_ItemDescHelper._addDescMo(moList, mo)
	if not mo then
		return
	end

	table.insert(moList, mo)
end

function Rouge2_ItemDescHelper._setOneDesc(helper, goRoot, unUseItemMap, descMo)
	if not descMo then
		return
	end

	local descType = descMo:getDescType()
	local showType = helper._descType2ShowType and helper._descType2ShowType(descType)
	local unUseItemList = unUseItemMap and unUseItemMap[showType]
	local goItem = unUseItemList and unUseItemList[1]

	if goItem then
		goItem = table.remove(unUseItemList, 1)
	else
		local goTemplate = gohelper.findChild(goRoot, string.format("go_Type%s", showType))

		goItem = gohelper.cloneInPlace(goTemplate, showType)
	end

	gohelper.setActive(goItem, true)
	gohelper.setAsLastSibling(goItem)

	local setFunc = helper._type2SetDescFunc and helper._type2SetDescFunc(showType)

	if setFunc and goItem then
		setFunc(descMo, goItem)
	end
end

function Rouge2_ItemDescHelper._buildUnuseItemMap(goParent)
	if gohelper.isNil(goParent) then
		logError("肉鸽构筑物描述根节点不存在")

		return
	end

	local unUseItemMap = {}
	local tranParent = goParent.transform
	local childNum = tranParent.childCount

	for i = 1, childNum do
		local goChild = tranParent:GetChild(i - 1).gameObject
		local goChildName = goChild.name
		local childType = string.splitToNumber(goChildName, "_")[1]

		if childType then
			unUseItemMap[childType] = unUseItemMap[childType] or {}

			table.insert(unUseItemMap[childType], goChild)
		end

		gohelper.setActive(goChild, false)
	end

	return unUseItemMap
end

function Rouge2_ItemDescHelper.getItemDescList(dataType, dataId, descMode, includeTypeList)
	local helper = Rouge2_ItemDescHelper._getItemDescHelper(dataType, dataId)

	if not helper then
		return {}
	end

	return Rouge2_ItemDescHelper._getItemDescList(helper, dataType, dataId, descMode, includeTypeList)
end

function Rouge2_ItemDescHelper._getItemDescHelper(dataType, dataId)
	local itemId, uid = Rouge2_BackpackHelper.getItemIdAndUid(dataType, dataId)
	local itemType = Rouge2_BackpackHelper.itemId2BagType(itemId)
	local helper = itemType and Rouge2_Enum.ItemType2DescHelper[itemType]

	if not helper then
		logError(string.format("Rouge2_ItemDescHelper.getItemDescHelper error helper is nil ! dataType = %s, dataId = %s, itemId = %s, itemType = %s", dataType, dataId, itemId, itemType))
	end

	return helper
end

function Rouge2_ItemDescHelper.getDefaultIncludeTypeList(dataType, dataId)
	local helper = Rouge2_ItemDescHelper._getItemDescHelper(dataType, dataId)

	if helper then
		return helper.getDefaultIncludeTypeList()
	end

	return nil
end

function Rouge2_ItemDescHelper.addFixTmpBreakLine(txtComp)
	if not txtComp then
		return
	end

	local fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(txtComp.gameObject, FixTmpBreakLine)

	fixTmpBreakLine:refreshTmpContent(txtComp)

	return fixTmpBreakLine
end

function Rouge2_ItemDescHelper._setDesc(dataType, dataId, goParent, descMode, includeTypeList)
	local helper = Rouge2_ItemDescHelper._getItemDescHelper(dataType, dataId)
	local descMoList = Rouge2_ItemDescHelper._getItemDescList(helper, dataType, dataId, descMode, includeTypeList)
	local unUseItemMap = Rouge2_ItemDescHelper._buildUnuseItemMap(goParent)

	if not descMoList or not unUseItemMap then
		return
	end

	for _, descMo in ipairs(descMoList) do
		Rouge2_ItemDescHelper._setOneDesc(helper, goParent, unUseItemMap, descMo)
	end
end

function Rouge2_ItemDescHelper.setItemDesc(dataType, dataId, goParent, descMode, includeTypeList)
	Rouge2_ItemDescHelper._setDesc(dataType, dataId, goParent, descMode, includeTypeList)
end

function Rouge2_ItemDescHelper.getItemDescStr(dataType, dataId, descMode, includeTypeList)
	local contentList = {}
	local itemDescList = Rouge2_ItemDescHelper.getItemDescList(dataType, dataId, descMode, includeTypeList)

	for _, itemDescMo in ipairs(itemDescList) do
		local content = itemDescMo:getContent()

		if content then
			table.insert(contentList, content)
		end
	end

	return table.concat(contentList, "\n")
end

function Rouge2_ItemDescHelper.setItemDescStr(dataType, dataId, txtComp, descMode, includeTypeList, percentColor, bracketColor)
	local descStr = Rouge2_ItemDescHelper.getItemDescStr(dataType, dataId, descMode, includeTypeList)

	txtComp.text = Rouge2_ItemDescHelper.buildDesc(descStr, percentColor, bracketColor)

	SkillHelper.addHyperLinkClick(txtComp)
	Rouge2_ItemDescHelper.addFixTmpBreakLine(txtComp)
end

function Rouge2_ItemDescHelper.setBuffTag(dataType, dataId, goTag, goTagItem)
	local itemCo = Rouge2_BackpackHelper.getItemCofigAndMo(dataType, dataId)
	local tagStr = itemCo and itemCo.tag or ""
	local tagIdList = string.splitToNumber(tagStr, "#") or {}

	gohelper.CreateObjList(Rouge2_ItemDescHelper, Rouge2_ItemDescHelper._refreshBuffTagItem, tagIdList, goTag, goTagItem)
end

function Rouge2_ItemDescHelper:_refreshBuffTagItem(obj, tagId, index)
	local txtTag = obj:GetComponent(gohelper.Type_TextMesh)
	local tagCo = lua_rouge2_tag.configDict[tagId]
	local tagName = tagCo and tagCo.name or ""

	txtTag.text = tagName
end

function Rouge2_ItemDescHelper.buildDesc(desc, percentColor, bracketColor)
	percentColor = percentColor or "#b84E32"

	return SkillHelper.buildDesc(desc, percentColor, bracketColor)
end

function Rouge2_ItemDescHelper.replaceColor(str, originColor, targetColor)
	return string.gsub(str, originColor, targetColor)
end

return Rouge2_ItemDescHelper
