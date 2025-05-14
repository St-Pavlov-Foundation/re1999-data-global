module("modules.logic.rouge.controller.RougeCollectionDescHelper", package.seeall)

local var_0_0 = _M

function var_0_0.setCollectionDescInfos(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_3 = arg_1_3 or var_0_0.getDefaultShowDescTypes()
	arg_1_4 = arg_1_4 or var_0_0.getDefaultExtraParams_HasInst()

	local var_1_0 = var_0_0.buildCollectionInfos(arg_1_3, arg_1_0, nil, nil, arg_1_4)

	var_0_0._showCollectionDescs(arg_1_1, arg_1_2, arg_1_3, var_1_0, arg_1_4)
end

function var_0_0.setCollectionDescInfos2(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	arg_2_4 = arg_2_4 or var_0_0.getDefaultShowDescTypes()
	arg_2_5 = arg_2_5 or var_0_0.getDefaultExtraParams_NoneInst()

	local var_2_0 = var_0_0.buildCollectionInfos(arg_2_4, nil, arg_2_0, arg_2_1, arg_2_5)

	var_0_0._showCollectionDescs(arg_2_2, arg_2_3, arg_2_4, var_2_0, arg_2_5)
end

function var_0_0.setCollectionDescInfos3(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_3 = arg_3_3 or var_0_0.getDefaultShowDescTypes()
	arg_3_4 = arg_3_4 or var_0_0.getDefaultExtraParams_NoneInst()

	local var_3_0 = var_0_0.buildCollectionInfos(arg_3_3, nil, arg_3_0, arg_3_1, arg_3_4)

	var_0_0._showCollectionDesc2(arg_3_3, var_3_0, arg_3_2, arg_3_4)
end

function var_0_0.setCollectionDescInfos4(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_2 = arg_4_2 or var_0_0.getDefaultShowDescTypes()
	arg_4_3 = arg_4_3 or var_0_0.getDefaultExtraParams_HasInst()

	local var_4_0 = var_0_0.buildCollectionInfos(arg_4_2, arg_4_0, arg_4_3)

	var_0_0._showCollectionDesc2(arg_4_2, var_4_0, arg_4_1, arg_4_3)
end

function var_0_0._showCollectionDescs(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if not arg_5_2 or not arg_5_3 then
		return
	end

	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
		local var_5_1 = arg_5_3[iter_5_1]

		if var_5_1 then
			for iter_5_2, iter_5_3 in ipairs(var_5_1) do
				local var_5_2 = var_0_0._getOrCreateDescItem(iter_5_1, var_5_0, arg_5_0, arg_5_1)

				var_0_0._showCollectionSingleContent(iter_5_1, iter_5_3, var_5_2, arg_5_4)
			end
		end
	end

	for iter_5_4, iter_5_5 in pairs(arg_5_1) do
		local var_5_3 = var_5_0[iter_5_4] or 0
		local var_5_4 = #iter_5_5

		for iter_5_6 = var_5_3 + 1, var_5_4 do
			gohelper.setActive(iter_5_5[iter_5_6], false)
		end
	end
end

function var_0_0._showCollectionDesc2(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if not arg_6_0 or not arg_6_1 or not arg_6_2 then
		return
	end

	local var_6_0 = arg_6_3 and arg_6_3.showDescToListFunc
	local var_6_1 = var_0_0._defaultShowDescToListFunc

	;(var_6_0 or var_6_1)(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
end

function var_0_0._defaultShowDescToListFunc(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = {}
	local var_7_1 = arg_7_3 and arg_7_3.isAllActive

	for iter_7_0, iter_7_1 in ipairs(arg_7_0) do
		local var_7_2 = arg_7_1[iter_7_1]

		if var_7_2 then
			for iter_7_2, iter_7_3 in ipairs(var_7_2) do
				local var_7_3 = var_7_1 or iter_7_3.isActive
				local var_7_4 = var_0_0._decorateCollectionEffectStr(iter_7_3.content, var_7_3)

				table.insert(var_7_0, var_7_4)

				if iter_7_3.isConditionVisible and not string.nilorempty(iter_7_3.condition) then
					local var_7_5 = var_0_0._decorateCollectionEffectStr(iter_7_3.condition, var_7_3)

					table.insert(var_7_0, var_7_5)
				end
			end
		end
	end

	arg_7_2.text = table.concat(var_7_0, "\n")

	SkillHelper.addHyperLinkClick(arg_7_2)
end

function var_0_0._getOrCreateDescItem(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = gohelper.findChild(arg_8_2, "go_descitem" .. arg_8_0)

	if not var_8_0 then
		logError("找不到描述类型对应的预制体 descType = " .. tostring(arg_8_0))

		return
	end

	local var_8_1 = arg_8_3 and arg_8_3[arg_8_0]
	local var_8_2 = var_8_1 and #var_8_1 or 0
	local var_8_3 = arg_8_1 and arg_8_1[arg_8_0] or 0
	local var_8_4 = var_8_3 < var_8_2
	local var_8_5 = var_8_3 + 1

	if not var_8_4 then
		local var_8_6 = string.format("%s_%s", arg_8_0, var_8_5)
		local var_8_7 = gohelper.cloneInPlace(var_8_0, var_8_6)

		arg_8_3[arg_8_0] = arg_8_3[arg_8_0] or {}

		table.insert(arg_8_3[arg_8_0], var_8_7)
	end

	arg_8_1[arg_8_0] = var_8_5

	return arg_8_3[arg_8_0][var_8_5]
end

function var_0_0._showCollectionSingleContent(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_3 and arg_9_3.showDescFuncMap
	local var_9_1 = var_9_0 and var_9_0[arg_9_0]
	local var_9_2 = var_0_0.getDefaultDescTypeShowFunc(arg_9_0)
	local var_9_3 = var_9_1 or var_9_2

	if not var_9_3 then
		logError("缺少造物描述显示方法 描述类型 : " .. tostring(arg_9_0))

		return
	end

	gohelper.setActive(arg_9_2, true)
	gohelper.setAsLastSibling(arg_9_2)
	var_9_3(arg_9_2, arg_9_1)
end

function var_0_0._showCollectionBaseEffect(arg_10_0, arg_10_1)
	local var_10_0 = gohelper.findChildText(arg_10_0, "txt_desc")
	local var_10_1 = gohelper.findChildImage(arg_10_0, "txt_desc/image_point")
	local var_10_2 = arg_10_1.isActive and "rouge_collection_point1" or "rouge_collection_point2"

	UISpriteSetMgr.instance:setRougeSprite(var_10_1, var_10_2)

	var_10_0.text = var_0_0._decorateCollectionEffectStr(arg_10_1.content, arg_10_1.isActive)

	SkillHelper.addHyperLinkClick(var_10_0)
	var_0_0.addFixTmpBreakLine(var_10_0)
end

function var_0_0._showCollectionExtraEffect(arg_11_0, arg_11_1)
	local var_11_0 = gohelper.findChildText(arg_11_0, "txt_desc")

	var_11_0.text = var_0_0._decorateCollectionEffectStr(arg_11_1.content, arg_11_1.isActive)

	SkillHelper.addHyperLinkClick(var_11_0)
	var_0_0.addFixTmpBreakLine(var_11_0)
end

function var_0_0._showCollectionText(arg_12_0, arg_12_1)
	gohelper.findChildText(arg_12_0, "txt_desc").text = arg_12_1.content
end

function var_0_0.addFixTmpBreakLine(arg_13_0)
	if not arg_13_0 then
		return
	end

	local var_13_0 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_13_0.gameObject, FixTmpBreakLine)

	var_13_0:refreshTmpContent(arg_13_0)

	return var_13_0
end

function var_0_0.buildCollectionInfos(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	if not arg_14_0 then
		return
	end

	local var_14_0, var_14_1, var_14_2, var_14_3 = var_0_0._checkExtraParamsValid(arg_14_1, arg_14_2, arg_14_3)

	if not var_14_0 then
		return
	end

	local var_14_4 = arg_14_4 and arg_14_4.buildDescFuncMap
	local var_14_5 = RougeCollectionExpressionHelper.getCollectionAttrMap(var_14_1, var_14_2, var_14_3)
	local var_14_6 = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_0) do
		local var_14_7 = var_14_4 and var_14_4[iter_14_1]
		local var_14_8 = var_0_0.getDefaultDescTypeExecuteFunc(iter_14_1)
		local var_14_9 = var_14_7 or var_14_8

		if not var_14_9 then
			logError("缺少造物描述数据构建方法 描述类型 : " .. tostring(iter_14_1))
		else
			local var_14_10 = var_14_9(var_14_1, var_14_2, var_14_3, var_14_5, arg_14_4)

			if var_14_10 and #var_14_10 > 0 then
				var_14_6[iter_14_1] = var_14_10
			end
		end
	end

	return var_14_6
end

function var_0_0._checkExtraParamsValid(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0 then
		local var_15_0 = RougeCollectionModel.instance:getCollectionByUid(arg_15_0)

		if not var_15_0 then
			return
		end

		arg_15_1 = var_15_0:getCollectionCfgId()
		arg_15_2 = var_15_0:getAllEnchantCfgId()
	elseif not RougeCollectionConfig.instance:getCollectionCfg(arg_15_1) then
		return
	end

	return true, arg_15_0, arg_15_1, arg_15_2
end

function var_0_0.getCollectionBaseEffectInfo(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = arg_16_4 and arg_16_4.isAllActive
	local var_16_1 = arg_16_4 and arg_16_4.activeEffectMap

	if not var_16_0 and not var_16_1 and arg_16_0 ~= nil then
		var_16_1 = RougeCollectionModel.instance:getCollectionActiveEffectMap(arg_16_0)
	end

	local var_16_2 = arg_16_4 and arg_16_4.infoType
	local var_16_3 = RougeCollectionModel.instance:getCurCollectionInfoType()
	local var_16_4 = (var_16_2 or var_16_3) == RougeEnum.CollectionInfoType.Complex
	local var_16_5 = arg_16_4 and arg_16_4.effectInfos
	local var_16_6 = RougeCollectionConfig.instance:getCollectionDescsCfg(arg_16_1)
	local var_16_7 = var_16_5 or var_16_6
	local var_16_8 = {}

	for iter_16_0, iter_16_1 in ipairs(var_16_7) do
		local var_16_9 = var_16_4 and iter_16_1.desc or iter_16_1.descSimply

		if not string.nilorempty(var_16_9) then
			local var_16_10 = RougeCollectionExpressionHelper.getDescExpressionResult(var_16_9, arg_16_3)
			local var_16_11

			var_16_11.isActive, var_16_11 = var_16_0 or var_16_1 and var_16_1[iter_16_1.effectId] == true, var_0_0._createCollectionDescMo(var_16_10)

			table.insert(var_16_8, var_16_11)
		end
	end

	return var_16_8
end

function var_0_0.getCollectionExtraEffectInfo(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = arg_17_4 and arg_17_4.isAllActive
	local var_17_1 = arg_17_4 and arg_17_4.activeEffectMap

	if not var_17_0 and not var_17_1 and arg_17_0 ~= nil then
		var_17_1 = RougeCollectionModel.instance:getCollectionActiveEffectMap(arg_17_0)
	end

	local var_17_2 = arg_17_4 and arg_17_4.effectInfos
	local var_17_3 = RougeCollectionConfig.instance:getCollectionDescsCfg(arg_17_1)
	local var_17_4 = var_17_2 or var_17_3
	local var_17_5 = arg_17_4 and arg_17_4.infoType
	local var_17_6 = RougeCollectionModel.instance:getCurCollectionInfoType()
	local var_17_7 = (var_17_5 or var_17_6) == RougeEnum.CollectionInfoType.Complex
	local var_17_8 = {}

	for iter_17_0, iter_17_1 in ipairs(var_17_4) do
		local var_17_9 = var_17_7 and iter_17_1.descExtra or iter_17_1.descExtraSimply

		if not string.nilorempty(var_17_9) then
			local var_17_10 = RougeCollectionExpressionHelper.getDescExpressionResult(var_17_9, arg_17_3)
			local var_17_11

			var_17_11.isActive, var_17_11 = var_17_0 or var_17_1 and var_17_1[iter_17_1.effectId] == true, var_0_0._createCollectionDescMo(var_17_10)

			table.insert(var_17_8, var_17_11)
		end
	end

	return var_17_8
end

function var_0_0.getCollectionTextInfo(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = RougeCollectionConfig.instance:getCollectionOfficialDesc(arg_18_1)

	if not string.nilorempty(var_18_0) then
		local var_18_1 = var_0_0._createCollectionDescMo(var_18_0)

		return {
			var_18_1
		}
	end
end

function var_0_0._createCollectionDescMo(arg_19_0)
	return {
		content = arg_19_0
	}
end

var_0_0.ActiveEffectColor = "#B7B7B7"
var_0_0.DisactiveEffectColor = "#7E7E7E"

function var_0_0._decorateCollectionEffectStr(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if string.nilorempty(arg_20_0) then
		return
	end

	local var_20_0 = arg_20_3 or var_0_0.DisactiveEffectColor
	local var_20_1 = arg_20_2 or var_0_0.ActiveEffectColor
	local var_20_2 = arg_20_1 and var_20_1 or var_20_0
	local var_20_3 = SkillHelper.buildDesc(arg_20_0)

	return (string.format("<%s>%s</color>", var_20_2, var_20_3))
end

function var_0_0.getDefaultDescTypeShowFunc(arg_21_0)
	if not var_0_0.DefaultDescTypeShowFuncMap then
		var_0_0.DefaultDescTypeShowFuncMap = {
			[RougeEnum.CollectionDescType.BaseEffect] = var_0_0._showCollectionBaseEffect,
			[RougeEnum.CollectionDescType.ExtraEffect] = var_0_0._showCollectionExtraEffect,
			[RougeEnum.CollectionDescType.Text] = var_0_0._showCollectionText,
			[RougeEnum.CollectionDescType.SpecialHeader] = RougeDLCHelper102._showSpCollectionHeader,
			[RougeEnum.CollectionDescType.SpecialText] = RougeDLCHelper102._showSpCollectionDescInfo
		}
	end

	return var_0_0.DefaultDescTypeShowFuncMap[arg_21_0]
end

function var_0_0.getDefaultDescTypeExecuteFunc(arg_22_0)
	if not var_0_0.DefaultDescTypeExecuteFuncMap then
		var_0_0.DefaultDescTypeExecuteFuncMap = {
			[RougeEnum.CollectionDescType.BaseEffect] = var_0_0.getCollectionBaseEffectInfo,
			[RougeEnum.CollectionDescType.ExtraEffect] = var_0_0.getCollectionExtraEffectInfo,
			[RougeEnum.CollectionDescType.Text] = var_0_0.getCollectionTextInfo,
			[RougeEnum.CollectionDescType.SpecialHeader] = RougeDLCHelper102.getSpCollectionHeaderInfo,
			[RougeEnum.CollectionDescType.SpecialText] = RougeDLCHelper102.getSpCollectionDescInfo
		}
	end

	return var_0_0.DefaultDescTypeExecuteFuncMap[arg_22_0]
end

function var_0_0.getDefaultShowDescTypes()
	if not var_0_0.DefaultShowDescTypes then
		var_0_0.DefaultShowDescTypes = {}

		for iter_23_0, iter_23_1 in pairs(RougeEnum.CollectionDescType) do
			table.insert(var_0_0.DefaultShowDescTypes, iter_23_1)
		end

		table.sort(var_0_0.DefaultShowDescTypes, var_0_0._showDescTypeSortFunc)
	end

	return var_0_0.DefaultShowDescTypes
end

function var_0_0._showDescTypeSortFunc(arg_24_0, arg_24_1)
	local var_24_0 = RougeEnum.CollectionDescTypeSort[arg_24_0] or 10000
	local var_24_1 = RougeEnum.CollectionDescTypeSort[arg_24_1] or 10000

	if var_24_0 ~= var_24_1 then
		return var_24_0 < var_24_1
	end

	return arg_24_0 < arg_24_1
end

function var_0_0.getShowDescTypesWithoutText()
	if not var_0_0.ShowDescTypesWithoutText then
		var_0_0.ShowDescTypesWithoutText = {}

		for iter_25_0, iter_25_1 in pairs(RougeEnum.CollectionDescType) do
			if iter_25_1 ~= RougeEnum.CollectionDescType.Text then
				table.insert(var_0_0.ShowDescTypesWithoutText, iter_25_1)
			end
		end

		table.sort(var_0_0.ShowDescTypesWithoutText, var_0_0._showDescTypeSortFunc)
	end

	return var_0_0.ShowDescTypesWithoutText
end

function var_0_0.getDefaultExtraParams_NoneInst()
	if not var_0_0.NoneInstExtraParams then
		var_0_0.NoneInstExtraParams = {
			isKeepConditionVisible = true,
			isAllActive = true
		}
	end

	return var_0_0.NoneInstExtraParams
end

function var_0_0.getDefaultExtraParams_HasInst()
	if not var_0_0.HasInstExtraParams then
		var_0_0.HasInstExtraParams = {}
	end

	return var_0_0.HasInstExtraParams
end

function var_0_0.getExtraParams_KeepAllActive()
	if not var_0_0.ExtraParams_KeepAllActive then
		var_0_0.ExtraParams_KeepAllActive = {
			isAllActive = true
		}
	end

	return var_0_0.ExtraParams_KeepAllActive
end

return var_0_0
