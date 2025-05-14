module("modules.logic.versionactivity1_8.dungeon.view.dispatch.VersionActivity1_8DispatchSelectHeroItem", package.seeall)

local var_0_0 = class("VersionActivity1_8DispatchSelectHeroItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.index = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.goHero = gohelper.findChild(arg_2_0.go, "#go_hero")
	arg_2_0.simageHeroIcon = gohelper.findChildSingleImage(arg_2_0.go, "#go_hero/#simage_heroicon")
	arg_2_0.imageCareer = gohelper.findChildImage(arg_2_0.go, "#go_hero/#image_career")
	arg_2_0.click = gohelper.getClick(arg_2_0.go)

	gohelper.setActive(arg_2_0.goHero, false)
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0.click:AddClickListener(arg_3_0.onClickSelf, arg_3_0)
	arg_3_0:addEventCb(DispatchController.instance, DispatchEvent.ChangeSelectedHero, arg_3_0.refreshUI, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0.click:RemoveClickListener()
	arg_4_0:removeEventCb(DispatchController.instance, DispatchEvent.ChangeSelectedHero, arg_4_0.refreshUI, arg_4_0)
end

function var_0_0.onClickSelf(arg_5_0)
	if not DispatchHeroListModel.instance:canChangeHeroMo() then
		return
	end

	if arg_5_0.mo then
		DispatchHeroListModel.instance:deselectMo(arg_5_0.mo)
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	end

	DispatchController.instance:dispatchEvent(DispatchEvent.ChangeDispatchHeroContainerEvent, true)
end

function var_0_0.refreshUI(arg_6_0)
	arg_6_0.mo = DispatchHeroListModel.instance:getSelectedMoByIndex(arg_6_0.index)

	local var_6_0 = arg_6_0:isSelected()

	gohelper.setActive(arg_6_0.goHero, var_6_0)

	if var_6_0 then
		arg_6_0.heroCo = arg_6_0.mo.config

		local var_6_1 = ResUrl.getRoomHeadIcon(arg_6_0.heroCo.id .. "01")

		arg_6_0.simageHeroIcon:LoadImage(var_6_1)
		UISpriteSetMgr.instance:setCommonSprite(arg_6_0.imageCareer, "lssx_" .. arg_6_0.heroCo.career)
	end
end

function var_0_0.isSelected(arg_7_0)
	return arg_7_0.mo ~= nil
end

function var_0_0.destroy(arg_8_0)
	arg_8_0.simageHeroIcon:UnLoadImage()
end

return var_0_0
