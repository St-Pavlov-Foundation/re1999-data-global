module("modules.logic.versionactivity1_8.dungeon.view.dispatch.VersionActivity1_8DispatchHeroItem", package.seeall)

local var_0_0 = class("VersionActivity1_8DispatchHeroItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0._go, "#simage_icon")
	arg_1_0._imagecareer = gohelper.findChildImage(arg_1_0._go, "#image_career")
	arg_1_0._godispatched = gohelper.findChild(arg_1_0._go, "#go_dispatched")
	arg_1_0._goselected = gohelper.findChild(arg_1_0._go, "#go_selected")

	gohelper.setActive(arg_1_0._goselected, false)

	arg_1_0._txtindex = gohelper.findChildText(arg_1_0._go, "#go_selected/#txt_index")
	arg_1_0.click = gohelper.getClick(arg_1_0._go)
	arg_1_0.isSelected = false
	arg_1_0.dispatched = false
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0.click:AddClickListener(arg_2_0.onClickSelf, arg_2_0)
	arg_2_0:addEventCb(DispatchController.instance, DispatchEvent.ChangeSelectedHero, arg_2_0.updateSelect, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0.click:RemoveClickListener()
	arg_3_0:removeEventCb(DispatchController.instance, DispatchEvent.ChangeSelectedHero, arg_3_0.updateSelect, arg_3_0)
end

function var_0_0.onClickSelf(arg_4_0)
	if not DispatchHeroListModel.instance:canChangeHeroMo() then
		return
	end

	if arg_4_0.mo:isDispatched() then
		return
	end

	if arg_4_0.isSelected then
		DispatchHeroListModel.instance:deselectMo(arg_4_0.mo)
	elseif DispatchHeroListModel.instance:canAddMo() then
		DispatchHeroListModel.instance:selectMo(arg_4_0.mo)
	end

	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_carddisappear)
end

function var_0_0.updateSelect(arg_5_0)
	local var_5_0 = DispatchHeroListModel.instance:getSelectedIndex(arg_5_0.mo)

	arg_5_0.isSelected = var_5_0 ~= nil

	gohelper.setActive(arg_5_0._goselected, arg_5_0.isSelected)

	if arg_5_0.isSelected then
		arg_5_0._txtindex.text = var_5_0
	end
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0.mo = arg_6_1
	arg_6_0.config = arg_6_1.config

	local var_6_0 = ResUrl.getRoomHeadIcon(arg_6_0.config.id .. "01")

	arg_6_0._simageicon:LoadImage(var_6_0)
	UISpriteSetMgr.instance:setCommonSprite(arg_6_0._imagecareer, "lssx_" .. arg_6_0.config.career)

	arg_6_0.dispatched = arg_6_0.mo:isDispatched()

	if arg_6_0.dispatched then
		arg_6_0.isSelected = false
	else
		arg_6_0.isSelected = DispatchHeroListModel.instance:getSelectedIndex(arg_6_0.mo) ~= nil
	end

	gohelper.setActive(arg_6_0._godispatched, arg_6_0.dispatched)
	arg_6_0:updateSelect()
end

function var_0_0.onDestroy(arg_7_0)
	arg_7_0._simageicon:UnLoadImage()
end

return var_0_0
