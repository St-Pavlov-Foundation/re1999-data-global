module("modules.logic.summon.view.custompick.SummonCustomPickDescView", package.seeall)

local var_0_0 = class("SummonCustomPickDescView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "infoScroll/Viewport/#go_Content")
	arg_1_0._goinfoItem = gohelper.findChild(arg_1_0.viewGO, "infoScroll/Viewport/#go_Content/#go_infoItem")

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

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._infoItemTab = arg_4_0:getUserDataTb_()
	arg_4_0._paragraphItems = arg_4_0:getUserDataTb_()
end

function var_0_0.onUpdateParam(arg_5_0)
	arg_5_0:onOpen()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._poolParam = SummonController.instance:getPoolInfo()
	arg_6_0._poolDetailId = arg_6_0._poolParam.poolDetailId
	arg_6_0._poolId = arg_6_0._poolParam.poolId

	local var_6_0 = SummonConfig.instance:getSummonPool(arg_6_0._poolId)

	arg_6_0._resultType = SummonMainModel.getResultType(var_6_0)
	arg_6_0._nameDict = arg_6_0:buildRareNameDict(var_6_0)

	arg_6_0:_refreshUI()
end

function var_0_0._refreshUI(arg_7_0)
	local var_7_0 = arg_7_0:buildDesc()

	arg_7_0:cleanParagraphs()

	arg_7_0._probUpIds = SummonPoolDetailCategoryListModel.buildCustomPickDict(arg_7_0._poolId)

	local var_7_1 = arg_7_0:parseDesc(var_7_0)

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		local var_7_2 = arg_7_0._infoItemTab[iter_7_0]

		if not var_7_2 then
			var_7_2 = gohelper.clone(arg_7_0._goinfoItem, arg_7_0._goContent, "item" .. iter_7_0)

			table.insert(arg_7_0._infoItemTab, var_7_2)
		end

		gohelper.setActive(var_7_2, true)
		arg_7_0:checkBuildProbUp(iter_7_1)

		gohelper.findChildText(var_7_2, "desctitle/#txt_desctitle").text = iter_7_1.title

		local var_7_3, var_7_4 = arg_7_0:splitParagraph(iter_7_1.desc)

		if not var_7_3 or #var_7_3 == 0 then
			return
		end

		for iter_7_2, iter_7_3 in ipairs(var_7_3) do
			arg_7_0:createParagraphUI(iter_7_3, var_7_4[iter_7_2] or "", var_7_2)
		end
	end
end

function var_0_0.cleanParagraphs(arg_8_0)
	for iter_8_0 = #arg_8_0._paragraphItems, 1, -1 do
		gohelper.destroy(arg_8_0._paragraphItems[iter_8_0])

		arg_8_0._paragraphItems[iter_8_0] = nil
	end
end

function var_0_0.buildDesc(arg_9_0)
	local var_9_0 = SummonConfig.instance:getSummonPool(arg_9_0._poolId)
	local var_9_1 = SummonConfig.instance:getPoolDetailConfig(arg_9_0._poolDetailId)
	local var_9_2 = {
		var_9_0.nameCn,
		var_9_0.nameEn
	}
	local var_9_3 = 3
	local var_9_4 = string.split(var_9_0.initWeight, "|")

	for iter_9_0, iter_9_1 in ipairs(var_9_4) do
		local var_9_5 = string.splitToNumber(iter_9_1, "#")
		local var_9_6 = var_9_5[1] + 1
		local var_9_7 = var_9_5[2]

		var_9_2[6 - var_9_6 + var_9_3] = var_9_7 / 100 .. "%%"
	end

	var_9_2[8] = string.split(var_9_0.awardTime, "|")[2]

	local var_9_8 = ""

	if var_9_1 then
		local var_9_9 = tonumber(var_9_1.info)

		if var_9_9 then
			var_9_8 = CommonConfig.instance:getConstStr(var_9_9)
			var_9_8 = GameUtil.getSubPlaceholderLuaLang(var_9_8, var_9_2)
		else
			logError(string.format("summon_pool_detail.info error! self._poolId = %s, detailId = %s", arg_9_0._poolId, arg_9_0._poolDetailId))
		end
	else
		logError(string.format("summon_pool_detail config not found ! self._poolId = %s, detailId = %s", arg_9_0._poolId, arg_9_0._poolDetailId))
	end

	return var_9_8
end

function var_0_0.parseDesc(arg_10_0, arg_10_1)
	local var_10_0 = {}

	for iter_10_0 in string.gmatch(arg_10_1, "{(.-)}") do
		local var_10_1 = {
			title = iter_10_0
		}

		table.insert(var_10_0, var_10_1)
	end

	arg_10_1 = string.gsub(arg_10_1, "{(.-)}", "|")

	local var_10_2 = string.split(arg_10_1, "|")

	for iter_10_1 = 2, #var_10_2 do
		var_10_0[iter_10_1 - 1].desc = var_10_2[iter_10_1]
	end

	return var_10_0
end

function var_0_0.checkBuildProbUp(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1.desc

	for iter_11_0 in var_11_0:gmatch("%[upname=.-%]") do
		local var_11_1, var_11_2, var_11_3, var_11_4, var_11_5 = string.find(iter_11_0, "(%[upname=)(.*)(%])")
		local var_11_6 = tonumber(var_11_4)
		local var_11_7 = arg_11_0._probUpIds[var_11_6]

		iter_11_0 = string.format("%s%s%s", "%[upname=", var_11_4, "%]")

		if var_11_7 then
			var_11_0 = string.gsub(var_11_0, iter_11_0, arg_11_0:getTargetName(var_11_7))
		else
			var_11_0 = string.gsub(var_11_0, iter_11_0, "")
		end
	end

	local var_11_8 = arg_11_0:descReplace(var_11_0, "%[ssr_up_rate%]", CommonConfig.instance:getConstNum(ConstEnum.SummonSSRUpProb) / 10 .. "%%")
	local var_11_9 = arg_11_0:descReplace(var_11_8, "%[sr_up_rate%]", CommonConfig.instance:getConstNum(ConstEnum.SummonSRUpProb) / 10 .. "%%")

	if arg_11_0._nameDict and arg_11_0._nameDict[SummonEnum.CustomPickRare] then
		var_11_9 = arg_11_0:descReplace(var_11_9, "%[all_six_star%]", table.concat(arg_11_0._nameDict[SummonEnum.CustomPickRare], "|"))
	else
		var_11_9 = arg_11_0:descReplace(var_11_9, "%[all_six_star%]", "")
	end

	arg_11_1.desc = var_11_9
end

function var_0_0.splitParagraph(arg_12_0, arg_12_1)
	local var_12_0 = {}
	local var_12_1 = {}
	local var_12_2 = arg_12_1

	while not string.nilorempty(var_12_2) do
		local var_12_3, var_12_4, var_12_5, var_12_6 = string.find(var_12_2, "%[para=(%d-)%](.-)%[/para%]")

		if var_12_3 == nil then
			table.insert(var_12_0, SummonEnum.DetailParagraphType.Normal)
			table.insert(var_12_1, var_12_2)

			break
		end

		local var_12_7 = string.sub(var_12_2, 0, var_12_3 - 1)

		if not string.nilorempty(var_12_7) then
			table.insert(var_12_0, SummonEnum.DetailParagraphType.Normal)
			table.insert(var_12_1, var_12_7)
		end

		if not string.nilorempty(var_12_6) then
			table.insert(var_12_0, tonumber(var_12_5))
			table.insert(var_12_1, tostring(var_12_6))
		end

		var_12_2 = string.sub(var_12_2, var_12_4 + 1)

		if string.find(var_12_2, "\n") == 1 then
			var_12_2 = string.sub(var_12_2, 2)
		end
	end

	return var_12_0, var_12_1
end

function var_0_0.createParagraphUI(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0

	if arg_13_1 == SummonEnum.DetailParagraphType.SpaceOne then
		local var_13_1 = gohelper.findChild(arg_13_3, "#txt_descspaceone")

		var_13_0 = gohelper.cloneInPlace(var_13_1, "para_2")
		var_13_0:GetComponent(gohelper.Type_TextMesh).text = arg_13_2
	else
		local var_13_2 = gohelper.findChild(arg_13_3, "#txt_descContent")

		var_13_0 = gohelper.cloneInPlace(var_13_2, "para_1")
		var_13_0:GetComponent(gohelper.Type_TextMesh).text = arg_13_2
	end

	table.insert(arg_13_0._paragraphItems, var_13_0)

	if not gohelper.isNil(var_13_0) then
		gohelper.setActive(var_13_0, true)
	end
end

function var_0_0.descReplace(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	for iter_14_0 in arg_14_1:gmatch(arg_14_2) do
		arg_14_1 = string.gsub(arg_14_1, arg_14_2, arg_14_3)
	end

	return arg_14_1
end

function var_0_0.getTargetName(arg_15_0, arg_15_1)
	if arg_15_0._resultType == SummonEnum.ResultType.Char then
		return HeroConfig.instance:getHeroCO(arg_15_1).name
	elseif arg_15_0._resultType == SummonEnum.ResultType.Equip then
		return EquipConfig.instance:getEquipCo(arg_15_1).name
	end

	return ""
end

function var_0_0.buildRareNameDict(arg_16_0, arg_16_1)
	local var_16_0 = {}

	for iter_16_0 = 1, 5 do
		var_16_0[iter_16_0] = {}
	end

	local var_16_1 = SummonMainModel.getResultType(arg_16_1)
	local var_16_2 = SummonConfig.instance:getSummonPool(arg_16_0._poolId)

	if var_16_2.type == SummonEnum.Type.StrongCustomOnePick then
		local var_16_3 = var_16_2.param
		local var_16_4 = string.splitToNumber(var_16_3, "#")

		for iter_16_1, iter_16_2 in ipairs(var_16_4) do
			local var_16_5 = HeroConfig.instance:getHeroCO(iter_16_2).name

			table.insert(var_16_0[SummonEnum.CustomPickRare], var_16_5)
		end
	else
		local var_16_6 = SummonConfig.instance:getSummon(arg_16_0._poolId)

		for iter_16_3, iter_16_4 in pairs(var_16_6) do
			local var_16_7 = iter_16_4.summonId
			local var_16_8 = string.splitToNumber(var_16_7, "#")

			for iter_16_5, iter_16_6 in ipairs(var_16_8) do
				if var_16_1 == SummonEnum.ResultType.Char then
					local var_16_9 = HeroConfig.instance:getHeroCO(iter_16_6).name

					table.insert(var_16_0[iter_16_3], var_16_9)
				elseif var_16_1 == SummonEnum.ResultType.Equip then
					local var_16_10 = EquipConfig.instance:getEquipCo(iter_16_6).name

					table.insert(var_16_0[iter_16_3], var_16_10)
				end
			end
		end
	end

	return var_16_0
end

function var_0_0.onClose(arg_17_0)
	return
end

function var_0_0.onDestroyView(arg_18_0)
	arg_18_0._rateUpIcons = nil
	arg_18_0._rateUpIconsPool = nil
end

return var_0_0
