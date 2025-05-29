module("modules.logic.rouge.dlc.102.controller.RougeDLCHelper102", package.seeall)

local var_0_0 = class("RougeDLCHelper102")

function var_0_0.getSpCollectionHeaderInfo(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	if not RougeDLCHelper.isUsingTargetDLC(RougeDLCEnum.DLCEnum.DLC_102) then
		return
	end

	local var_1_0 = RougeDLCConfig102.instance:getCollectionOwnerCo(arg_1_1)

	if var_1_0 then
		return {
			var_1_0
		}
	end
end

function var_0_0.getSpCollectionDescInfo(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if not RougeDLCHelper.isUsingTargetDLC(RougeDLCEnum.DLCEnum.DLC_102) then
		return
	end

	local var_2_0 = RougeDLCConfig102.instance:getSpCollectionDescCos(arg_2_1)

	if not var_2_0 then
		return
	end

	local var_2_1 = arg_2_4 and arg_2_4.infoType
	local var_2_2 = RougeCollectionModel.instance:getCurCollectionInfoType()
	local var_2_3 = (var_2_1 or var_2_2) == RougeEnum.CollectionInfoType.Complex
	local var_2_4 = arg_2_4 and arg_2_4.isAllActive
	local var_2_5 = arg_2_4 and arg_2_4.isKeepConditionVisible
	local var_2_6 = arg_2_4 and arg_2_4.activeEffectMap

	if not var_2_4 and not var_2_6 and arg_2_0 ~= nil then
		var_2_6 = RougeCollectionModel.instance:getCollectionActiveEffectMap(arg_2_0)
	end

	local var_2_7 = {}
	local var_2_8 = arg_2_4 and arg_2_4.spDescExpressionFunc
	local var_2_9 = arg_2_4 and arg_2_4.spConditionExpressionFunc

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		local var_2_10 = var_2_3 and iter_2_1.desc or iter_2_1.descSimply
		local var_2_11 = var_2_3 and iter_2_1.condition or iter_2_1.conditionSimply

		if not string.nilorempty(var_2_10) then
			local var_2_12 = RougeCollectionExpressionHelper.getDescExpressionResult(var_2_10, arg_2_3, var_2_8)
			local var_2_13 = RougeCollectionExpressionHelper.getDescExpressionResult(var_2_11, arg_2_3, var_2_9)
			local var_2_14 = var_2_4 or var_2_6 and var_2_6[iter_2_1.effectId] == true
			local var_2_15 = var_2_5 or var_0_0.checkpCollectionConditionVisible(arg_2_0, iter_2_0)
			local var_2_16 = {
				isActive = var_2_14,
				content = var_2_12,
				isConditionVisible = var_2_15,
				condition = var_2_13
			}

			table.insert(var_2_7, var_2_16)
		end
	end

	return var_2_7
end

local var_0_1 = {
	3001,
	3002,
	4001
}

function var_0_0.checkpCollectionConditionVisible(arg_3_0, arg_3_1)
	local var_3_0 = true

	if arg_3_0 and arg_3_0 ~= 0 then
		local var_3_1 = RougeCollectionModel.instance:getCollectionByUid(arg_3_0)

		if var_3_1 and var_0_1[arg_3_1] then
			var_3_0 = not var_3_1:isAttrExist(var_0_1[arg_3_1])
		end
	end

	return var_3_0
end

function var_0_0._defaultSpDescExpressionFunc()
	return
end

function var_0_0._defaultSpConditionExpressionFunc()
	return
end

function var_0_0._showSpCollectionHeader(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.name

	gohelper.findChildText(arg_6_0, "txt_desc").text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge_spcollection_header"), var_6_0)
end

local var_0_2 = "#B7B7B7"
local var_0_3 = "#7E7E7E"
local var_0_4 = 1
local var_0_5 = 1
local var_0_6 = "#A08156"

function var_0_0._showSpCollectionDescInfo(arg_7_0, arg_7_1)
	local var_7_0 = gohelper.findChildText(arg_7_0, "txt_desc")
	local var_7_1 = gohelper.findChildText(arg_7_0, "txt_desc2")
	local var_7_2 = gohelper.findChildImage(arg_7_0, "txt_desc/image_point")
	local var_7_3 = arg_7_1.isActive

	var_7_0.text = SkillHelper.buildDesc(arg_7_1.content)

	SLFramework.UGUI.GuiHelper.SetColor(var_7_0, var_7_3 and var_0_2 or var_0_3)
	ZProj.UGUIHelper.SetColorAlpha(var_7_0, var_7_3 and var_0_4 or var_0_5)

	local var_7_4 = var_7_3 and "rouge_collection_point1" or "rouge_collection_point2"

	UISpriteSetMgr.instance:setRougeSprite(var_7_2, var_7_4)
	SkillHelper.addHyperLinkClick(var_7_0)
	RougeCollectionDescHelper.addFixTmpBreakLine(var_7_0)
	LuaUtil.updateTMPRectHeight_LayoutElement(var_7_0)

	local var_7_5 = arg_7_1.isConditionVisible

	gohelper.setActive(var_7_1, var_7_5)

	if var_7_5 then
		local var_7_6 = GameUtil.getSubPlaceholderLuaLang(luaLang("rouge_spcollection_unlock"), {
			arg_7_1.condition
		})

		var_7_1.text = SkillHelper.buildDesc(var_7_6)

		SLFramework.UGUI.GuiHelper.SetColor(var_7_1, var_0_6)
	end
end

return var_0_0
