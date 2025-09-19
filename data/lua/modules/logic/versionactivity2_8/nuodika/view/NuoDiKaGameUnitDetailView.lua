module("modules.logic.versionactivity2_8.nuodika.view.NuoDiKaGameUnitDetailView", package.seeall)

local var_0_0 = class("NuoDiKaGameUnitDetailView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_enemyicon")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#txt_desc")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_desc/#txt_name")
	arg_1_0._goclose = gohelper.findChild(arg_1_0.viewGO, "image_Close")
	arg_1_0._closeClick = gohelper.getClickWithAudio(arg_1_0._goclose)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._closeClick:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._closeClick:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0:_addEvents()
end

function var_0_0._addEvents(arg_6_0)
	return
end

function var_0_0._removeEvents(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_unit_tip)

	if arg_8_0.viewParam.unitType == NuoDiKaEnum.EventType.Enemy then
		arg_8_0:_refreshEnemy()
	elseif arg_8_0.viewParam.unitType == NuoDiKaEnum.EventType.Item then
		arg_8_0:_refreshItem()
	end
end

function var_0_0._refreshEnemy(arg_9_0)
	local var_9_0 = NuoDiKaConfig.instance:getEnemyCo(arg_9_0.viewParam.unitId)

	arg_9_0._txtname.text = var_9_0.name

	local var_9_1 = string.gsub(var_9_0.desc, "#FF7373", "#931E0E")

	arg_9_0._txtdesc.text = var_9_1

	arg_9_0._simageicon:LoadImage(ResUrl.getNuoDiKaMonsterIcon(var_9_0.picture))
end

function var_0_0._refreshItem(arg_10_0)
	local var_10_0 = NuoDiKaConfig.instance:getItemCo(arg_10_0.viewParam.unitId)

	arg_10_0._txtname.text = var_10_0.name

	local var_10_1 = string.gsub(var_10_0.desc, "#FF7373", "#931E0E")

	arg_10_0._txtdesc.text = var_10_1

	arg_10_0._simageicon:LoadImage(ResUrl.getNuoDiKaItemIcon(var_10_0.picture))
end

function var_0_0.onClose(arg_11_0)
	arg_11_0._simageicon:UnLoadImage()
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0:_removeEvents()
end

return var_0_0
