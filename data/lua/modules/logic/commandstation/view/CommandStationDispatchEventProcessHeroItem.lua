module("modules.logic.commandstation.view.CommandStationDispatchEventProcessHeroItem", package.seeall)

local var_0_0 = class("CommandStationDispatchEventProcessHeroItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobg = gohelper.findChild(arg_1_0.viewGO, "#go_bg")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_icon")
	arg_1_0._imagecareer = gohelper.findChildImage(arg_1_0.viewGO, "#image_career")
	arg_1_0._godispatched = gohelper.findChild(arg_1_0.viewGO, "#go_dispatched")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "#go_selected")
	arg_1_0._txtindex = gohelper.findChildText(arg_1_0.viewGO, "#go_selected/#txt_index")
	arg_1_0._goclick = gohelper.findChild(arg_1_0.viewGO, "#go_selected/#go_click")
	arg_1_0._goupicon = gohelper.findChild(arg_1_0.viewGO, "#go_upicon")

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
	return
end

function var_0_0._editableAddEvents(arg_5_0)
	arg_5_0._clickListener = SLFramework.UGUI.UIClickListener.Get(arg_5_0._gobg)

	arg_5_0._clickListener:AddClickListener(arg_5_0._onClickHandler, arg_5_0)
end

function var_0_0._editableRemoveEvents(arg_6_0)
	if arg_6_0._clickListener then
		arg_6_0._clickListener:RemoveClickListener()
	end
end

function var_0_0._onClickHandler(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.play_ui_common_click2)

	if arg_7_0._isUsed then
		return
	end

	if CommandStationHeroListModel.instance:getHeroSelectedIndex(arg_7_0._mo) then
		CommandStationHeroListModel.instance:cancelSelectedHero(arg_7_0._mo)
		arg_7_0:_updateSelectedInfo()

		return
	end

	local var_7_0 = CommandStationHeroListModel.instance:getEmptyIndex()

	if var_7_0 then
		CommandStationHeroListModel.instance:setSelectedHero(var_7_0, arg_7_0._mo)
		arg_7_0:_updateSelectedInfo()
	end
end

function var_0_0._updateSelectedInfo(arg_8_0)
	local var_8_0 = CommandStationHeroListModel.instance:getHeroSelectedIndex(arg_8_0._mo)

	gohelper.setActive(arg_8_0._goselected, var_8_0 ~= nil)

	if var_8_0 then
		arg_8_0._txtindex.text = var_8_0
	end
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	arg_9_0._mo = arg_9_1

	local var_9_0 = arg_9_0._mo.config
	local var_9_1 = var_9_0.skinId
	local var_9_2 = SkinConfig.instance:getSkinCo(var_9_1)

	arg_9_0._simageicon:LoadImage(ResUrl.getHeadIconSmall(var_9_2.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(arg_9_0._imagecareer, "lssx_" .. var_9_0.career)
	gohelper.setActive(arg_9_0._goupicon, CommandStationHeroListModel.instance:heroIsSpecial(arg_9_0._mo.heroId))

	arg_9_0._isUsed = CommandStationHeroListModel.instance:heroIsUsed(arg_9_0._mo.heroId)

	gohelper.setActive(arg_9_0._godispatched, arg_9_0._isUsed)
	arg_9_0:_updateSelectedInfo()
end

function var_0_0.onSelect(arg_10_0, arg_10_1)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
