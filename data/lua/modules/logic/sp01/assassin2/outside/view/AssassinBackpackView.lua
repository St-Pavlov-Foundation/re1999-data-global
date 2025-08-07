module("modules.logic.sp01.assassin2.outside.view.AssassinBackpackView", package.seeall)

local var_0_0 = class("AssassinBackpackView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goinfo = gohelper.findChild(arg_1_0.viewGO, "root/#go_info")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "root/#go_info/#txt_name")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "root/#go_info/#simage_icon")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "root/#go_info/#simage_icon/#txt_num")
	arg_1_0._gofightEff = gohelper.findChild(arg_1_0.viewGO, "root/#go_info/ScrollView/Viewport/#go_layoutEff/#go_fightEff")
	arg_1_0._txtfightEffDesc = gohelper.findChildText(arg_1_0.viewGO, "root/#go_info/ScrollView/Viewport/#go_layoutEff/#go_fightEff/#txt_fightEffDesc")
	arg_1_0._gostealthEff = gohelper.findChild(arg_1_0.viewGO, "root/#go_info/ScrollView/Viewport/#go_layoutEff/#go_stealthEff")
	arg_1_0._txtstealthEffDesc = gohelper.findChildText(arg_1_0.viewGO, "root/#go_info/ScrollView/Viewport/#go_layoutEff/#go_stealthEff/#txt_stealthEffDesc")
	arg_1_0._goremove = gohelper.findChild(arg_1_0.viewGO, "root/#go_info/change/#go_remove")
	arg_1_0._goequip = gohelper.findChild(arg_1_0.viewGO, "root/#go_info/change/#go_equip")
	arg_1_0._goban = gohelper.findChild(arg_1_0.viewGO, "root/#go_info/change/#go_ban")
	arg_1_0._btnchange = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "root/#go_info/change/#btn_change", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._goIsEquiped = gohelper.findChild(arg_1_0.viewGO, "root/#go_info/#go_Equip")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnchange:AddClickListener(arg_2_0._btnchangeOnClick, arg_2_0)
	arg_2_0._animationEvent:AddEventListener("changeInfo", arg_2_0.refreshSelectedItemInfo, arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.OnSelectBackpackItem, arg_2_0.onSelectItem, arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.OnChangeEquippedItem, arg_2_0._onChangeEquippedItem, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnchange:RemoveClickListener()
	arg_3_0._animationEvent:RemoveEventListener("changeInfo")
	arg_3_0:removeEventCb(AssassinController.instance, AssassinEvent.OnSelectBackpackItem, arg_3_0.onSelectItem, arg_3_0)
	arg_3_0:removeEventCb(AssassinController.instance, AssassinEvent.OnChangeEquippedItem, arg_3_0._onChangeEquippedItem, arg_3_0)
end

function var_0_0._btnchangeOnClick(arg_4_0)
	AssassinController.instance:changeEquippedItem(arg_4_0._assassinHeroId)
end

function var_0_0.onSelectItem(arg_5_0, arg_5_1)
	if arg_5_1 then
		arg_5_0.animator:Play("switch", 0, 0)
	else
		arg_5_0:refreshSelectedItemInfo()
	end
end

function var_0_0._onChangeEquippedItem(arg_6_0)
	arg_6_0:refreshSelectedItemInfo()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0.animator = arg_7_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_7_0._animationEvent = arg_7_0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	arg_7_0:refreshSelectedItemInfo()
end

function var_0_0.onUpdateParam(arg_8_0)
	arg_8_0._assassinHeroId = arg_8_0.viewParam.assassinHeroId
	arg_8_0._carryIndex = arg_8_0.viewParam.carryIndex
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:onUpdateParam()

	local var_9_0
	local var_9_1 = AssassinHeroModel.instance:getCarryItemId(arg_9_0._assassinHeroId, arg_9_0._carryIndex)

	if var_9_1 then
		local var_9_2 = AssassinItemModel.instance:getAssassinItemMo(var_9_1)

		var_9_0 = AssassinBackpackListModel.instance:getIndex(var_9_2)
	else
		local var_9_3 = AssassinBackpackListModel.instance:getList()

		for iter_9_0, iter_9_1 in ipairs(var_9_3) do
			if iter_9_1:isNew() then
				var_9_0 = iter_9_0
			end
		end
	end

	AssassinController.instance:backpackSelectItem(var_9_0)
end

function var_0_0.refreshSelectedItemInfo(arg_10_0)
	local var_10_0 = AssassinBackpackListModel.instance:getSelectedItemId()

	if not var_10_0 then
		gohelper.setActive(arg_10_0._goinfo, false)

		return
	end

	arg_10_0._txtname.text = AssassinConfig.instance:getAssassinItemName(var_10_0)

	AssassinHelper.setAssassinItemIcon(var_10_0, arg_10_0._imageicon)

	arg_10_0._txtnum.text = AssassinItemModel.instance:getAssassinItemCount(var_10_0)

	local var_10_1 = AssassinConfig.instance:getAssassinItemFightEffDesc(var_10_0)
	local var_10_2 = not string.nilorempty(var_10_1)

	if var_10_2 then
		arg_10_0._txtfightEffDesc.text = var_10_1
	end

	gohelper.setActive(arg_10_0._gofightEff, var_10_2)

	local var_10_3 = AssassinConfig.instance:getAssassinItemStealthEffDesc(var_10_0)
	local var_10_4 = not string.nilorempty(var_10_3)

	if var_10_4 then
		arg_10_0._txtstealthEffDesc.text = var_10_3
	end

	gohelper.setActive(arg_10_0._gostealthEff, var_10_4)

	if AssassinHeroModel.instance:getItemCarryIndex(arg_10_0._assassinHeroId, var_10_0) then
		gohelper.setActive(arg_10_0._goremove, true)
		gohelper.setActive(arg_10_0._goequip, false)
		gohelper.setActive(arg_10_0._goban, false)
		gohelper.setActive(arg_10_0._goIsEquiped, true)
	else
		local var_10_5 = AssassinHeroModel.instance:isCarryItemFull(arg_10_0._assassinHeroId)

		gohelper.setActive(arg_10_0._goremove, false)
		gohelper.setActive(arg_10_0._goequip, not var_10_5)
		gohelper.setActive(arg_10_0._goban, var_10_5)
		gohelper.setActive(arg_10_0._goIsEquiped, false)
	end

	gohelper.setActive(arg_10_0._goinfo, true)
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
