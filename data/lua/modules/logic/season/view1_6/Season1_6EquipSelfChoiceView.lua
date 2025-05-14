module("modules.logic.season.view1_6.Season1_6EquipSelfChoiceView", package.seeall)

local var_0_0 = class("Season1_6EquipSelfChoiceView", BaseView)

function var_0_0._refreshPropsAndReturnCount(arg_1_0, arg_1_1)
	local var_1_0 = SeasonConfig.instance:getSeasonEquipCo(arg_1_1)
	local var_1_1 = SeasonEquipMetaUtils.getEquipPropsStrList(var_1_0.attrId, true)
	local var_1_2 = SeasonEquipMetaUtils.getCareerColorBrightBg(arg_1_1)
	local var_1_3 = 0

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		local var_1_4 = arg_1_0:getOrCreateSkillText(var_1_3 + 1)

		if not string.nilorempty(iter_1_1) then
			var_1_4.txtDesc.text = iter_1_1

			SLFramework.UGUI.GuiHelper.SetColor(var_1_4.txtDesc, var_1_2)
			SLFramework.UGUI.GuiHelper.SetColor(var_1_4.imagePoint, var_1_2)
			gohelper.setActive(var_1_4.go, true)

			var_1_3 = var_1_3 + 1
		end
	end

	for iter_1_2 = var_1_3 + 1, #arg_1_0._skillItems do
		local var_1_5 = arg_1_0._skillItems[iter_1_2]

		gohelper.setActive(var_1_5.go, false)
	end

	return var_1_3
end

function var_0_0._selectSelfChoiceCard_overseas(arg_2_0, arg_2_1)
	local var_2_0 = SeasonConfig.instance:getSeasonEquipCo(arg_2_1)

	if not var_2_0 then
		gohelper.setActive(arg_2_0.goempty, true)
		gohelper.setActive(arg_2_0.gocardinfo, false)

		return
	end

	if not arg_2_0._skillItems then
		arg_2_0._skillItems = {}
	end

	local var_2_1 = arg_2_0:_refreshPropsAndReturnCount(arg_2_1)

	gohelper.setActive(arg_2_0.goempty, false)
	gohelper.setActive(arg_2_0.gocardinfo, true)

	arg_2_0.txtcardname.text = var_2_0.name

	local var_2_2 = SeasonEquipMetaUtils.getSkillEffectStrList(var_2_0)
	local var_2_3 = SeasonEquipMetaUtils.getCareerColorBrightBg(arg_2_1)

	for iter_2_0, iter_2_1 in ipairs(var_2_2) do
		local var_2_4 = arg_2_0:getOrCreateSkillText(var_2_1 + 1)

		if not string.nilorempty(iter_2_1) then
			var_2_4.txtDesc.text = iter_2_1

			SLFramework.UGUI.GuiHelper.SetColor(var_2_4.txtDesc, var_2_3)
			SLFramework.UGUI.GuiHelper.SetColor(var_2_4.imagePoint, var_2_3)
			gohelper.setActive(var_2_4.go, true)

			var_2_1 = var_2_1 + 1
		end
	end

	for iter_2_2 = var_2_1 + 1, #arg_2_0._skillItems do
		local var_2_5 = arg_2_0._skillItems[iter_2_2]

		gohelper.setActive(var_2_5.go, false)
	end
end

function var_0_0.onInitView(arg_3_0)
	arg_3_0._btnclose1 = gohelper.findChildButtonWithAudio(arg_3_0.viewGO, "#btn_close1")
	arg_3_0._simagebg1 = gohelper.findChildSingleImage(arg_3_0.viewGO, "root/bg/#simage_bg1")
	arg_3_0._simagebg2 = gohelper.findChildSingleImage(arg_3_0.viewGO, "root/bg/#simage_bg2")
	arg_3_0._scrollitem = gohelper.findChildScrollRect(arg_3_0.viewGO, "root/mask/#scroll_item")
	arg_3_0._gocarditem = gohelper.findChild(arg_3_0.viewGO, "root/mask/#scroll_item/viewport/itemcontent/#go_carditem")
	arg_3_0._btnok = gohelper.findChildButtonWithAudio(arg_3_0.viewGO, "root/#btn_ok")
	arg_3_0._btnclose = gohelper.findChildButtonWithAudio(arg_3_0.viewGO, "root/#btn_close")
	arg_3_0.goempty = gohelper.findChild(arg_3_0.viewGO, "root/right/#go_empty")
	arg_3_0.gocardinfo = gohelper.findChild(arg_3_0.viewGO, "root/right/#go_cardinfo")
	arg_3_0.txtcardname = gohelper.findChildTextMesh(arg_3_0.viewGO, "root/right/#go_cardinfo/#txt_curcardname")
	arg_3_0.godescitem = gohelper.findChild(arg_3_0.viewGO, "root/right/#go_cardinfo/#scroll_info/Viewport/Content/#go_descitem")

	if arg_3_0._editableInitView then
		arg_3_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_4_0)
	arg_4_0._btnclose1:AddClickListener(arg_4_0._btnclose1OnClick, arg_4_0)
	arg_4_0._btnok:AddClickListener(arg_4_0._btnokOnClick, arg_4_0)
	arg_4_0._btnclose:AddClickListener(arg_4_0._btncloseOnClick, arg_4_0)
	arg_4_0:addEventCb(Activity104Controller.instance, Activity104Event.SelectSelfChoiceCard, arg_4_0.selectSelfChoiceCard, arg_4_0)
