module("modules.logic.bossrush.view.v2a9.V2a9_BossRushSkillBackpackView", package.seeall)

local var_0_0 = class("V2a9_BossRushSkillBackpackView", BaseView)

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
	arg_1_0._btnchange = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "root/#go_info/change/#btn_change")
	arg_1_0._goIsEquiped = gohelper.findChild(arg_1_0.viewGO, "root/#go_info/#go_Equip")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnchange:AddClickListener(arg_2_0._btnchangeOnClick, arg_2_0)
	arg_2_0:addEventCb(BossRushController.instance, BossRushEvent.OnSelectV2a9SpItem, arg_2_0.onSelectItem, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnchange:RemoveClickListener()
	arg_3_0:removeEventCb(BossRushController.instance, BossRushEvent.OnSelectV2a9SpItem, arg_3_0.onSelectItem, arg_3_0)
end

function var_0_0._btnchangeOnClick(arg_4_0)
	V2a9BossRushModel.instance:changeEquippedSelectItem(arg_4_0._stage, arg_4_0.refreshView, arg_4_0)
end

function var_0_0.onSelectItem(arg_5_0)
	arg_5_0:refreshSelectedItemInfo()
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = HeroGroupModel.instance.episodeId

	arg_7_0._stage = BossRushConfig.instance:getEpisodeCoByEpisodeId(var_7_0).stage

	V2a9BossRushSkillBackpackListModel.instance:initSelect()
	arg_7_0:refreshSelectedItemInfo()
end

function var_0_0.refreshSelectedItemInfo(arg_8_0)
	local var_8_0 = V2a9BossRushModel.instance:getSelectedItemId()

	if not var_8_0 then
		gohelper.setActive(arg_8_0._goinfo, false)

		return
	end

	arg_8_0._txtname.text = AssassinConfig.instance:getAssassinItemName(var_8_0)

	AssassinHelper.setAssassinItemIcon(var_8_0, arg_8_0._imageicon)

	arg_8_0._txtnum.text = AssassinItemModel.instance:getAssassinItemCount(var_8_0)

	local var_8_1 = AssassinConfig.instance:getAssassinItemFightEffDesc(var_8_0)
	local var_8_2 = not string.nilorempty(var_8_1)

	if var_8_2 then
		arg_8_0._txtfightEffDesc.text = var_8_1
	end

	gohelper.setActive(arg_8_0._gofightEff, var_8_2)

	local var_8_3 = AssassinConfig.instance:getAssassinItemStealthEffDesc(var_8_0)
	local var_8_4 = not string.nilorempty(var_8_3)

	if var_8_4 then
		arg_8_0._txtstealthEffDesc.text = var_8_3
	end

	gohelper.setActive(arg_8_0._gostealthEff, var_8_4)
	arg_8_0:refreshBtn()
end

function var_0_0.refreshBtn(arg_9_0)
	local var_9_0 = V2a9BossRushModel.instance:isFullEquip(arg_9_0._stage)
	local var_9_1 = V2a9BossRushModel.instance:getSelectedItemId()
	local var_9_2 = V2a9BossRushModel.instance:isEquip(arg_9_0._stage, var_9_1)

	gohelper.setActive(arg_9_0._goremove, var_9_2)
	gohelper.setActive(arg_9_0._goequip, not var_9_0 and not var_9_2)
	gohelper.setActive(arg_9_0._goban, var_9_0 and not var_9_2)
	gohelper.setActive(arg_9_0._goIsEquiped, var_9_2)
	gohelper.setActive(arg_9_0._goinfo, true)
end

function var_0_0.refreshView(arg_10_0)
	arg_10_0:refreshBtn()
	V2a9BossRushSkillBackpackListModel.instance:onModelUpdate()
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
