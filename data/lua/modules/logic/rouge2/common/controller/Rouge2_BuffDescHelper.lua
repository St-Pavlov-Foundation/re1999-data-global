-- chunkname: @modules/logic/rouge2/common/controller/Rouge2_BuffDescHelper.lua

module("modules.logic.rouge2.common.controller.Rouge2_BuffDescHelper", package.seeall)

local Rouge2_BuffDescHelper = class("Rouge2_BuffDescHelper")

Rouge2_BuffDescHelper.ActiveEffectColor = "#201F1E"
Rouge2_BuffDescHelper.DisactiveEffectColor = "#7E7E7E"

function Rouge2_BuffDescHelper._type2GetDescFunc(descType)
	if not Rouge2_BuffDescHelper._getDescFuncMap then
		Rouge2_BuffDescHelper._getDescFuncMap = {}
		Rouge2_BuffDescHelper._getDescFuncMap[Rouge2_Enum.RelicsDescType.Desc] = Rouge2_BuffDescHelper._getDesc_Desc
		Rouge2_BuffDescHelper._getDescFuncMap[Rouge2_Enum.RelicsDescType.NarrativeDesc] = Rouge2_BuffDescHelper._getDesc_NarrativeDesc
		Rouge2_BuffDescHelper._getDescFuncMap[Rouge2_Enum.RelicsDescType.NarrativeDescOutside] = Rouge2_BuffDescHelper._getDesc_NarrativeDescOutside
	end

	local func = Rouge2_BuffDescHelper._getDescFuncMap[descType]

	if not func then
		logError(string.format("肉鸽不存在获取指定造物描述的方法, descType = %s", descType))
	end

	return func
end

function Rouge2_BuffDescHelper._getDesc_Desc(model, config, descType, descMode, resultDescList)
	local isSimply = descMode == Rouge2_Enum.ItemDescMode.Simply
	local descStr = isSimply and config.descSimply or config.desc

	if string.nilorempty(descStr) then
		return
	end

	local descList = string.split(descStr, "|")
	local descNum = descList and #descList or 0

	for i = 1, descNum do
		local desc = descList[i]
		local descResult = Rouge2_ItemExpressionHelper.getDescResult(model, config, desc)
		local isTrigger = model == nil and true or model:isTriggerEffect(i)
		local descMo = Rouge2_ItemDescHelper._buildDescMo(descType, descMode, Rouge2_Enum.RelicsDescParam.Desc, descResult, Rouge2_Enum.RelicsDescParam.isTrigger, isTrigger)

		Rouge2_ItemDescHelper._addDescMo(resultDescList, descMo)
	end
end

function Rouge2_BuffDescHelper._getDesc_NarrativeDesc(model, config, descType, descMode, resultDescList)
	if string.nilorempty(config.narrativeDesc) then
		return
	end

	local descMo = Rouge2_ItemDescHelper._buildDescMo(descType, descMode, Rouge2_Enum.RelicsDescParam.Desc, config.narrativeDesc)

	table.insert(resultDescList, descMo)
end

function Rouge2_BuffDescHelper._getDesc_NarrativeDescOutside(model, config, descType, descMode, resultDescList)
	if string.nilorempty(config.narrativeDesc) then
		return
	end

	local descMo = Rouge2_ItemDescHelper._buildDescMo(descType, descMode, Rouge2_Enum.RelicsDescParam.Desc, string.format("<color=#C2AA99><i>%s<i></color>", config.narrativeDesc))

	table.insert(resultDescList, descMo)
end

function Rouge2_BuffDescHelper.getDefaultIncludeTypeList()
	if not Rouge2_BuffDescHelper._defaultIncludeTypeList then
		Rouge2_BuffDescHelper._defaultIncludeTypeList = {
			Rouge2_Enum.RelicsDescType.Desc,
			Rouge2_Enum.RelicsDescType.NarrativeDesc
		}
	end

	return Rouge2_BuffDescHelper._defaultIncludeTypeList
end

return Rouge2_BuffDescHelper
