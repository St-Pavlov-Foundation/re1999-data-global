module("modules.logic.rouge.view.RougerewardThemeTipView", package.seeall)

local var_0_0 = class("RougerewardThemeTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._simageblockpackageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "content/blockpackageiconmask/#simage_blockpackageicon")
	arg_1_0._gosuitcollect = gohelper.findChild(arg_1_0.viewGO, "content/blockpackageiconmask/#go_suitcollect")
	arg_1_0._simagebuildingicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "content/blockpackageiconmask/#go_suitcollect/#simage_buildingicon")
	arg_1_0._btnsuitcollect = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "content/blockpackageiconmask/#go_suitcollect/#btn_suitcollect")
	arg_1_0._gocollecticon = gohelper.findChild(arg_1_0.viewGO, "content/blockpackageiconmask/#go_suitcollect/#go_collecticon")
	arg_1_0._txtbuildingname = gohelper.findChildText(arg_1_0.viewGO, "content/blockpackageiconmask/#go_suitcollect/#txt_buildingname")
	arg_1_0._txtcollectdesc = gohelper.findChildText(arg_1_0.viewGO, "content/blockpackageiconmask/#go_suitcollect/#txt_collectdesc")
	arg_1_0._gonormaltitle = gohelper.findChild(arg_1_0.viewGO, "content/title/#go_normaltitle")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "content/title/#go_normaltitle/#txt_name")
	arg_1_0._gohascollect = gohelper.findChild(arg_1_0.viewGO, "content/title/#go_hascollect")
	arg_1_0._txtname2 = gohelper.findChildText(arg_1_0.viewGO, "content/title/#go_hascollect/#txt_name2")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "content/desc/#txt_desc")
	arg_1_0._scrollitem = gohelper.findChildScrollRect(arg_1_0.viewGO, "content/go_scroll/#scroll_item")
	arg_1_0._txtnameitem = gohelper.findChildText(arg_1_0.viewGO, "content/go_scroll/#scroll_item/viewport/content/#txt_nameitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnsuitcollect:AddClickListener(arg_2_0._btnsuitcollectOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnsuitcollect:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnsuitcollectOnClick(arg_5_0)
	return
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0._config = arg_8_0.viewParam

	arg_8_0._simageblockpackageicon:LoadImage(ResUrl.getRougeIcon("reward/rouge_reward_roomskindetail"))
end

function var_0_0._initUI(arg_9_0)
	return
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
