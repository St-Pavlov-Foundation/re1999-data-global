module("modules.logic.season.view1_3.Season1_3EquipSelfChoiceView", package.seeall)

local var_0_0 = class("Season1_3EquipSelfChoiceView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close1")
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/bg/#simage_bg1")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/bg/#simage_bg2")
	arg_1_0._scrollitem = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/mask/#scroll_item")
	arg_1_0._gocarditem = gohelper.findChild(arg_1_0.viewGO, "root/mask/#scroll_item/viewport/itemcontent/#go_carditem")
	arg_1_0._btnok = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_ok")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")
	arg_1_0.goempty = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_empty")
	arg_1_0.gocardinfo = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_cardinfo")
	arg_1_0.txtcardname = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/right/#go_cardinfo/#txt_curcardname")
	arg_1_0.godescitem = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_cardinfo/#scroll_info/Viewport/Content/#go_descitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose1:AddClickListener(arg_2_0._btnclose1OnClick, arg_2_0)
	arg_2_0._btnok:AddClickListener(arg_2_0._btnokOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0:addEventCb(Activity104Controller.instance, Activity104Event.SelectSelfChoiceCard, arg_2_0.selectSelfChoiceCard, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose1:RemoveClickListener()
	arg_3_0._btnok:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0:removeEventCb(Activity104Controller.instance, Activity104Event.SelectSelfChoiceCard, arg_3_0.selectSelfChoiceCard, arg_3_0)
end

function var_0_0._btnclose1OnClick(arg_4_0)
	return
end

function var_0_0._btnokOnClick(arg_5_0)
	Activity104EquipSelfChoiceController.instance:sendSelectCard(arg_5_0.handleSendChoice, arg_5_0)
end

function var_0_0._btncloseOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	arg_7_0._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))
end

function var_0_0.onDestroyView(arg_8_0)
	arg_8_0._simagebg1:UnLoadImage()
	arg_8_0._simagebg2:UnLoadImage()
	Activity104EquipSelfChoiceController.instance:onCloseView()
end

function var_0_0.onOpen(arg_9_0)
	local var_9_0 = arg_9_0.viewParam.actId
	local var_9_1 = arg_9_0.viewParam.costItemUid

	if not Activity104EquipSelfChoiceController:checkOpenParam(var_9_0, var_9_1) then
		arg_9_0:delayClose()

		return
	end

	arg_9_0:selectSelfChoiceCard()
	Activity104EquipSelfChoiceController.instance:onOpenView(var_9_0, var_9_1)
end

function var_0_0.selectSelfChoiceCard(arg_10_0, arg_10_1)
	local var_10_0 = SeasonConfig.instance:getSeasonEquipCo(arg_10_1)

	if not var_10_0 then
		gohelper.setActive(arg_10_0.goempty, true)
		gohelper.setActive(arg_10_0.gocardinfo, false)

		return
	end

	gohelper.setActive(arg_10_0.goempty, false)
	gohelper.setActive(arg_10_0.gocardinfo, true)

	arg_10_0.txtcardname.text = var_10_0.name

	local var_10_1 = SeasonEquipMetaUtils.getSkillEffectStrList(var_10_0)
	local var_10_2 = SeasonEquipMetaUtils.getCareerColorBrightBg(arg_10_1)

	if not arg_10_0._skillItems then
		arg_10_0._skillItems = {}
	end

	for iter_10_0 = 1, math.max(#arg_10_0._skillItems, #var_10_1) do
		local var_10_3 = arg_10_0:getOrCreateSkillText(iter_10_0)

		if var_10_1[iter_10_0] then
			gohelper.setActive(var_10_3.go, true)

			var_10_3.txtDesc.text = var_10_1[iter_10_0]

			SLFramework.UGUI.GuiHelper.SetColor(var_10_3.txtDesc, var_10_2)
			SLFramework.UGUI.GuiHelper.SetColor(var_10_3.imagePoint, var_10_2)
		else
			gohelper.setActive(var_10_3.go, false)
		end
	end
end

function var_0_0.getOrCreateSkillText(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._skillItems[arg_11_1]

	if not var_11_0 then
		var_11_0 = arg_11_0:getUserDataTb_()
		var_11_0.go = gohelper.cloneInPlace(arg_11_0.godescitem, "desc" .. tostring(arg_11_1))
		var_11_0.txtDesc = gohelper.findChildText(var_11_0.go, "txt_desc")
		var_11_0.imagePoint = gohelper.findChildImage(var_11_0.go, "dot")
		arg_11_0._skillItems[arg_11_1] = var_11_0
	end

	return var_11_0
end

function var_0_0.onClose(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0.closeThis, arg_12_0)
end

function var_0_0.delayClose(arg_13_0)
	TaskDispatcher.runDelay(arg_13_0.closeThis, arg_13_0, 0.001)
end

function var_0_0.handleSendChoice(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_2 ~= 0 then
		return
	end

	arg_14_0:closeThis()

	if arg_14_0.viewParam.successCall then
		arg_14_0.viewParam.successCall(arg_14_0.viewParam.successCallObj)
	end
end

return var_0_0
