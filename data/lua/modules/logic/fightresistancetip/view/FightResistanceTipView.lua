module("modules.logic.fightresistancetip.view.FightResistanceTipView", package.seeall)

local var_0_0 = class("FightResistanceTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._goresistance = gohelper.findChild(arg_1_0.viewGO, "#go_resistance")
	arg_1_0._scrollresistance = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_resistance/#scroll_resistance")
	arg_1_0._goresistanceitem = gohelper.findChild(arg_1_0.viewGO, "#go_resistance/#scroll_resistance/viewport/content/#go_resistanceitem")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_resistance/#scroll_resistance/viewport/content")
	arg_1_0._btnclosedetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closedetail")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "#go_tips")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_tips/#txt_name")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_tips/#txt_desc")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnclosedetail:AddClickListener(arg_2_0._btnclosedetailOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnclosedetail:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnclosedetailOnClick(arg_5_0)
	arg_5_0:hideDescTip()
end

var_0_0.Interval = 10
var_0_0.MaxHeight = 535

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.goDetailClose = arg_6_0._btnclosedetail.gameObject

	gohelper.setActive(arg_6_0._goresistanceitem, false)
	arg_6_0:hideDescTip()

	arg_6_0.rectTrResistance = arg_6_0._goresistance:GetComponent(gohelper.Type_RectTransform)
	arg_6_0.rectTrTips = arg_6_0._gotips:GetComponent(gohelper.Type_RectTransform)
	arg_6_0.rectTrScrollResistance = arg_6_0._scrollresistance:GetComponent(gohelper.Type_RectTransform)
	arg_6_0.rectTrContent = arg_6_0._gocontent:GetComponent(gohelper.Type_RectTransform)
	arg_6_0.itemList = {}
	arg_6_0.rectTrViewGo = arg_6_0.viewGO:GetComponent(gohelper.Type_RectTransform)
	arg_6_0.rectTrView = arg_6_0.viewGO:GetComponent(gohelper.Type_RectTransform)
	arg_6_0.viewWidth = recthelper.getWidth(arg_6_0.rectTrView)
	arg_6_0.resistanceWidth = recthelper.getWidth(arg_6_0.rectTrResistance)
	arg_6_0.tipWidth = recthelper.getWidth(arg_6_0.rectTrTips)
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.screenPos = arg_7_0.viewParam.screenPos

	arg_7_0:buildResistanceList(arg_7_0.viewParam.resistanceDict)
	arg_7_0:refreshResistanceItem()
	arg_7_0:setAnchor()
	arg_7_0:calculateMaxHeight()
	arg_7_0:changeScrollHeight()
end

function var_0_0.buildResistanceList(arg_8_0, arg_8_1)
	arg_8_0.resistanceList = arg_8_0.resistanceList or {}
	arg_8_0.resistanceDict = arg_8_0.resistanceDict or {}

	tabletool.clear(arg_8_0.resistanceList)
	tabletool.clear(arg_8_0.resistanceDict)

	if not arg_8_1 then
		return
	end

	arg_8_0:buildResistanceListByReToughness(arg_8_1, FightEnum.Resistance.controlResilience)
	arg_8_0:buildResistanceListByReToughness(arg_8_1, FightEnum.Resistance.delExPointResilience)
	arg_8_0:buildResistanceListByReToughness(arg_8_1, FightEnum.Resistance.stressUpResilience)
	arg_8_0:buildResistanceListByResistanceDict(arg_8_1)
end

function var_0_0.buildResistanceListByReToughness(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = FightEnum.ToughnessToResistance[arg_9_2]
	local var_9_1 = arg_9_0:getResistanceValue(arg_9_1, arg_9_2)

	arg_9_0.tempResistanceList = arg_9_0.tempResistanceList or {}

	tabletool.clear(arg_9_0.tempResistanceList)

	if var_9_1 and var_9_1 > 0 then
		table.insert(arg_9_0.resistanceList, {
			resistanceId = arg_9_2,
			value = var_9_1
		})

		arg_9_0.resistanceDict[arg_9_2] = true

		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			table.insert(arg_9_0.tempResistanceList, {
				resistanceId = iter_9_1,
				value = arg_9_0:getResistanceValue(arg_9_1, iter_9_1)
			})

			arg_9_0.resistanceDict[iter_9_1] = true
		end

		table.sort(arg_9_0.tempResistanceList, var_0_0.sortResistance)

		for iter_9_2, iter_9_3 in ipairs(arg_9_0.tempResistanceList) do
			table.insert(arg_9_0.resistanceList, iter_9_3)
		end
	end
end

function var_0_0.buildResistanceListByResistanceDict(arg_10_0, arg_10_1)
	arg_10_0.tempResistanceList = arg_10_0.tempResistanceList or {}

	tabletool.clear(arg_10_0.tempResistanceList)

	for iter_10_0, iter_10_1 in pairs(arg_10_1) do
		if iter_10_1 > 0 then
			local var_10_0 = FightEnum.Resistance[iter_10_0]

			if var_10_0 and not arg_10_0.resistanceDict[var_10_0] then
				table.insert(arg_10_0.tempResistanceList, {
					resistanceId = var_10_0,
					value = arg_10_0:getResistanceValue(arg_10_1, var_10_0)
				})

				arg_10_0.resistanceDict[var_10_0] = true
			end
		end
	end

	if #arg_10_0.tempResistanceList > 0 then
		table.sort(arg_10_0.tempResistanceList, var_0_0.sortResistance)

		for iter_10_2, iter_10_3 in ipairs(arg_10_0.tempResistanceList) do
			table.insert(arg_10_0.resistanceList, iter_10_3)
		end
	end
end

function var_0_0.getResistanceValue(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = FightHelper.getResistanceKeyById(arg_11_2)

	return var_11_0 and arg_11_1[var_11_0] or 0
end

function var_0_0.refreshResistanceItem(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.resistanceList) do
		local var_12_0 = arg_12_0.itemList[iter_12_0] or arg_12_0:createResistanceItem()

		gohelper.setActive(var_12_0.go, true)

		local var_12_1 = lua_character_attribute.configDict[iter_12_1.resistanceId]

		UISpriteSetMgr.instance:setBuffSprite(var_12_0.imageIcon, var_12_1.icon)

		var_12_0.attrCo = var_12_1
		var_12_0.txtName.text = var_12_1.name
		var_12_0.txtValue.text = string.format("%s%%", math.floor(iter_12_1.value / 10))
	end

	for iter_12_2 = #arg_12_0.resistanceList + 1, #arg_12_0.itemList do
		gohelper.setActive(arg_12_0.itemList[iter_12_2].go, false)
	end

	arg_12_0._scrollresistance.horizontalNormalizedPosition = 1
end

function var_0_0.calculateMaxHeight(arg_13_0)
	arg_13_0.maxHeight = recthelper.getHeight(arg_13_0.rectTrViewGo) - math.abs(recthelper.getAnchorY(arg_13_0.rectTrResistance)) - 50
end

function var_0_0.setAnchor(arg_14_0)
	local var_14_0, var_14_1 = recthelper.screenPosToAnchorPos2(arg_14_0.screenPos, arg_14_0.rectTrView)

	recthelper.setAnchor(arg_14_0.rectTrResistance, var_14_0, var_14_1)

	if arg_14_0.viewWidth - (math.abs(var_14_0) + var_0_0.Interval + arg_14_0.resistanceWidth) >= arg_14_0.tipWidth then
		recthelper.setAnchor(arg_14_0.rectTrTips, var_14_0 - arg_14_0.resistanceWidth - var_0_0.Interval, var_14_1)
	else
		recthelper.setAnchor(arg_14_0.rectTrTips, var_14_0 + var_0_0.Interval + arg_14_0.tipWidth, var_14_1)
	end
end

function var_0_0.changeScrollHeight(arg_15_0)
	local var_15_0 = recthelper.getHeight(arg_15_0.rectTrContent)
	local var_15_1 = math.min(var_15_0, arg_15_0.maxHeight)

	recthelper.setHeight(arg_15_0.rectTrScrollResistance, var_15_1)
end

function var_0_0.createResistanceItem(arg_16_0)
	local var_16_0 = arg_16_0:getUserDataTb_()

	var_16_0.go = gohelper.cloneInPlace(arg_16_0._goresistanceitem)
	var_16_0.imageIcon = gohelper.findChildImage(var_16_0.go, "#image_icon")
	var_16_0.txtName = gohelper.findChildText(var_16_0.go, "#txt_name")
	var_16_0.txtValue = gohelper.findChildText(var_16_0.go, "#txt_value")
	var_16_0.btnDetails = gohelper.findChildClickWithDefaultAudio(var_16_0.go, "#txt_name/icon/#btn_details")

	var_16_0.btnDetails:AddClickListener(arg_16_0.onClickResistanceItem, arg_16_0, var_16_0)
	table.insert(arg_16_0.itemList, var_16_0)

	return var_16_0
end

function var_0_0.onClickResistanceItem(arg_17_0, arg_17_1)
	arg_17_0:showDescTip()

	local var_17_0 = arg_17_1.attrCo

	arg_17_0._txtname.text = var_17_0.name
	arg_17_0._txtdesc.text = var_17_0.desc
end

function var_0_0.showDescTip(arg_18_0)
	gohelper.setActive(arg_18_0.goDetailClose, true)
	gohelper.setActive(arg_18_0._gotips, true)
end

function var_0_0.hideDescTip(arg_19_0)
	gohelper.setActive(arg_19_0.goDetailClose, false)
	gohelper.setActive(arg_19_0._gotips, false)
end

function var_0_0.sortResistance(arg_20_0, arg_20_1)
	if arg_20_0.value ~= arg_20_1.value then
		return arg_20_0.value > arg_20_1.value
	end

	local var_20_0 = lua_character_attribute.configDict[arg_20_0.resistanceId]
	local var_20_1 = lua_character_attribute.configDict[arg_20_1.resistanceId]

	return var_20_0.sortId < var_20_1.sortId
end

function var_0_0.onClose(arg_21_0)
	return
end

function var_0_0.onDestroyView(arg_22_0)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0.itemList) do
		iter_22_1.btnDetails:RemoveClickListener()
	end

	arg_22_0.itemList = nil
end

return var_0_0