end

function var_0_0.removeEvents(arg_5_0)
	arg_5_0._btnclose1:RemoveClickListener()
	arg_5_0._btnok:RemoveClickListener()
	arg_5_0._btnclose:RemoveClickListener()
	arg_5_0:removeEventCb(Activity104Controller.instance, Activity104Event.SelectSelfChoiceCard, arg_5_0.selectSelfChoiceCard, arg_5_0)
end

function var_0_0._btnclose1OnClick(arg_6_0)
	return
end

function var_0_0._btnokOnClick(arg_7_0)
	Activity104EquipSelfChoiceController.instance:sendSelectCard(arg_7_0.handleSendChoice, arg_7_0)
end

function var_0_0._btncloseOnClick(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	arg_9_0._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._simagebg1:UnLoadImage()
	arg_10_0._simagebg2:UnLoadImage()
	Activity104EquipSelfChoiceController.instance:onCloseView()
end

function var_0_0.onOpen(arg_11_0)
	local var_11_0 = arg_11_0.viewParam.actId
	local var_11_1 = arg_11_0.viewParam.costItemUid

	if not Activity104EquipSelfChoiceController:checkOpenParam(var_11_0, var_11_1) then
		arg_11_0:delayClose()

		return
	end

	arg_11_0:selectSelfChoiceCard()
	Activity104EquipSelfChoiceController.instance:onOpenView(var_11_0, var_11_1)
end

function var_0_0.selectSelfChoiceCard(arg_12_0, arg_12_1)
	do return arg_12_0:_selectSelfChoiceCard_overseas(arg_12_1) end

	local var_12_0 = SeasonConfig.instance:getSeasonEquipCo(arg_12_1)

	if not var_12_0 then
		gohelper.setActive(arg_12_0.goempty, true)
		gohelper.setActive(arg_12_0.gocardinfo, false)

		return
	end

	gohelper.setActive(arg_12_0.goempty, false)
	gohelper.setActive(arg_12_0.gocardinfo, true)

	arg_12_0.txtcardname.text = var_12_0.name

	local var_12_1 = SeasonEquipMetaUtils.getSkillEffectStrList(var_12_0)
	local var_12_2 = SeasonEquipMetaUtils.getCareerColorBrightBg(arg_12_1)

	if not arg_12_0._skillItems then
		arg_12_0._skillItems = {}
	end

	for iter_12_0 = 1, math.max(#arg_12_0._skillItems, #var_12_1) do
		local var_12_3 = arg_12_0:getOrCreateSkillText(iter_12_0)

		if var_12_1[iter_12_0] then
			gohelper.setActive(var_12_3.go, true)

			var_12_3.txtDesc.text = var_12_1[iter_12_0]

			SLFramework.UGUI.GuiHelper.SetColor(var_12_3.txtDesc, var_12_2)
			SLFramework.UGUI.GuiHelper.SetColor(var_12_3.imagePoint, var_12_2)
		else
			gohelper.setActive(var_12_3.go, false)
		end
	end
end

function var_0_0.getOrCreateSkillText(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._skillItems[arg_13_1]

	if not var_13_0 then
		var_13_0 = arg_13_0:getUserDataTb_()
		var_13_0.go = gohelper.cloneInPlace(arg_13_0.godescitem, "desc" .. tostring(arg_13_1))
		var_13_0.txtDesc = gohelper.findChildText(var_13_0.go, "txt_desc")
		var_13_0.imagePoint = gohelper.findChildImage(var_13_0.go, "dot")
		arg_13_0._skillItems[arg_13_1] = var_13_0
	end

	return var_13_0
end

function var_0_0.onClose(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0.closeThis, arg_14_0)
end

function var_0_0.delayClose(arg_15_0)
	TaskDispatcher.runDelay(arg_15_0.closeThis, arg_15_0, 0.001)
end

function var_0_0.handleSendChoice(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if arg_16_2 ~= 0 then
		return
	end

	arg_16_0:closeThis()

	if arg_16_0.viewParam.successCall then
		arg_16_0.viewParam.successCall(arg_16_0.viewParam.successCallObj)
	end
end

return var_0_0
